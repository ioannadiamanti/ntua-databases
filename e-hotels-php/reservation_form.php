<!DOCTYPE html>
<?php
	
//Reservation data (all data are in string form)
	$start_date=$_POST['start_date'];
	$finish_date=$_POST['finish_date'];
//Room data	(all data are in string form)
	$room_id=$_POST['room_id'];
	$hotel_id=$_POST['hotel_id'];
	$hotel_name=$_POST['hotel_name'];
	$hotelgroup_name=$_POST['hotel_group_name'];
?>	
<html>
<head>
	<title>Reservation</title>
	<link rel="stylesheet" type="text/css" href="style_search3.css">
</head>
<body>
	<div id="srch">
	<center><h2>Reservation</h2><center>
		<center><form action="reservation.php" method="POST">
			Please fill the following field to proceed:
			<p>
				<label> <b>IRS Number*</label><br>
				<input type="text" name="irs_number" required>
			</p>
			
			*Mandatory Field </b>
			<?php foreach($room_id as $r_id){
					echo '<input type="hidden" name="room_id[]" value="'. $r_id. '">';
				}
				foreach($hotel_id as $h_id){
					echo '<input type="hidden" name="hotel_id[]" value="'. $h_id. '">';
				}
				foreach($hotel_name as $h_n){
					echo '<input type="hidden" name="hotel_name[]" value="'. $h_n. '">';
				}
				foreach($hotelgroup_name as $hg_n){
					echo '<input type="hidden" name="hotelgroup_name[]" value="'. $hg_n. '">';
				}?>
				<input type="hidden" name="start_date" value=<?=$start_date;?>>
				<input type="hidden" name="finish_date" value=<?=$finish_date;?>>
			<p>
				<input type="submit" id="btn" name="Submit">
			</p>
</center></form>
	</div>
	
</body>
<?php

?>