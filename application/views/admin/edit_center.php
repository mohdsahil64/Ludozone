<div class="bg-white p-2 m-2 rounded shadow-sm">
<div>
<div class="d-flex justify-content-between">
<h5>Update Center</h5>
<a href="<?=base_url('admin/centerslist')?>" class="btn btn-sm btn-outline-primary showloading"><i class="bi bi-arrow-left-circle"></i> Back</a>
</div>
<hr>

<?=form_open_multipart('admin/updatecenter/'.$center->id,'class="row g-3"')?>
    <div class="d-flex justify-content-between col-12 border-bottom pb-2">
<div class=" mx-1">
    <img src="<?=base_url('assets/uploads/'.$center->director_profile)?>" id="directorprofile" class="rounded border" width="90px" height="90px"/><br>
    <label for="" class="form-label">Director Profile</label>
    <input type="file" class="form-control" name="director_profile" id="directorprofilei" accept="image/png, image/gif, image/jpeg,image/jpg">
    <?php
    if($this->session->flashdata('director-profile-error')){
        ?>
<p class="text-danger">image is larger than 1mb</p>
        <?php
    }
    ?>
  </div>  
 
  <div class=" mx-1 text-end">
  <img src="<?=base_url('assets/uploads/'.$center->center_logo)?>" class="rounded border" id="centerlogo" width="90px" height="90px"/><br>
    <label for="" class="form-label">Center Logo</label>
    <input type="file" class="form-control" name="center_logo" id="centerlogoi" accept="image/png, image/gif, image/jpeg,image/jpg">
    <?php
    if($this->session->flashdata('center-logo-error')){
        ?>
<p class="text-danger">image is larger than 1mb</p>
        <?php
    }
    ?>
  </div>
</div>
  <div class="col-md-6">
    <label for="" class="form-label">Director's Name<sup class="text-danger">*</sup></label>
    <input type="name" class="form-control" id="" name="director_name" value="<?=html_escape($center->director_name)?>" placeholder='enter center director name..' required>
  </div>
  
  <div class="col-md-6">
    <label for="" class="form-label">Status<sup class="text-danger">*</sup></label>
    <select class="form-control" name="status">

<option value="2" <?=$center->status==2?'selected':''?>>Active</option>
<option value="1"  <?=$center->status==1?'selected':''?>>Inactive</option>

</select>
  </div>

  <div class="col-md-6">
    <label for="" class="form-label">Email Id<sup class="text-danger">*</sup></label>
    <input type="email" class="form-control" id="" name="director_email" value="<?=html_escape($center->director_email)?>" placeholder="enter director email id.." required>
  </div>
  <div class="col-md-6">
    <label for="" class="form-label">Login Password<sup class="text-danger">*</sup></label>
    <input type="text" class="form-control" id="" name="password" value="<?=$center->password?>" placeholder="enter center password" required>
  </div>

  <div class="col-md-6">
    <label for="" class="form-label">Aadhar No<sup class="text-danger">*</sup></label>
    <input type="number" name="aadhar" class="form-control" id="" value="<?=$center->aadhar?>" placeholder="enter aadhar card no" required>
  </div>
  <div class="col-md-6">
    <label for="" class="form-label">PAN<sup class="text-danger">*</sup></label>
    <input type="text"  name="pancard" class="form-control" id="" value="<?=$center->pancard?>" placeholder="enter pan no" required>
  </div>

  <div class="col-md-6">
    <label for="" class="form-label">Mobile No<sup class="text-danger">*</sup></label>
    <input type="number" min="6000000000" max="9999999999" name="director_mobile"  value="<?=html_escape($center->director_mobile)?>" class="form-control" id="" placeholder="enter director mobile no" required>
  </div>
  <div class="col-md-6">
    <label for="" class="form-label">Date Of Birth<sup class="text-danger">*</sup></label>
    <input type="date" class="form-control" id="dob" value="<?=date('Y-m-d',$center->director_dob)?>" name="director_dob" placholder="enter director dob .." required>
  </div>
  <div class="col-md-6">
    <label for="" class="form-label">Gender<sup class="text-danger">*</sup></label>
    <select class="form-control" name="director_gender">
<option value="Male"  <?=$center->director_gender=='Male'?'selected':''?>>Male</option>
<option value="Female" <?=$center->director_gender=='Female'?'selected':''?>>Female</option>

</select>
  </div>
  <div class="col-md-6">
    <label for="" class="form-label">Center Name<sup class="text-danger">*</sup></label>
    <input type="text" class="form-control" name="center_name" value="<?=html_escape($center->center_name)?>" placeholder="enter center name here.." required>
  </div>


  <div class="col-12">
    <label for="" class="form-label">Center Address<sup class="text-danger">*</sup></label>
    <textarea type="text" class="form-control" id="" name="center_address" placeholder="enter center address here.." required><?=$center->center_address?></textarea>
  </div>
  
 
 
  <div class="col-12 text-end">
    <button type="submit" class="btn btn-primary"><i class="bi bi-building-add"></i> Update Center</button>
  </div>
</form>

</div>
</div>