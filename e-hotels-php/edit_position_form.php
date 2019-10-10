<?php

	$first_name = $_POST['first_name'];
	$last_name = $_POST['last_name'];
	$street=$_POST['street'];
	$number=$_POST['number'];
	$postal_code=$_POST['postal_code'];
	$city=$_POST['city'];
	$SSN=$_POST['ssn'];
	$IRS=$_POST['IRS'];
	$hotel_name=$_POST['hotel_name'];
	$new_IRS=$_POST['new_IRS'];
	
	$conn = mysqli_connect("localhost", "root", "");
	mysqli_select_db($conn,"hotel_db");
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	} 

	$query = "select * from hotel where hotel_name = '$hotel_name'";
	$result = mysqli_query($conn, $query)or die (mysqli_error($con));
	$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
	$hotel_id = $row['hotel_ID'];
	
	$query = "select * from works where IRS_Number_Employee = '$IRS' and Hotel_ID ='$hotel_id'";
	$result = mysqli_query($conn, $query)or die (mysqli_error($con));
	if($result -> num_rows == 0){
		echo '<script type="text/javascript">'; 
		echo 'alert("There is no Employee with this IRS Number working at this Hotel.");'; 
		echo 'window.location.href = "edit_employee_form.php";';
		echo '</script>';
	}
	date_default_timezone_set('Europe/Athens');
	$current_date=date("Y/m/d");
	
	if (!empty($first_name)){
		$sql = "UPDATE employee SET First_Name = '$first_name' where IRS_Number = '$IRS'";
		if ($conn->query($sql) === false) {
					$flag2=false;
			}
	}
	
	if (!empty($last_name)){
		$sql = "UPDATE employee SET Last_Name = '$last_name' where IRS_Number = '$IRS'";
		if ($conn->query($sql) === false) {
					$flag3=false;
		}
	}
	if (!empty($SSN)){
		$sql = "UPDATE employee SET Social_Security_Number = '$SSN' where IRS_Number = '$IRS'";
		if ($conn->query($sql) === false) {
					$flag4=false;
		}
	}
	if (!empty($number)){
		$sql = "UPDATE employee SET Number = '$number' where IRS_Number = '$IRS'";
		if ($conn->query($sql) === false) {
					$flag5=false;
		}
	}
	if (!empty($street)){
		$sql = "UPDATE employee SET Street = '$street' where IRS_Number = '$IRS'";
		if ($conn->query($sql) === false) {
					$flag6=false;
		}
	}
	if (!empty($city)){
		$sql = "UPDATE employee SET City = '$city' where IRS_Number = '$IRS'";
		if ($conn->query($sql) === false) {
					$flag7=false;
		}
	}
	if (!empty($postal_code)){
		$sql = "UPDATE employee SET Postal_Code = '$postal_code' where IRS_Number = '$IRS'";
		if ($conn->query($sql) === false) {
					$flag8=false;
		}
	}
	
	
	
	$conn->close();
	?>

<html>
<head>
<head>
	<title>E-hotels</title>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
<head>
<body>
	<div id="srch">
<center><h2>Edit Employee's Positions</h2></center>
		<center><form action="edit_employee.php" method="POST">
		<center><b>Please select either none or one position from each list. </b></center>
		<p>
				<label>The Employee works at <b> <?php echo "$hotel_name";?> </b> Hotel at the Positions: <br/></label> <b>Change</b> 
		
			<?php
				$conn = mysqli_connect("localhost", "root", "");
				mysqli_select_db($conn,"hotel_db");
				if ($conn->connect_error) {
					die("Connection failed: " . $conn->connect_error);
				} 
				
				$query = " select * from works where IRS_Number_Employee = '$IRS' and Hotel_ID = '$hotel_id'";
				$result = mysqli_query($conn, $query)or die("Failure!");
				
				echo '<select type = text name=old_positions value=', '></option>';
				echo "<option value=\"\"></option>";
				while($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
					
					echo "<option value=\"{$row['Position']}\">{$row['Position']}</option>";
				
				}
				echo "</select>";
				$conn->close();
				?>
			</p>
			
			
		<p>
				<label>The Employee doesn't work at <b><?php echo "$hotel_name";?> </b> Hotel at the Positions: <br/></label> <b>To</b> 
		
			<?php
				
				$conn = mysqli_connect("localhost", "root", "");
				mysqli_select_db($conn,"hotel_db");
				if ($conn->connect_error) {
					die("Connection failed: " . $conn->connect_error);
				} 
				$maketemp = "
					CREATE TEMPORARY TABLE Positions (
					`Position` VARCHAR(45) NOT NULL,
					PRIMARY KEY(Position))"; 
				 mysqli_query( $conn,$maketemp) or die ("Sql error : ".mysql_error());
				 
				$sql = "INSERT INTO Positions (Position) VALUES ('Manager'),('Chef'),('KitchenAssistance'),('Gardener'),('CleaningStaff'),('Maid'),('WaitingStaff'),('Reception')
				,('Bartender'),('Groom'),('SpaTherapist'),('Engineer'),('Logistics'),('Security'),('ValetBoy'),('BabySitter'),('Lifeguard'),('ManagingSupplies')";
				if ($conn->query($sql) === TRUE) {
						
				}
				else {
					echo "Error: " . $sql . "<br>" . $conn->error;
				}
				$query = " select Position from Positions where Position not in (select Position from works where IRS_Number_Employee = '$IRS' and Hotel_ID = '$hotel_id')";
				$result = mysqli_query($conn, $query)or die("Failure!");
				
				echo '<select type = text name=new_positions value=', '></option>';
				echo "<option value=\"\"></option>";
				while($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
					
					echo "<option value=\"{$row['Position']}\">{$row['Position']}</option>";
				
				}
				echo "</select>";
				$conn->close();
				?>
			
			</p>			
			
			 
			 
			<p>
				<input type="submit" id="btn" name="Submit">
			</p>
			<input type="hidden" name="IRS" value=<?=$IRS;?>>
			<input type="hidden" name="new_IRS" value=<?=$new_IRS;?>>
			<input type="hidden" name="hotel_id" value=<?=$hotel_id;?>>
			
			

	</center></form>
</div>
</body>
</head>
</html>
		
		
		
		
		
		
		
		
		
		
		
		
		