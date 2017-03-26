<?php
	include("database.php");
	
	// Example of the string
	// amount_points:team_one_id:team_two_id:team_1_odds:team_2_odds:team_one_scored:team_two_scored:team_id_i_bet_on:
	//						game_date|......
	
	$userId = $_POST['data'];
	
	$query = "SELECT bets.amount_points, games.team_one_id, games.team_two_id, 
						games.team_1_odds, games.team_2_odds, games.team_one_scored, games.team_two_scored,
						bets.team_id
				FROM bets
				JOIN games
				ON bets.game_id = games.game_id
				WHERE user_id = 1
				ORDER BY bet_id DESC
				LIMIT 40";	

	$result = mysqli_query($connection,$query);
	$index = 1;
	while($row = mysqli_fetch_array($result)){
		echo($row[0]);
		echo(":");
		echo($row[1]);
		echo(":");
		echo($row[2]);
		echo(":");
		echo($row[3]);
		echo(":");
		echo($row[4]);
		echo(":");
		echo($row[5]);
		echo(":");
		echo($row[6]);
		echo(":");
		echo($row[7]);

		if($index != mysqli_num_rows($result)){
			echo"|";	
		}
		$index++;
	}
	
// 	echo($postVar);
?>

