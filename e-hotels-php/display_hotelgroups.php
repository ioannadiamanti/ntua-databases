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
	
	$query = "SELECT * FROM hotel_group order by Hotel_group_ID";
	
	$result = mysqli_query($conn, $query)or die (mysqli_error($conn));
	
	if ($result->num_rows >=1) {
		echo "<center><table>";
		echo "<tr><td>";
		echo "Hotel Group ID";
		echo "<td>";
		echo "Hotel Group Name";
		echo "<td>";
		echo "Street";
		echo "<td>";
		echo "Number";
		echo "<td>";
		echo "Postal code";
		echo "<td>";
		echo "City";
		echo "<td>";
		echo "Number of hotels";
		echo "<td>";
		echo "Email adress";
		echo "<td>";
		echo "Phone number";
		echo "<td>";
		
		while($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
			echo "<tr><td>";
			echo $row['Hotel_group_ID'];
			echo "<td>";
			echo $row['hotelgroup_name'];
			echo "<td>";
			echo $row['Street'];
			echo "<td>";
			echo $row['Number'];
			echo "<td>";
			echo $row['Postal_Code'];
			echo "<td>";
			echo $row['City_group'];
			echo "<td>";
			echo $row['Number_of_hotels'];
			echo "<td>";
			$hotelgroup_id = $row['Hotel_group_ID'];
			$query1 = " select * from email_hotel_group where Hotel_group_ID='$hotelgroup_id'";
			$result1 = mysqli_query($conn, $query1)or die (mysqli_error($con));
			while($row = mysqli_fetch_array($result1, MYSQLI_ASSOC)){
				echo $row['Email_Address'];
				echo "<br>";
			}
			echo "<td>";
			$query2 = " select * from phone_hotel_group where Hotel_group_ID='$hotelgroup_id'";
			$result2 = mysqli_query($conn, $query2)or die (mysqli_error($con));
			while($row = mysqli_fetch_array($result2, MYSQLI_ASSOC)){
				echo $row['Phone_number'];
				echo "<br>";
			}
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
						There are no hotel groups.
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