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
	
	$query = "SELECT Room_id,hotel.hotel_ID,Room_Number, hotel_name, hotelgroup_name, Capacity, View, Expandable, Repairs_need, Price FROM hotel_room 
	join hotel on (hotel.hotel_ID=hotel_room.Hotel_ID) join hotel_group on (hotel.Hotelgroup_ID=hotel_group.Hotel_group_ID) order by Room_id";
	
	$result = mysqli_query($conn, $query)or die (mysqli_error($conn));
	
	if ($result->num_rows >=1) {
		echo "<center><table>";
		echo "<tr><td>";
		echo "Hotel Room ID";
		echo "<td>";
		echo "Hotel Room Number";
		echo "<td>";
		echo "Hotel name";
		echo "<td>";
		echo "Hotel Group Name";
		echo "<td>";
		echo "Capacity";
		echo "<td>";
		echo "Price per night";
		echo "<td>";
		echo "Expandable";
		echo "<td>";
		echo "View";
		echo "<td>";
		echo "Need for Repairs";
		echo "<td>";
		echo "Amenities";
		echo "<td>";
		
		while($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
			echo "<tr><td>";
			echo $row['Room_id'];
			echo "<td>";
			echo $row['Room_Number'];
			echo "<td>";
			echo $row['hotel_name'];
			echo "<td>";
			echo $row['hotelgroup_name'];
			echo "<td>";
			echo $row['Capacity'];
			echo "<td>";
			echo $row['Price'];
			echo "<td>";
			echo $row['Expandable'];
			echo "<td>";
			echo $row['View'];
			echo "<td>";
			echo $row['Repairs_need'];
			echo "<td>";
			$room_id = $row['Room_id'];
			$hotel_id= $row['hotel_ID'];
            
			$query1 = " select * from amenities where Room_ID='$room_id' and Hotel_ID = '$hotel_id'";
			$result1 = mysqli_query($conn, $query1)or die (mysqli_error($con));
			while($row = mysqli_fetch_array($result1, MYSQLI_ASSOC)){
				echo $row['Type'];
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
						There are no hotel rooms.
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