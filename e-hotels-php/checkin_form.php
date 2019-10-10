<!DOCTYPE html>

<html>
<head>
	<title>E-hotels</title>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
<body>
	<div id="srch">
	<center><h2>Check in! </h2><center>
		<center><form action="checkin_question.php" method="POST">
			<p>
				You can only check-in reservations that start today.
			</p>
			<p>
				<label><b>Employee IRS*</label><br>
				<input type="text" id="e_irs" name="e_irs" required>
			</p>
			
			<p>
				<label>Customer IRS*</label><br>
				<input type="text" id="c_irs" name="c_irs" required>
			</p>
			*Mandatory Field</b>
			<p>
				<input type="submit" id="btn" name="Submit">
			</p>
		<center></form>
	</div>
</body>
<?php

?>