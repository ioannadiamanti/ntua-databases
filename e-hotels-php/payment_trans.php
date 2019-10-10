<?php
	$pay = $_POST['pmethod'];
	$e_irs = $_POST['e_irs'];
	$c_irs = $_POST['c_irs']; 
	$room_id = $_POST['room_id'];
	$hotel_id = $_POST['hotel_id'];
	$price = $_POST['price'];
	$start_date=$_POST['start_date'];
	$finish_date=$_POST['finish_date'];


	$diff = abs(strtotime($finish_date) - strtotime($start_date));

	$years = floor($diff / (365*60*60*24));
	$months = floor(($diff - $years * 365*60*60*24) / (30*60*60*24));
	$days = floor(($diff - $years * 365*60*60*24 - $months*30*60*60*24)/ (60*60*24));
		
	$con = mysqli_connect("localhost", "root", "");
	mysqli_select_db($con,"hotel_db");
	
	if ($days==0){
		$amount = ($days+1)* $price ;
	}
	else{
		$amount =  $days* $price ;
	}

	mysqli_query($con,"insert into payment_transaction(IRS_Number_Employee, IRS_Number_Customer, Room_ID, Hotel_ID, Payment_Amount, Payment_Method) values('$e_irs', '$c_irs', '$room_id', '$hotel_id', '$amount', '$pay')");
	
?>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
<body>
	<div id="srch">
		<center><form action="e-hotels.php" method="POST">
			<p>
				Payment done!
			</p>		
			<p>
				<input type="submit" id="btn" name="Ok!" value="OK!">
			</p>
		<center></form>
	</div>
</body>
</html>