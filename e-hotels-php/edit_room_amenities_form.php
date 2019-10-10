<?php
	
	$hotel_name = $_POST['hotel_name'];
	$room_number = $_POST['room_number'];
	$new_room_number = $_POST['new_room_number'];
	$capacity = $_POST['capacity'];
	$view = $_POST['view'];
	$expand = $_POST['expand'];
	$repairs = $_POST['repairs'];
	$price = $_POST['price'];
	
	$conn = mysqli_connect("localhost", "root", "");
	mysqli_select_db($conn,"hotel_db");
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	} 
	
	if (empty($hotel_name) OR empty($room_number)){
		echo '<script type="text/javascript">'; 
		echo 'alert("Please enter both the Hotel Name and Room Number.");'; 
		echo 'window.location.href = "edit_hotel_room_form.php";';
		echo '</script>';
		exit();
	}
	$query = "select * from hotel where hotel_name = '$hotel_name'";
	$result = mysqli_query($conn, $query)or die (mysqli_error($con));
	$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
	$hotel_id = $row['hotel_ID'];
	
		
	if(!empty($new_room_number)){
		$query = "select * from hotel_room where Hotel_ID = '$hotel_id' and Room_Number = '$new_room_number'";
		$result = mysqli_query($conn, $query)or die (mysqli_error($conn));
		if ($result -> num_rows != 0){
			echo '<script type="text/javascript">'; 
			echo 'alert("The New Room Number already exists.Please try again.");'; 
			echo 'window.location.href = "edit_hotel_room_form.php";';
			echo '</script>';
			exit();
		}
			
	}
	
		
			
		$query = "select * from hotel_room where Room_Number = '$room_number' and Hotel_ID = '$hotel_id'";
		$result = mysqli_query($conn, $query)or die (mysqli_error($con));
		if ($result->num_rows == 0 ) {
			echo '<script type="text/javascript">'; 
			echo 'alert("The Room Number is not valid. Please try Again");'; 
			echo 'window.location.href = "edit_hotel_room_form.php";';
			echo '</script>';
		}
		else{
			$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
			$room_id = $row['Room_id'];
		}
		
	
	
		$conn->close();
?>

<!DOCTYPE html>
<html>
<head>
	<title>E-hotels</title>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
<body>

<div id="srch">
<center><h2>Room  Amenities Edit</h2></center>
		<center><form action="edit_hotel_room.php" method ="POST">
			<p>
				<label>The selected Room has the Amenities shown below. <br/> Choose the ones you would like to remove.</label><br>
			<?php
				$conn = mysqli_connect("localhost", "root", "");
				mysqli_select_db($conn,"hotel_db");
				if ($conn->connect_error) {
				die("Connection failed: " . $conn->connect_error);
				} 
				
				$query = " select * from amenities where Room_ID = '$room_id'";
				$result = mysqli_query($conn, $query)or die("Failure!");
				
				echo '<select type = text name=old_amenities[] multiple = "multiple" value=', '></option>';
				
				while($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
					
					echo "<option value=\"{$row['Type']}\">{$row['Type']}</option>";
				
				}
				echo "</select>";
				$conn->close();
				?>
			</p>
			<p>
				<label>The selected room lacks the Amenities shown below. <br/>Choose the ones you would like to add.</label><br>
			<?php
				$conn = mysqli_connect("localhost", "root", "");
				mysqli_select_db($conn,"hotel_db");
				if ($conn->connect_error) {
				die("Connection failed: " . $conn->connect_error);
				} 
				$maketemp = "
					CREATE TEMPORARY TABLE Amenities_temp(
					`Type` VARCHAR(45) NOT NULL,
					PRIMARY KEY(Type))"; 
				 mysqli_query( $conn,$maketemp) or die ("Sql error : ".mysql_error());
				 
				$sql = "INSERT INTO Amenities_temp (Type) VALUES ('PrivatePool'),('Breakfast'),('Hairdryer'),('Balcony'),('AirConditioning'),('TV'),('MiniFridge'),('Towels')
				,('RoomService'),('DailyCleanup'),('Spa')";
				if ($conn->query($sql) === TRUE) {
						
				}
				else {
					echo "Error: " . $sql . "<br>" . $conn->error;
				}
				$query = " select Type from Amenities_temp where Type not in (select Type from amenities where Room_ID = '$room_id')";
				$result = mysqli_query($conn, $query)or die("Failure!");
							
				echo '<select type = text name=new_amenities[] multiple = "multiple" value=', '></option>';
				
				while($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
					
					echo "<option value=\"{$row['Type']}\">{$row['Type']}</option>";
				
				}
				echo "</select>";
				$conn->close();
				?>
			</p>
			
			
			 <b>-Use Ctrl key for Multiple Selection/Deselection</b>
			<p>
				<input type="submit" id="btn" name="Submit">
			</p>
			<input type="hidden" name="room_id" value=<?=$room_id;?>>
			<input type="hidden" name="new_room_number" value=<?=$new_room_number;?>>
			<input type="hidden" name="hotel_name" value=<?=$hotel_name;?>>
			<input type="hidden" name="capacity" value=<?=$capacity;?>>
			<input type="hidden" name="view" value=<?=$view;?>>
			<input type="hidden" name="expand" value=<?=$expand;?>>
			<input type="hidden" name="repairs" value=<?=$repairs;?>>			
			<input type="hidden" name="price" value=<?=$price;?>>
			<input type="hidden" name="hotel_id" value=<?=$hotel_id;?>>
				
			
</center></form>
	</div>
</body>
</head>
</html>