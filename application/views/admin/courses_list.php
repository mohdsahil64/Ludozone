<?php
$status=[1=>'<div class="d-flex align-items-center"><div style="width:7px;height:7px"class="inline-block bg-danger rounded-circle"></div>&nbsp;Inactive</div>',
2=>'<div class="d-flex align-items-center"><div style="width:7px;height:7px"class="inline-block bg-success rounded-circle"></div>&nbsp;Active</div>'];
?>
<div class="bg-white p-2 m-2 rounded shadow-sm">
<div>
<h5>Courses</h5>
<hr>
<div class="table-responsive">
<table class="table">
<thead>
<tr>
<th>#</th>
<th class="text-nowrap">Course Code</th>
<th class="text-nowrap">Course Title</th>
<th class="text-nowrap">Duration</th>
<th class="text-nowrap">Course Fee</th>
<th class="text-nowrap">Status</th>
<th class="text-nowrap">Actions</th>

</tr>
</thead>
<tbody>
<?php
$count=1;
foreach($courses as $course){
    ?>
<tr>
    <td><?=$count?></td>
    <td class="text-nowrap">C<?=$course->id+100?></td>
    <td class="text-nowrap"><?=$course->course_title?></td>
    <td class="text-nowrap"><?=$course->course_duration?> Months</td>
    <td class="text-nowrap"><i class="bi bi-currency-rupee"></i> <?=number_format($course->course_fee,0)?> Rs</td>
    <td class="text-nowrap"><?=@$status[$course->status]?></td>


    <td class="text-nowrap">
    <button class="btn btn-sm btn-warning" data-coreui-toggle="modal" title="Show Course Details" data-coreui-target="#viewcourseinfo<?=$course->id?>"><i class="bi bi-info-circle"></i></button>
    <a href="<?=base_url('admin/editcourse/'.$course->id)?>" title="Edit Center" class="btn btn-sm btn-primary showloading"><i class="bi bi-pencil-square"></i></a>



        <button class="btn btn-sm btn-danger" data-coreui-toggle="modal" title="Delete Course" data-coreui-target="#deletecourse<?=$course->id?>"><i class="bi bi-trash3"></i></button>


<!-- delete center mdoal start -->

<div class="modal fade" id="deletecourse<?=$course->id?>" data-coreui-backdrop="static" data-coreui-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel"><?=$course->course_title?></h5>
        <button type="button" class="btn-close" data-coreui-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <p class="fs-5 text-wrap">Are you sure You Want To Delete this Course ?</p>

      </div>
      <div class="modal-footer">
        <?=form_open('admin/deletecourse')?>
        <input type="hidden" name="id" value="<?=$course->id?>" />
        <button type="button" class="btn btn-secondary" data-coreui-dismiss="modal">No</button>
        <button type="submit" class="btn btn-danger" data-coreui-dismiss="modal">Yes</button>
</form>

      </div>
    </div>
  </div>
</div>

<!-- delete center modal ends  -->



<!-- view info modal start -->
<div class="modal fade" id="viewcourseinfo<?=$course->id?>" data-coreui-backdrop="static" data-coreui-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel"><?=$course->course_title?></h5>
        <button type="button" class="btn-close" data-coreui-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body table-responsive">
      
        <table class="table w-100">

<tr>
    <td class="fw-bold">Course Title</td><td class=""><?=$course->course_title?></td>
</tr>
<tr>
    <td class="fw-bold">Course Duration</td><td class=""><?=$course->course_duration?> Months</td>
</tr>

<tr>
    <td class="fw-bold">Course Fee's</td><td class=""><i class="bi bi-currency-rupee"></i> <?=number_format($course->course_fee,0)?> Rs</td>
</tr>
<tr>
    <td class="fw-bold">Course Code</td><td class="">C<?=$course->id+100?></td>
</tr>
<tr>
    <td class="fw-bold">Created On</td><td class=""><?=date('d M,Y h:i A',$course->created_at)?></td>
</tr>
<tr>
    <td class="fw-bold">Last Updated on</td><td class=""><?=$course->updated_at?date('d M,Y h:i A',$course->updated_at):'not updated'?></td>
</tr>
<tr>
    <td colspan="2" class=""><span class="fw-bold">Course Info</span><br>
<pre><?=$course->course_info?></pre>
</td>
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