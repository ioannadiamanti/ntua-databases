<?php

		
//Customer data (all data are in string form)
	$IRS_number=$_POST['IRS'];
	$Street=$_POST['Street'];
	$Number=$_POST['number'];
	$Postal_code=$_POST['postal_code'];
	$City=$_POST['city'];
	$First_name=$_POST['first_name'];
	$Last_name=$_POST['last_name'];
	$SSN=$_POST['ssn'];
	
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

date_default_timezone_set('Europe/Athens');
$current_date=date("Y/m/d");
	$sql_customer = "INSERT INTO customer (IRS_Number, Street, Number, Postal_Code, City, First_name, Last_name, Social_Security_Number, First_Registration)
	VALUES ('$IRS_number', '$Street', '$Number', '$Postal_code', '$City', '$First_name', '$Last_name', '$SSN', '$current_date')";
	
	if ($conn->query($sql_customer) === TRUE) {
		//echo '<script type="text/javascript">'; 
		//echo 'alert("New customer record created successfully.");'; 
		//echo 'window.location.href = "search1.php";';
		//echo '</script>';
		
?>
	
	<html>
		<head>
			<title>Registration Success</title>
			<link rel="stylesheet" type="text/css" href="style_search.css">
		</head>
		<body>
			<div id="srch">
				<center><form action="welcome.php" method="POST">
					<p>
					Thank you for your registration!
					</p>
					<p>
					New customer record created successfully.	
					</p>					
					<p>
					<input type="submit" id="btn" value="OK!"></input>	
					</p>
					
				</center></form>
			</div>
		</body>	
			
<?php		
		
	} else {
		if (mysqli_errno($conn) == 1062) {
			//echo '<script type="text/javascript">'; 
			//echo 'alert("It seems that you have already been registered.");'; 
			//echo 'window.location.href = "search1.php";';
			//echo '</script>';
?>
	
	<html>
		<head>
			<title>Registration Failure</title>
			<link rel="stylesheet" type="text/css" href="style_search.css">
		</head>
		<body>
			<div id="srch">
				<center><form action="welcome.php" method="POST">
					<p>
					It seems that you have already been registered.	
					</p>					
					<p>
					<input type="submit" id="btn" value="OK!"></input>	
					</p>
					
				</center></form>
			</div>
		</body>	
			
<?php		
		}
		else {
			echo "Error: " . $sql_reserves . "<br>" . $conn->error;
		}
	}
$conn->close();
?>