<html>
<head>
	<title>Edit Employee</title>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
<body>
	<div id="srch">
<center><h2>Update Employee's Contract</h2></center>
		<center><form action="update_contract.php" method="POST">
			<p>
				<label> <b>IRS Number*</label><br>
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
				<label>Position that the Finish Date will be updated</label><br>
				<select type="text" id="first_name" name="position" size="">
				<option value = "Manager">Manager</option>
				<option value = "Chef">Chef</option>
				<option value = "KitchenAssistance">Kitchen Assistance</option>
				<option value = "Gardener">Garderer</option>
				<option value = "CleaningStuff">Cleaning Stuff</option>
				<option value = "Maid">Maid</option>
				<option value = "WaitingStuff">Waiting Stuff</option>
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
				<label>New Finish Date*</label><br>
				<input type="date" id="new_finish_date" name="new_finish_date" required>
			</p>

			<b>*Mandatory Field</b>
			<p>
				<input type="submit" id="btn" name="Submit">
			</p>
		</center></form>
			
			
</center></form>
	</div>
	
</body>
			