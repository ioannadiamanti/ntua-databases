<html>
<head>
<link rel="stylesheet" type="text/css" href="data.css">
</head>
<body>

<?php
	
	$IRS=$_POST['IRS'];
	$new_IRS=$_POST['new_IRS'];
	$hotel_id=$_POST['hotel_id'];
	$old_positions = $_POST['old_positions'];
	$new_positions = $_POST['new_positions'];
	
	$flag1=true;
	$flag2=true;
	
		
	$conn = mysqli_connect("localhost", "root", "");
	mysqli_select_db($conn,"hotel_db");
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	}
	if((!empty($old_positions) and empty($new_positions)) OR (empty($old_positions) and !empty($new_positions))){
		echo '<script type="text/javascript">'; 
		echo 'alert("Please select either none or one Position of each list.");'; 
		echo 'window.location.href = "edit_employee_form.php";';
		echo '</script>';
	}
	
	if(!empty($old_positions) and !empty($new_positions)){
			$query = "select * from works where Hotel_ID = '$hotel_id' and Position = 'Manager' ";
			$result = mysqli_query($conn, $query)or die("Failure!");
			
			if ($old_positions == 'Manager'){					
					if($result -> num_rows == 1){
						echo '<script type="text/javascript">'; 
						echo 'alert("This Employee is the only Manager of the Hotel.He cannot get fired until another Manager is hired first.");'; 
						echo 'window.location.href = "edit_employee_form.php";';
						echo '</script>';
						exit();
					}
					else{					
						$sql = "UPDATE works SET Position = '$new_positions' where IRS_Number_Employee = '$IRS' and Hotel_ID = '$hotel_id'  and Position = '$old_positions'";
					}
			}
			else{
				$sql = "UPDATE works SET Position = '$new_positions' where IRS_Number_Employee = '$IRS' and Hotel_ID = '$hotel_id'  and Position = '$old_positions'";
			}
			
			if ($conn->query($sql) === false) {
					$flag1=false;
			}
	
	}	
	if(!empty($new_IRS)){
		$sql = "UPDATE employee SET IRS_Number = '$new_IRS' where IRS_Number = '$IRS'";
		if ($conn->query($sql) === false) {
					$flag2=false;
		}
		
	}
	
	
if($flag1 and $flag2){
		?>
		<html>
<head>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
<body>
	<div id="srch">
		<center><form action="e-hotels.php" method="POST">
			<p>
				Employee Data Edited Successfully!
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
</body>
</html>