<html>
<head>
<link rel="stylesheet" type="text/css" href="data.css">
</head>
<body>

<?php

	//Repair data
	$needrepair=$_POST['answer'];
	
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
	
	//Connection data
	$servername = "localhost";
	$username = "root";
	$password = "";
	$dbname = "hotel_db";

	// Create connection
	$conn = new mysqli($servername, $username, $password, $dbname);

	// Check connection
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	}

	//Update rents
	$query = "update rents set Finish_Date=curdate() where Room_id='$room_id' ";
	if ($conn->query($query) === TRUE) {
		//echo "Finish Date in 'rents' updated successfully". "<br>";
	}
	else {
			echo "Error: " . $query . "<br>" . $conn->error;
	}
		
	//Update reserves	
	$query = "update reserves set Finish_Date=curdate() where Room_ID='$room_id' ";
	if ($conn->query($query) === TRUE) {
		//echo "Finish Date in 'reserves' updated successfully". "<br>";
	}
	else {
			echo "Error: " . $query . "<br>" . $conn->error;
	}
	
	//Update room 
	if ($needrepair=="yes"){
		$query = "update hotel_room set Repairs_need = 'yes' where Room_id='$room_id' ";
		if ($conn->query($query) === TRUE) {
			//echo "RepairsNeed in 'hotel_room' updated successfully". "<br>";
		}
		else {
			echo "Error: " . $query . "<br>" . $conn->error;
		}
	}
	else {
		$query = "update hotel_room set Repairs_need = 'no' where Room_id='$room_id' ";
		if ($conn->query($query) === TRUE) {
			//echo "RepairsNeed in 'hotel_room' updated successfully". "<br>";
		}
		else {
			echo "Error: " . $query . "<br>" . $conn->error;
		}
	}
	
	?>
	<html>
		<head>
			<title>Check-out</title>
			<link rel="stylesheet" type="text/css" href="style_search.css">
		</head>
		<body>
			<div id="srch">
				<center><form action="payment_form.php" method="POST">
					<p>
					You are almost done!	
					</p>					
					<p>
					</p>
					You just need to pay to complete your check-out!
					<p>
					<input type="submit" id="btn" value="Pay!"></input>	
					</p>
					<input type="hidden" name="hotel_id" value=<?=$hotel_id;?>>
					<input type="hidden" name="room_id" value=<?=$room_id;?>>
					<input type="hidden" name="e_irs" value=<?=$e_irs;?>>
					<input type="hidden" name="c_irs" value=<?=$c_irs;?>>
					<input type="hidden" name="start_date" value=<?=$start_date;?>>
					<input type="hidden" name="finish_date" value=<?=$finish_date;?>>
					<input type="hidden" name="price" value=<?=$price;?>>
				</center></form>
			</div>
		</body>	
			
<?php	
	
	$conn->close();

?>	