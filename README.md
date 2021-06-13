# AhlScraper

This gem scrapes the AHL website for team, game, playoff bracket, player, or season data and returns it to you in an easy to use format.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ahl_scraper'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ahl_scraper

## Requirements

- Ruby 2.7+

## Documentation

Check out the [Wiki page](https://github.com/notnotjeff/ahl_scraper/wiki) for additional documentation.

## Usage

This gem is divided into five modules that provide you with an assortment of methods to access data from the AHL website:

- [Seasons](#seasons)
  - `list`
  - `retrieve`
  - `retrieve_all`
- [Games](#games)
  - `list`
  - `retrieve`
- [Players](#players)
  - `retrieve`
- [Teams](#teams)
  - `list`
- [PlayoffBrackets](#playoffbrackets)
  - `retrieve`
- [RosterPlayers](#rosterplayers)
  - `retrieve_all`

### Seasons

#### list

Returns a list of all seasons as an array of `SeasonListItem` objects:

```ruby
require "ahl_scraper"
AhlScraper::Seasons.list

#=> [#<SeasonListItem:0x3c3c {:id=>72, :season_type=>:playoffs, :name=>"2021 Playoffs"}>,
 #<SeasonListItem:0x3c50 {:id=>68, :season_type=>:regular, :name=>"2020-21 Regular Season"}>,
 #<SeasonListItem:0x3c64 {:id=>67, :season_type=>:all_star, :name=>"2020 All-Star Challenge"}>,
 #<SeasonListItem:0x3c78 {:id=>65, :season_type=>:regular, :name=>"2019-20 Regular Season"}>,
 # ...
 #]
```

#### retrieve(season_id)

Returns a `Season` object which has full details on a single season by passing in the season id:

```ruby
require "ahl_scraper"
AhlScraper::Seasons.retrieve(68)

#=> #<Season:0x4b28 {:id=>68, :season_type=>:regular, :start_year=>2020, :end_year=>2021, :start_date=>"Mon, Feb 1 2020", :end_date=>"Sat, Jun 8 2021", ... >
```

#### retrieve_all

Get an array of `Season` objects with full details on each season:

```ruby
require "ahl_scraper"
AhlScraper::Seasons.retrieve_all

#=> [#<Season:0x4b28>, #<Season:0x9k34>, #<Season:0x2a23> ...]
```

### Games

#### list(season_id)

Returns a list of `GameListItem` objects for all games in a season by passing in the season id:

```ruby
require "ahl_scraper"
AhlScraper::Games.list(68)

#=> [#<GameListItem:0x4100 {:date=>"Fri, Feb 5", :id=>1022050, :status=>"Final", :game_sheet_url=>"https://lscluster.hockeytech.com/game_reports/official-game-report.php?client_code=ahl&game_id=1022050&lang_id=1", :game_center_url=>"https://theahl.com/stats/game-center/1022050", :home_team_city=>"Providence", :home_team_score=>4, :home_team_id=>309, :away_team_city=>"Bridgeport", :away_team_score=>1, :away_team_id=>317, :game_report_url=>"https://lscluster.hockeytech.com/game_reports/text-game-report.php?client_code=ahl&game_id=1022050&lang_id=1"}>,
 #<GameListItem:0x4114 {:date=>"Fri, Feb 5", :id=>1022051, :status=>"Final", :game_sheet_url=>"https://lscluster.hockeytech.com/game_reports/official-game-report.php?client_code=ahl&game_id=1022051&lang_id=1", :game_center_url=>"https://theahl.com/stats/game-center/1022051", :home_team_city=>"Rochester", :home_team_score=>2, :home_team_id=>323, :away_team_city=>"Utica", :away_team_score=>3, :away_team_id=>390, :game_report_url=>"https://lscluster.hockeytech.com/game_reports/text-game-report.php?client_code=ahl&game_id=1022051&lang_id=1"}>,
 #...
 #]
```

#### retrieve(game_id)

Get a `Game` object which has full details on a single game by passing in a game id:

```ruby
require "ahl_scraper"
AhlScraper::Games.retrieve(1022050)

#=> #<Game:0x4d6c {:game_id=>1022050, :season_type=>:regular, :info=>#<Info:0x4d80 {:date=>"Friday, February 05, 2021", :name=>"BRI @ PRO", :id=>1022050, :end_time=>"3:15 pm", ... >
```

### Players

#### retrieve(player_id)

Returns a `Player` object which has full details on a player by passing their id:

```ruby
require "ahl_scraper"
AhlScraper::Players.retrieve(6845)

#=> #<Player:0x4b8c {:id=>6845, :current_age=>0.2534e2, :position=>"D", :first_name=>"Sebastian", :shoots=>"L", :last_name=>"Aho", :birthplace=>"Umea, Sweden", :height=>"5-11", :birthdate=>"1996-02-17", :draft_year=>2014, :weight=>177, :catches=>"R", :name=>"Sebastian Aho", :jersey_number=>28}>
```

### Teams

#### list(season_id)

Returns a list of `TeamListItem` objects for every team in a season by passing the season id:

```ruby
require "ahl_scraper"
AhlScraper::Teams.list(68)

#=> [#<TeamListItem:0x4ba0 {:id=>309, :name=>"y - Providence Bruins", :season_id=>68}>,
 #<TeamListItem:0x4bb4 {:id=>307, :name=>"Hartford Wolf Pack", :season_id=>68}>,
 #<TeamListItem:0x4bc8 {:id=>317, :name=>"Bridgeport Sound Tigers", :season_id=>68}>,
 #<TeamListItem:0x4bdc {:id=>319, :name=>"y - Hershey Bears", :season_id=>68}>,
 #<TeamListItem:0x4bf0 {:id=>313, :name=>"Lehigh Valley Phantoms", :season_id=>68}>,
 #<TeamListItem:0x4c04 {:id=>324, :name=>"Syracuse Crunch", :season_id=>68}>,
 #...
 #]
```

### PlayoffBrackets

#### retrieve(season_id)

Get a `PlayoffBracket` object which has series breakdowns for an entire playoff season by passing season id:

```ruby
require "ahl_scraper"
AhlScraper::PlayoffBrackets.retrieve(64)

#=> #<PlayoffBracket:0x41c8 {:logo_url=>"https://lscluster.hockeytech.com/download.php?file_path=img/playoffs_64.jpg&client_code=ahl", :rounds=>[#<Round:0x41dc {:series=>[#<Series:0x41f0 {:id=>"A", :games=>[#<Game:0x4204 {:notes=>"", :id=>1019529, :home_team=>309, :status=>"Final", :home_score=>4, :away_score=>5, :away_team=>384, :if_necessary?=>false, :date=>"2019-04-20 19:05:00"}>, #<Game:0x4218 {:notes=>"", :id=>1019530, :home_team=>309, :status=>"Final", :home_score=>4, :away_score=>2, :away_team=>384, :if_necessary?=>false, :date=>"2019-04-21 17:05:00"}>,
```

### RosterPlayers

#### retrieve_all(team_id, season_id)

Returns an array of `RosterPlayer` objects which provide information on all of a teams roster players. Pass the team id and the season id:

```ruby
require "ahl_scraper"
AhlScraper::RosterPlayers.retrieve(335, 68)

#=> [#<RosterPlayer:0x3c3c {:id=>6379, :current_age=>0.2521e2, :season_id=>68, :position=>"C", :shoots=>"L", :birthplace=>"Saskatoon, SK", :birthdate=>"1996-04-03", :height=>"6-0", :draft_year=>2014, :weight=>203, :rookie?=>false, :team_id=>335, :name=>"Rourke Chartier", :jersey_number=>15}>,
 #<RosterPlayer:0x3c50 {:id=>1844, :current_age=>0.3416e2, :season_id=>68, :position=>"LW", :shoots=>"L", :birthplace=>"Toronto, ON", :birthdate=>"1987-04-25", :height=>"5-11", :draft_year=>2005, :weight=>207, :rookie?=>false, :team_id=>335, :name=>"Richard Clune", :jersey_number=>17}>,
 #<RosterPlayer:0x3c64 {:id=>5660, :current_age=>0.2914e2, :season_id=>68, :position=>"LW", :shoots=>"L", :birthplace=>"Morristown, NJ", :birthdate=>"1992-04-30", :height=>"6-0", :draft_year=>2010, :weight=>200, :rookie?=>false, :team_id=>335, :name=>"Kenny Agostino", :jersey_number=>18}>,
 #...
 #]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/notnotjeff/ahl_scraper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/ahl_scraper/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AhlScraper project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ahl_scraper/blob/master/CODE_OF_CONDUCT.md).
