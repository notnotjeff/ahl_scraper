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

require "ahl_scraper/games/events/shot"

require "ahl_scraper/games/format/penalty_shots"
require "ahl_scraper/games/format/scoring_statlines"

module AhlScraper
  module Games
    class GameObject # rubocop:disable Metrics/ClassLength
      include Enumerable

      ATTRIBUTES = %i[
        game_id
        season_type
        status
        info
        season_id
        regular_season
        referees
        home_coaches
        away_coaches
        home_team
        away_team
        winning_team
        three_stars
        home_skaters
        away_skaters
        home_goalies
        away_goalies
        goals
        penalties
        penalty_shots
        periods
        overtimes
        overtime
        home_shootout_attempts
        away_shootout_attempts
        shootout
      ].freeze

      attr_reader(*ATTRIBUTES)

      def initialize(game_id, opts = {})
        @game_id = game_id
        @raw_data = Fetch::GameData.new(game_id).call
        @raw_event_data = Fetch::GameEventData.new(game_id).call
        @season_type = opts[:season_type] || Fetch::SeasonType.new(@raw_data[:details][:seasonId]).call
      end

      def values
        @values ||= ATTRIBUTES.map do |m|
          [m, send(m)]
        end.to_h.transform_keys(&:to_sym)
      end

      def inspect
        "#<#{self.class.to_s.split('::').last}:0x#{object_id.to_s(16)} #{values}>"
      end

      def [](key)
        values[key.to_sym]
      end

      def keys
        values.keys
      end

      def to_json(*_opts)
        JSON.generate(values)
      end

      def each(&blk)
        values.each(&blk)
      end

      def status
        @status ||=
          case @raw_data[:details][:status]
          when /Final/
            "finished"
          when ""
            "in-progress"
          else
            "not-started"
          end
      end

      def info
        @info ||= Info.new(@raw_data[:details], { name: "#{away_team.abbreviation} @ #{home_team.abbreviation}" })
      end

      def season_id
        @season_id ||= @raw_data[:details][:seasonId].to_i
      end

      def referees
        @referees ||= Array.new((@raw_data[:referees] + @raw_data[:linesmen])).map { |r| Referee.new(r) }
      end

      def three_stars
        @three_stars ||= Array.new(@raw_data[:mostValuablePlayers]).map.with_index { |t, i| Star.new(t, { number: i + 1 }) }
      end

      def home_coaches
        @home_coaches ||= Array.new(@raw_data[:homeTeam][:coaches]).map { |coach| Coach.new(coach, { team_id: home_team.id }) }
      end

      def away_coaches
        @away_coaches ||= Array.new(@raw_data[:visitingTeam][:coaches]).map { |coach| Coach.new(coach, { team_id: away_team.id }) }
      end

      def home_team
        @home_team ||= Team.new(@raw_data[:homeTeam], { home_team: true })
      end

      def away_team
        @away_team ||= Team.new(@raw_data[:visitingTeam], { home_team: false })
      end

      def winning_team
        @winning_team ||= @raw_data[:homeTeam][:stats][:goals] > @raw_data[:visitingTeam][:stats][:goals] ? home_team : away_team
      end

      def home_skaters
        @home_skaters ||= Format::ScoringStatlines.new(
          @raw_data[:homeTeam][:skaters],
          raw_goals.filter { |g| g[:team][:id] == home_team.id },
          { home_team: true, team_id: home_team.id, team_abbreviation: home_team.abbreviation }
        ).call
      end

      def away_skaters
        @away_skaters ||= Format::ScoringStatlines.new(
          @raw_data[:visitingTeam][:skaters],
          raw_goals.filter { |g| g[:team][:id] == away_team.id },
          { home_team: false, team_id: away_team.id, team_abbreviation: away_team.abbreviation }
        ).call
      end

      def home_goalies
        @home_goalies ||= Array.new(@raw_data[:homeTeam][:goalies]).map { |g| Goalie.new(g, { team_id: away_team.id, home_team: true }) }
      end

      def away_goalies
        @away_goalies ||= Array.new(@raw_data[:visitingTeam][:goalies]).map { |g| Goalie.new(g, { team_id: away_team.id, home_team: false }) }
      end

      def goals
        @goals ||= raw_goals.map.with_index { |g, i| Goal.new(g, { number: i + 1 }) }
      end

      def penalties
        @penalties ||= raw_penalties.map.with_index { |pn, i| Penalty.new(pn, { number: i + 1 }) }
      end

      def penalty_shots
        @penalty_shots ||= Format::PenaltyShots.new(@raw_data[:penaltyShots][:homeTeam] + @raw_data[:penaltyShots][:visitingTeam]).call
      end

      def periods
        @periods ||= Array.new(@raw_data[:periods][0..2]).map { |per| Period.new(per) }
      end

      def overtimes
        @overtimes ||= Array.new(@raw_data[:periods][3..-1]).map { |o| Overtime.new(o, { regular_season: season_type == :regular }) }
      end

      def overtime
        overtimes.length.positive?
      end

      def home_shootout_attempts
        @home_shootout_attempts ||= @raw_data.dig(:shootoutDetails, :homeTeamShots)&.map&.with_index do |att, i|
          ShootoutAttempt.new(att, { number: i + 1 })
        end || []
      end

      def away_shootout_attempts
        @away_shootout_attempts ||= @raw_data.dig(:shootoutDetails, :visitingTeamShots)&.map&.with_index do |att, i|
          ShootoutAttempt.new(att, { number: i + 1 })
        end || []
      end

      def shootout
        @shootout ||= @raw_data[:hasShootout] == true
      end

      private

      def raw_goals
        @raw_goals ||= Array.new(@raw_data[:periods]).map { |period| period[:goals] }.flatten
      end

      def raw_penalties
        @raw_penalties ||= Array.new(@raw_data[:periods]).map { |pd| pd[:penalties] }.flatten
      end
    end
  end
end
