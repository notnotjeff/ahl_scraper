# frozen_string_literal: true

require "ahl_scraper/games/game_resources/coach"
require "ahl_scraper/games/game_resources/goal"
require "ahl_scraper/games/game_resources/goalie"
require "ahl_scraper/games/game_resources/info"
require "ahl_scraper/games/game_resources/on_ice_skater"
require "ahl_scraper/games/game_resources/overtime"
require "ahl_scraper/games/game_resources/penalty_shot"
require "ahl_scraper/games/game_resources/penalty"
require "ahl_scraper/games/game_resources/period"
require "ahl_scraper/games/game_resources/referee"
require "ahl_scraper/games/game_resources/shootout_attempt"
require "ahl_scraper/games/game_resources/skater"
require "ahl_scraper/games/game_resources/star"
require "ahl_scraper/games/game_resources/team"

require "ahl_scraper/games/format/penalty_shots"
require "ahl_scraper/games/format/scoring_statlines"

module AhlScraper
  module Games
    class GameObject
      include Fetch::GameData
      include Fetch::GameEventData

      attr_reader :game_id, :raw_data, :raw_event_data

      def initialize(game_id)
        @game_id = game_id
        @raw_data = Fetch::GameData.fetch(game_id)
        @raw_event_data = Fetch::GameEventData.fetch(game_id)
      end

      def season_id
        @season_id ||= raw_data[:details][:seasonId].to_i
      end

      def regular_season?
        @regular_season ||= true # Need to figure this out somehow
      end

      def info
        @info ||= Info.new(raw_data[:details], { name: "#{away_team.abbreviation} @ #{home_team.abbreviation}" })
      end

      def status
        @status ||=
          case details[:status]
          when /Final/
            "finished"
          when ""
            "in-progress"
          else
            "not-started"
          end
      end

      def home_coaches
        @home_coaches ||= Array.new(raw_data[:homeTeam][:coaches]).map { |coach| Coach.new(coach, { team_id: home_team.id }) }
      end

      def away_coaches
        @away_coaches ||= Array.new(raw_data[:visitingTeam][:coaches]).map { |coach| Coach.new(coach, { team_id: away_team.id }) }
      end

      def home_skaters
        @home_skaters ||= Format::ScoringStatlines.new(
          raw_data[:homeTeam][:skaters],
          Array.new(raw_data[:periods]).map { |period| period[:goals] }.flatten,
          { home_team: true }
        ).call
      end

      def away_skaters
        @away_skaters ||= Format::ScoringStatlines.new(
          raw_data[:homeTeam][:skaters],
          Array.new(raw_data[:periods]).map { |period| period[:goals] }.flatten,
          { home_team: false }
        ).call
      end

      def home_goalies
        @home_goalies ||= Array.new(raw_data[:homeTeam][:goalies]).map { |goalie| Goalie.new(goalie, { team_id: away_team.id, home_team: true }) }
      end

      def away_goalies
        @away_goalies ||= Array.new(raw_data[:visitingTeam][:goalies]).map { |goalie| Goalie.new(goalie, { team_id: away_team.id, home_team: false }) }
      end

      def home_team
        @home_team ||= Team.new(raw_data[:homeTeam], { home_team: true })
      end

      def away_team
        @away_team ||= Team.new(raw_data[:visitingTeam], { home_team: false })
      end

      def goals
        @goals ||= Array.new(raw_data[:periods]).map { |period| period[:goals] }.flatten.map.with_index { |g, i| Goal.new(g, { number: i + 1 }) }
      end

      def penalties
        @penalties ||= Array.new(raw_data[:periods]).map { |pd| pd[:penalties] }.flatten.map.with_index { |pn, i| Penalty.new(pn, { number: i + 1 }) }
      end

      def penalty_shots?
        penalty_shots.size.positive?
      end

      def penalty_shots
        @penalty_shots ||= Format::PenaltyShots.new(raw_data[:penaltyShots][:homeTeam] + raw_data[:penaltyShots][:visitingTeam]).call
      end

      def shootout?
        @shootout ||= raw_data[:hasShootout]
      end

      def shootout_attempts
        # TODO: TURN THIS INTO A SERVICE SO THAT ALL ATTEMPTS CAN BE ORDERED PROPERLY
        @shootout_attempts ||= Array.new(home_shootout_attempts + away_shootout_attempts)
      end

      def home_shootout_attempts
        @home_shootout_attempts ||= Array.new(raw_data.dig(:shootoutDetails, :homeTeamShots)).map.with_index { |a, i| a.merge(number: i + 1) }
      end

      def away_shootout_attempts
        @away_shootout_attempts ||= Array.new(raw_data.dig(:shootoutDetails, :visitingTeamShots)).map.with_index { |a, i| a.merge(number: i + 1) }
      end

      def referees
        @referees ||= Array.new((raw_data[:referees] + raw_data[:linesmen])).map { |r| Referee.new(r) }
      end

      def three_stars
        @three_stars ||= Array.new(raw_data[:mostValuablePlayers]).map.with_index { |t, i| Star.new(t, { number: i + 1 }) }
      end

      def winning_team
        @winning_team ||= home_team.score > away_team.score ? home_team : away_team
      end

      def overtime?
        overtimes.length.positive?
      end

      def periods
        @periods ||= Array.new(raw_data[:periods][0..2]).map { |per| Period.new(per) }
      end

      def overtimes
        @overtimes ||= Array.new(raw_data[:periods][3..-1]).map { |o| Overtime.new(o, { regular_season: regular_season? }) }
      end
    end
  end
end
