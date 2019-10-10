<html>
<head>
	<title>Reservation</title>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
<body>
	<div id="srch">
<center><h2>Edit Customer Data</h2></center>
		<center><form action="edit_customer_data.php" method="POST">
			<p>
				<label><b> Current IRS Number*</b></label><br>
				<input type="text" name="IRS" required>
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
				<input type="text" name="Street">
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
			</center></form>
			
</center></form>
	</div>
	
</body>