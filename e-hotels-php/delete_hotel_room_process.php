<html>
<head>
<link rel="stylesheet" type="text/css" href="data.css">
</head>
<body>

<?php

	
	
	$hotel_name = $_POST['hotel_name'];
	$room_number = $_POST['room_number'];
	
	
	$conn = mysqli_connect("localhost", "root", "");
	mysqli_select_db($conn,"hotel_db");
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	} 
	$query = " select * from hotel where  hotel_name = '$hotel_name'";
	$result = mysqli_query($conn, $query)or die("Failure!");
	$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
	$hotel_id = $row['hotel_ID'];
	
	$query = " select * from hotel_room where Hotel_ID = '$hotel_id' and Room_Number = '$room_number'";
	$result = mysqli_query($conn, $query)or die("Failure!");
	if ($result -> num_rows == 0){
		echo '<script type="text/javascript">'; 
		echo 'alert("There is no Room with the specified Room Number in this Hotel. Please try again.");'; 
		echo 'window.location.href = "delete_hotel_room_form.php";';
		echo '</script>';
	}
	else{
		$sql = "DELETE FROM hotel_room where  Hotel_ID = '$hotel_id' and Room_Number = '$room_number'";
		if ($conn->query($sql) === TRUE) {
		
?>
		<html>
<head>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
<body>
	<div id="srch">
		<center><form action="e-hotels.php" method="POST">
			<p>
				Hotel Room Deleted Successfully!
			</p>		
			<p>
				<input type="submit" id="btn" name="Ok!" value="OK!">
			</p>
		<center></form>
	</div>
</body>
</html>
<?php
	}
	
	$conn->close();
	}
?>
 </table>
</body>
</html>
	