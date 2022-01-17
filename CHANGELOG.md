# CHANGELOG

## 0.3.2

## General

- Changed `.split` to `&.split` and use `.dig` more to not fail when fields don't exist (often on games that have not finished)

### Game::Goalie

- Fix penalty minutes not being copied to the object because of a typo

## 0.3.1

### Scoreboards

- Add new module for getting the scores seen at the top of the AHL website
  - Retrieve Scoreboards based on a passed in date range

### Game

- Add postponed status to possible game statuses

## 0.3.0

### General

- Upgrade project Ruby version to `2.7.3`
- Update gem minimum version to `2.7.0`
- Use JSON override for game `1003351` where goalie boxscore stats don't match goal records (see wiki)
- Use term `handedness` for players
- Added penalty ids to JSON override games

### GameInfo

- If game has not started set status to reflect that and include start time

### Game

- Current time will check for whether a game has started so that games that haven't been played yet will return nil

### GameListItem

- Use `dig` to be less error prone
- Set status to `Not Started` if game status still shows start time

### Games::Penalty

- Add `id` field
- Add `bench?` attribute for when bench minor penalty
- Add `:penalty_shot` penalty type

### PlayoffBracket

- Hardcode wins needed for series to allow for accurate series statuses
- Revamp `active?` logic to work even for finals (which remained set to active by AHL)
- Stick with `home` and `away` teams instead of `team1` and `team2` for:
  - `feeder_series1` to `home_feeder_series`
  - `feeder_series2` to `away_feeder_series`
  - `team1` to `home_team_id`
  - `team2` to `away_team_id`
- Change `winning_team` to `winning_team_id`
- Add `wins_needed` attribute

### Game::Skater

- Use `p1_` for primary point short form instead of full words for `scoring_statline`

### Season

- Add `preseason` season type with appropriate abbreviations

## 0.2.0

### RosterPlayers

- Changed `shoots` to `handedness` and fixed value so that goalies get a proper handedness

### Players

- Merged `shoots` and `catches` into `handedness` attribute

### Penalties

- Uses AHL id under the `id` attribute
- Add `penalty_shot` type
- Add `bench?` for bench related penalties
- Add `invalid?` for tagging broken penalties that can be skipped
