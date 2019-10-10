<html>
<head>
<link rel="stylesheet" type="text/css" href="data.css">
</head>
<body>
	
<?php

	$date_a = $_POST['date_a'];
	$date_b = $_POST['date_b'];
	
	date_default_timezone_set('Europe/Athens');
	$current_date=date("Y-m-d");
	
	$date_a = date_create($date_a);	
	$date_a = date_format($date_a, 'Y-m-d');
	$date_b = date_create($date_b);	
	$date_b = date_format($date_b, 'Y-m-d');
	
	if ($date_b <= $date_a ){
		echo '<script type="text/javascript">'; 
		echo 'alert("Departure Day cannot happen before Arrival Day.");'; 
		echo 'window.location.href = "select_dates_for_city_view.php";';
		echo '</script>';
	}
	
	if ($date_a < $current_date or $date_b <= $current_date ){
		echo '<script type="text/javascript">'; 
		echo 'alert("You can only search for available rooms in future dates.");'; 
		echo 'window.location.href = "select_dates_for_city_view.php";';
		echo '</script>';
	}
	
	$con = mysqli_connect("localhost", "root", "");
	mysqli_select_db($con,"hotel_db");
	
	$query = "CREATE OR REPLACE VIEW hotel_db.`region_view` AS
    SELECT 
        hotel_db.`hotel`.`City` AS City,
        (hotel_db.`hotel_room`.`Room_id`) AS room_id
    FROM
        (hotel_db.`hotel`
        JOIN hotel_db.`hotel_room` ON ((hotel_db.`hotel_room`.`Hotel_ID` = hotel_db.`hotel`.`hotel_ID`)))
        ";
	
	$result = mysqli_query($con, $query)or die (mysqli_error($con));
	
	$query = "SELECT City, count(n1.room_id) c FROM hotel_db.region_view as n1 left join reserves n5 
			on (( n1.room_id=n5.Room_ID) and 
            ( ('$date_a' between n5.Start_Date and n5.Finish_Date)
					or ('$date_b' between n5.Start_Date and n5.Finish_Date) 
					or (n5.Start_Date between '$date_a' and '$date_b') 
				or (n5.Finish_Date between '$date_a' and '$date_b') ))
		 where n5.Room_ID is null group by City";
		 
	//echo $query;	 
	$result = mysqli_query($con, $query)or die (mysqli_error($con));
	
	if ($result->num_rows >=1) {
		echo "<center><table>";
		echo "<tr><td>";
		echo "Available Rooms";
		echo "<td>";
		echo "City";
		echo "<td>";            
		
		while($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
			echo "<tr><td>";
			echo $row['c'];
			echo "<td>";
			echo $row['City'];
			echo "<td>";
		} 	
	}
	
    else{
?>	
<head>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
		<body>
			<div id="srch">
				<center><form action="search.php" method="POST">		
						Sorry!
						There are no rooms available for the required dates.
					<p>
						<input type="Submit" id="btn" value="OK" name = "ok_button">
					</p>			
				</center></form>
			</div>

<?php		
        
    }   
?>
		
	
</body>
</html> 

		 