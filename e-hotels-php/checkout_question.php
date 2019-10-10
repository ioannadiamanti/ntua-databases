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

//Employee Data
	$e_irs=$_POST['e_irs'];

//Customer Data
	$c_irs=$_POST['c_irs'];

if ( empty($e_irs) OR empty($c_irs)){
?>
	<html>
		<head>
			<title>Check-in</title>
			<link rel="stylesheet" type="text/css" href="style_search.css">
		</head>
		<body>
			<div id="srch">
				<center><form action="checkout_form.php" method="POST">
				<link rel="stylesheet" type="text/css" href="style_search.css">
					Please fill all fields.
					<p>
					<input type="submit" id="btn" value="OK!"></input>	
					</p>
				</center></form>
			</div>
		</body>	
			
<?php			
		exit();
	}	

date_default_timezone_set('Europe/Athens');	
$current_date=date("Y-m-d");

	$query = "select * from employee where IRS_Number = '$e_irs' ";
	$result = mysqli_query($conn, $query)or die("Failure!");
	if ($result -> num_rows == 0){
		echo '<script type="text/javascript">'; 
		echo 'alert("There is no employee with such IRS.");'; 
		echo 'window.location.href = "checkout_form.php";';
		echo '</script>';
	}
	
	$query = "select * from rents where IRS_Number_Customer = '$c_irs' ";
	$result = mysqli_query($conn, $query)or die("Failure!");
	if ($result -> num_rows == 0){
		echo '<script type="text/javascript">'; 
		echo 'alert("There are no reservations from the specified customer.");'; 
		echo 'window.location.href = "checkout_form.php";';
		echo '</script>';
	}

	else {
		
		$query = "select r.* , reserves.Paid, h.City, h.Stars, hr.Price, hr.Capacity from rents as r inner join hotel_room as hr on (r.Room_ID=hr.Room_id) 
		inner join hotel as h on (hr.Hotel_ID=h.hotel_ID ) join hotel_group as hg on (hg.Hotel_group_ID=h.Hotelgroup_ID) inner join reserves on 
		(reserves.Room_ID=r.Room_id and reserves.Start_Date=r.Start_Date and reserves.IRS_Number_Customer=r.IRS_Number_Customer) 
		where r.IRS_Number_Customer='$c_irs' and r.Finish_Date>='$current_date' 
		and r.Hotel_ID in (select w.Hotel_ID from works as w where w.IRS_Number_Employee='$e_irs') and paid='no'";
		
		$result = mysqli_query($conn, $query)or die("Failure!");
		if ($result->num_rows >=1) {
			echo"<center><table>";
				echo "<tr><td>";
				echo "Room ID";
				echo "<td>";
				echo "Hotel Group Name";
				echo "<td>";
				echo "Hotel Name";
				echo "<td>";
				echo "City";
				echo "<td>";
				echo "Stars";
				echo "<td>";
				echo "Price";
				echo "<td>";
				echo "Capacity";
				echo "<td>";
				echo "Employee IRS";
				echo "<td>";
				echo "Customer IRS";
				echo "<td>";
				echo "Start Date";
				echo "<td>";
				echo "Finish Date";
				echo "<td>";
				echo "Paid";
				echo "<td>";
				while($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
					echo "<tr><td>";
					echo $row['Room_id'];
					echo "<td>";
					echo $row['Hotelgroup_name'];
					echo "<td>";
					echo $row['Hotel_name'];
					echo "<td>";
					echo $row['City'];
					echo "<td>";
					echo $row['Stars'];
					echo "<td>";
					echo $row['Price'];
					echo "<td>";
					echo $row['Capacity'];
					echo "<td>";
					echo $row['IRS_Number_Employee'];
					echo "<td>";
					echo $row['IRS_Number_Customer'];
					echo "<td>";
					echo $row['Start_Date'];
					echo "<td>";
					echo $row['Finish_Date'];
					echo "<td>";
					echo $row['Paid'];
					echo "<td>";
					$hotel_id = $row['Hotel_id'];
					$room_id = $row['Room_id'];
					$start_date = $row['Start_Date'];
					$finish_date = $row['Finish_Date'];
					$price = $row['Price'];
?>	
		
			<center><form action="checkout_info_form.php" method="POST">		
			<link rel="stylesheet" type="text/css" href="style_search.css">
				<p>
					<input type="Submit" id="btn" value="Check-out!" name = "yes_button">
				</p>			
				<input type="hidden" name="hotel_id" value=<?=$hotel_id;?>>
				<input type="hidden" name="room_id" value=<?=$room_id;?>>
				<input type="hidden" name="e_irs" value=<?=$e_irs;?>>
				<input type="hidden" name="c_irs" value=<?=$c_irs;?>>
				<input type="hidden" name="start_date" value=<?=$start_date;?>>
				<input type="hidden" name="finish_date" value=<?=$finish_date;?>>
				<input type="hidden" name="price" value=<?=$price;?>>
			</center></form>
			
	<?php
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
				<link rel="stylesheet" type="text/css" href="style_search.css">				
						There are no not checked-out reservations from the specified customer that have been checked-in and that end today.
					<p>
						<input type="Submit" id="btn" value="OK" name = "ok_button">
					</p>			
				</center></form>
			</div>
		</body>
<?php		
		}
	}	
?>
	
	</table>
</body>
</html>