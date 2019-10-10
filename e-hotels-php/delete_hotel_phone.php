<html>
<head>
	<title>E-hotels</title>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
<head>
<body>
	<div id="srch">
<center><h2>Delete Hotel's Phone Number</h2></center>
		<center><form action="delete_phone_process.php" method="POST">
		<p>
				<label>Hotel Name*</label><br>
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
			<label>Phone Number*</label><br>
			<input type="text" name="phone" required>				
		</p>
		
			*Mandatory Field
			<p>
				<input type="submit" id="btn" name="Submit">
			</p>

	</center></form>
</div>
</body>
</head>
</html>