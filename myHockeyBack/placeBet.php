<?php
	// Example string this interface will take
	// user_id:game_id:amount_points:team_id:odds
	include("database.php");
	include("demo.php");

	$postVar = $_POST['data'];
	
	$arrayFromPost = explode(":", $postVar);

	// This will check if the data in post was fine and if wasn't will terminate execution
	if(count($arrayFromPost) < 4) {
		echo("wrong data in POST");
		exit();
	}
	
	$userId = 		$arrayFromPost[0];
	$gameId = 		$arrayFromPost[1];
	$ammountPoints= $arrayFromPost[2];
	$teamId = 		$arrayFromPost[3];
	$odds = 		$arrayFromPost[4];
	
	$takeFromUser = "UPDATE users
					SET number_points = number_points - $ammountPoints
					WHERE user_id=" . $userId . ";";

	$insertToBet = "INSERT INTO bets (user_id, game_id, amount_points, odds, team_id)
					VALUES ($userId,$gameId,$ammountPoints,$odds,$teamId)";
	
	if(mysqli_query($connection,$insertToBet)){
// 		print("new bet inserted");	
	} else {
// 		print("new bet not inserter");
	}
	
	if(mysqli_query($connection,$takeFromUser)){
// 		print("user points updated");	
	} else {
// 		print("user points NOT updated");
	}
	
	
	
 	closeDay();
?>