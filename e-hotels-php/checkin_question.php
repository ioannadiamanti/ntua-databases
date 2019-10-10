<html>
<head>
<link rel="stylesheet" type="text/css" href="data.css">
</head>
<body>

<?php


	$servername = "localhost";
	$username = "root";
	$password = "";
	$dbname = "hotel_db";


$conn = new mysqli($servername, $username, $password, $dbname);


if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 


	$e_irs=$_POST['e_irs'];


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
				<center><form action="checkin_form.php" method="POST">
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
		echo 'window.location.href = "checkin_form.php";';
		echo '</script>';
	}
$query = "select * from reserves where IRS_Number_Customer = '$c_irs' ";
$result = mysqli_query($conn, $query)or die("Failure!");
	if ($result -> num_rows == 0){
		echo '<script type="text/javascript">'; 
		echo 'alert("There are no reservations from the specified customer.");'; 
		echo 'window.location.href = "checkin_form.php";';
		echo '</script>';
	}
	
	else {
		$query = "select r.Room_ID, hg.hotelgroup_name, h.hotel_name, City, Stars, Price, Capacity, r.IRS_Number_Customer, r.Start_Date, r.Finish_Date, r.Paid, 
		hr.Hotel_ID	from reserves as r inner join hotel_room as hr on (r.Room_ID=hr.Room_id) inner join hotel as h on (hr.Hotel_ID=h.hotel_ID )	
		join hotel_group as hg 	on (hg.Hotel_group_ID=h.Hotelgroup_ID) left join rents as rr on (r.Room_ID=rr.Room_id and 
		r.IRS_Number_Customer=rr.IRS_Number_Customer and r.Start_Date=rr.Start_Date) where r.IRS_Number_Customer='$c_irs' and r.Start_Date='$current_date' 
		and r.Hotel_ID in (select w.Hotel_ID from works as w where w.IRS_Number_Employee='$e_irs') and rr.Room_id is null ";
		$result = mysqli_query($conn, $query)or die("Failure!");
		
		if ($result -> num_rows > 0){
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
					echo $row['Room_ID'];
					echo "<td>";
					echo $row['hotelgroup_name'];
					echo "<td>";
					echo $row['hotel_name'];
					echo "<td>";
					echo $row['City'];
					echo "<td>";
					echo $row['Stars'];
					echo "<td>";
					echo $row['Price'];
					echo "<td>";
					echo $row['Capacity'];
					echo "<td>";
					echo $row['IRS_Number_Customer'];
					echo "<td>";
					echo $row['Start_Date'];
					echo "<td>";
					echo $row['Finish_Date'];
					echo "<td>";
					echo $row['Paid'];
					echo "<td>";
					$hotel_id = $row['Hotel_ID'];
					$room_id = $row['Room_ID'];
					$start_date = $row['Start_Date'];
					$finish_date = $row['Finish_Date'];
					$hotel_name = $row['hotel_name'];
					$hotelgroup_name = $row['hotelgroup_name'];
?>	
		
			<center><form action="checkin_process.php" method="POST">	
			<link rel="stylesheet" type="text/css" href="style_search.css">			
				<p>
					<input type="Submit" id="btn" value="Check-in!" name = "yes_button"
					onclick="a href='checkin_process.php'">
				</p>			
				<input type="hidden" name="hotel_id" value=<?=$hotel_id;?>>
				<input type="hidden" name="room_id" value=<?=$room_id;?>>
				<input type="hidden" name="e_irs" value=<?=$e_irs;?>>
				<input type="hidden" name="c_irs" value=<?=$c_irs;?>>
				<input type="hidden" name="start_date" value=<?=$start_date;?>>
				<input type="hidden" name="finish_date" value=<?=$finish_date;?>>
				<input type="hidden" name="hotel_name" value=<?=$hotel_name;?>>
				<input type="hidden" name="hotelgroup_name" value=<?=$hotelgroup_name;?>>
			</center></form>
			
	<?php
				}
		}
		else {
			?>
	<html>
		<head>
			<title>Check-in</title>
			<link rel="stylesheet" type="text/css" href="style_search.css">
		</head>
		<body>
			<div id="srch">
				<center><form action="e-hotels.php" method="POST">
					No not checked-in reservations in hotels where the specified employee works. 
					<p>
					<input type="submit" id="btn" value="OK!"></input>	
					</p>
				</center></form>
			</div>
		</body>	
			
<?php			
		exit();
		}	
	}	
?>	
