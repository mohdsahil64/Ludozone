<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Api extends CI_Controller {

    // Cron job - auto handle timeout matches
    public function cron_timeout(){
        // CASE 1: 20 min no response → Conflict to admin
        $timeout_20min = time() - 1200;
        
        $no_response_matches = $this->db->where('status', 1)
            ->where('room_code !=', 0)
            ->where('joiner_id !=', 0)
            ->where('winner', 0)
            ->where('looser', 0)
            ->where('joiner_time <', $timeout_20min)
            ->where('joiner_time !=', 0)
            ->get('matches')->result();
        
        $conflicts_created = 0;
        foreach($no_response_matches as $match){
            $conflict = $this->db->where('match_id', $match->id)->where('status', 1)->get('conflicts')->row();
            if($conflict) continue;
            
            $cc = [];
            $cc['user_id'] = 0;
            $cc['match_id'] = $match->id;
            $cc['created_at'] = time();
            $cc['screenshot'] = '';
            $cc['status'] = 1;
            $cc['reason'] = 'Timeout - 20 min no response';
            $this->db->insert('conflicts', $cc);
            $conflicts_created++;
        }
        
        // CASE 2: One result + 2 min no response
        $timeout_2min = time() - 120;
        $auto_decided = 0;
        
        // 2a: Winner set, looser not -> Conflict to admin
        $won_matches = $this->db->where('status', 1)
            ->where('room_code !=', 0)
            ->where('joiner_id !=', 0)
            ->where('winner !=', 0)
            ->where('looser', 0)
            ->where('winner_time <', $timeout_2min)
            ->where('winner_time !=', 0)
            ->get('matches')->result();
        
        foreach($won_matches as $match){
            $conflict = $this->db->where('match_id', $match->id)->where('status', 1)->get('conflicts')->row();
            if($conflict) continue;
            
            $cc = [];
            $cc['user_id'] = $match->winner;
            $cc['match_id'] = $match->id;
            $cc['created_at'] = time();
            $cc['screenshot'] = '';
            $cc['status'] = 1;
            $cc['reason'] = 'Opponent did not respond in 2 min after win claim';
            $this->db->insert('conflicts', $cc);
            $conflicts_created++;
        }
        
        // 2b: Looser set, winner not -> Auto win to opponent
        $lost_matches = $this->db->where('status', 1)
            ->where('room_code !=', 0)
            ->where('joiner_id !=', 0)
            ->where('winner', 0)
            ->where('looser !=', 0)
            ->where('looser_time <', $timeout_2min)
            ->where('looser_time !=', 0)
            ->get('matches')->result();
        
        foreach($lost_matches as $match){
            $conflict = $this->db->where('match_id', $match->id)->where('status', 1)->get('conflicts')->row();
            if($conflict) continue;
            
            $winner_id = ($match->looser == $match->host_id) ? $match->joiner_id : $match->host_id;
            $this->db->where('id', $match->id)->update('matches', [
                'winner' => $winner_id,
                'winner_time' => time()
            ]);
            $this->complete_match($match->id);
            $auto_decided++;
        }
        
        // CASE 4: Cancel + room code shared + 2 min opponent didn't cancel -> Conflict
        $cancel_reqs = $this->db->where('status', 1)->where('created_at <', $timeout_2min)->get('cancel_reqs')->result();
        
        foreach($cancel_reqs as $creq){
            $match = $this->db->where('id', $creq->match_id)->where('status', 1)->get('matches')->row();
            if(!$match) continue;
            if($match->room_code == 0) continue;
            if($match->winner != 0 || $match->looser != 0) continue;
            
            $both = $this->db->where('match_id', $match->id)->where('status', 1)->get('cancel_reqs')->num_rows();
            if($both >= 2){
                $host = $this->db->where('id', $match->host_id)->get('users')->row();
                $joiner = $this->db->where('id', $match->joiner_id)->get('users')->row();
                $txn = [];
                $txn['user_id'] = $match->host_id;
                $txn['order_id'] = 'txn'.time().rand(100,999);
                $txn['utr'] = time();
                $txn['amount'] = $match->amount;
                $txn['type'] = 'CREDIT';
                $txn['reason'] = 'Match Canceled With @'.$joiner->username;
                $txn['created_at'] = time();
                $txn['status'] = 1;
                $txn['ctg'] = 'MATCH_REFUND';
                $txn['match_id'] = $match->id;
                $this->db->insert('transections', $txn);
                $txn['user_id'] = $match->joiner_id;
                $txn['order_id'] = 'txn'.time().rand(100,999);
                $txn['reason'] = 'Match Canceled With @'.$host->username;
                $this->db->insert('transections', $txn);
                $this->db->where('id', $match->id)->update('matches', ['status' => 0]);
                $this->db->where('match_id', $match->id)->update('cancel_reqs', ['status' => 0]);
                continue;
            }
            
            $conflict = $this->db->where('match_id', $match->id)->where('status', 1)->get('conflicts')->row();
            if($conflict) continue;
            
            $cc = [];
            $cc['user_id'] = $creq->req_by;
            $cc['match_id'] = $match->id;
            $cc['created_at'] = time();
            $cc['screenshot'] = '';
            $cc['status'] = 1;
            $cc['reason'] = 'Cancel request - opponent did not respond in 2 min';
            $this->db->insert('conflicts', $cc);
            $conflicts_created++;
        }
        
        echo json_encode(['conflicts_created' => $conflicts_created, 'auto_decided' => $auto_decided, 'time' => date('Y-m-d H:i:s')]);
    }
    
    // Complete match - give winnings
    private function complete_match($matchid){
        $match = $this->db->where('id', $matchid)->get('matches')->row();
        if($match->winner != $match->looser && $match->winner != 0 && $match->looser != 0 && $match->status == 1){
            $winner = $this->db->where('id', $match->winner)->get('users')->row();
            $looser = $this->db->where('id', $match->looser)->get('users')->row();
            
            $system = $this->db->get('system')->row();
            $reward_pct = $system->wining_reward;
            $winning_amount = floor(($match->amount * 2) - (($match->amount * 2) / 100 * (100 - $reward_pct)));
            
            $txn = [];
            $txn['user_id'] = $match->winner;
            $txn['order_id'] = 'txn'.time().rand(100,999);
            $txn['utr'] = time();
            $txn['amount'] = $winning_amount;
            $txn['type'] = 'CREDIT';
            $txn['reason'] = 'Won Match With @'.$looser->username;
            $txn['created_at'] = time();
            $txn['status'] = 1;
            $txn['ctg'] = 'MATCH_WININGS';
            $txn['match_id'] = $matchid;
            $this->db->insert('transections', $txn);
            
            // Referral bonus
            if($winner->refer_code){
                $refman = $this->db->where('code', $winner->refer_code)->get('users')->row();
                if($refman){
                    $txn['user_id'] = $refman->id;
                    $txn['order_id'] = 'txn'.time().rand(100,999);
                    $txn['amount'] = (($match->amount) / 100) * ($system->ref_commission);
                    $txn['reason'] = 'Referral Bonus from @'.$winner->username;
                    $txn['ctg'] = 'REFERRAL_BONUS';
                    $this->db->insert('transections', $txn);
                }
            }
            
            $this->db->where('id', $matchid)->update('matches', ['status' => 0]);
            $this->db->where('match_id', $match->id)->update('cancel_reqs', ['status' => 0]);
        }
    }
  protected $user=null;


   public function sendaadharotp(){
 $post=$this->input->post();
    $kyc=$this->db->where('aadhar_no',$post['aadharno'])->get('kycs')->row();

if($kyc){
$res['code']=500;
$res['data']['message']='aadhar no is already used for kyc by another user';
echo json_encode($res);
die();
}


    $api=$this->db->where(['tag'=>'AADHAR'])->get('apis')->row();


    // $user = $this->db->where('id',$this->session->userdata('UserAuth'))->get('users')->row();

    $url = 'https://api.sandbox.co.in/kyc/aadhaar/okyc/otp';


// $_SESSION['txn']=$data;

$postdata = '{
  "aadhaar_number": "'.$post['aadharno'].'"
}';

$headers[]='Authorization: '.$api->authtoken;
$headers[]='accept: application/json';
$headers[]='content-type: application/json';
$headers[]='x-api-key: '.$api->apikey;
$headers[]='x-api-version: 1.0';

$ch = curl_init($url);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, $postdata);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
$result = curl_exec($ch);
curl_close($ch);
echo $result;

    }

