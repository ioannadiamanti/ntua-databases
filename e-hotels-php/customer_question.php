<!DOCTYPE html>
<?php

//Reservation data (all data are in string form)
	if (isset($_POST['start_date'])){
		$start_date = $_POST['start_date'];
	}
	if (isset($_POST['finish_date'])){
		$finish_date = $_POST['finish_date'];
	}
	if (isset($_POST['view'])){
		$view = $_POST['view'];
	}
	if (isset($_POST['expand'])){
		$expand = $_POST['expand'];
	}
	if (isset($_POST['city'])){
		$city = $_POST['city'];
	}
	if (isset($_POST['rooms'])){
		$rooms = $_POST['rooms'];
	}
	if (isset($_POST['stars'])){
		$stars = $_POST['stars'];
	}
	if (isset($_POST['chain'])){
		$chain = $_POST['chain'];
	}
	if (isset($_POST['capacity'])){
		$cap = $_POST['capacity'];
	}
	if (isset($_POST['price_from'])){
		$price_from = (int)$_POST['price_from'];
	}
	if (isset($_POST['price_to'])){
		$price_to= (int)$_POST['price_to'];
	}
	if (isset($_POST['amenities'])){
		$amenities = $_POST['amenities'];
	}
//Room data	(all data are in string form)
	
	//for($i=0; $i < count($_POST['room_id']); $i++){
  //    echo($room_id[$i] . " ");
  //  }
 	
	if (isset($_POST['room_id'])){
		$room_id = $_POST['room_id'];
	}
	if (empty($room_id)){
		?>
			
<html>
		<head>
			<title>Registration</title>
			<link rel="stylesheet" type="text/css" href="style_search3.css">
		</head>
		<body>
			<div id="srch">
				<center><form action="search_process.php" method="POST">
					Please Select at least one Hotel Room to continue.
				<?php if (!empty($start_date)){ 
						echo '<input type="hidden" name="date_a" value="'. $start_date. '">';
					}
					if (!empty($finish_date)){ 
						echo '<input type="hidden" name="date_b" value="'. $finish_date. '">';
					}
					 if (!empty($view)){ 
						echo '<input type="hidden" name="view" value="'. $view. '">';
					 }
					if (!empty($city)){ 
						echo '<input type="hidden" name="city" value="'. $city. '">';
					}
					if (!empty($rooms)){ 
						echo '<input type="hidden" name="rooms" value="'. $rooms. '">';
					}
					if (!empty($stars)){ 
						echo '<input type="hidden" name="stars" value="'. $stars. '">';
					}
					if (!empty($chain)){ 
						echo '<input type="hidden" name="chain" value="'. $chain. '">';
					}
					if (!empty($cap)){ 
						echo '<input type="hidden" name="capacity" value="'. $cap. '">';
					}
					if (!empty($price_from)){ 
						echo '<input type="hidden" name="price_from" value="'. $price_from. '">';
					}
					if (!empty($price_to)){ 
						echo '<input type="hidden" name="price_to" value="'. $price_to. '">';
					}
					if (!empty($amenities)){
						foreach($amenities as $am){
							echo '<input type="hidden" name="amenities[]" value="'. $am. '">';
						}
					}
						
				?>
					
					<p>
					<input type="submit" id="btn" value="OK!"></input>	
					</p>
				</center></form>
			</div>
		</body>	
			
<?php			
			
			exit();
	}
	
	$conn = mysqli_connect("localhost", "root", "");
	mysqli_select_db($conn,"hotel_db");
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	} 	
	
	for($i=0; $i < count($_POST['room_id']); $i++){
			$element = $_POST["room_id"][$i];
			$query = " select * from hotel_room where Room_ID ='$element'";
			$result = mysqli_query($conn, $query)or die("Failure!");
			$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
			$hotel_id[$i] = $row['Hotel_ID'];
			$element = $hotel_id[$i];
			$query = " select * from hotel where hotel_ID ='$element'";
			$result = mysqli_query($conn, $query)or die("Failure!");
			$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
			$hotel_name[$i] = $row['hotel_name'];
			$hotel_group_id[$i] = $row['Hotelgroup_ID'];
			$element = $hotel_group_id[$i];
			$query = " select * from hotel_group where Hotel_group_ID ='$element'";
			$result = mysqli_query($conn, $query)or die("Failure!");
			$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
			$hotel_group_name[$i] = $row['hotelgroup_name'];
			
    }
	
	
	//for($i=0; $i < count($hotel_name); $i++){
     // echo($hotel_name[$i] . " ");
   // }

	
	//for($i=0; $i < count($hotel_group_name); $i++){
   //   echo($hotel_group_name[$i] . " ");
  //  }
?>	
<html>
<head>
	<title>E-hotels</title>
	<link rel="stylesheet" type="text/css" href="style_search3.css">
</head>
<body>
	<div id="srch">
			<center><form action="reservation_form.php" method="POST">
			
				Have you registered?
			
				<p>
					<input type="Submit" id="btn" value="Yes" name = "yes_button"
					onclick="a href='reservation_form.php'">
				</p>
				
				<?php foreach($room_id as $r_id){
					echo '<input type="hidden" name="room_id[]" value="'. $r_id. '">';
				}
				foreach($hotel_id as $h_id){
					echo '<input type="hidden" name="hotel_id[]" value="'. $h_id. '">';
				}
				 foreach($hotel_name as $h_n){
					echo '<input type="hidden" name="hotel_name[]" value="'. $h_n. '">';
				}
				foreach($hotel_group_name as $hg_n){
					echo '<input type="hidden" name="hotel_group_name[]" value="'. $hg_n. '">';
				}?>
				<input type="hidden" name="start_date" value=<?=$start_date;?>>
				<input type="hidden" name="finish_date" value=<?=$finish_date;?>>
			
			</center></form>
			
			<center><form action="registration_form.php" method="POST">
				
				<p>
					<input type="Submit" id="btn" value="No" name = "no_button"
					onclick="a href='registration_form.php'">
				</p>
				<?php foreach($room_id as $r_id){
					echo '<input type="hidden" name="room_id[]" value="'. $r_id. '">';
				}
				foreach($hotel_id as $h_id){
					echo '<input type="hidden" name="hotel_id[]" value="'. $h_id. '">';
				}
				foreach($hotel_name as $h_n){
					echo '<input type="hidden" name="hotel_name[]" value="'. $h_n. '">';
				}
				foreach($hotel_group_name as $hg_n){
					echo '<input type="hidden" name="hotel_group_name[]" value="'. $hg_n. '">';
				}?>
				<input type="hidden" name="start_date" value=<?=$start_date;?>>
				<input type="hidden" name="finish_date" value=<?=$finish_date;?>>
				
			
			</center></form>
	</div>
	
</body>
<?php

?>