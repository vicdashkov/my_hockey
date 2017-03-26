<?php
	include("database.php");
	include("demo.php");
	// Example string
	// "team1:team2:gameId:team1odds:team2odds|..."
	
	$currentDate = getCurrentDay();
	
	$selectTeamsQuery = "SELECT t1.team_name, t2.team_name, game_id, team_1_odds, team_2_odds, stadium_id,
									games.game_date, games.team_one_scored, games.team_two_scored
						FROM games
						JOIN teams as t1
						ON games.team_one_id = t1.team_id
						JOIN teams as t2
						ON  games.team_two_id = t2.team_id
						WHERE game_date >= '$currentDate'
						ORDER BY game_date
						LIMIT 30";
						
	$result = mysqli_query($connection,$selectTeamsQuery);
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
		echo(":");
		echo($row[8]);
		
		if($index != mysqli_num_rows($result)){
			echo"|";	
		}
		$index++;
	}
// 	echo "Calgary:Edmonton|Montreal:Toronto|Edmonton:Vancouver";
?>