public function verifyaadharotp(){

    $api=$this->db->where(['tag'=>'AADHAR'])->get('apis')->row();

    $post=$this->input->post();
    // $user = $this->db->where('id',$this->session->userdata('UserAuth'))->get('users')->row();

    $url = 'https://api.sandbox.co.in/kyc/aadhaar/okyc/otp/verify';


// $_SESSION['txn']=$data;

$postdata = '{
  "otp": "'.$post['aadharotp'].'",
  "ref_id": "'.$post['ref_id'].'"
}';

$headers[]='Authorization: '.$api->authtoken;
$headers[]='accept: application/json';
$headers[]='content-type: application/json';
$headers[]='x-api-key: '.$api->apikey;
$headers[]='x-api-version: 1.0';

$ch = curl_init($url);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, $postdata);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
$result = curl_exec($ch);
curl_close($ch);
header('content-type: application/json');
echo $result;
$res=json_decode($result);
if($res->code==200 && isset($res->data->status) && $res->data->status=='VALID'){
    $kyc['user_id']=$this->session->userdata('UserAuth');
    $kyc['aadhar_no']=$post['aadhar_no'];
    $kyc['kycdata']=json_encode($res->data);
    $kyc['created_at']=time();
    $kyc['status']=1;


    $this->db->insert('kycs',$kyc);
$this->session->set_flashdata('txnmsg','Your KYC is successfully completed !');

}
    }


    public function savelogin($id){
        setcookie('UserAuth', $id, time() + (86400 * 300000), "/");
    }

