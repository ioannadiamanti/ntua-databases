<?php
	$hotel_name=$_POST['hotel_name'];
	$email=$_POST['email'];
	
		$conn = mysqli_connect("localhost", "root", "");
		mysqli_select_db($conn,"hotel_db");
		$query="select * from hotel where hotel_name ='$hotel_name'";
		$result = mysqli_query($conn, $query)or die("Failure!");
		$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
		$hotel_id = $row['hotel_ID'];
		
		$query="select * from email_hotel where Email_Address ='$email'";
		$result = mysqli_query($conn, $query)or die("Failure!");
		if($result  -> num_rows != 0){
			echo '<script type="text/javascript">'; 
			echo 'alert("This E-Mail Address already exists.Please try again.");'; 
			echo 'window.location.href = "insert_hotel_email.php";';
			echo '</script>';
			exit();
		}
		
		$sql = "INSERT INTO email_hotel (Hotel_ID,Email_Address) VALUES ('$hotel_id','$email')";
		if ($conn->query($sql) === true) {
			
		
			?>
		<html>
<head>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
<body>
	<div id="srch">
		<center><form action="e-hotels.php" method="POST">
			<p>
				E-Mail Added Successfully!
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