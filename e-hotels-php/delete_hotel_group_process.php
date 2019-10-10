<html>
<head>
<link rel="stylesheet" type="text/css" href="data.css">
</head>
<body>

<?php

	
	$hotel_group_name = $_POST['hotel_group_name'];
	$conn = mysqli_connect("localhost", "root", "");
	mysqli_select_db($conn,"hotel_db");
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	} 
	
	$query = " select * from hotel_group where  hotelgroup_name = '$hotel_group_name'";
	$result = mysqli_query($conn, $query)or die("Failure!");
	if ($result -> num_rows == 0){
		echo '<script type="text/javascript">'; 
		echo 'alert("There is no Hotel Group matching this Hotel Group Name. Please try again.");'; 
		echo 'window.location.href = "delete_hotel_group_form.php";';
		echo '</script>';
	}
	else{
		$sql = "DELETE FROM hotel_group where hotelgroup_name = '$hotel_group_name'";
		
	}
	
	
	if ($conn->query($sql) === TRUE) {
	
	
 ?>
 	
<html>
<head>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
		<body>
			<div id="srch">
				<center><form action="e-hotels.php" method="POST">		
					Hotel Group deleted successfully!
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
	$conn->close();
?>
 </table>
</body>
</html>
	