public function onlyforauth(){
        $this->autologin();
        if($this->session->userdata('UserAuth')){
            $this->user = $this->db->where('id',$this->session->userdata('UserAuth'))->get('users')->row();
        }else{
            redirect(base_url('user/login'));
        }
    }

     public function onlyfornonauth(){
        $this->autologin();

        if($this->session->userdata('UserAuth')){
         redirect(base_url('user/dashboard'));
        }else{
            $this->user = null;
        }
    }

public function send_otp($number=0)
	{
        $post=$this->input->post();
        $isMobileAlreadyRegistred=$this->db->where('mobile_no',$post['mobile_no'])->get('users')->row();

        if(trim($post['full_name'],'!@#$%^&*()_+=-')=='' || str_replace(' ','',$post['full_name'])==''){
          $res['return']=false;
$res['message']='please enter a valid name';
echo json_encode($res);
        die();
        }



$mobileregex = "/^[6-9][0-9]{9}$/" ;
         if(preg_match($mobileregex, $post['mobile_no']) != 1){
          $res['return']=false;
$res['message']='please enter a valid mobile no';
echo json_encode($res);
        die();
        }

        if($isMobileAlreadyRegistred){
$res['return']=false;
$res['message']='mobile no already registered !';
echo json_encode($res);
        die();
        }

        if($post['refer_code']){
            $isReferCodeValid=$this->db->where('code',$post['refer_code'])->get('users')->row();
        if(!$isReferCodeValid){
$res['return']=false;
$res['message']='refer code is not valid !';
echo json_encode($res);
        die();
        }
        }

        ini_set("allow_url_fopen", 1);

        $otp=rand(100000,999999);

    // SMS API Configuration
    $api_key = "Nr0LkeFd53";
    $sender_id = "SBGINF";
    $message = urlencode("Your registration OTP is $otp");
    $otp_url = "https://dvhosting.in/api-sms-v3.php?api_key=$api_key&number=$number&otp=$otp&senderid=$sender_id&message=$message";

    ini_set("allow_url_fopen", 1);
    $arrContextOptions = array(
        "ssl" => array(
            "verify_peer" => false,
            "verify_peer_name" => false,
        ),
    );

$result = file_get_contents($otp_url, false, stream_context_create($arrContextOptions));
$this->session->set_userdata('login_otp',$otp);
$response = [
    'return' => true,
    'request_id' => 'lwdtp7cjyqxvfe9',
    'message' => ['Message sent successfully']
];
echo json_encode($response);

	}



