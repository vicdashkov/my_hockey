<?php
	include("database.php");
		
	$gameId = $_POST['data'];
	
	$query = "SELECT COUNT(user_id) FROM bets WHERE game_id=$gameId GROUP BY team_id";	

	$result = mysqli_query($connection,$query);
	$row = mysqli_fetch_array($result);
	$betOn1 = $row[0];
	$row = mysqli_fetch_array($result);
	$betOn2 = $row[0];
	echo $betOn1;
	echo("|");
	echo($betOn2);
	
// 	echo($postVar);
?>

