<div class="bg-white p-2 m-2 rounded shadow-sm">
<div>
<h5>Add New Course</h5>
<hr>

<?=form_open_multipart('admin/savecourse','class="row g-3"')?>
    <!-- <div class="d-flex justify-content-between col-12 border-bottom pb-2">
<div class=" mx-1">
    <img src="<?=base_url('assets/images/noprofile.png')?>" id="directorprofile" class="rounded border" width="90px" height="90px"/><br>
    <label for="" class="form-label">Course</label>
    <input type="file" class="form-control" name="director_profile" id="directorprofilei" accept="image/png, image/gif, image/jpeg,image/jpg">
    <?php
    if($this->session->flashdata('course-error')){
        ?>
<p class="text-danger">image is larger than 1mb</p>
        <?php
    }
    ?>
  </div>  
 
  <div class=" mx-1 text-end">

  </div>
</div> -->
  <div class="col-md-6">
    <label for="" class="form-label">Course Title<sup class="text-danger">*</sup></label>
    <input type="name" class="form-control" id="" name="course_title" placeholder='enter course title here..' required>
  </div>

  <div class="col-md-6">
    <label for="" class="form-label">Course Fee (Total)<sup class="text-danger">*</sup></label>
    <input type="number" min="0" name="course_fee" class="form-control" id="" placeholder="enter course fee .." required>
  </div>

  <div class="col-md-6">
    <label for="" class="form-label">Course Duration (In Months)<sup class="text-danger">*</sup></label>
    <input type="number" min="0" name="course_duration" class="form-control" id="" placeholder="enter course duration.." required>
  </div>

  <div class="col-md-6">
    <label for="" class="form-label">Status<sup class="text-danger">*</sup></label>
    <select class="form-control" name="status">

<option value="2">Active</option>
<option value="1">Inactive</option>

</select>
  </div>

  <div class="col-12">
    <label for="" class="form-label">Course Info<sup class="text-danger">*</sup></label>
    <textarea type="text" class="form-control" id="" name="course_info" placeholder="enter course info here.." required></textarea>
  </div>
  
 
 
  <div class="col-12 text-end">
    <button type="submit" class="btn btn-primary"><i class="bi bi-journal-plus"></i> Add Course</button>
  </div>
</form>

</div>
</div>