public function send_login_otp($number = 0)
{
    // Retrieve post data if required
    $post = $this->input->post();
    if ($number == 0 && isset($post['number'])) {
        $number = $post['number'];
    }
    
    // Check if the mobile number is registered
    $isMobileAlreadyRegistered = $this->db->where('mobile_no', $number)->get('users')->row();
    if (!$isMobileAlreadyRegistered) {
        $res = [
            'return'  => false,
            'message' => 'Mobile number is not registered!'
        ];
        echo json_encode($res);
        die();
    }

    // Enable URL fopen if not already enabled
    ini_set("allow_url_fopen", 1);
    
    // Generate a random OTP
    $otp = rand(100000, 999999);
    
    // Store OTP in session for later verification
    $this->session->set_userdata('login_otp', $otp);
    
    // Define your API key and SSL options
    $api_key = "Nr0LkeFd53";
    $arrContextOptions = array(
        "ssl" => array(
            "verify_peer"      => false,
            "verify_peer_name" => false,
        ),
    );
    
    // Prepare the message and URL (URL encode the message)
    $message = urlencode("Your OTP is " . $otp);
    $otp_url = "https://dvhosting.in/api-sms-v3.php?api_key={$api_key}&number={$number}&otp={$otp}&senderid=SBGINF&message={$message}";

    // Send the API request
    $result = file_get_contents($otp_url, false, stream_context_create($arrContextOptions));

    // Prepare and echo JSON response
    $response = [
        'return'     => true,
        'request_id' => uniqid(),
        'message'    => ['Message sent successfully']
    ];
    echo json_encode($response);
}


     function gen_ref_code(){
        $string='abcdefghijklmnopqrstuvwxyz1234567890'.time();
        $string=str_shuffle($string);
        $check=true;
        while($check){
         $code=substr($string,0,8);
         if($this->db->where('code',$code)->get('users')->result()){
            $string=str_shuffle($string);
         }else{
$check=false;
return $code;
         }

        }
    }

    function clean($string) {
   $string = str_replace(' ', '_', $string); // Replaces all spaces with hyphens.

   return preg_replace('/[^A-Za-z0-9\-]/', '', $string); // Removes special chars.
}

     function gen_username($name){
        $count=1;
        $username=$this->clean(strtolower($name));


        $check=true;
        while($check){
         $un=$username.$count;
         if($this->db->where('username',$un)->get('users')->result()){
            $count++;
         }else{
$check=false;
return $un;
         }

        }
    }

    public function verify_otp($otp=0){
$post=$this->input->post();
// foreach($post as $index=>$val){

//    if(!$val){
// $this->session->set_flashdata('txnmsg',"Don't Try to be smart, fill the form correctly.");
// redirect(base_url());
//    }
// }

$post['code']=strtoupper($this->gen_ref_code());
if($this->session->userdata('login_otp')==$post['uotp']){
$post['created_at']=time();
unset($post['uotp']);
$post['avatar']='avatar16.png';
$post['username']=$this->gen_username($post['full_name']);
$post['refer_code']=strtoupper($post['refer_code']);
$this->db->insert('users',$post);
$userid=$this->db->insert_id();
$this->session->set_userdata('UserAuth',$userid);
$this->savelogin($userid);

if($this->db->get('system')->row()->joining_bonus>0){
     $txn['user_id']=$userid;
    $txn['order_id']='txn'.rand(100,999).time();
    $txn['utr']=time();
    $txn['amount']=$this->db->get('system')->row()->joining_bonus;
    $txn['type']='CREDIT';
    $txn['reason']='Joining Bonus';
    $txn['created_at']=time();
    $txn['status']=1;
    $txn['ctg']='JOINING_BONUS';

    $this->db->insert('transections',$txn);
}
$response['status']=true;
$response['message']='Mobile No, Verified !';
}else{
$response['status']=false;
$response['message']='Incorrect OTP, Please Try Again';

}

echo json_encode($response);
    }


