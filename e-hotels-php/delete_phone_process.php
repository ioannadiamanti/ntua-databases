<?php
	$hotel_name=$_POST['hotel_name'];
	$phone=$_POST['phone'];
		$conn = mysqli_connect("localhost", "root", "");
		mysqli_select_db($conn,"hotel_db");
		$query="select * from hotel where hotel_name ='$hotel_name'";
		$result = mysqli_query($conn, $query)or die("Failure!");
		$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
		$hotel_id = $row['hotel_ID'];
		
		$query="select * from phone_hotel where Phone_number ='$phone'";
		$result = mysqli_query($conn, $query)or die("Failure!");
		if($result  -> num_rows == 0){
			echo '<script type="text/javascript">'; 
			echo 'alert("This Phone Number does not exist.Please try again.");'; 
			echo 'window.location.href = "delete_hotel_phone.php";';
			echo '</script>';
			exit();
		}
		$query="select * from phone_hotel where Phone_number ='$phone' and Hotel_ID = '$hotel_id'";
		$result = mysqli_query($conn, $query)or die("Failure!");
		if($result  -> num_rows == 0){
			echo '<script type="text/javascript">'; 
			echo 'alert("This Phone Number does not belong to the specified Hotel.Please try again.");'; 
			echo 'window.location.href = "delete_hotel_phone.php";';
			echo '</script>';
			exit();
		}
		
		$sql = "DELETE FROM phone_hotel where Phone_number = '$phone' and Hotel_ID = '$hotel_id'";
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
				Phone Number <?php echo "'$phone'";?> Of <?php echo "'$hotel_name'";?> Deleted Successfully!
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