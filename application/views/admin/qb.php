<?php
$status=[1=>'<div class="d-flex align-items-center"><div style="width:7px;height:7px"class="inline-block bg-danger rounded-circle"></div>&nbsp;Inactive</div>',
2=>'<div class="d-flex align-items-center"><div style="width:7px;height:7px"class="inline-block bg-success rounded-circle"></div>&nbsp;Active</div>'];
?>
<div class="bg-white p-2 m-2 rounded shadow-sm">
<div>
<div class="d-flex justify-content-between">
<h5>Question Banks</h5>
<button class="btn btn-sm btn-primary" data-coreui-toggle="modal" data-coreui-target="#addq"><i class="bi bi-plus-lg"></i> Add Quiz</button>
</div>
<!-- delete center mdoal start -->

<div class="modal fade" id="addq" data-coreui-backdrop="static" data-coreui-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">Add New Quiz</h5>
        <button type="button" class="btn-close" data-coreui-dismiss="modal" aria-label="Close"></button>
      </div>
      <?=form_open('admin/addqb')?>
      <div class="modal-body">
   <label>Enter Quiz Title</label>
   <input type="text" class="form-control my-1" name="qb_title" placeholder="enter title here.." required>
   <label>Price ₹</label>
   <input type="number" class="form-control my-1" name="price" placeholder="enter price.." required>
   <label>Course</label>
   <?php
$courses = $this->db->where('status',2)->get('courses')->result();
   ?>
   <select class="form-control my-1" name="course_id">
<?php
foreach($courses as $course){
  ?>
<option value="<?=$course->id?>"><?=$course->course_title?></option>
  <?php
}
?>
</select>

      </div>
      <div class="modal-footer">
      
      
        <button type="button" class="btn btn-secondary" data-coreui-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary">Add Quiz</button>


      </div>
      </form>
    </div>
  </div>
</div>

<!-- delete center modal ends  -->
<hr>
<div class="table-responsive">
<table class="table">
<thead>
<tr>
<th>#</th>
<th class="text-nowrap">Quiz Title</th>
<th class="text-nowrap">Course</th>
<th class="text-nowrap">Price</th>
<th class="text-nowrap">Actions</th>

</tr>
</thead>
<tbody>
<?php
$count=1;
foreach($qbs as $qb){
    ?>
<tr>
<td><?=$count?></td>
<td class="text-nowrap"><?=$qb->qb_title?></td>

<td class="text-nowrap"><?=$this->db->where('id',$qb->course_id)->get('courses')->row()->course_title?></td>
<td class="text-nowrap">₹<?=number_format($qb->price)?></td>

<td class="text-nowrap">
<!-- <button class="btn btn-sm btn-warning" data-coreui-toggle="modal" title="Show Course Details" data-coreui-target="#viewcourseinfo<?=$course->id?>"><i class="bi bi-info-circle"></i></button> -->
    <a href="<?=base_url('admin/addquestion/'.$qb->id)?>" title="Add Questions" class="btn btn-sm btn-primary showloading"><i class="bi bi-question-circle"></i> Questions (<?=$this->db->where('qb_id',$qb->id)->get('questions')->num_rows()?>)</a>


    <button class="btn btn-sm btn-primary" data-coreui-toggle="modal" title="Edit Quiz" data-coreui-target="#editcourse<?=$qb->id?>"><i class="bi bi-pencil-square"></i></button>

        <button class="btn btn-sm btn-danger" data-coreui-toggle="modal" title="Delete Quiz" data-coreui-target="#deletecourse<?=$qb->id?>"><i class="bi bi-trash3"></i></button>

<!-- delete center mdoal start -->

<div class="modal fade" id="editcourse<?=$qb->id?>" data-coreui-backdrop="static" data-coreui-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel"><?=$qb->qb_title?></h5>
        <button type="button" class="btn-close" data-coreui-dismiss="modal" aria-label="Close"></button>
      </div>
      <?=form_open('admin/updateqb/'.$qb->id)?>
      <div class="modal-body">
   <label>Quiz Title</label>
   <input type="text" class="form-control my-1" name="qb_title" value="<?=$qb->qb_title?>" placeholder="enter title here.." required>
   <label>Price ₹</label>
   <input type="number" class="form-control my-1" name="price" value="<?=$qb->price?>" placeholder="enter price.." required>
   <label>Course</label>
   <?php
$courses = $this->db->where('status',2)->get('courses')->result();
   ?>
   <select class="form-control my-1" name="course_id">
<?php
foreach($courses as $course){
  ?>
<option value="<?=$course->id?>" <?=$qb->course_id==$course->id?'selected':''?>><?=$course->course_title?></option>
  <?php
}
?>
</select>

      </div>
      <div class="modal-footer">
      
      
        <button type="button" class="btn btn-secondary" data-coreui-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary">Update Quiz</button>


      </div>
      </form>

    </div>
  </div>
</div>

<!-- delete center modal ends  -->


<!-- delete center mdoal start -->

<div class="modal fade" id="deletecourse<?=$qb->id?>" data-coreui-backdrop="static" data-coreui-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel"><?=$qb->qb_title?></h5>
        <button type="button" class="btn-close" data-coreui-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <p class="fs-5 text-wrap">Are you sure You Want To Delete this Question Bank?</p>

      </div>
      <div class="modal-footer">
        <?=form_open('admin/deleteqb')?>
        <input type="hidden" name="id" value="<?=$qb->id?>" />
        <button type="button" class="btn btn-secondary" data-coreui-dismiss="modal">No</button>
        <button type="submit" class="btn btn-danger" data-coreui-dismiss="modal">Yes</button>
</form>

      </div>
    </div>
  </div>
</div>

<!-- delete center modal ends  -->



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