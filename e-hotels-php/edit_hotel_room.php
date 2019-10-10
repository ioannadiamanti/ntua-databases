<html>
<head>
<link rel="stylesheet" type="text/css" href="data.css">
</head>
<body>

<?php
	
	$hotel_name = $_POST['hotel_name'];
	$room_id = $_POST['room_id'];
	$new_room_number = $_POST['new_room_number'];
	$capacity = $_POST['capacity'];
	$view = $_POST['view'];
	$expand = $_POST['expand'];
	$repairs = $_POST['repairs'];
	$price = $_POST['price'];
	$hotel_id = $_POST['hotel_id'];
	
	$flag1=true;
	$flag2=true;
	$flag3=true;
	$flag4=true;
	$flag5=true;
	$flag6=true;
	$flag7=true;
	$flag8=true;
	
	if (isset($_POST['old_amenities'])){
		$old_amenities = $_POST['old_amenities'];
	}
	
	if (isset($_POST['new_amenities'])){
		$new_amenities = $_POST['new_amenities'];
	}
	
	
	$conn = mysqli_connect("localhost", "root", "");
	mysqli_select_db($conn,"hotel_db");
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	} 
	if (!empty($new_room_number)){
			$sql = "UPDATE hotel_room SET Room_Number = '$new_room_number' where Room_id = '$room_id' and Hotel_ID = '$hotel_id'";
			if ($conn->query($sql) === TRUE) {
		
				$flag8=true;
			} 
			else {
				$flag8=false;
				echo "Error: " . $sql . "<br>" . $conn->error;
			}
		
	}	
	if (!empty($capacity)){
		$sql = "UPDATE hotel_room SET Capacity = '$capacity' where Room_id = '$room_id' and Hotel_ID = '$hotel_id'";
		if ($conn->query($sql) === TRUE) {
			//echo "Capacity of Room updated successfully". "<br>";
			$flag1=true;
		} 
		else {
			$flag1=false;
			echo "Error: " . $sql . "<br>" . $conn->error;
		}
	}
	if (!empty($view)){
		$sql = "UPDATE hotel_room SET View = '$view' where Room_id = '$room_id' and Hotel_ID = '$hotel_id'";
		if ($conn->query($sql) === TRUE) {
			//echo "View of Room updated successfully". "<br>";
			$flag2=true;
		} 
		else {
			$flag2=false;
			echo "Error: " . $sql . "<br>" . $conn->error;
		}
	}
	if (!empty($expand)){
		$sql = "UPDATE hotel_room SET Expandable = '$expand' where Room_id = '$room_id' and Hotel_ID = '$hotel_id'";
		if ($conn->query($sql) === TRUE) {
			//echo "Expanability of Room updated successfully". "<br>";
			$flag3=true;
		} 
		else {
			$flag3=false;
			echo "Error: " . $sql . "<br>" . $conn->error;
		}
	}
	if (!empty($repairs)){
		$sql = "UPDATE hotel_room SET Repairs_need = '$repairs' where Room_id = '$room_id' and Hotel_ID = '$hotel_id'";
		if ($conn->query($sql) === TRUE) {
			//echo "The Repair Needs of Room updated successfully". "<br>";
			$flag4=true;
		} 
		else {
			$flag4=false;
			echo "Error: " . $sql . "<br>" . $conn->error;
		}
	}
	if (!empty($price)){
		$sql = "UPDATE hotel_room SET Price = '$price' where Room_id = '$room_id' and Hotel_ID = '$hotel_id'";
		if ($conn->query($sql) === TRUE) {
			//echo "The Price of Room updated successfully". "<br>";
			$flag5=true;
		} 
		else {
			$flag5=false;
			echo "Error: " . $sql . "<br>" . $conn->error;
		}
	}
	if ( !empty($old_amenities)){
		$sql = "DELETE FROM amenities where Room_ID = '$room_id' and Hotel_ID = '$hotel_id' and Type in (";
		for($i = 0; $i < count($_POST['old_amenities'])-1; $i++) {
			$element = $_POST['old_amenities'][$i];
			$sql .= "'$element',";
		}
		$i  = count($_POST['old_amenities'])-1;
		$element = $_POST['old_amenities'][$i];
		$sql .= "'$element')";
		if ($conn->query($sql) === TRUE) {
			$flag6=true;
		}
		else {
			$flag6=false;
			echo "Error: " . $sql . "<br>" . $conn->error;
		}
	}
	if ( !empty($new_amenities)){
		$sql = "INSERT INTO amenities (Room_ID,Hotel_ID,Type) VALUES ";
		for($i = 0; $i < count($_POST["new_amenities"])-1; $i++) {
			$element = $_POST["new_amenities"][$i];
			$sql .= "('$room_id','$hotel_id','$element'),";
		}
		$i  = count($_POST["new_amenities"])-1;
		$element = $_POST["new_amenities"][$i];
		$sql .= "('$room_id','$hotel_id','$element')";
		if ($conn->query($sql) === TRUE) {
			//echo "Hotel Room Amenities inserted successfully". "<br>";
			$flag7=true;
		}
		else {
			$flag7=false;
			echo "Error: " . $sql . "<br>" . $conn->error;
		}
	}
	
	if ($flag1 and $flag2 and $flag3 and $flag4 and $flag5 and $flag6 and $flag7 and $flag8) {
			?>	
<html>
<head>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
		<body>
			<div id="srch">
				<center><form action="e-hotels.php" method="POST">		
						Hotel Room edited successfully.
					<p>	
						<input type="Submit" id="btn" value="OK" name = "ok_button">
					</p>			
				</center></form>
			</div>
		</body>
<?php		
	} 
			
		
	
?>
</table>
</body>
</html>