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
	
	$query = "SELECT IRS_Number, Last_Name, First_Name, e.Street, e.Number, e.City, e.Postal_Code, Social_Security_Number, Position, hotel_name, Start_Date, Finish_Date FROM employee as e
	join works as w on (e.IRS_Number=w.IRS_Number_Employee) join hotel as h on (w.Hotel_ID=h.hotel_ID) order by IRS_Number ";
	
	$result = mysqli_query($conn, $query)or die (mysqli_error($conn));
	
	if ($result->num_rows >=1) {
		echo "<center><table>";
		echo "<tr><td>";
		echo "IRS";
		echo "<td>";
		echo "First name";
		echo "<td>";
		echo "Last name";
		echo "<td>";
		echo "Position";
		echo "<td>";
		echo "Hotel name";
		echo "<td>";
		echo "Start Date";
		echo "<td>";
		echo "Finish Date";
		echo "<td>";
		echo "Street";
		echo "<td>";
		echo "Number";
		echo "<td>";
		echo "Postal Code";
		echo "<td>";
		echo "City";
		echo "<td>";
		echo "SSN";
		echo "<td>";
		
		while($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
			echo "<tr><td>";
			echo $row['IRS_Number'];
			echo "<td>";
			echo $row['First_Name'];
			echo "<td>";
			echo $row['Last_Name'];
			echo "<td>";
			echo $row['Position'];
			echo "<td>";
			echo $row['hotel_name'];
			echo "<td>";
			echo $row['Start_Date'];
			echo "<td>";
			echo $row['Finish_Date'];
			echo "<td>";
			echo $row['Street'];
			echo "<td>";
			echo $row['Number'];
			echo "<td>";
			echo $row['Postal_Code'];
			echo "<td>";
			echo $row['City'];
			echo "<td>";
			echo $row['Social_Security_Number'];
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
						There are no employees.
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