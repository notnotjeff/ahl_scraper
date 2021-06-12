# AhlScraper

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/ahl_scraper`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ahl_scraper'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ahl_scraper

## Usage

TODO: Write usage instructions here

## Game Statuses

There are many statuses a game can be depending on its current state or if any problems arose to invalidate or change the status of the game (forfeit, COVID, etc). Games that need overriden statuses can be found in `game_object.rb` in the `IRREGULAR_GAMES` constant.

| Status               | Description                                                                |
| -------------------- | -------------------------------------------------------------------------- |
| `in_progress`        | Game is currently being played                                             |
| `finished`           | Game has finished                                                          |
| `void`               | Game does not count for both the teams and the players                     |
| `result_void`        | Game does not count for the team but the individual player results count   |
| `stats_void`         | Game counts for the team but not for the individual player results         |
| `finished_later`     | Game was partially played but finished on a different date                 |
| `continuation`       | Game is a continuation of a previous game (likely a `finished_later` game) |
| `forfeit`            | Game was forfeited and no player stats exist                               |
| `forfeit_with_stats` | Game was forfeited but player stats do exist                               |
| `postponed`          | Game was never started but moved to a different date                       |

## Broken Games

These games need alternative methods of scraping or manual fixtures to override.

| GameID                                                    | SeasonID | Description                                                                                                                                          | Notes                                                                                                                                                                      | Status        |
| --------------------------------------------------------- | -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- |
| [`1022174`](https://theahl.com/stats/game-center/1022174) | `68`     | This game was postponed due to COVID and [replayed in its entirety](https://theahl.com/stats/game-center/1022609)                                    | Investigate if any data from this game is valid, if not, this is resolved                                                                                                  | `RESULT_VOID` |
| [`1018774`](https://theahl.com/stats/game-center/1018774) | `61`     | The first period is the only one that is documented in JSON, should be an OT game but resolves to regulation which causes an error in team standings | [Game Report](https://lscluster.hockeytech.com/game_reports/official-game-report.php?lang_id=1&client_code=ahl&game_id=1018774) is accurate so it could be scraped instead | `UNRESOLVED`  |

### Broken Game Status Legend

| Status        | Description                                                                                                                                                              |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `UNRESOLVED`  | The scraper has no solution for how to properly scrape the game, will need to be properly fixed.                                                                         |
| `JSON`        | The scraper uses an internal JSON file to solve any issues with the game.                                                                                                |
| `GAME_REPORT` | Scraper uses the game report page instead of the league's JSON endpoint to fix broken game.                                                                              |
| `RESULT_VOID` | This game has valid skater/goalie stats but the result for the team was not counted.                                                                                     |
| `STATS_VOID`  | This game has invalid (or no) individual skater/goalie stats but the result for the team was counted.                                                                    |
| `VOID`        | The game was not played or finished. Usually due to the fact the game was cancelled or rescheduled on another date                                                       |
| `RESULT_VOID` | The game was not played or finished. Usually due to the fact the game was cancelled or rescheduled on another date, individual stats will be counted for skaters/goalies |

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/notnotjeff/ahl_scraper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/ahl_scraper/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AhlScraper project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ahl_scraper/blob/master/CODE_OF_CONDUCT.md).
