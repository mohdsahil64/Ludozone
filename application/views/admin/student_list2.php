<?php
$status=[1=>'<div class="d-flex align-items-center"><div style="width:7px;height:7px"class="inline-block bg-danger rounded-circle"></div>&nbsp;Inactive</div>',
2=>'<div class="d-flex align-items-center"><div style="width:7px;height:7px"class="inline-block bg-success rounded-circle"></div>&nbsp;Active</div>'];
$gender=[
    'Male'=>'<i class="bi bi-gender-male"></i>',
    'Female'=>'<i class="bi bi-gender-female"></i>'
]
?>
<div class="bg-white p-2 m-2 rounded shadow-sm">
<div>
<h5>Grade Card & Certificate Manager</h5>
<form>
<div class="input-group mb-3">
  <input type="text" class="form-control" name="search" value="<?=@$_GET['search']?>" placeholder="enter student name here.."  aria-describedby="button-addon2">
  <button type="submit" class="btn btn-primary" type="button" id="button-addon2"><i class="bi bi-search"></i> Search</button>
</div>
</form>
<hr>
<div class="table-responsive">
<table class="table">
<thead>
<tr>
<th>#</th>
<th class="text-nowrap">Student</th>
<th class="text-nowrap">Certificate & Grade Cards</th>
</tr>
</thead>
<tbody>
<?php
   function marks($data){
    $total=$data->written+$data->practical+$data->assignment+$data->viva;
    $percentage=number_format(($total/400)*100,2);
    if($percentage>=85){
      $grade='A+';
      $performance='Excellent';
    }elseif($percentage>=75){
      $grade='A';
      $performance='Very Good';
    }elseif($percentage>=60){
      $grade='B';
      $performance='Good';
    }elseif($percentage>=40){
      $grade='C';
      $performance='Satisfactory';
    }else{
      $grade='F';
      $performance='Failure';
    }
    return [
      'grade'=>$grade,
      'percentage'=>$percentage,
      'performance'=>$performance,
      'total'=>$total
    ];
  }
