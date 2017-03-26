<?php
	include("database.php");	
	include 'distributeWinningPoints.php';
	
	// This function fill add 1 day to current day
	function addDay() {
		global $connection;
		$query = "UPDATE `current_date` SET `current_d` = DATE_ADD(`current_d`, INTERVAL 1 DAY)";
		if(mysqli_query($connection,$query)) {
			print "worked";
		} else {
			print "didn't work";
		}
	}
	
	function randomlyPlayThisDayGame() {
		global $connection;
		$currentDay = getCurrentDay();
		$teamOneScored = rand(0,10);
		$teamTwoScored = rand(0,10);
// 		echo($currentDay);
// 		echo($teamTwoScored);
		$query1 = "UPDATE games SET team_one_scored = $teamOneScored WHERE game_date = '$currentDay'";
		$query2 = "UPDATE games SET team_two_scored = $teamTwoScored WHERE game_date = '$currentDay'";
		
		if(mysqli_query($connection,$query1)) {
// 			echo("worked");
		}
		if(mysqli_query($connection,$query2)) { 
// 			echo("worked");	
		}
		
	}
	


	function placeBetsRandomlyFromOtherUsers() {
		global $connection;
		$allUsers;
		$currentGameId = getCurrentGameId();
		$queryOtherUsers = "SELECT user_id FROM users ORDER BY user_id";
		$result = mysqli_query($connection,$queryOtherUsers);
		
		// All users except first one (me)
		$row = mysqli_fetch_array($result);
		while ($row = mysqli_fetch_array($result)) {
			$allUsers[] = $row[0];
		}
		foreach ($allUsers as $user) {
			$userWillDoThisManyBets = rand(0,3);
			for ($i = 0; $i <= $userWillDoThisManyBets; $i++) {
				placeRandomBetOnAnyFutureGame($user);
			}
		}
	}

	
	function placeRandomBetOnAnyFutureGame($userId) {
		global $connection;
		$currentGameId = getCurrentGameId();
		$lastGameId = getLastGameId();
		$gameBetOn = rand($currentGameId, $lastGameId);
		
		$teamOneOrTwo = rand(1,2);
		$amountPointsBet = rand(1,10);
		
		$selectQuery = "SELECT team_one_id, team_two_id, team_1_odds, team_2_odds FROM games WHERE game_id = $gameBetOn";
		$result = mysqli_query($connection,$selectQuery);
		$row = mysqli_fetch_array($result);
		$teamOneId = $row[0];
		$teamTwoId = $row[1];
		$teamOneOdds = $row[2];
		$teamTwoOdds = $row[3];
		
		if($teamOneOrTwo == 1) {
			placeBet($userId, $gameBetOn, $amountPointsBet, $teamOneOdds, $teamOneId);
		} else {
			placeBet($userId, $gameBetOn, $amountPointsBet, $teamTwoOdds, $teamTwoId);
		}
/*
		$insertQuery;
		
			$insertQuery = "INSERT INTO bets (user_id, game_id, amount_points, odds, team_id)
							VALUES ($userId,$gameBetOn,$amountPointsBet,$teamOneOdds,$teamOneId)";
		} else {
			$insertQuery = "INSERT INTO bets (user_id, game_id, amount_points, odds, team_id)
							VALUES ($userId,$gameBetOn,$amountPointsBet,$teamTwoOdds,$teamTwoId)";
		}
		
		if(mysqli_query($connection,$insertQuery)) {
			echo("worked");
		}
*/
	}
	
	function getCurrentDay() {
		global $connection;
		$query = "SELECT * FROM  `current_date`";
		$result = mysqli_query($connection,$query);
		$row = mysqli_fetch_array($result);
// 		print_r($row);
		return $row[0];
		
	}
	
	function getLastGameId() {
		global $connection;
		$currentDay = getCurrentDay();
		$query = "SELECT game_id FROM games ORDER BY game_id DESC LIMIT 1";
		$result = mysqli_query($connection,$query);
		$row = mysqli_fetch_array($result);
		return $row[0];
	}
	
	function getCurrentGameId() {
		global $connection;
		$currentDay = getCurrentDay();
		$query = "SELECT game_id FROM games WHERE game_date = '$currentDay'";
		$result = mysqli_query($connection,$query);
		$row = mysqli_fetch_array($result);
		return $row[0];
	}
	
	// This is helper function for "randomlyAddGame" that will fetch date from games table
	function getDayForNewGame() {
		global $connection;
		$query = "SELECT DATE_ADD(game_date, INTERVAL 1 DAY) FROM  `games` ORDER BY game_date DESC LIMIT 1";
		$result = mysqli_query($connection,$query);
		$row = mysqli_fetch_array($result);
		return $row[0];
	}
	
	// This will add new random game to db
	function randomlyAddGame(){
		$myRandomNumber = rand(1,2);
		global $connection;
		$nextGameDate = getDayForNewGame();
		$randTeam1id = rand(1,7);
		$randTeam2id = rand(1,7);
		while ($randTeam1id == $randTeam2id) {
			$randTeam2id = rand(1,7);
		}
		$randTeam1odds = rand(1,9);
		$randTeam2odds = rand(1,9);
		
		$query = "INSERT INTO games (game_date, team_one_id, team_two_id, team_1_odds, team_2_odds)
				  VALUES ('$nextGameDate', $randTeam1id, $randTeam2id, $randTeam1odds, $randTeam2odds)";
		if(mysqli_query($connection,$query)){
			echo("worked");
		} else {
			echo("didn't work");
		}
	
	}
	
	// This will return team_id and 0 if there no winner or tie
	function getWinnerForTheGame($gameId) {
		global $connection;
		$query = "SELECT team_one_scored, team_two_scored, team_one_id, team_two_id FROM games WHERE game_id = $gameId";
		$result = mysqli_query($connection,$query);
		$row = mysqli_fetch_array($result);
		$teamOneScore = $row[0];
		$teamTwoScore = $row[1];
		if($teamOneScore > $teamTwoScore) {
			return $row[2];
		} elseif ($teamTwoScore > $teamOneScore) {
			return  $row[3];
		} else {
			return 0;
		}
	}
	
	// This will place fake bet for specified user.
	// Helper function for placeRandomBetOnAnyFutureGame
	function placeBet($userId, $gameId, $ammountPoints, $odds, $teamId) {
		global $connection;
		
		$takeFromUser = "UPDATE users
						SET number_points = number_points - $ammountPoints
						WHERE user_id=" . $userId . ";";
	
		$insertToBet = "INSERT INTO bets (user_id, game_id, amount_points, odds, team_id)
						VALUES ($userId,$gameId,$ammountPoints,$odds,$teamId)";
		
		if(mysqli_query($connection,$insertToBet)){
// 			print("new bet inserted");	
		} else {
// 			print("new bet not inserter");
		}
		
		if(mysqli_query($connection,$takeFromUser)){
// 			print("user points updated");	
		} else {
// 			print("user points NOT updated");
		}
	}
	
	// This function will distribute points to all winning users,
	// Roll the day to the next day and so on.
	// This function will run 50% of the time
	function closeDay(){
		if(rand(1,2) == 1) {
			placeBetsRandomlyFromOtherUsers();
			randomlyAddGame();
			if(rand(1,6) == 2) {
				randomlyAddGame();
			}
			
			randomlyPlayThisDayGame();
			distributeWinningPoints(getCurrentGameId(), getWinnerForTheGame(getCurrentGameId()));
			addDay();
		}
		
	}
	
// 	closeDay();		
?>