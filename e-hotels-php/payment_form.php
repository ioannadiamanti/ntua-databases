<?php
	$start_date=$_POST['start_date'];
	$finish_date=$_POST['finish_date'];
	$room_id=$_POST['room_id'];
	$hotel_id=$_POST['hotel_id'];
	$price=$_POST['price'];
	$e_irs=$_POST['e_irs'];
	$c_irs=$_POST['c_irs']; 
?>

<html>
<head>
	<link rel="stylesheet" type="text/css" href="style_search6.css">
</head>
<body>

	<div id="srch">
	<center><h2> Payment method? </h2>
		<form action="payment_trans.php" method="POST">
			<p>
			<center><label class="container">Credit Card<input type="radio"  name="pmethod" value="Credit Card"checked> 
			<span class="checkmark"></span>
			</center></label>
			<label class="container">Cash<input type="radio"  name="pmethod" value="Cash"checked>
			<span class="checkmark"></span>
			</label>
			</p>
			<input type="submit" id="btn" name="Pay!">
			<input type="hidden" name="hotel_id" value=<?=$hotel_id;?>>
			<input type="hidden" name="room_id" value=<?=$room_id;?>>
			<input type="hidden" name="e_irs" value=<?=$e_irs;?>>
			<input type="hidden" name="c_irs" value=<?=$c_irs;?>>
			<input type="hidden" name="start_date" value=<?=$start_date;?>>
			<input type="hidden" name="finish_date" value=<?=$finish_date;?>>
			<input type="hidden" name="price" value=<?=$price;?>>
		</form></center>
	</div>
</body>