$count=1;
foreach($students as $student){
 
  $center=$this->db->where('id',$student->center)->get('centers')->row();
         
    ?>
<tr>
    <td><?=$count?></td>
    <td class="text-nowrap">
        <div class="d-flex">
<img src="<?=base_url('assets/uploads/'.$student->student_profile)?>" width="70px" class="rounded border" height="70px"/>
<div class="mx-2">
    <p class="fw-bold m-0"><?=$student->student_name?></p>
    <p class="m-0">UID : S<?=$student->id?></p>
</div>
</div>
    </td>

 

</td>


    <td class="text-nowrap" style="gap:5px">

   
    




<button type="button" class="btn btn-sm btn-primary" data-coreui-toggle="modal" data-coreui-target="#course<?=$student->id?>">Generate Grade Card & Certificate</button>
<button type="button" class="btn btn-sm btn-danger text-white" data-coreui-toggle="modal" data-coreui-target="#ccourse<?=$student->id?>">Download Certificates & Grade Card</button>


<!-- certificate starts here -->
<div class="modal fade" id="ccourse<?=$student->id?>" data-coreui-backdrop="static" data-coreui-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel"><?=$student->student_name?> (S<?=$student->id?>)</h5>
        <button type="button" class="btn-close" data-coreui-dismiss="modal" aria-label="Close"></button>
      </div>
    

      <div class="modal-body">
        <table class="table">
          <tr>
<th>Course</th>
<th>Percentage</th>
<th>Actions</th>
</tr>
      <?php
       

      $gcs=$this->db->where('student_id',$student->id)->get('gradecard')->result();
      if(!$gcs){
        ?>
<p class="p-2 text-center">No grade cards & certificate available</p>
        <?php
      }
      

      foreach($gcs as $gc){
        $ucourse=$this->db->where('id',$gc->course_id)->get('courses')->row();
        ?>
<tr>
<td>
  <?=$ucourse->course_title?>
</td>
<td>
<?=marks($gc)['percentage']?>%
      </td>
<td class="d-flex" style="gap:10px">
<form method="post" class="icardform" action="<?=base_url('pdf/certificate.php')?>" target="_blank">
  <input type="hidden" name="sino" value="<?=$gc->id?>" />
  <input type="hidden" name="regno" value="S<?=$gc->student_id?>" />
  <input type="hidden" name="fullname" value="<?=$student->student_name?>" />
  <input type="hidden" name="guardian" value="<?=$student->father_name?>" />
  <input type="hidden" name="course" value="<?=$ucourse->course_title?>" />
  <input type="hidden" name="center" value="<?=$center->center_name?>" />
  <input type="hidden" name="centercode" value="<?=$center->center_code?>" />
  <input type="hidden" name="duration" value="<?=$ucourse->course_duration?> Months" />
  <input type="hidden" name="passingyear" value="<?=$gc->complete_date?>" />
  <input type="hidden" name="doi" value="<?=$gc->doi?>" />
  <input type="hidden" name="grade" value="<?=marks($gc)['grade']?>" />











<button class="btn btn-sm btn-danger text-white"><i class="bi bi-file-earmark-pdf"></i> Certificate</button>
</form>

<form method="post" class="icardform" action="<?=base_url('pdf/gradecard.php')?>" target="_blank">
  <input type="hidden" name="sino" value="<?=$gc->id?>" />
  <input type="hidden" name="regno" value="S<?=$gc->student_id?>" />
  <input type="hidden" name="fullname" value="<?=$student->student_name?>" />
  <input type="hidden" name="guardian" value="<?=$student->father_name?>" />
  <input type="hidden" name="mother" value="<?=$student->mother_name?>" />

  <input type="hidden" name="profile" value="<?=$student->student_profile?>" />


  <input type="hidden" name="course" value="<?=$ucourse->course_title?>" />
  <input type="hidden" name="center" value="<?=$center->center_name?>" />
  <input type="hidden" name="centercode" value="<?=$center->center_code?>" />
  <input type="hidden" name="duration" value="<?=$ucourse->course_duration?> Months" />
  <input type="hidden" name="passingyear" value="<?=$gc->complete_date?>" />
  <input type="hidden" name="doi" value="<?=$gc->doi?>" />

  <input type="hidden" name="written" value="<?=$gc->written?>" />
  <input type="hidden" name="practical" value="<?=$gc->practical?>" />
  <input type="hidden" name="project" value="<?=$gc->assignment?>" />
  <input type="hidden" name="viva" value="<?=$gc->viva?>" />


  <input type="hidden" name="grade" value="<?=marks($gc)['grade']?>" />
  <input type="hidden" name="performance" value="<?=marks($gc)['performance']?>" />
  <input type="hidden" name="grandtotal" value="<?=marks($gc)['total']?>" />
  <input type="hidden" name="percentage" value="<?=marks($gc)['percentage']?>" />
  <input type="hidden" name="modules" value="<?=$ucourse->course_info?>" />















<button class="btn btn-sm btn-danger text-white"><i class="bi bi-file-earmark-pdf"></i> Grade Card</button>
</form>
</td>
<td>

</td>

</tr>
        <?php
      }
      ?>
</table>
      </div>
      <div class="modal-footer">
       
        
        <button type="button" class="btn btn-secondary" data-coreui-dismiss="modal">Close</button>
      </div>
     
    </div>
  </div>
</div>
<!-- certificate ends here -->

<!-- courses starts here -->
<div class="modal fade" id="course<?=$student->id?>" data-coreui-backdrop="static" data-coreui-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel"><?=$student->student_name?> (S<?=$student->id?>)</h5>
        <button type="button" class="btn-close" data-coreui-dismiss="modal" aria-label="Close"></button>
      </div>
      <?=form_open('admin/addgradecard')?>
      
  

    <input type="hidden" name="student_id" value="<?=$student->id?>">

      <div class="modal-body">
       
        <h5>Center : <?=$center->center_name?></h5>
    <div class="row">
    <div class="col-md-6">
    <label for="" class="form-label">Course Completetion Date<sup class="text-danger">*</sup></label>
    <input type="date" class="form-control" id="" name="complete_date" placeholder='select date' required>
  </div>

  <div class="col-md-6">
    <label for="" class="form-label">Issue Date<sup class="text-danger">*</sup></label>
    <input type="date"  name="doi" class="form-control" id="" placeholder="select date" required>
  </div>

  <div class="col-12 py-2">
    <label for="" class="form-label">Course<sup class="text-danger">*</sup></label>
    <select name="course_id" class="form-control" id="" required>
<?php
foreach($courses as $course){
  if(!$this->db->where('center_id',$center->id)->where('course_id',$course->id)->get('center_course_rel')->num_rows()){
    continue;
        }
  ?>
<option value="<?=$course->id?>"><?=$course->course_title?></option>
  <?php
}
?>
</select>
  </div>
 
<hr>
<h4>Marks</h4>
  <div class="col-md-6">
    <label for="" class="form-label">Written<sup class="text-danger">*</sup></label>
    <input type="number"  name="written" class="form-control" id="" placeholder="enter marks here" required>
  </div>

  <div class="col-md-6">
    <label for="" class="form-label">Practical<sup class="text-danger">*</sup></label>
    <input type="number"  name="practical" class="form-control" id="" placeholder="enter marks here" required>
  </div>
  <div class="col-md-6">
    <label for="" class="form-label">Assignment / Project<sup class="text-danger">*</sup></label>
    <input type="number"  name="assignment" class="form-control" id="" placeholder="enter marks here" required>
  </div>
  <div class="col-md-6">
    <label for="" class="form-label">Viva<sup class="text-danger">*</sup></label>
    <input type="number"  name="viva" class="form-control" id="" placeholder="enter marks here" required>
  </div>

</div>
      </div>
      <div class="modal-footer">
       
        
        <button type="button" class="btn btn-secondary" data-coreui-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary">Add Certificate & Grade Card</button>
      </div>
      </form>
    </div>
  </div>
</div>
<!-- courses ends here -->



    

    </td>

</tr>
    <?php
    $count++;
}
?>
</tbody>
</table>
</div>


</div>
</div>