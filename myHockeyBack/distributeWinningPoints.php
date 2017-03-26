<?php
	include("database.php");
	// Call this function when game has happend and winning team is known
	// This function will update user points
	function distributeWinningPoints($gameId, $winningTeamId) {
		global $connection;
		
		// Getting users who won
		$usersWhoWonArray;
		
		$usersWhoWonQuery = "SELECT user_id
							FROM bets
							WHERE game_id=$gameId AND team_id=$winningTeamId
							GROUP BY user_id";
		
		$result = mysqli_query($connection,$usersWhoWonQuery);
	
		while($row = mysqli_fetch_array($result)){
// 			print_r($row);
// 			echo("<BR>");
			$usersWhoWonArray[] = $row[0];
		}
		
		
// 		print_r($usersWhoWonArray); echo("<BR>");
		
		// Updating users winnings
		for($i = 0; $i < count($usersWhoWonArray); $i ++) {
			$userId = $usersWhoWonArray[$i];
			
			$selectQuery = "SELECT sum(odds * amount_points) as count
							FROM bets
							WHERE user_id= $userId
							AND game_id=$gameId AND team_id=$winningTeamId";
			$result = mysqli_query($connection,$selectQuery);
			$row = mysqli_fetch_array($result);
			$ammountToPayToPlayer = $row[0];
			
			$updateQuery = "UPDATE users
							SET number_points = number_points + $ammountToPayToPlayer
							WHERE user_id = $userId";
							
			if(mysqli_query($connection,$updateQuery)){
				print("worked");	
			} else {
				print("didn't work");
			}
		}				
		
		// save this for future use 

/*
		$ammountToPay = "(SELECT odds * amount_points 
						FROM bets
						WHERE game_id=$gameId AND team_id=$winningTeamId)";
		
		$usersWhoWon = "(SELECT user_id
						FROM bets
						WHERE game_id=$gameId AND team_id=$winningTeamId)";
		
		$updatingUserTable = "UPDATE users
							  SET users.number_points = $ammountToPay
							  WHERE users.user_id=$usersWhoWon";


							  
		if(mysqli_query($connection,$updatingUserTable)){
			print("users have been payed");	
		} else {
			print("didn't work to pay users");
		}
*/

		


/*
		$innerQuery = "(SELECT b.user_id AS buser_id, b.amount_points AS amount_points, b.odds AS odds,
						u.user_id AS uuser_id, u.number_points AS number_points
						FROM bets AS b
						INNER JOIN users AS u
						ON b.user_id = u.user_id)";
*/

/*
		$result = mysqli_query($connection,$innerQuery);
	
		while($row = mysqli_fetch_array($result)){
			print_r($row);
			echo("<BR>");
		}	
*/	

/*
				$usersWhoWon = "UPDATE users u, $innerQuery as t
								SET u.number_points = u.number_points + (t.amount_points * t.odds)
								WHERE u.user_id = t.uuser_id";
*/



/*
		$usersWhoWon =	"UPDATE users
						JOIN bets
						ON users.user_id = bets.user_id
						SET users.number_points = users.number_points + (bets.odds * bets.amount_points)";

*/
/*
		if(mysqli_query($connection,$usersWhoWon)){
			print("worked");	
		} else {
			print("didn't work");
		}
*/


	}

	
?>