<!DOCTYPE html>
<html>
<head>
	<title>E-hotels</title>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
<body>
	<div id="srch">
		<center><h2>Add Hotel Room</h2></center><br>
		<center><form action="insert_hotel_room_process.php" method="POST">
		Please insert the new Hotel Room's Data in the following fields.
			
			<p>
				<label><b>Hotel's Name*</label><br>
				<?php
				$conn = mysqli_connect("localhost", "root", "");
				mysqli_select_db($conn,"hotel_db");
				if ($conn->connect_error) {
				die("Connection failed: " . $conn->connect_error);
				} 
				$query = " select * from hotel";
				$result = mysqli_query($conn, $query)or die("Failure!");
				
				echo '<select type = text name=hotel_name value=', '></option>';
				
				while($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
					
					echo "<option value=\"{$row['hotel_name']}\">{$row['hotel_name']}</option>";
				
				}
				echo "</select>";
				$conn->close();
				?>
			</p>				
			</p>
			<p>
				<label>Room Number*</label><br>
				<input type="text" name="number" required>				
			</p>
			<p>
				<label>Capacity*</label><br>
				<input type="text" name="capacity" required>				
			</p>
			<p>
				<label>View*</label><br>
				<input type="text" name="view" required>				
			</p>
			<p>
				<label>Expandability*</label><br>
				<input type="text" name="expand" required>				
			</p>
			<p>
				<label>Repairs Needed*</label><br>
				<input type="text" name="repairs" required>				
			</p>
			<p>
				<label>Price(€) per night*</label><br>
				<input type="text" name="price" required>				
			</p>
			<p>
				<label>Select Amenities : <br/> -Use Ctrl key for Multiple Selection/Deselection:</label><br>
				<select type = "text" name="amenities[]" multiple = "multiple" size = "">
				
				<option value="PrivatePool">Private Pool</option>
				<option value="Breakfast">Breakfast</option>
				<option value="Hairdryer">Hairdryer</option>
				<option value="Balcony">Balcony</option>
				<option value="AirConditioning">Air Conditioning</option>
				<option value="TV">TV</option>
				<option value="Mini Fridge">Mini Fridge</option>
				<option value="Towels">Towels</option>
				<option value="RoomService">Room Service</option>
				<option value="DailyCleanup">Daily Cleanup</option>
				<option value="Spa">Spa</option>
				</select>
			</p>
			
			*Mandatory Field</b>
			<p>
				<input type="submit" id="btn" name="Submit">
			</p>
		</center></form>
	</div>
</body>
<?php

?>