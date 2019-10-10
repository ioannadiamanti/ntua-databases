<!DOCTYPE html>
<?php

	
	$start_date=$_POST['start_date'];
	$finish_date=$_POST['finish_date'];
	$room_id=$_POST['room_id'];
	$hotel_id=$_POST['hotel_id'];
	$hotel_name=$_POST['hotel_name'];
	$hotelgroup_name=$_POST['hotel_group_name'];
		
?>
<html>
<head>
	<title>Registration</title>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
<body>
	<div id="srch">
	<center><h2>Registration</h2></center>
		<center><form action="registration_process.php" method="POST">
			<p>
				<label> <b>IRS Number*</label><br>
				<input type="text" name="IRS" required>
			</p>
			
			<p>
				<label> First Name*</label><br>
				<input type="text" name="first_name" required>
			</p>
			<p>
				<label> Last Name*</label><br>
				<input type="text" name="last_name" required>
			</p>
			<p>
				<label> Street*</label><br>
				<input type="text" name="Street" required>
			</p>
			<p>
				<label> Number*</label><br>
				<input type="text" name="number" required>
			</p>
			<p>
				<label> City*</label><br>
				<input type="text" name="city" required>
			</p>
			<p>
				<label> Postal Code*</label><br>
				<input type="text" name="postal_code" required>
			</p>
			<p>
				<label> SSN*</label><br>
				<input type="text" name="ssn" required>
			</p>
			*Mandatory Field</b>
			<p>
				<input type="submit" id="btn" name="Submit">
			</p>
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
			
</center></form>
	</div>
	
</body>
<?php

?>