public function verify_login_otp($otp=0){
$post=$this->input->post();

if($this->session->userdata('login_otp')==$otp){

$user=$this->db->where('mobile_no',$post['mobile_no'])->get('users')->row();
if($user){
    $this->session->set_userdata('UserAuth',$user->id);
    $this->savelogin($user->id);
    $response['status']=true;
$response['message']='Mobile No, Verified !';
}else{
    $response['status']=false;
$response['message']='something is wrong, please refresh the page and try again';
}



}else{
$response['status']=false;
$response['message']='Incorrect OTP, Please Try Again';

}

echo json_encode($response);
    }


    public function changeavatar(){
    $post=$this->input->post();
    $avatar = explode('assets/images/avatars/',$post['avatar'])[1];
$userid=$this->session->userdata('UserAuth');
$this->db->where('id',$userid)->update('users',[
'avatar'=>$avatar
]);
echo 'ok';
    }




  public function addwithdrawreq(){
    $post=$this->input->post();


$userid=$this->session->userdata('UserAuth');

if($this->db->get('system')->row()->kyc_type!=2){
$kyc=$this->db->where('user_id',$userid)->where('status',1)->get('kycs')->row();

if(!$kyc){
$response['msg']="please complete your kyc , before placing any withdraw request";
$response['status']=false;
echo json_encode($response);
die();
}

}

if($post['wamount']>$this->getRewardBalance()){

$response['status']=false;
$response['msg']="you have don't have sufficient balance in your reward wallet";

}else{

    $wtxn['user_id']=$userid;
    $wtxn['amount']=$post['wamount'];
    $wtxn['upi_mobile']=$post['upi'];
    $wtxn['upi_app']=$post['upiapp'];
    $wtxn['name']=$post['name'];
    $wtxn['bank_ac_no']=$post['bankno'];
    $wtxn['bank_ifsc_code']=$post['ifsc'];


    $wtxn['created_at']=time();
    $wtxn['status']=2;
    $wtxn['req_id']='WD'.rand(1000,9999).time();

    $this->db->insert('withdraw_reqs',$wtxn);

$this->session->set_flashdata('txnmsg',"your withdraw request is successfully submitted, it will take 24 hours to process");





$response['msg']="your withdraw request is successfully submitted, it will take 24 hours to process";
$response['status']=true;
}


echo json_encode($response);
    }




      public function changeusername(){
    $post=$this->input->post();

$userid=$this->session->userdata('UserAuth');

$un=$this->db->where('username',$post['username'])->get('users')->result();
if($un){
$response['status']=false;
$response['msg']="'".$post['username']."' is already taken";

}else{
$this->db->where('id',$userid)->update('users',['username'=>$post['username']]);
$response['status']=true;
}


echo json_encode($response);
    }


     public function updateroomcode(){
    $post=$this->input->post();

$userid=$this->session->userdata('UserAuth');

$match=$this->db->where('id',$post['match'])->get('matches')->row();
if($match){
$response['status']=true;
$this->db->where('id',$match->id)->update('matches',['room_code'=>$post['room_code']]);
$response['msg']="room code updated";

}else{

$response['status']=false;
$response['msg']="room code not updated";

}


echo json_encode($response);
    }


  public function getAvailableBalance(){
        $where['user_id']=@$this->db->where('id',$this->session->userdata('UserAuth'))->get('users')->row()->id;
        $where['type']='CREDIT';

        $credit = $this->db->select('SUM(amount) as money')->where('(ctg!="MATCH_WININGS" AND ctg!="REFERRAL_BONUS")')->where($where)->get('transections')->row()->money;

        $where['type']='DEBIT';

        $debit = $this->db->select('SUM(amount) as money')->where('(ctg!="WITHDRAW" AND ctg!="TRANSFER")')->where($where)->get('transections')->row()->money;


        return ($credit-$debit);


    }

  public function getRewardBalance(){
        $where['user_id']=@$this->db->where('id',$this->session->userdata('UserAuth'))->get('users')->row()->id;
        $where['type']='CREDIT';
        $credit = $this->db->select('SUM(amount) as money')->where($where)->where('(ctg="MATCH_WININGS" OR ctg="REFERRAL_BONUS")')->get('transections')->row()->money;

        $where['type']='DEBIT';

        $debit = $this->db->select('SUM(amount) as money')->where($where)->where('(ctg="WITHDRAW")')->get('transections')->row()->money;


$debit += $this->db->select('SUM(amount) as money')->where([
    'user_id'=>$this->session->userdata('UserAuth'),
    'status'=>2
])->get('withdraw_reqs')->row()->money;

$where['type']='CREDIT';
$where['ctg']='TRANSFER';
$debit += $this->db->select('SUM(amount) as money')->where($where)->get('transections')->row()->money;

        return ($credit-$debit);


    }


     public function creatematch(){

    $post=$this->input->post();
$userid=$this->session->userdata('UserAuth');

$alreadyopenmatch=$this->db->where('status',1)->where('joiner_id !=',0)->where('winner !=',$userid)->where('looser !=',$userid)->where("(host_id=$userid OR joiner_id=$userid)")->get('matches')->row();


if($post['amount']>($this->getAvailableBalance() + $this->getRewardBalance())){
$response['status']=false;
$response['msg']="you don't have sufficient balance in your wallet";
}elseif($alreadyopenmatch){
$response['status']=false;
$response['msg']="you are already in a active match or didn't submitted result";
}else{

    $match['host_id']=$userid;
    $match['amount']=$post['amount'];
    $match['game']=$post['match'];
    $match['status']=1;
    $match['created_at']=time();

    $this->db->insert('matches',$match);

    $matchid=$this->db->insert_id();

$game = $this->db->where('id',$post['match'])->get('games')->row();

    $txn['user_id']=$userid;
    $txn['order_id']='txn'.rand(100,999).time();
    $txn['utr']=time();
    $txn['amount']=$post['amount'];
    $txn['type']='DEBIT';
    $txn['reason']='Created '.$game->game_name.' Match';
    $txn['created_at']=time();
    $txn['status']=1;
    $txn['ctg']='MATCH';
    $txn['match_id']=$matchid;

    $this->db->insert('transections',$txn);


$response['status']=true;
}



echo json_encode($response);
    }


    //payment
    public function createorder(){



    $post=$this->input->post();
    // $post['amount']=1;
    $_SESSION['addamount']=$post['amount'];
$response=[];
$user = $this->db->where('id',$this->session->userdata('UserAuth'))->get('users')->row();
 if($this->db->get('system')->row()->payment_gateway=='UG'){


    $user = $this->db->where('id',$this->session->userdata('UserAuth'))->get('users')->row();

//    #############


                    $key = $this->db->where('tag','UPIGATEWAY')->get('apis')->row()->apikey;	// Your Api Token https://merchant.upigateway.com/user/api_credentials
					$post_data = new stdClass();
					$post_data->key = $key;
					$post_data->client_txn_id = 'txn'.$user->id.time(); // you can use this field to store order id;
					$post_data->amount = "{$post['amount']}";
					$post_data->p_info = "walletadd";
					$post_data->customer_name = $user->full_name;
					$post_data->customer_email = 'admin@ludotopper.com';
					$post_data->customer_mobile = $user->mobile_no;
					$post_data->redirect_url = base_url('user/ug_verifypayment'); // automatically ?client_txn_id=xxxxxx&txn_id=xxxxx will be added on redirect_url
					$post_data->udf1 = "";
					$post_data->udf2 = "";
					$post_data->udf3 = "";

					$curl = curl_init();
					curl_setopt_array($curl, array(
						CURLOPT_URL => 'https://api.ekqr.in/api/create_order',
						CURLOPT_RETURNTRANSFER => true,
						CURLOPT_ENCODING => '',
						CURLOPT_MAXREDIRS => 10,
						CURLOPT_TIMEOUT => 30,
						CURLOPT_FOLLOWLOCATION => true,
						CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
						CURLOPT_CUSTOMREQUEST => 'POST',
						CURLOPT_POSTFIELDS => json_encode($post_data),
						CURLOPT_HTTPHEADER => array(
							'Content-Type: application/json'
						),
					));
					$response2 = curl_exec($curl);
					curl_close($curl);

					$result = json_decode($response2, true);
					if ($result['status'] == true) {
						$response['gotourl']=$result['data']['payment_url'];
					}




}elseif($this->db->get('system')->row()->payment_gateway=='PG'){

$response['gotourl']=base_url('user/addmoney');
}elseif($this->db->get('system')->row()->payment_gateway=='P'){
// pppppppppppppppppppppppppppppppp

// Replace these with your actual PhonePe API credentials


$merchantId = $this->db->where('tag','PHONEPE')->get('apis')->row()->secretkey; // production merchantId
$apiKey=$this->db->where('tag','PHONEPE')->get('apis')->row()->apikey; // production APIKEY
//$merchantId = 'PGTESTPAYUAT'; // sandbox or test merchantId
//$apiKey="099eb0cd-02cf-4e2a-8aca-3e6c6aff0399"; // sandbox or test APIKEY
$redirectUrl = base_url('user/phonepe_verifypayment/'.$user->id);

// Set transaction details
$order_id = uniqid();
$name=$user->full_name;
$mobile=$user->mobile_no;
$amount = $post['amount']; // amount in INR
$description = 'Deposit Money In Wallet';


$paymentData = array(
    'merchantId' => $merchantId,
    'merchantTransactionId' => "TXN".$user->id.time(), // test transactionID
    "merchantUserId"=>$user->mobile_no,
    'amount' => $amount*100,
    'redirectUrl'=>$redirectUrl,
    'redirectMode'=>"POST",
    'callbackUrl'=>$redirectUrl,
    "merchantOrderId"=>$order_id,
   "mobileNumber"=>$mobile,
   "message"=>$description,
   "shortName"=>$name,
   "paymentInstrument"=> array(
    "type"=> "PAY_PAGE",
  )
);


 $jsonencode = json_encode($paymentData);
 $payloadMain = base64_encode($jsonencode);
 $salt_index = 1; //key index 1
 $payload = $payloadMain . "/pg/v1/pay" . $apiKey;
 $sha256 = hash("sha256", $payload);
 $final_x_header = $sha256 . '###' . $salt_index;
 $request = json_encode(array('request'=>$payloadMain));

$curl = curl_init();
curl_setopt_array($curl, [
  CURLOPT_URL => "https://api.phonepe.com/apis/hermes/pg/v1/pay",
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => "",
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 30,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => "POST",
   CURLOPT_POSTFIELDS => $request,
  CURLOPT_HTTPHEADER => [
    "Content-Type: application/json",
     "X-VERIFY: " . $final_x_header,
     "accept: application/json"
  ],
]);

$response2 = curl_exec($curl);
$err = curl_error($curl);

curl_close($curl);

if ($err) {
  echo "cURL Error #:" . $err;
} else {
   $res = json_decode($response2);

if(isset($res->success) && $res->success=='1'){
$paymentCode=$res->code;
$paymentMsg=$res->message;
$payUrl=$res->data->instrumentResponse->redirectInfo->url;

$response['gotourl']=$payUrl;
}else{

var_dump($res);
}
}



//ppppppppppppppppppppppppppppppppp

}elseif($this->db->get('system')->row()->payment_gateway=='CP'){
// cpcpcpcpcpcpcpcp

$orderId = 'txn'.uniqid();
$secretKey=$this->db->where('tag','CASHFREE')->get('apis')->row()->secretkey;
$appId=$this->db->where('tag','CASHFREE')->get('apis')->row()->apikey;

$postData = array(
     "appId" => $appId,
     "orderId" => $orderId,
     "orderAmount" => $post['amount'],
     "orderCurrency" => 'INR',
     "customerName" => $user->full_name,
     "customerEmail" => 'admin@ludotopper.com',
        "customerPhone" => $user->mobile_no,
     "returnUrl" => base_url('user/verifycashfreepayment/'.$user->id),
     'notifyUrl'=>''
   );




   ksort($postData);
   $signatureData = "";
   foreach ($postData as $key => $value){
      $signatureData .= $key.$value;
   }

   $signature = hash_hmac('sha256', $signatureData, $secretKey, true);
   $signature = base64_encode($signature);

   $rrd=$postData;
   $rrd['signature']=$signature;
   $_SESSION['cashfree']=$rrd;

$response['gotourl']=base_url('user/cashfreepayment');

}elseif($this->db->get('system')->row()->payment_gateway=='D'){
$this->session->set_flashdata('txnmsg','Currently Deposit Money is Disabled By Admin');
$response['gotourl']=base_url('user/wallet');
}




echo json_encode($response);

    }


    public function fetchpayment(){

    }
}
