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
	
	$query = "SELECT Start_Date, Finish_Date, Payment_Amount, Payment_Method, rents.hotelgroup_name, rents.hotel_name, payment_transaction.Room_ID, 
	payment_transaction.IRS_Number_Employee, payment_transaction.IRS_Number_Customer FROM payment_transaction join rents on 
	(rents.Room_id=payment_transaction.Room_ID and payment_transaction.IRS_Number_Customer=rents.IRS_Number_Customer and 
	payment_transaction.IRS_Number_Employee=rents.IRS_Number_Employee) order by Start_Date ";
	
	$result = mysqli_query($conn, $query)or die (mysqli_error($conn));
	
	if ($result->num_rows >=1) {
		echo "<center><table>";
		echo "<tr><td>";
		echo "Rent's Start date";
		echo "<td>";
		echo "Rent's Finish date"."<br>"."- Payment Date";
		echo "<td>";
		echo "Payment Amount";
		echo "<td>";
		echo "Payment Method";
		echo "<td>";
		echo "Hotel Group Name";
		echo "<td>";
		echo "Hotel Name";
		echo "<td>";
		echo "Room ID";
		echo "<td>";
		echo "Employee's IRS";
		echo "<td>";
		echo "Customer's IRS";
		echo "<td>";
				
		while($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
			echo "<tr><td>";
			echo $row['Start_Date'];
			echo "<td>";
			echo $row['Finish_Date'];
			echo "<td>";
			echo $row['Payment_Amount'];
			echo "<td>";
			echo $row['Payment_Method'];
			echo "<td>";
			echo $row['hotelgroup_name'];
			echo "<td>";
			echo $row['hotel_name'];
			echo "<td>";
			echo $row['Room_ID'];
			echo "<td>";
			echo $row['IRS_Number_Employee'];
			echo "<td>";
			echo $row['IRS_Number_Customer'];
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
						There are no payment transactions yet.
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