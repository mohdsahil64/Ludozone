<?php
$status=[1=>'<div class="d-flex align-items-center"><div style="width:7px;height:7px"class="inline-block bg-danger rounded-circle"></div>&nbsp;Inactive</div>',
2=>'<div class="d-flex align-items-center"><div style="width:7px;height:7px"class="inline-block bg-success rounded-circle"></div>&nbsp;Active</div>'];
?>
<div class="bg-white p-2 m-2 rounded shadow-sm">
<div>
<div class="d-flex justify-content-between">
<h5><?=$qb->qb_title?></h5>
<div>
<button class="btn btn-sm btn-primary" data-coreui-toggle="modal" data-coreui-target="#addq"><i class="bi bi-plus-lg"></i> Add Question</button>
<a href="<?=base_url('admin/questionbank')?>" class="btn btn-sm btn-outline-primary showloading"><i class="bi bi-arrow-left-circle"></i> Back</a>
</div>
</div>
<!-- delete center mdoal start -->

<div class="modal fade" id="addq" data-coreui-backdrop="static" data-coreui-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">Add Question</h5>
        <button type="button" class="btn-close" data-coreui-dismiss="modal" aria-label="Close"></button>
      </div>
      <?=form_open('admin/addq/'.$qb->id)?>
      <div class="modal-body">
   <p>Enter Question</p>
   <input type="text" class="form-control mb-2" name="question" placeholder="enter question here" required>

<div class="input-group mb-2">
  <span class="input-group-text" id="basic-addon1">a.</span>
  <input type="text" class="form-control" name="op1" placeholder="Option 1" required>
</div>
<div class="input-group mb-2">
  <span class="input-group-text" id="basic-addon1">b.</span>
  <input type="text" class="form-control" name="op2" placeholder="Option 2" required>
</div>
<div class="input-group mb-2">
  <span class="input-group-text" id="basic-addon1">c.</span>
  <input type="text" class="form-control" name="op3" placeholder="Option 3" required>
</div>
<div class="input-group mb-2">
  <span class="input-group-text" id="basic-addon1">d.</span>
  <input type="text" class="form-control" name="op4" placeholder="Option 4" required>
</div>
<p>Correct Option</p>
<div class="d-flex justify-content-between col-md-6">
<div class="form-check">
  <input class="form-check-input" type="radio" name="correct_op" id="op1" value="1" checked>
  <label class="form-check-label" for="op1">
    a
  </label>
</div>

<div class="form-check">
  <input class="form-check-input" type="radio" name="correct_op" id="op2" value="2">
  <label class="form-check-label" for="op2">
    b
  </label>
</div>

<div class="form-check">
  <input class="form-check-input" type="radio" name="correct_op" id="op3" value="3">
  <label class="form-check-label" for="op3">
    c
  </label>
</div>

<div class="form-check">
  <input class="form-check-input" type="radio" name="correct_op" id="op4" value="4">
  <label class="form-check-label" for="op4">
    d
  </label>
</div>


</div>
      </div>
      <div class="modal-footer">
      
      
        <button type="button" class="btn btn-secondary" data-coreui-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary">Add Question</button>


      </div>
      </form>
    </div>
  </div>
</div>

<!-- delete center modal ends  -->
<hr>
<div class="table-responsive">
<div class="accordion" id="accordionExample">

<?php
$count=1;
foreach($questions as $q){
    ?>
<div class="accordion-item">
    <h2 class="accordion-header">
      <button class="accordion-button" type="button" data-coreui-toggle="collapse" data-coreui-target="#collapseOne<?=$q->id?>" aria-expanded="true" aria-controls="collapseOne">
       Q<?=$count?>. <?=$q->question?>
      </button>
    </h2>
    <div id="collapseOne<?=$q->id?>" class="accordion-collapse collapse" aria-labelledby="headingOne" data-coreui-parent="#accordionExample">
      <div class="accordion-body">
<div>

<div class="form-check">
  <input class="form-check-input" type="radio" name="correct_op" id="q<?=$q->id?>op1" value="1">
  <label class="form-check-label" for="q<?=$q->id?>op1">
    a. <?=$q->op1?> <?=$q->correct_op==1?'<span class="text-success small"><i class="bi bi-patch-check-fill"></i> Correct Option</span>':''?>
  </label>
</div>

<div class="form-check">
  <input class="form-check-input" type="radio" name="correct_op" id="q<?=$q->id?>op2" value="2">
  <label class="form-check-label" for="q<?=$q->id?>op2">
    b. <?=$q->op2?> <?=$q->correct_op==2?'<span class="text-success small"><i class="bi bi-patch-check-fill"></i> Correct Option</span>':''?>
  </label>
</div>

<div class="form-check">
  <input class="form-check-input" type="radio" name="correct_op" id="q<?=$q->id?>op3" value="3">
  <label class="form-check-label" for="q<?=$q->id?>op3">
    c. <?=$q->op3?> <?=$q->correct_op==3?'<span class="text-success small"><i class="bi bi-patch-check-fill"></i> Correct Option</span>':''?>
  </label>
</div>

<div class="form-check">
  <input class="form-check-input" type="radio" name="correct_op" id="q<?=$q->id?>op4" value="4">
  <label class="form-check-label" for="q<?=$q->id?>op4">
    d. <?=$q->op1?> <?=$q->correct_op==4?'<span class="text-success small"><i class="bi bi-patch-check-fill"></i> Correct Option</span>':''?>
  </label>
</div>



</div>
      </div>
    </div>
  </div>
    <?php
    $count++;
}
?>



 

</div>
</div>


</div>
</div>