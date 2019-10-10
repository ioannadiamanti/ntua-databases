<!DOCTYPE html>
<html>
<head>
	<title>E-hotels</title>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
<body>

<div id="srch">
<center><h2>Room Edit</h2></center>
		<center><form action="edit_room_amenities_form.php"  method="POST">
			<p>
				<label><b>Hotel Name*</label><br>
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
			
			<p>
				<label>Room Number*</b></label><br>
				<input type="text" id="id" name="room_number" required>				
			</p>
			<p>
				<label>	New Room Number**</b></label><br>
				<input type="text" id="id" name="new_room_number">				
			</p>
			<p>
				<label>Capacity**</label><br>
				<input type="text" name="capacity">				
			</p>
			<p>
				<label>View**</label><br>
				<input type="text" name="view">				
			</p>
			<p>
				<label>Expandable**</label><br>
				<input type="text" name="expand">				
			</p>
			<p>
				<label>Repairs Needed**</label><br>
				<input type="text" name="repairs">				
			</p>
			<p>
				<label>Price (Per Night)**</label><br>
				<input type="text" name="price">				
			</p>
			
			<b>*Mandatory Field</b><br>
			**Fill the fields you would like to be changed <br>
					
			Press Submit to continue with amenities editing
			<p>
				<input type="submit" id="btn" name="Submit">
			</p>
				
		
</center></form>
	</div>
</body>
</head>
</html>