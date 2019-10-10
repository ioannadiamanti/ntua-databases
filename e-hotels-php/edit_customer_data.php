<html>
<head>
<link rel="stylesheet" type="text/css" href="data.css">
</head>
<body>

<?php
	$IRS=$_POST['IRS'];
	$new_IRS=$_POST['new_IRS'];
	$Street=$_POST['Street'];
	$Number=$_POST['number'];
	$Postal_code=$_POST['postal_code'];
	$City=$_POST['city'];
	$First_name=$_POST['first_name'];
	$Last_name=$_POST['last_name'];
	$SSN=$_POST['ssn'];
	
	$flag1=true;
	$flag2=true;
	$flag3=true;
	$flag4=true;
	$flag5=true;
	$flag6=true;
	$flag7=true;
	$flag8=true;
	
	$conn = mysqli_connect("localhost", "root", "");
	mysqli_select_db($conn,"hotel_db");
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	} 
	
	
		$query = "select * from customer where IRS_Number = '$IRS'";
		$result = mysqli_query($conn, $query)or die (mysqli_error($con));
		if ($result->num_rows == 0 ) {
			echo '<script type="text/javascript">'; 
			echo 'alert("Current IRS  Number is not valid. Please try Again");'; 
			echo 'window.location.href = "edit_customer_data_form.php";';
			echo '</script>';
		}
		else{
			$query = "select * from customer where IRS_Number = '$new_IRS'";
			$result = mysqli_query($conn, $query)or die (mysqli_error($con));
			if ($result->num_rows != 0 ) {
				echo '<script type="text/javascript">'; 
				echo 'alert("New IRS  Number already exists. Please try Again");'; 
				echo 'window.location.href = "edit_customer_data_form.php";';
				echo '</script>';
				exit();
			}
			
			if (!empty($Street)){
				$sql = "UPDATE customer SET Street = '$Street' where IRS_Number = '$IRS'";
				if ($conn->query($sql) ===false) {
					$flag1=false;
				} 
			}
			if (!empty($Number)){
				$sql = "UPDATE customer SET Number = '$Number' where IRS_Number = '$IRS'";
				if ($conn->query($sql) === false) {
					$flag2=false;
				} 
				
			}
			if (!empty($Postal_Code)){
				$sql = "UPDATE customer SET Postal_Code = '$Postal_code' where IRS_Number = '$IRS'";
				if ($conn->query($sql) === false) {
					$flag3=false;
				}
			}
			if (!empty($City)){
				$sql = "UPDATE customer SET City = '$City' where IRS_Number = '$IRS'";
				if ($conn->query($sql) === false) {
					$flag4=false;
				} 
				
			}
			if (!empty($First_name)){
				$sql = "UPDATE customer SET First_name = '$First_name' where IRS_Number = '$IRS'";
				if ($conn->query($sql) === false) {
					$flag5=false;
				} 
			}
			if (!empty($Last_name)){
				$sql = "UPDATE customer SET Last_name = '$Last_name' where IRS_Number = '$IRS'";
				if ($conn->query($sql) === false) {
					$flag6=false;
				} 
			}
			if (!empty($SSN)){
				$sql = "UPDATE customer SET Social_Security_Number = '$SSN' where IRS_Number = '$IRS'";
				if ($conn->query($sql) === false) {
					$flag7=false;
				}
			}
			if (!empty($new_IRS)){
				$sql = "UPDATE customer SET IRS_Number = '$new_IRS' where IRS_Number = '$IRS'";
				if ($conn->query($sql) === false) {
					$flag8=false;
				} 
			}
		}
	
			if($flag1 and $flag2 and $flag3 and $flag3 and $flag4 and $flag5 and $flag6 and $flag7 and $flag8){
		?>
		<html>
<head>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
<body>
	<div id="srch">
		<center><form action="e-hotels.php" method="POST">
			<p>
				Customer Data Edited Successfully!
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

?>
	
</table>
</body>
</html>