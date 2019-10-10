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
	
	$query = "SELECT hotel_ID, hotel_name, hotelgroup_name, hotel.Street, hotel.Number, hotel.City, hotel.Postal_Code, Stars, 
	Number_of_rooms FROM hotel_db.hotel join hotel_group on (hotel.Hotelgroup_ID=hotel_group.Hotel_group_ID) order by hotel_ID ";
	
	$result = mysqli_query($conn, $query)or die (mysqli_error($conn));
	
	if ($result->num_rows >=1) {
		echo "<center><table>";
		echo "<tr><td>";
		echo "Hotel ID";
		echo "<td>";
		echo "Hotel Name";
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
		echo "Stars";
		echo "<td>";
		echo "Number of rooms";
		echo "<td>";
		echo "Email adress";
		echo "<td>";
		echo "Phone number";
		echo "<td>";
		
		while($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
			echo "<tr><td>";
			echo $row['hotel_ID'];
			echo "<td>";
			echo $row['hotel_name'];
			echo "<td>";
			echo $row['hotelgroup_name'];
			echo "<td>";
			echo $row['Street'];
			echo "<td>";
			echo $row['Number'];
			echo "<td>";
			echo $row['Postal_Code'];
			echo "<td>";
			echo $row['City'];
			echo "<td>";
			echo $row['Stars'];
			echo "<td>";
			echo $row['Number_of_rooms'];
			echo "<td>";
			$hotel_id = $row['hotel_ID'];
			$query1 = " select * from email_hotel where Hotel_ID='$hotel_id'";
			$result1 = mysqli_query($conn, $query1)or die (mysqli_error($con));
			while($row = mysqli_fetch_array($result1, MYSQLI_ASSOC)){
				echo $row['Email_Address'];
				echo "<br>";
			}
			echo "<td>";
			$query2 = " select * from phone_hotel where Hotel_ID='$hotel_id'";
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
						There are no hotels.
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