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
	
	$query = "select Room_ID, hotel_name, hotelgroup_name, IRS_Number_Customer, Start_Date, Finish_Date, Paid from reserves order by Room_ID";
	
	$result = mysqli_query($conn, $query)or die (mysqli_error($conn));
	
	if ($result->num_rows >=1) {
		echo "<center><table>";
		echo "<tr><td>";
		echo "Room ID";
		echo "<td>";
		echo "Hotel Name";
		echo "<td>";
		echo "Hotel Group Name";
		echo "<td>";
		echo "Customer's IRS";
		echo "<td>";
		echo "Start Date";
		echo "<td>";
		echo "End Date";
		echo "<td>";
		echo "Paid";
		echo "<td>";
		echo "Reservation"."<br>"."Status";
		echo "<td>";
		echo "Room"."<br>"."Status";
		echo "<td>";
		
		while($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
			echo "<tr><td>";
			echo $row['Room_ID'];
			$room_id = $row['Room_ID'];
			echo "<td>";
			echo $row['hotel_name'];
			echo "<td>";
			echo $row['hotelgroup_name'];
			echo "<td>";
			echo $row['IRS_Number_Customer'];
			$c_irs = $row['IRS_Number_Customer'];
			echo "<td>";
			echo $row['Start_Date'];
			$start_date = $row['Start_Date'];
			echo "<td>";
			echo $row['Finish_Date'];
			$finish_date = $row['Finish_Date'];
			echo "<td>";
			echo $row['Paid'];
			$paid = $row['Paid'];
			echo "<td>";
			if ($paid == "yes") {
				echo "checked-out";
				echo "<td>";
			}
			else{
				$query1 = "select * from rents where Room_id='$room_id' and Start_Date='$start_date' and Finish_Date='$finish_date' and 
				IRS_Number_Customer='$c_irs' ";
				$result1 = mysqli_query($conn, $query1)or die (mysqli_error($conn));
				if ($result1->num_rows >=1) {
					echo "checked-in";
					echo "<td>";
				}
				else {
					echo "pending";
					echo "<td>";
				}
			}
			$query2 = "select * from hotel_room where Room_id = '$room_id'";
			$result2 = mysqli_query($conn, $query2)or die (mysqli_error($conn));
				if ($result2->num_rows > 0) {
					echo "existing";
					echo "<td>";
				}
				else {
					echo "deleted";
					echo "<td>";
				}
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
						There are no reservations yet.
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