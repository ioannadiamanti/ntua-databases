<html>
<head>
<link rel="stylesheet" type="text/css" href="data.css">
</head>
<body>

<?php
	$first_name = $_POST['first_name'];
	$last_name = $_POST['last_name'];
	$street=$_POST['street'];
	$number=$_POST['number'];
	$postal_code=$_POST['postal_code'];
	$city=$_POST['city'];
	$SSN=$_POST['ssn'];
	$IRS_number=$_POST['irs'];
	$position=$_POST['position'];
	$hotel_name=$_POST['hotel_name'];
	$finish_date=$_POST['finish_date'];
	
	$flag1=true;
	$flag2=true;
	$flag3=true;
	
	
	date_default_timezone_set('Europe/Athens');
	$current_date=date("y-m-d");
	if ($finish_date <= $current_date){
		echo '<script type="text/javascript">'; 
		echo 'alert("Finish Date cannot happen before Hiring Date (today).");'; 
		echo 'window.location.href = "employee_hiring_form.php";';
		echo '</script>';
	}
	$conn = mysqli_connect("localhost", "root", "");
	mysqli_select_db($conn,"hotel_db");
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	} 
	
	$query = "select * from hotel where hotel_name='$hotel_name'";
	$result = mysqli_query($conn, $query)or die("Failure!");
	$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
	$hotel_id=$row['hotel_ID'];
	
	$query = "select * from employee where IRS_Number='$IRS_number'";
	$result = mysqli_query($conn, $query)or die("Failure!");
	if ($result -> num_rows != 0){
		
		$query = "select * from works where IRS_Number_Employee ='$IRS_number' and Hotel_ID = '$hotel_id' and Position = '$position' 
		and '$current_date' between Start_Date and Finish_Date";
		
		$result = mysqli_query($conn, $query)or die("Failure!");
		if ($result-> num_rows != 0){
			echo '<script type="text/javascript">'; 
			echo 'alert("This Employee is already working at this Hotel at the particular position. Please try again");'; 
			echo 'window.location.href = "employee_hiring_form.php";';
			echo '</script>';
		}
		else{
			$sql = "INSERT INTO works (IRS_Number_Employee,Hotel_ID,Start_Date,Position,Finish_Date) VALUES ('$IRS_number','$hotel_id','$current_date','$position','$finish_date')";
			if ($conn->query($sql) === FALSE) {
				$flag1=false;
			}
		}
	}
	else{
		$sql = "INSERT INTO employee (IRS_Number,Last_Name,First_Name,Social_Security_Number,Street,Number,Postal_Code,City) VALUES 
		('$IRS_number', '$last_name', '$first_name', '$SSN', '$street', '$number', '$postal_code', '$city')";
	
		if ($conn->query($sql) === FALSE) {
			$flag2=false;
		} 
		
		
		$sql = "INSERT INTO works (IRS_Number_Employee,Hotel_ID,Start_Date,Position,Finish_Date) VALUES ('$IRS_number','$hotel_id','$current_date','$position','$finish_date')";
		if ($conn->query($sql) === FALSE) {
			$flag3 = false;
		}
	}
	if($flag1 and $flag2 and $flag3){
		?>
		<html>
<head>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
<body>
	<div id="srch">
		<center><form action="e-hotels.php" method="POST">
			<p>
				Employee Hired!
			</p>		
			<p>
				<input type="submit" id="btn" name="Ok!" value="OK!">
			</p>
		<center></form>
	</div>
</body>
</html>
<?php
	}
	$conn->close();
?>