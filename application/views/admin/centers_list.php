<?php
$status=[1=>'<div class="d-flex align-items-center"><div style="width:7px;height:7px"class="inline-block bg-danger rounded-circle"></div>&nbsp;Inactive</div>',
2=>'<div class="d-flex align-items-center"><div style="width:7px;height:7px"class="inline-block bg-success rounded-circle"></div>&nbsp;Active</div>'];
?>
<div class="bg-white p-2 m-2 rounded shadow-sm">
<div>
<h5>Centers</h5>
<hr>
<div class="table-responsive">
<table class="table">
<thead>
<tr>
<th>#</th>
<th class="text-nowrap">Center Code</th>
<th class="text-nowrap">Center Name</th>
<th class="text-nowrap">Director Name</th>
<th class="text-nowrap">Students</th>
<th class="text-nowrap">Status</th>
<th class="text-nowrap">Actions</th>

</tr>
</thead>
<tbody>
<?php
$count=1;
foreach($centers as $center){
    ?>
<tr>
    <td><?=$count?></td>
    <td class="text-nowrap"><?=$center->center_code?></td>
    <td class="text-nowrap"><?=$center->center_name?></td>
    <td class="text-nowrap"><?=$center->director_name?></td>
    <td class="text-nowrap"><a href=""><?=$this->db->where('center',$center->id)->get('students')->num_rows()?></a></td>
    <td class="text-nowrap"><?=@$status[$center->status]?></td>


    <td class="text-nowrap">
    <button class="btn btn-sm btn-warning" data-coreui-toggle="modal" title="Show Center Details" data-coreui-target="#viewcenterinfo<?=$center->id?>"><i class="bi bi-info-circle"></i></button>
    <a href="<?=base_url('admin/editcenter/'.$center->id)?>" title="Edit Center" class="btn btn-sm btn-primary showloading"><i class="bi bi-pencil-square"></i></a>
    <!-- <a href="<?=base_url('admin/editcenter/'.$center->id)?>" title="Manage Center Users" class="btn btn-sm btn-primary showloading"><i class="bi bi-person-add"></i></a> -->
    <button title="Manage Center Courses" class="btn btn-sm btn-primary" data-coreui-toggle="modal" data-coreui-target="#course<?=$center->id?>"><i class="bi bi-journal-plus"></i></button>


        <button class="btn btn-sm btn-danger" data-coreui-toggle="modal" title="Delete Center" data-coreui-target="#deletecenter<?=$center->id?>"><i class="bi bi-trash3"></i></button>


<!-- delete center mdoal start -->

<div class="modal fade" id="deletecenter<?=$center->id?>" data-coreui-backdrop="static" data-coreui-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel"><?=$center->center_name?></h5>
        <button type="button" class="btn-close" data-coreui-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <p class="fs-5 text-wrap">Are you sure You Want To Delete this Center ?</p>

      </div>
      <div class="modal-footer">
        <?=form_open('admin/deletecenter')?>
        <input type="hidden" name="id" value="<?=$center->id?>" />
        <button type="button" class="btn btn-secondary" data-coreui-dismiss="modal">No</button>
        <button type="submit" class="btn btn-danger" data-coreui-dismiss="modal">Yes</button>
</form>

      </div>
    </div>
  </div>
</div>

<!-- delete center modal ends  -->

<!-- courses starts here -->
<div class="modal fade" id="course<?=$center->id?>" data-coreui-backdrop="static" data-coreui-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel"><?=$center->center_name?></h5>
        <button type="button" class="btn-close" data-coreui-dismiss="modal" aria-label="Close"></button>
      </div>
      <?=form_open('admin/updatecentercourses','class="updatecentercourses"')?>
      <div class="modal-body">
      <p class="fs-5 text-wrap">Available Courses</p>
      <?php

foreach($courses as $course){
    
    ?>
<div class="form-check">
  <input class="form-check-input" type="checkbox" value="<?=$course->id?>" name="courses[]" id="flexCheckDefault<?=$course->id.$center->center_code?>" <?=$this->db->where('center_id',$center->id)->where('course_id',$course->id)->get('center_course_rel')->num_rows()?'checked':''?>>
  <label class="form-check-label" for="flexCheckDefault<?=$course->id.$center->center_code?>">
  <?=$course->course_title?>
  </label>
</div>
    <?php
}
      ?>
      </div>
      <div class="modal-footer">
       
        <input type="hidden" name="id" value="<?=$center->id?>" />
        <button type="button" class="btn btn-secondary" data-coreui-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary">Update Courses Selection</button>


      </div>
      </form>
    </div>
  </div>
</div>
<!-- courses ends here -->

<!-- view info modal start -->
<div class="modal fade" id="viewcenterinfo<?=$center->id?>" data-coreui-backdrop="static" data-coreui-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel"><?=$center->center_name?></h5>
        <button type="button" class="btn-close" data-coreui-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body table-responsive">
      
        <table class="table w-100">
<tr>
    <td class="border"><img src="<?=base_url('assets/uploads/'.$center->director_profile)?>" class="rounded" width="90px" height="90px"/>
<p class="m-0 ">Director Profile</p>
</td>
    <td class="border"><img src="<?=base_url('assets/uploads/'.$center->center_logo)?>" class="rounded" width="90px" height="90px"/>
    <p class="m-0 ">Center Logo</p>
</td>
</tr>
<tr>
    <td class="fw-bold">Director's Name</td><td class=""><?=$center->director_name?></td>
</tr>
<tr>
    <td class="fw-bold">Director's Email</td><td class=""><?=$center->director_email?></td>
</tr>
<tr>
    <td class="fw-bold">Director's Mobile</td><td class=""><?=$center->director_mobile?></td>
</tr>
<tr>
    <td class="fw-bold">Director's DOB</td><td class=""><?=date('d M,Y',$center->director_dob)?></td>
</tr>
<tr>
    <td class="fw-bold">Director's Gender</td><td class=""><?=$center->director_gender?></td>
</tr>
<tr>
    <td class="fw-bold">Center Name</td><td class=""><?=$center->center_name?></td>
</tr>
<tr>
    <td class="fw-bold">Center Address</td><td class="text-wrap"><?=$center->center_address?></td>
</tr>
<tr>
    <td class="fw-bold">Center Code</td><td class=""><?=$center->center_code?></td>
</tr>
<tr>
    <td class="fw-bold">Aadhar No</td><td class=""><?=$center->aadhar?></td>
</tr>
<tr>
    <td class="fw-bold">Pan Card</td><td class=""><?=$center->pancard?></td>
</tr>
<tr>
    <td class="fw-bold">Created On</td><td class=""><?=date('d M,Y h:i A',$center->created_at)?></td>
</tr>
<tr>
    <td class="fw-bold">Last Updated on</td><td class=""><?=$center->updated_at?date('d M,Y h:i A',$center->updated_at):'not updated'?></td>
</tr>
</table>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-coreui-dismiss="modal">Close</button>

      </div>
    </div>
  </div>
</div>
<!-- view info modal ends here -->
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