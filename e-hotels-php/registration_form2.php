<!DOCTYPE html>

<html>
<head>
	<title>Registration</title>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
<body>
	<div id="srch">
	<center><h2>Registration</h2></center>
		<center><form action="registration_process2.php" method="POST">
			<p>
				<label> <b>IRS Number*</label><br>
				<input type="text" name="IRS" required>
			</p>
			
			<p>
				<label> First Name*</label><br>
				<input type="text" name="first_name" required>
			</p>
			<p>
				<label> Last Name*</label><br>
				<input type="text" name="last_name" required>
			</p>
			<p>
				<label> Street*</label><br>
				<input type="text" name="Street" required>
			</p>
			<p>
				<label> Number*</label><br>
				<input type="text" name="number" required>
			</p>
			<p>
				<label> City*</label><br>
				<input type="text" name="city" required>
			</p>
			<p>
				<label> Postal Code*</label><br>
				<input type="text" name="postal_code" required>
			</p>
			<p>
				<label> SSN*</label><br>
				<input type="text" name="ssn" required>
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