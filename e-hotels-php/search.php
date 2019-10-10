<!DOCTYPE html>
<html>
<head>
	<title>E-hotels</title>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
<body>
	<div id="srch">
	<center><h2>Search for Hotels and Rooms!</h2></center>
		
		<center><form action="search_process.php" method="POST">
			
			<p>
				<label><b>Arrival date*</label><br>
				<input type="date" id="date_a" name="date_a" required>
				
			</p>
			<p>
				<label>Departure date*</b></label><br>
				<input type="date" id="date_b" name="date_b" required>
			</p>
			<p>
				
				<label>Category★</label><br>
				<select type="number" id="stars" name="stars" size="">
				<option></option>
				<option>1</option>
				<option>2</option>
				<option>3</option>
				<option>4</option>
				<option>5</option>
				</select>
				
			</p>
			<p>
				<label>Hotel Group</label><br>
				<?php
				$conn = mysqli_connect("localhost", "root", "");
				mysqli_select_db($conn,"hotel_db");
				if ($conn->connect_error) {
				die("Connection failed: " . $conn->connect_error);
				} 
				$query = " select * from hotel_group";
				$result = mysqli_query($conn, $query)or die("Failure!");
				
				echo '<select type = text name=chain value=', '></option>';
				echo "<option value=\"\"></option>";
				while($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
					
					echo "<option value=\"{$row['hotelgroup_name']}\">{$row['hotelgroup_name']}</option>";
				
				}
				echo "</select>";
				$conn->close();
				?>
			</p>
			<p>
				<label>City</label><br>
				
				<?php
				$conn = mysqli_connect("localhost", "root", "");
				mysqli_select_db($conn,"hotel_db");
				if ($conn->connect_error) {
				die("Connection failed: " . $conn->connect_error);
				} 
				$query = " select distinct City from hotel";
				$result = mysqli_query($conn, $query)or die("Failure!");
				
				echo '<select name=city value=', '></option>';
				echo "<option value=\"\"></option>";
				while($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
					
					echo "<option value=\"{$row['City']}\">{$row['City']}</option>";
				
				}
				echo "</select>";
				$conn->close();
				?>
				
			</p>
			<p>
				<label>Number of rooms</label><br>
				<input type="number" name="rooms" min ="0" max ="100">
				
			</p>
			
			<p>
				<label>Select Amenities  <br/> -Use Ctrl key for Multiple Selection/Deselection:</label><br>
				<select type = "text" name="amenities[]" multiple = "multiple" size = "">
				
				<option value="PrivatePool">Private Pool</option>
				<option value="Breakfast">Breakfast</option>
				<option value="Hairdryer">Hairdryer</option>
				<option value="Balcony">Balcony</option>
				<option value="AirConditioning">Air Conditioning</option>
				<option value="TV">TV</option>
				<option value="MiniFridge">Mini Fridge</option>
				<option value="Towels">Towels</option>
				<option value="RoomService">Room Service</option>
				<option value="DailyCleanup">Daily Cleanup</option>
				<option value="Spa">Spa</option>
				</select>
			</p>
			<p>
				<label>View</label><br>
				
				<?php
				$conn = mysqli_connect("localhost", "root", "");
				mysqli_select_db($conn,"hotel_db");
				if ($conn->connect_error) {
				die("Connection failed: " . $conn->connect_error);
				} 
				$query = " select distinct View from hotel_room";
				$result = mysqli_query($conn, $query)or die("Failure!");
				
				echo '<select name=view value=', '></option>';
				echo "<option value=\"\"></option>";
				while($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
					
					echo "<option value=\"{$row['View']}\">{$row['View']}</option>";
				
				}
				echo "</select>";
				$conn->close();
				?>
				
			</p>
			<p>
				<label>Capacity</label><br>
				<input type="number" name="capacity" min = "0" max ="100">
				
			</p>
			<p>
				<label>Expandability</label><br>
				
				<?php
				$conn = mysqli_connect("localhost", "root", "");
				mysqli_select_db($conn,"hotel_db");
				if ($conn->connect_error) {
				die("Connection failed: " . $conn->connect_error);
				} 
				$query = " select distinct Expandable from hotel_room where Expandable != 'no' and Expandable != 'yes'";
				$result = mysqli_query($conn, $query)or die("Failure!");
				
				echo '<select name=expand value=', '></option>';
				echo "<option value=\"\"></option>";
				while($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
					
					echo "<option value=\"{$row['Expandable']}\">{$row['Expandable']}</option>";
				
				}
				echo "</select>";
				$conn->close();
				?>
				
			</p>
			<p>
				<label>Price Range (€) - from:</label><br>
				<input type="number" name="price_from" min="0">
			</p>
			<p>
				<label>Price Range (€) - to:</label><br>
				<input type="number" name="price_to" min="0">
			</p>
			<b>*Mandatory Field</b>
			<p>
				<input type="submit" id="btn" name="Submit">
			</p>
		</center></form>
	</div>
</body>
<?php

?>