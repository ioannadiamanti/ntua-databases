<!DOCTYPE html>
<html>
<head>
	<title>E-hotels</title>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
<body>
	<div id="srch">
<center><h2>Hire Employee</h2></center>
		<center><form action="employee_hiring.php" method="POST">
		Please insert the new employee's data in the following fields.
			<p>
				<label><b>Hotel Name* </label><br>
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
				<label>Position* </label><br>
				<select type="text" id="first_name" name="position" size="" >
				<option value = "Manager">Manager</option>
				<option value = "Chef">Chef</option>
				<option value = "KitchenAssistance">Kitchen Assistance</option>
				<option value = "Gardener">Garderer</option>
				<option value = "CleaningStaff">Cleaning Staff</option>
				<option value = "Maid">Maid</option>
				<option value = "WaitingStaff">Waiting Staff</option>
				<option value = "Reception">Reception</option>
				<option value = "Bartender">Bartender</option>
				<option value = "Groom">Groom</option>
				<option value = "SpaTherapist">Spa Therapist</option>
				<option value = "Engineer">Engineer</option>
				<option value = "Logistics">Logistics</option>
				<option value = "Security">Security</option>
				<option value = "ValetBoy">Valet Boy (Parking)</option>
				<option value = "BabySitter">Baby Sitter</option>
				<option value = "Lifeguard">Lifeguard</option>
				<option value = "ManagingSupplies">Managing Supplies</option>
				</select>
			</p>
			<p>
				<label>Finish Date*</label><br>
				<input type="date" id="finish_date" name="finish_date" required>
			</p>
			<p>
				<label>First Name* </label><br>
				<input type="text" id="first_name" name="first_name" required>
			</p>
			<p>
				<label>Last Name* </label><br>
				<input type="text" id="last_name" name="last_name" required>
			</p>
			<p>
				<label>Street* </label><br>
				<input type="text" id="street" name="street" required>
			</p>
			<p>
				<label>Number* </label><br>
				<input type="text" id="number" name="number" required>
			</p>
			<p>
				<label>Postal Code* </label><br>
				<input type="text" id="postal_code" name="postal_code" required>
			</p>
			<p>
				<label>City* </label><br>
				<input type="text" id="city" name="city" required>
			</p>
			<p>
				<label>IRS Number* </label><br>
				<input type="text" id="irs" name="irs" required>
			</p>
			<p>
				<label>SSN Number*</label><br>
				<input type="text" id="ssn" name="ssn" required>
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