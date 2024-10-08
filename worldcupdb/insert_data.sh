#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

tail -n +2 games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
if [[ $YEAR == 'year' ]]
then
continue
else
#QUERY FOR TEAMS
W_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
O_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")

if [[ $W_ID < 0 ]]
then
echo "$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")"
fi
if [[ $O_ID < 0 ]]
then
echo "$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")"
fi
#QUERY FOR TEAMS ID
WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")
#QUERY FOR GAMES
echo "$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES($YEAR,'$ROUND',$WINNER_ID,$OPPONENT_ID,$WINNER_GOALS,$OPPONENT_GOALS)")"
fi
done