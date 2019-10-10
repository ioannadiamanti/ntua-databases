<?php

	$hotel_id = $_POST['hotel_id'];
	$room_id = $_POST['room_id'];
	$e_irs = $_POST['e_irs'];
	$c_irs = $_POST['c_irs'];
	$start_date =  $_POST['start_date'];
	$finish_date =  $_POST['finish_date']; 
	$hotel_name =  $_POST['hotel_name']; 
	$hotelgroup_name =  $_POST['hotelgroup_name']; 
	
	//Connection data
	$servername = "localhost";
	$username = "root";
	$password = "";
	$dbname = "hotel_db";

	if ( empty($e_irs) OR empty($c_irs)){
?>
	<html>
		<head>
			<title>Check-in</title>
			<link rel="stylesheet" type="text/css" href="style_search.css">
		</head>
		<body>
			<div id="srch">
				<center><form action="checkin_form.php" method="POST">
					Please fill all fields.
					<input type="hidden" name="room_id" value=<?=$room_id;?>>
					<input type="hidden" name="hotel_id" value=<?=$hotel_id;?>>
					<input type="hidden" name="start_date" value=<?=$start_date;?>>
					<input type="hidden" name="finish_date" value=<?=$finish_date;?>>
					<input type="hidden" name="hotel_name" value=<?=$hotel_name;?>>
					<input type="hidden" name="hotelgroup_name" value=<?=$hotelgroup_name;?>>
					<p>
					<input type="submit" id="btn" value="OK!"></input>	
					</p>
				</center></form>
			</div>
		</body>	
			
<?php		
			exit();
	}	
	
	
	$conn = new mysqli($servername, $username, $password, $dbname);

	
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	}

	
	$sql_rents = "INSERT INTO rents (IRS_Number_Employee, IRS_Number_Customer, Room_id, Hotel_id, Start_Date, Finish_Date, Hotel_name, Hotelgroup_name)
	VALUES ('$e_irs', '$c_irs', '$room_id', '$hotel_id', '$start_date', '$finish_date', '$hotel_name', '$hotelgroup_name')";

	if ($conn->query($sql_rents) === TRUE) {
		
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
					Your check-in has successfully completed!	
					</p>					
					<p>
					Enjoy your stay!
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
		if (mysqli_errno($conn) == 1062) {
				
?>
	
	<html>
		<head>
			<title>Reservation Failure</title>
			<link rel="stylesheet" type="text/css" href="style_search.css">
		</head>
		<body>
			<div id="srch">
				<center><form action="e-hotels.php" method="POST">
					<p>
					The required check-in has already been made.	
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
			echo "Error: " . $sql_rents . "<br>" . $conn->error;
		}
	}

?>	