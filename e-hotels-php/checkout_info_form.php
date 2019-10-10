<!DOCTYPE html>
<?php
	
//Reservation data (all data are in string form)
	$start_date=$_POST['start_date'];
	$finish_date=$_POST['finish_date'];
//Room data	(all data are in string form)
	$room_id=$_POST['room_id'];
	$hotel_id=$_POST['hotel_id'];
	$price=$_POST['price'];
//People data
	$e_irs=$_POST['e_irs'];
	$c_irs=$_POST['c_irs'];

	
?>	
<html>
<head>
	
	<link rel="stylesheet" type="text/css" href="style_search5.css">
</head>
<body>
	<div id="srch">
	<center><h2> Check out!</h2></center>
		<center><form action="checkout_process.php" method="POST">
			<p>
				Does the room being checked-out need any repairs?
			</p>
			<p>
			<center><label class="container">Yes<input type="radio"  name="answer" value="yes"checked> 
			<span class="checkmark"></span>
			</center></label>
			<label class="container">No<input type="radio"  name="answer" value="no"checked>
			<span class="checkmark"></span>
			</label>
			</p>
			<p>
				<input type="submit" id="btn" name="Submit">
			</p>
				<input type="hidden" name="hotel_id" value=<?=$hotel_id;?>>
				<input type="hidden" name="room_id" value=<?=$room_id;?>>
				<input type="hidden" name="e_irs" value=<?=$e_irs;?>>
				<input type="hidden" name="c_irs" value=<?=$c_irs;?>>
				<input type="hidden" name="start_date" value=<?=$start_date;?>>
				<input type="hidden" name="finish_date" value=<?=$finish_date;?>>
				<input type="hidden" name="price" value=<?=$price;?>>
		<center></form>
	</div>
</body>
<?php

?>