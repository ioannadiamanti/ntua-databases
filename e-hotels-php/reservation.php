<html>
<head>
<link rel="stylesheet" type="text/css" href="data.css">
</head>
<body>

<?php
	
	//Customer data	
	$IRS=$_POST['irs_number'];
	
	//Reservation data (all data are in string form)
	$start_date=$_POST['start_date'];
	$finish_date=$_POST['finish_date'];
	$paid='no'; 
	
	//Room data	(all data are in string form)
	$room_id=$_POST['room_id'];
	$hotel_id=$_POST['hotel_id'];
	$hotel_name=$_POST['hotel_name'];
	$hotelgroup_name=$_POST['hotelgroup_name'];
	
	
	$conn = new mysqli("localhost", "root","", "hotel_db");
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	} 
	
	$query = "select * from customer where IRS_Number = '$IRS'";	
	$result = mysqli_query($conn, $query)or die (mysqli_error($conn));
	if ($result -> num_rows == 0 ){
		?>
	
	<html>
		<head>
			<title>Reservation Failure</title>
			<link rel="stylesheet" type="text/css" href="style_search.css">
		</head>
		<body>
			<div id="srch">
				<center><form action="registration_form.php" method="POST">
					<p>
					It seems that you are not registered. Please register to continue.	
					</p>					
					<p>
					<input type="submit" id="btn" value="OK!"></input>	
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
					echo '<input type="hidden" name="hotel_group_name[]" value="'. $hg_n. '">';
				}?>
				<input type="hidden" name="start_date" value=<?=$start_date;?>>
				<input type="hidden" name="finish_date" value=<?=$finish_date;?>>
					
				</center></form>
			</div>
		</body>	
			
<?php		
			
			
	}
	else{
	
	$flag = true;
	
	for($i=0; $i < count($room_id); $i++){
		$sql_reserves = "INSERT INTO reserves (IRS_Number_Customer, Room_ID, Hotel_ID, Start_Date, Paid, Finish_Date, Hotel_name, Hotelgroup_name)
		VALUES ('$IRS', '$room_id[$i]', '$hotel_id[$i]', '$start_date', '$paid', '$finish_date', '$hotel_name[$i]', '$hotelgroup_name[$i]' )";
		if ($conn->query($sql_reserves) === FALSE) {
			$flag = false;
		}			
	}
	if ($flag) {
		
?>
	
	<html>
		<head>
			<title>Reservation Success</title>
			<link rel="stylesheet" type="text/css" href="style_search.css">
		</head>
		<body>
			<div id="srch">
				<center><form action="e-hotels.php" method="POST">
					<p>
					Your reservation has successfully completed!	
					</p>					
					<p>
					Enjoy your trip!
					</p>
					<p>
					<input type="submit" id="btn" value="OK!"></input>	
					</p>
				</center></form>
			</div>
		</body>	
			
<?php		
		
	} 
	
	else {
			echo "Error: " . $sql_reserves . "<br>" . $conn->error;
		}
	}
	$conn->close();
?>
	