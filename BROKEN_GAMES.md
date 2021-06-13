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
