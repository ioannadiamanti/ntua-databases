<html>
<head>
<link rel="stylesheet" type="text/css" href="data.css">
</head>
<body>

<?php
	
	$hotel_name = $_POST['hotel_name'];
	$capacity = $_POST['capacity'];
	$view = $_POST['view'];
	$expand = $_POST['expand'];
	$repairs = $_POST['repairs'];
	$price = $_POST['price'];
	$number = $_POST['number'];
	
	$flag1=false;
	$flag2=false;
	
	if (isset($_POST['amenities'])){
		$amenities = $_POST['amenities'];
	}
	
	$conn = mysqli_connect("localhost", "root", "");
	mysqli_select_db($conn,"hotel_db");
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	} 
		$query = "select MAX(Room_id) as max from hotel_room";
		$result = mysqli_query($conn, $query)or die (mysqli_error($con));
		if ($result->num_rows == 0 ) {
			$max = 0;
		}
		else {
			$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
			$max=$row['max'];
		}
		$room_id= ++$max;
		$query = "select * from hotel where hotel_name = '$hotel_name'";
		$result = mysqli_query($conn, $query)or die (mysqli_error($con));
		$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
		$hotel_id=$row['hotel_ID'];
		
		$query = "select * from hotel_room where Room_Number = '$number' and Hotel_ID = '$hotel_id'";
		$result = mysqli_query($conn, $query)or die (mysqli_error($conn));
		if ($result -> num_rows != 0){
			echo '<script type="text/javascript">'; 
			echo 'alert("Sorry this Room Number already belongs to a another Hotel Room. Please try again.");'; 
			echo 'window.location.href = "insert_hotel_room_form.php";';
			echo '</script>';
			exit();
		}
		
		$sql ="INSERT INTO hotel_room (Room_id,Room_Number,Capacity,View,Expandable,Repairs_need,Price,Hotel_ID) VALUES ('$room_id','$number','$capacity','$view','$expand','$repairs',
		'$price','$hotel_id')";
		if ($conn->query($sql) === TRUE) {
			//echo "Hotel Room inserted successfully". "<br>";
			$flag1=true;
		}
		else {
			echo "Error: " . $sql . "<br>" . $conn->error;
		}
		if(!empty($amenities)) {
			$sql = "INSERT INTO amenities (Room_ID,Hotel_ID,Type) VALUES ";
			for($i = 0; $i < count($_POST["amenities"])-1; $i++) {
				$element = $_POST["amenities"][$i];
				$sql .= "('$room_id','$hotel_id','$element'),";
			}
				$i  = count($_POST["amenities"])-1;
				$element = $_POST["amenities"][$i];
				$sql .= "('$room_id','$hotel_id','$element')";
			if ($conn->query($sql) === TRUE) {
				//echo "Hotel Room Amenities inserted successfully". "<br>";
				$flag2=true;
			}
			else {
				echo "Error: " . $sql . "<br>" . $conn->error;
			}
		}
		if ($flag1 and $flag2) {
			?>	
<html>
<head>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
		<body>
			<div id="srch">
				<center><form action="e-hotels.php" method="POST">		
						New hotel room added successfully.
					<p>	
						<input type="Submit" id="btn" value="OK" name = "ok_button">
					</p>			
				</center></form>
			</div>
		</body>
<?php		
		} 
		
	
	
?>
		
	
</table>
</body>
</html>