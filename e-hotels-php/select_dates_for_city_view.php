<!DOCTYPE html>
<html>
<head>
	<title>E-hotels</title>
	<link rel="stylesheet" type="text/css" href="style_search3.css">
</head>
<body>
	<div id="srch">
	<center><h2>Search for City View!</h2></center>
		
		<center><form action="city_view_process.php" method="POST">
			
			<p>
				<label><b>Arrival date*</label><br>
				<input type="date" id="date_a" name="date_a" required>
				
			</p>
			<p>
				<label>Departure date*</b></label><br>
				<input type="date" id="date_b" name="date_b" required>
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