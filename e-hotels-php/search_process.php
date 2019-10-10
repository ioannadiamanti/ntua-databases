<html>
<head>
<link rel="stylesheet" type="text/css" href="data.css">
</head>
<body>
	
<?php

	$date_a = $_POST['date_a'];
	$date_b = $_POST['date_b'];
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
	
	
		$date_a = date_create($date_a);	
		$date_a = date_format($date_a, 'Y-m-d');
		$date_b = date_create($date_b);	
		$date_b = date_format($date_b, 'Y-m-d');
	
	
	if ($date_b <= $date_a ){
		echo '<script type="text/javascript">'; 
		echo 'alert("Departure Day cannot happen before Arrival Day.");'; 
		echo 'window.location.href = "search.php";';
		echo '</script>';
	}
	date_default_timezone_set('Europe/Athens');
	$current_date=date("Y-m-d");

	if ($date_a < $current_date or $date_b <= $current_date ){
		echo '<script type="text/javascript">'; 
		echo 'alert("You can only search for available rooms in future dates.");'; 
		echo 'window.location.href = "search.php";';
		echo '</script>';
	}

	$con = mysqli_connect("localhost", "root", "");
	mysqli_select_db($con,"hotel_db");

	$query = 
	"select distinct n1.* , n2.*, n3.* 
	from hotel n1 
		join hotel_room n2 
			on (n1.hotel_ID=n2.Hotel_ID) 
		join hotel_group n3 
			on(n1.Hotelgroup_ID=n3.Hotel_group_ID) 
			
			left join reserves n5 
			on ( (n2.Room_id=n5.Room_ID) and 
					( ('$date_a' between n5.Start_Date and n5.Finish_Date)
					or ('$date_b' between n5.Start_Date and n5.Finish_Date) 
					or (n5.Start_Date between '$date_a' and '$date_b') 
				or (n5.Finish_Date between '$date_a' and '$date_b') ))		
		 where ";

		//join amenities n4 
			//on(n4.Room_ID=n2.Room_id) 
		 
	if(!empty($city)) {
		$query .= "n1.City='$city' and "; 
	}
	if(!empty($rooms)) {
		$query .= "n1.Number_of_rooms>='$rooms' and "; 
	}
	if(!empty($stars)) {
		$query .= "n1.Stars='$stars' and "; 
	}
	if(!empty($cap)) {
		$query .= " n2.Capacity='$cap' and "; 
	}
	if(!empty($chain)) {
		$query .= " n3.hotelgroup_name='$chain' and "; 
	}
	if(!empty($price_from)) {
		$query .= " n2.Price>='$price_from' and "; 
	}
	
	if(!empty($price_to)) {
		$query .= " n2.Price<='$price_to' and "; 
	}
	if(!empty($expand)) {
		$query .= " n2.Expandable='$expand' and "; 
	}
	if(!empty($view)) {
		$query .= " n2.View='$view' and "; 
	}
	
	$query .= "n5.Room_ID is null ";

	if(!empty($amenities)) {
		$query .= "and n2.Room_id in (select Room_ID from amenities where type in (";
		for($i = 0; $i < count($_POST["amenities"])-1; $i++) {
			$element = $_POST["amenities"][$i];
			$query .= "'$element', "; 
		}
		$i = count($_POST["amenities"])-1;
		$element = $_POST["amenities"][$i];
		$count = count($_POST["amenities"]);
		$query .= "'$element') group by Room_ID having (count(*)=$count))";
	}

	//echo $query;
	$result = mysqli_query($con, $query)or die (mysqli_error($con));
	//("Failure!");	
	$number_of_rooms = ($result -> num_rows);
	//$result = mysqli_query($con,"select * from hotel where City='$city' and Number_of_rooms='$rooms'")
		//or die("Failure!");
			
	if ($result->num_rows >=1) {
		echo "<br>";
		echo "<center><h2>Tick the hotel rooms you wish to book!</h2>"; 
		echo "<center><table>";
		echo "<tr><td>";
		echo "Hotel name";
		echo "<td>";
		echo "Hotel Group name";
		echo "<td>";
		echo "City";
		echo "<td>";
		echo "Stars";
		echo "<td>";
		echo "Capacity";
		echo "<td>";
		echo "Price per night";
		echo "<td>";
		echo "Expandable";
		echo "<td>";
		echo "View";
		echo "<td>";
		echo "Amenities";
		echo "<td>";
		
            
		
		while($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
			echo "<tr><td>";
			echo $row['hotel_name'];
			echo "<td>";
			echo $row['hotelgroup_name'];
			echo "<td>";
			echo $row['City'];
			echo "<td>";
			echo $row['Stars'];
			echo "<td>";
			echo $row['Capacity'];
			echo "<td>";
			echo $row['Price'];
			echo "<td>";
			echo $row['Expandable'];
			echo "<td>";
			echo $row['View'];
			echo "<td>";
			$hotel_name=$row['hotel_name'];
			$hotelgroup_name=$row['hotelgroup_name'];
			$room_id=$row['Room_id'];
			$hotel_id=$row['Hotel_ID'];
            $start_date =$date_a;
            $finish_date = $date_b;
			
			$query1 = " select * from amenities where Room_ID='$room_id'";
			$result1 = mysqli_query($con, $query1)or die (mysqli_error($con));
			while($row = mysqli_fetch_array($result1, MYSQLI_ASSOC)){
				echo $row['Type'];
				echo "<br>";
			}
			echo "<td>";
			
			

		
     ?>

		<body>
			
			<div >
			<link rel="stylesheet" type="text/css" href="style_search2.css">
				<center><form  action="customer_question.php" method="POST">		
					<p>
					<label class="container"><input type="checkbox" name= "room_id[]" value=<?=$room_id;?>>
					<span class="checkmark"></span>
					</label>

						
					</p>	
				<?php
		}
		echo "<tr><td><td><td><td><td><td>";
?>		
		
		<?php 		if (!empty($date_a)){ 
						echo '<input type="hidden" name="start_date" value="'. $date_a. '">';
					}
					if (!empty($date_b)){ 
						echo '<input type="hidden" name="finish_date" value="'. $date_b. '">';
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
		<input type="Submit" id="btn"  value="Book!" name = "yes_button">
		</p>
</center></form>
</div>


<?php
		echo "<td><td><td><td>";
	}
    else{
?>	
<head>
	<link rel="stylesheet" type="text/css" href="style_search.css">
</head>
		<body>
			<div id="srch">
				<center><form action="search.php" method="POST">		
						Sorry!
						There are no rooms available for the required dates.
					<p>
						<input type="Submit" id="btn" value="OK" name = "ok_button">
					</p>			
				</center></form>
			</div>

<?php		
        //echo "There are no rooms available for the required dates."."<br>" ;
    }   
?>
		
	
</body>
</html>