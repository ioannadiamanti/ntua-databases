<html>
<head>
<link rel="stylesheet" type="text/css" href="data.css">
</head>
<body>

<?php

	//Connection data
	$servername = "localhost";
	$username = "root";
	$password = "";
	$dbname = "hotel_db";

	// Create connection
	$conn = new mysqli($servername, $username, $password, $dbname);

	// Check connection
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	} 
	
	$query = "select * from customer order by First_name";
	
	$result = mysqli_query($conn, $query)or die (mysqli_error($conn));
	
	if ($result->num_rows >=1) {
		echo "<center><table>";
		echo "<tr><td>";
		echo "First name";
		echo "<td>";
		echo "Last name";
		echo "<td>";
		echo "Street";
		echo "<td>";
		echo "Number";
		echo "<td>";
		echo "Postal code";
		echo "<td>";
		echo "City";
		echo "<td>";
		echo "First registration";
		echo "<td>";
		echo "SSN";
		echo "<td>";
		echo "IRS";
		echo "<td>";
		
		while($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
			echo "<tr><td>";
			echo $row['First_name'];
			echo "<td>";
			echo $row['Last_name'];
			echo "<td>";
			echo $row['Street'];
			echo "<td>";
			echo $row['Number'];
			echo "<td>";
			echo $row['Postal_Code'];
			echo "<td>";
			echo $row['City'];
			echo "<td>";
			echo $row['First_Registration'];
			echo "<td>";
			echo $row['Social_Security_Number'];
			echo "<td>";
			echo $row['IRS_Number'];
			echo "<td>";
        }
	}
    else{
?>	
<html>
<head>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
		<body>
			<div id="srch">
				<center><form action="e-hotels.php" method="POST">		
						There are no registered customers.
					<p>
						<input type="Submit" id="btn" value="OK" name = "ok_button">
					</p>			
				</center></form>
			</div>
		</body>
<?php		
    }   
?>
		
	
</table>
</body>
</html>