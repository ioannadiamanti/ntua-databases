<!DOCTYPE html>
<html>
<head>
	<title>E-hotels</title>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
<body>

<div id="srch">
<center>Hotel Edit</center>
		<center><form action="edit_hotel.php" method="POST">
			<p>
				<label>Current Hotel Name</label><br>
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
				<label>Desired Hotel Name**</label><br>
				<input type="text" name="new_hotel_name">				
			</p>
			<p>
				<label>Stars**</label><br>
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
				<label>Current E-Mail**</label><br>
				<input type="email" name="email">				
			</p>
			
			<p>
				<label>New E-Mail**</label><br>
				<input type="email" name="new_email">				
			</p>
			<p>
				<label>Current Phone**</label><br>
				<input type="text" name="phone" >				
			</p>
				<p>
				<label>New Phone**</label><br>
				<input type="text" name="new_phone">				
			</p>
			
			**Fill the fields you would like to be changed
			<p>
				<input type="submit" id="btn" name="Submit">
			</p>
</center></form>
	</div>
</body>
</head>
</html>