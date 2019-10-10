<?php
	
	$hotel_name=$_POST['hotel_name'];
	$hotel_group_name=$_POST['hotelgroup_name'];
	$street=$_POST['street'];
	$number=$_POST['number'];
	$postal_code=$_POST['postal_code'];
	$city=$_POST['city'];
	$stars=$_POST['stars'];
	$num_emails = $_POST['num_emails'];
	$num_phones = $_POST['num_phones'];
	
	$conn = mysqli_connect("localhost", "root", "");
	mysqli_select_db($conn,"hotel_db");
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	} 
	$query = " select * from hotel_group where hotelgroup_name = '$hotel_group_name'";
	$result = mysqli_query($conn, $query)or die("Failure!");
	$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
	$hotel_group_id = $row['Hotel_group_ID'];
	
	$query = " select * from hotel where hotel_name = '$hotel_name'";
	$result = mysqli_query($conn, $query)or die("Failure!");
	if($result -> num_rows != 0){
		echo '<script type="text/javascript">'; 
		echo 'alert("This Hotel Name already exists.Please try again.");'; 
		echo 'window.location.href = "insert_hotel_form.php";';
		echo '</script>';
	}
	$query= "select MAX(hotel_ID) as max FROM hotel";
	$result = mysqli_query($conn, $query)or die("Failure!");
	if ($result -> num_rows == 0){
		$max =0;
	}
	else{
		$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
		$max=$row['max'];
	}
	$hotel_id= ++$max;
	
	
	$sql="INSERT INTO hotel (hotel_ID,hotel_name,Street,Number,Postal_Code,City,Stars,Number_of_rooms,Hotelgroup_ID) VALUES ('$hotel_id','$hotel_name','$street',
		'$number','$postal_code','$city','$stars','0','$hotel_group_id')";
	if ($conn->query($sql) === false){
		echo "Error: " . $sql . "<br>" . $conn->error;
	}
	$conn->close();
	?>
<html>
<head>
	<title>E-hotels</title>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
<head>
<body>
	<div id="srch">
<center><h2>Insert Hotel's Phone Number's And E-Mail Addresses</h2></center>
		<center><form action="insert_hotel_process.php" method="POST">

<?php	
	for($i = 0; $i < $num_emails; $i++) {
		?>
		<p>
			<b><label>E-Mails(s)*</label><br>
			<input type="email" name="emails[]" required>				
		</p>
	<?php } 
	
	for($i = 0; $i < $num_phones; $i++) {
		?>
		<p>
			<label>Phone(s)*</label><br>
			<input type="text" name="phones[]" required>				
		</p>
	<?php } ?>
		*Mandatory Field </b>
	
			<p>
				<input type="submit" id="btn" name="Submit">
			</p>
			<input type="hidden" name="hotel_id" value=<?=$hotel_id;?>>
			
			
			

	</center></form>
</div>
</body>
</head>
</html>
		
	
	