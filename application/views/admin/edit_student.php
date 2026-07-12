<div class="bg-white p-2 m-2 rounded shadow-sm">
<div>
<div class="d-flex justify-content-between">
<h5>Update Student</h5>
<a href="<?=base_url('admin/studentlist')?>" class="btn btn-sm btn-outline-primary showloading"><i class="bi bi-arrow-left-circle"></i> Back</a>
</div>
<hr>

<?=form_open_multipart('admin/updatestudent/'.$student->id,'class="row g-3"')?>
    <div class="d-flex justify-content-between col-12 border-bottom pb-2">
<div class=" mx-1">
    <img src="<?=base_url('assets/uploads/'.$student->student_profile)?>" id="directorprofile" class="rounded border" width="90px" height="90px"/><br>
    <label for="" class="form-label">Student Profile</label>
    <input type="file" class="form-control" name="director_profile" id="directorprofilei" accept="image/png, image/gif, image/jpeg,image/jpg">
    <?php
    if($this->session->flashdata('director-profile-error')){
        ?>
<p class="text-danger">image is larger than 1mb</p>
        <?php
    }
    ?>
  </div>  
 
 
</div>
  <div class="col-md-6">
    <label for="" class="form-label">Student's Name<sup class="text-danger">*</sup></label>
    <input type="name" class="form-control" id="" value="<?=html_escape($student->student_name)?>" name="student_name" placeholder='enter center student name..' required>
  </div>
  <div class="col-md-6">
    <label for="" class="form-label">Status<sup class="text-danger">*</sup></label>
    <select class="form-control" name="status">

<option value="2" <?=$student->status==2?'selected':''?>>Active</option>
<option value="1"  <?=$student->status==1?'selected':''?>>Inactive</option>

</select>
  </div>

  <div class="col-md-6">
    <label for="" class="form-label">Email Id<sup class="text-danger">*</sup></label>
    <input type="email" class="form-control" id="" value="<?=html_escape($student->student_email)?>" name="student_email" placeholder="enter student email id.." required>
  </div>
  <div class="col-md-6">
    <label for="" class="form-label">Login Password<sup class="text-danger">*</sup></label>
    <input type="text" class="form-control" id="" value="<?=$student->password?>" name="password" placeholder="enter login password.." required>
  </div>
  <div class="col-md-6">
    <label for="" class="form-label">Father's Name<sup class="text-danger">*</sup></label>
    <input type="name" class="form-control" id="" value="<?=html_escape($student->father_name)?>" name="father_name" placeholder='enter father name..' required>
    
  </div>

  <div class="col-md-6">
    <label for="" class="form-label">Mother's Name<sup class="text-danger">*</sup></label>
    <input type="name" class="form-control" id="" name="mother_name" value="<?=html_escape($student->mother_name)?>" placeholder='enter mother name..' required>
    
  </div>
  <div class="col-md-6">
    <label for="" class="form-label">Mobile No<sup class="text-danger">*</sup></label>
    <input type="number" min="6000000000" max="9999999999" value="<?=html_escape($student->student_mobile)?>" name="student_mobile" class="form-control" id="" placeholder="enter student mobile no" required>
  </div>
  <div class="col-md-6">
    <label for="" class="form-label">Date Of Birth<sup class="text-danger">*</sup></label>
    <input type="date" class="form-control" id="" value="<?=html_escape(date('Y-m-d',$student->student_dob))?>" name="student_dob" placholder="enter student dob .." required>
  </div>

 <div class="col-md-6">
    <label for="" class="form-label">Gender<sup class="text-danger">*</sup></label>
    <select class="form-control" name="student_gender">
<option value="Male"  <?=$student->student_gender=='Male'?'selected':''?>>Male</option>
<option value="Female" <?=$student->student_gender=='Female'?'selected':''?>>Female</option>

</select>
  </div>
  <div class="col-md-6">
    <label for="" class="form-label">Center<sup class="text-danger">*</sup></label>
    <select class="form-control" name="center">
<?php
foreach($centers as $center){
    ?>
<option value="<?=$center->id?>" <?=$center->id==$student->center?'selected':''?>><?=$center->center_code.' : '.$center->center_name?></option>
    <?php
}
?>

</select>
  </div>
 

  <div class="col-md-12">
    <label for="" class="form-label">Address<sup class="text-danger">*</sup></label>
    <textarea type="text" class="form-control" id="" name="student_address" placeholder="enter student address here.." required><?=$student->student_address?></textarea>
  </div>
  
 
 
  <div class="col-12 text-end">
    <button type="submit" class="btn btn-primary"><i class="bi bi-person-fill-add"></i> Update Student</button>
  </div>
</form>

</div>
</div>