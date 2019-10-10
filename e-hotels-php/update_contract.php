<html>
<head>
<link rel="stylesheet" type="text/css" href="data.css">
</head>
<body>

<?php
	$position=$_POST['position'];
	$hotel_name = $_POST['hotel_name'];
	$IRS=$_POST['IRS'];
	$new_finish_date=$_POST['new_finish_date'];
	$flag=true;
	
	date_default_timezone_set('Europe/Athens');
	$current_date=date("Y-m-d");
	if ($new_finish_date <= $current_date){
		echo '<script type="text/javascript">'; 
		echo 'alert("Finish Date cannot happen before the current day. Please try again.");'; 
		echo 'window.location.href = "update_contract_form.php";';
		echo '</script>';
	}
	$conn = mysqli_connect("localhost", "root", "");
	mysqli_select_db($conn,"hotel_db");
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	} 
	
	$query = "select * from hotel where hotel_name = '$hotel_name'";
	$result = mysqli_query($conn, $query)or die("Failure!");
	$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
	$hotel_id = $row['hotel_ID'];
	
	$query = " select * from employee where IRS_Number = '$IRS'";
	$result = mysqli_query($conn, $query)or die("Failure!");
	if ($result -> num_rows == 0){
		echo '<script type="text/javascript">'; 
		echo 'alert("There is no Employee with this IRS number. Please try again.");'; 
		echo 'window.location.href = "update_contract_form.php";';
		echo '</script>';
	}
	
	$query = "select * from works where IRS_Number_Employee = '$IRS' and Hotel_ID = '$hotel_id' and Position = '$position'";
	$result = mysqli_query($conn, $query)or die("Failure!");
	$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
	if ($result -> num_rows == 0){
		echo '<script type="text/javascript">'; 
		echo 'alert("This Employee is not working at this hotel at this position at the time.");'; 
		echo 'window.location.href = "update_contract_form.php";';
		echo '</script>';
		
	}
	else{
		$start_date = $row['Start_Date'];
		
		if ($new_finish_date <= $start_date){
			echo '<script type="text/javascript">'; 
			echo 'alert("Finish Date cannot happen before the Start Day. Please try again.");'; 
			echo 'window.location.href = "update_contract_form.php";';
			echo '</script>';
		}
		else{
			$sql = "UPDATE works SET Finish_Date = '$new_finish_date' where IRS_Number_Employee = '$IRS' and Hotel_ID = '$hotel_id' and Position = '$position'";
			if ($conn->query($sql) === false) {
				$flag=false;
			} 
			
		}
	}
		if($flag){
		?>
		<html>
<head>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
<body>
	<div id="srch">
		<center><form action="e-hotels.php" method="POST">
			<p>
				Contract Updated!
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
	