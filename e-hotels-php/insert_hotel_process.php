<html>
<head>
<link rel="stylesheet" type="text/css" href="data.css">
</head>
<body>
<?php
	
	$hotel_id=$_POST['hotel_id'];
	$phones = $_POST['phones'];
	$emails=$_POST['emails'];
	
	$conn = mysqli_connect("localhost", "root", "");
	mysqli_select_db($conn,"hotel_db");
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	} 

			
	for($i = 0; $i < count($_POST["phones"]); $i++) {
			$element = $_POST["phones"][$i];
			$query = " select * from phone_hotel where phone_number = '$element'";
			$result = mysqli_query($conn, $query)or die("Failure!");
		if ($result -> num_rows != 0){
			echo '<script type="text/javascript">'; 
			echo 'alert("Phone Number already exists.Please try again.");'; 
			echo 'window.location.href = "insert_hotel_form.php";';
			echo '</script>';
			exit();
		}		
	}	
	
	for($i = 0; $i < count($_POST["emails"]); $i++) {
			$element = $_POST["emails"][$i];
			$query = " select * from email_hotel where Email_Address = '$element'";
			$result = mysqli_query($conn, $query)or die("Failure!");
		if ($result -> num_rows != 0){
			echo '<script type="text/javascript">';
			echo 'alert("Email Address already exists.Please try again.");'; 
			echo 'window.location.href = "insert_hotel_form.php";';
			echo '</script>';
			exit();
		}		
	}	
	
	
		$sql = "INSERT INTO email_hotel (Hotel_ID,Email_Address) VALUES ";
		for($i = 0; $i < count($_POST["emails"])-1; $i++) {
			$element = $_POST["emails"][$i];
			$sql .= "('$hotel_id','$element'),";
		}
			$i  = count($_POST["emails"])-1;
			$element = $_POST["emails"][$i];
			$sql .= "('$hotel_id','$element')";
		if ($conn->query($sql) === false) {
			echo "Error: " . $sql . "<br>" . $conn->error;
		}
		$sql = "INSERT INTO phone_hotel (Hotel_ID,phone_number) VALUES ";
		for($i = 0; $i < count($_POST["phones"])-1; $i++) {
			$element = $_POST["phones"][$i];
			$sql .= "('$hotel_id','$element'),";
		}
			$i  = count($_POST["phones"])-1;
			$element = $_POST["phones"][$i];
			$sql .= "('$hotel_id','$element')";
		
		if ($conn->query($sql) === true) {
		
		
	?>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
		<body>
			<div id="srch">
				<center><form action="e-hotels.php" method="POST">		
						New hotel added successfully.
					<p>	
						<input type="Submit" id="btn" value="OK" name = "ok_button">
					</p>			
				</center></form>
			</div>
		</body>
<?php	
	}
	else {
			echo "Error: " . $sql . "<br>" . $conn->error;
	}
?>

 </table>
</body>
</html>
	