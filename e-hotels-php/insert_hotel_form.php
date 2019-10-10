<!DOCTYPE html>
<html>
<head>
	<title>E-hotels</title>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
<body>
	<div id="srch">
		<center><h2>Add Hotel</h2></center><br>
		<center><form action="insert_email_phone_form.php" method="POST">
		Please insert the new Hotel's Data in the following fields.
			<p>
				<label><b>Hotel Group's Name*</label><br>
				<?php
				$conn = mysqli_connect("localhost", "root", "");
				mysqli_select_db($conn,"hotel_db");
				if ($conn->connect_error) {
				die("Connection failed: " . $conn->connect_error);
				} 
				$query = " select * from hotel_group";
				$result = mysqli_query($conn, $query)or die("Failure!");
				
				echo '<select type = text name=hotelgroup_name value=', '></option>';
				
				while($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
					
					echo "<option value=\"{$row['hotelgroup_name']}\">{$row['hotelgroup_name']}</option>";
				
				}
				echo "</select>";
				$conn->close();
				?>
			</p>
			<p>
				<label>Hotel's Name*</label><br>
				<input type="text" name="hotel_name" pattern = "^[a-zA-Z0-9_ ]*$" required>				
			</p>
			<p>
				<label>Stars*</label><br>
				<select type="number" id="stars" name="stars" size="" required>
				<option>1</option>
				<option>2</option>
				<option>3</option>
				<option>4</option>
				<option>5</option>
				</select>			
			</p>
			<p>
				<label>City*</label><br>
				<input type="text" name="city" required>				
			</p>
			<p>
				<label>Street*</label><br>
				<input type="text" name="street" required>				
			</p>
			<p>
				<label>Number*</label><br>
				<input type="text" name="number" required>				
			</p>
			<p>
				<label>Postal Code*</label><br>
				<input type="text" name="postal_code" required>				
			</p>
			<p>
				<label>Number of E-Mail(s)*</label><br>
				<input type="number" type = "button "name="num_emails" min="1" required>	
				
			</p>	
			<p>
				<label>Number of Phone(s)*</label><br>
				<input type="number" type = "button "name="num_phones" min="1" required>	
				
			</p>
			
  			*Mandatory Field</b><br>
			Press Submit to continue with adding E-Mail Addresse(s) and Phone Number(s)
			<p>
				<input type="submit" id="btn" name="submit">
			</p>
		</center></form>
	</div>
</body>
<?php

?>