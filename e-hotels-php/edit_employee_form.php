<html>
<head>
	<title>Edit Employee</title>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
<body>
	<div id="srch">
<center><h2>Edit Employee's Data</h2></center>
		<center><form action="edit_position_form.php" method="POST">
			<p>
				<label> <b>Current IRS Number*</label><br>
				<input type="text" name="IRS" required>
			</p>
			<p>
				<label>Hotel Name* </label><br>
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
				<label> New IRS Number</label><br>
				<input type="text" name="new_IRS">
			</p>
			
			<p>
				<label> First Name</label><br>
				<input type="text" name="first_name">
			</p>
			<p>
				<label> Last Name</label><br>
				<input type="text" name="last_name">
			</p>
			<p>
				<label> Street</label><br>
				<input type="text" name="street">
			</p>
			<p>
				<label> Number</label><br>
				<input type="text" name="number">
			</p>
			<p>
				<label> City</label><br>
				<input type="text" name="city">
			</p>
			<p>
				<label> Postal Code</label><br>
				<input type="text" name="postal_code">
			</p>
			<p>
				<label> SSN</label><br>
				<input type="text" name="ssn">
			</p>
			<b>*Mandatory Field</b>
			<p>
				<input type="submit" id="btn" name="Submit">
			</p>
			<b> Press Submit to continue with Position Editing</b>
			</center></form>
			
</center></form>
	</div>
	
</body>