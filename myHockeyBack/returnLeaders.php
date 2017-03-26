<?php
	// Example string
	// "nickname1:points1|nickname2:points2"
	include("database.php");
	
	$selectUsers = "SELECT * 
					FROM users
					ORDER BY number_points DESC";
	
	$result = mysqli_query($connection,$selectUsers);
	
	
	$index = 1;
	while($row = mysqli_fetch_array($result)){
		echo($row[1]);
		echo(":");
		echo($row[2]);
		if($index != mysqli_num_rows($result)){
			echo"|";	
		}
		$index++;
	}
	
// 	echo "nicolM:33|viktord:44|amandaP:55|breadlyPits:555|amandaPits:55";

?>