<html>
<head>
<link rel="stylesheet" type="text/css" href="data.css">
</head>
<body>

<?php
	$position=$_POST['position'];
	$hotel_name = $_POST['hotel_name'];
	$IRS_number=$_POST['irs'];
	
	$flag = true;
	
	$conn = mysqli_connect("localhost", "root", "");
	mysqli_select_db($conn,"hotel_db");
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	} 
	
	$query = "select * from hotel where hotel_name = '$hotel_name'";
	$result = mysqli_query($conn, $query)or die("Failure!");
	$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
	$hotel_id = $row['hotel_ID'];
	
	$query = " select * from employee where IRS_Number = '$IRS_number'";
	$result = mysqli_query($conn, $query)or die("Failure!");
	if ($result -> num_rows == 0){
		echo '<script type="text/javascript">'; 
		echo 'alert("There is no Employee with this IRS number. Please try again.");'; 
		echo 'window.location.href = "employee_firing_form.php";';
		echo '</script>';
	}
	
	$query = "select * from works where IRS_Number_Employee = '$IRS_number' and Hotel_ID = '$hotel_id' and Position = '$position'";
	$result = mysqli_query($conn, $query)or die("Failure!");
	$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
	if ($result -> num_rows == 0){
		echo '<script type="text/javascript">'; 
		echo 'alert("This Employee is not working at this hotel at this position at the time.");'; 
		echo 'window.location.href = "employee_firing_form.php";';
		echo '</script>';
		
	}
	else{
		if ($position == 'Manager'){
			$query = "select * from works where Hotel_ID = '$hotel_id' and Position = 'Manager'";
			
			$result = mysqli_query($conn, $query)or die("Failure!");
			if($result -> num_rows == 1){
				echo '<script type="text/javascript">'; 
				echo 'alert("This Employee is the only Manager of the Hotel.He cannot get fired until another Manager is hired first.");'; 
				echo 'window.location.href = "employee_firing_form.php";';
				echo '</script>';
				exit();
			}
		}
	}
	$sql= " DELETE FROM works WHERE IRS_Number_Employee = '$IRS_number' and Hotel_ID = '$hotel_id' and Position = '$position'";
	
	if ($conn->query($sql) === false) {
		$flag=false;
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
				Employee Fired!
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