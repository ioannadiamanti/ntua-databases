<html>
<head>
<link rel="stylesheet" type="text/css" href="data.css">
</head>
<body>

<?php
	
	$hotel_name=$_POST['hotel_name'];
	$n_hotel_name=$_POST['new_hotel_name'];
	$stars = $_POST['stars'];
	$email = $_POST['email'];
	$phone = $_POST['phone'];
	$new_email = $_POST['new_email'];
	$new_phone = $_POST['new_phone'];
	
	$flag1=true;
	$flag2=true;
	$flag3=true;
	$flag4=true;
	
	
	
	
	$conn = mysqli_connect("localhost", "root", "");
	mysqli_select_db($conn,"hotel_db");
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	} 
	
	
	
		$query = " select * from hotel where  hotel_name = '$n_hotel_name'";
		$result = mysqli_query($conn, $query)or die("Failure!");
		if($result -> num_rows != 0){
			echo '<script type="text/javascript">'; 
			echo 'alert("A Hotel with this Name already exists.Please try again.");'; 
			echo 'window.location.href = "edit_hotel_form.php";';
			echo '</script>';
			exit();
		}
		if ((!empty($email) and empty($new_email)) OR (empty($email) and !empty($new_email))){
			echo '<script type="text/javascript">'; 
			echo 'alert("Please fill either none or both of the Current E-Mail and New E-Mail fields.");'; 
			echo 'window.location.href = "edit_hotel_form.php";';			
			echo '</script>';
			exit();
		}
		if ((!empty($phone) and empty($new_phone)) OR (empty($phone) and !empty($new_phone))){
			echo '<script type="text/javascript">'; 
			echo 'alert("Please fill either none or both of the Current Phone and New Phone fields.");'; 
			echo 'window.location.href = "edit_hotel_form.php";';			
			echo '</script>';
			exit();
		}
		
		$query = " select * from hotel where  hotel_name = '$hotel_name'";
		$result = mysqli_query($conn, $query)or die("Failure!");
		$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
		$hotel_id = $row['hotel_ID'];
		
		if (!empty($phone) and !empty($new_phone)){
			$query = " select * from phone_hotel where  Phone_number = '$phone'";
			$result = mysqli_query($conn, $query)or die("Failure!");
			if ($result -> num_rows == 0){
				echo '<script type="text/javascript">'; 
				echo 'alert("The Phone number to be changed does not exist.Please try again.");'; 
				echo 'window.location.href = "edit_hotel_form.php";';			
				echo '</script>';
				exit();
			}
			$query = " select * from phone_hotel where  Phone_number = '$phone' and Hotel_ID = '$hotel_id'";
			$result = mysqli_query($conn, $query)or die("Failure!");
			if ($result -> num_rows == 0){
				echo '<script type="text/javascript">'; 
				echo 'alert("The Phone number and Hotel Name do not match.Please try again.");'; 
				echo 'window.location.href = "edit_hotel_form.php";';			
				echo '</script>';
				exit();
			}
			$query = " select * from phone_hotel where  Phone_number = '$new_phone'";
			$result = mysqli_query($conn, $query)or die("Failure!");
			if ($result -> num_rows != 0){
				echo '<script type="text/javascript">'; 
				echo 'alert("The New Phone number already exists.Please try again.");'; 
				echo 'window.location.href = "edit_hotel_form.php";';			
				echo '</script>';
				exit();
			}
			$sql = "UPDATE phone_hotel SET Phone_number = '$new_phone' where Hotel_ID = '$hotel_id' and Phone_number = '$phone'";
			if ($conn->query($sql) === TRUE) {
				//echo "Number of Hotel updated successfully". "<br>";
				$flag1=true;
			} 
			else {
				$flag1=false;
				echo "Error: " . $sql . "<br>" . $conn->error;
			}
		}
		
		if (!empty($email) and !empty($new_email)){
			$query = " select * from email_hotel where  Email_Address = '$email'";
			$result = mysqli_query($conn, $query)or die("Failure!");
			if ($result -> num_rows == 0){
				echo '<script type="text/javascript">'; 
				echo 'alert("The Email Address to be changed does not exist.Please try again.");'; 
				echo 'window.location.href = "edit_hotel_form.php";';			
				echo '</script>';
				exit();
			}
			$query = " select * from email_hotel where  Email_Address = '$email' and Hotel_ID = '$hotel_id'";
			$result = mysqli_query($conn, $query)or die("Failure!");
			if ($result -> num_rows == 0){
				echo '<script type="text/javascript">'; 
				echo 'alert("The Email Address and Hotel Name do not match.Please try again.");'; 
				echo 'window.location.href = "edit_hotel_form.php";';			
				echo '</script>';
				exit();
			}
			$query = " select * from email_hotel where  Email_Address = '$new_email'";
			$result = mysqli_query($conn, $query)or die("Failure!");
			if ($result -> num_rows != 0){
				echo '<script type="text/javascript">'; 
				echo 'alert("The New Email Address already exists.Please try again.");'; 
				echo 'window.location.href = "edit_hotel_form.php";';			
				echo '</script>';
				exit();
			}
			$sql = "UPDATE email_hotel SET Email_Address = '$new_email' where Hotel_ID = '$hotel_id' and Email_Address = '$email'";
			if ($conn->query($sql) === TRUE) {
				//echo "Email of Hotel updated successfully". "<br>";
				$flag2=true;
			} 
			else {
				$flag2=false;
				echo "Error: " . $sql . "<br>" . $conn->error;
			}
		}		
		if (!empty($n_hotel_name)){
			$sql = "UPDATE hotel SET hotel_name = '$n_hotel_name' where hotel_name = '$hotel_name'";
			if ($conn->query($sql) === TRUE) {
				//echo "Name of Hotel updated successfully". "<br>";
				$flag3=true;
			} 
			else {
				$flag3=false;
				echo "Error: " . $sql . "<br>" . $conn->error;
			}
		}
		if (!empty($stars)){
			$sql = "UPDATE hotel SET Stars = '$stars' where hotel_name = '$hotel_name'";
			if ($conn->query($sql) === TRUE) {
				//echo "Stars of Hotel updated successfully". "<br>";
				$flag4=true;
			} 
			else {
				$flag4=false;
				echo "Error: " . $sql . "<br>" . $conn->error;
			}
		}
		
		if ($flag1 and $flag2 and $flag3 and $flag4) {
			?>	
<html>
<head>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
		<body>
			<div id="srch">
				<center><form action="e-hotels.php" method="POST">		
						Hotel edited successfully.
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