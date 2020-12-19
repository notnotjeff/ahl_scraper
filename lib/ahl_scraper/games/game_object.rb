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

module AhlScraper
  module Games
    class GameObject
      include Fetch::GameData
      include Fetch::GameEventData
      include Format::ScoringStatlines

      attr_reader :game_id, :raw_data, :raw_event_data

      def initialize(game_id)
        @game_id = game_id
        @raw_data = Fetch::GameData.fetch(game_id)
        @raw_event_data = Fetch::GameEventData.fetch(game_id)
      end

      def season_id
        @season_id ||= raw_data[:details][:seasonId].to_i
      end

      def details
        @details ||= raw_data[:details].merge!(
          name: "#{away_team.abbreviation} @ #{home_team.abbreviation}",
          date: raw_data[:details][:date].to_date
        )
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
        @home_coaches ||= raw_data[:homeTeam][:coaches].map { |coach| Coach.new(coach, { team_id: home_team.id }) }
      end

      def away_coaches
        @away_coaches ||= raw_data[:visitingTeam][:coaches].map { |coach| Coach.new(coach, { team_id: away_team.id }) }
      end

      def home_skaters
        @home_skaters ||= Format::ScoringStatlines.format(raw_data[:homeTeam][:skaters], raw_goals)

        # .map do |skater|
        #   Skater.new(skater, { team_id: home_team.id, team_abbreviation: home_team.abbreviation, on_home_team: true })
        # end
      end

      def away_skaters
        @away_skaters ||= raw_data[:visitingTeam][:skaters].map do |skater|
          Skater.new(skater, { team_id: away_team.id, team_abbreviation: away_team.abbreviation, on_home_team: false })
        end
      end

      def home_goalies
        @home_goalies ||= raw_data[:homeTeam][:goalies].map do |goalie|
          OpenStruct.new({ **underscore_case(goalie), team_id: home_team.id, on_home_team: true })
        end
      end

      def away_goalies
        @away_goalies ||= raw_data[:visitingTeam][:goalies].map do |goalie|
          OpenStruct.new({ **underscore_case(goalie), team_id: away_team.id, on_home_team: false })
        end
      end

      def home_team
        @home_team ||= OpenStruct.new(
          {
            **raw_data[:homeTeam][:info],
            score: raw_data[:homeTeam][:stats][:goals],
            **underscore_case(raw_data[:homeTeam][:stats]),
            is_home_team: true,
          }
        )
      end

      def away_team
        @away_team ||= OpenStruct.new(
          {
            **raw_data[:visitingTeam][:info],
            **underscore_case(raw_data[:visitingTeam][:stats]),
            score: raw_data[:visitingTeam][:stats][:goals],
            is_home_team: false,
          }
        )
      end

      def goals
        @goals ||= raw_data[:periods].map { |period| period[:goals] }
                                     .flatten
                                     .map.with_index do |goal, i|
          {
            number: i + 1,
            team: OpenStruct.new(underscore_case(goal[:team])),
            time: goal[:time],
            period: goal[:period][:id].to_i,
            game_time_elapsed: convert_time(goal[:time]) + ((goal[:period][:id].to_i - 1) * 1200),
            scored_by: OpenStruct.new(underscore_case(goal[:scoredBy])),
            assists: goal[:assists].map { |a| OpenStruct.new(underscore_case(a)) },
            properties: OpenStruct.new(underscore_case(goal[:properties])),
            plus_players: goal[:plus_players].map.with_index { |p, ind| OpenStruct.new(underscore_case(p.merge!(number: ind + 1))) },
            minus_players: goal[:minus_players].map.with_index { |p, ind| OpenStruct.new(underscore_case(p.merge!(number: ind + 1))) },
          }
        end
      end

      def penalties
        @penalties ||= raw_data[:periods].map { |period| period[:penalties] }.flatten.map.with_index { |p, i| Penalty.new(p, { number: i + 1 }) }
      end

      def penalty_shots?
        penalty_shots.size.positive?
      end

      def penalty_shots
        @penalty_shots ||= Array.new(
          (raw_data[:penaltyShots][:homeTeam] + raw_data[:penaltyShots][:visitingTeam]).map.with_index { |ps, i| { **ps, number: i + 1 } }
        )
      end

      def shootout?
        raw_data[:hasShootout]
      end

      def shootout_attempts
        @shootout_attempts ||= home_shootout_attempts + away_shootout_attempts
      end

      def home_shootout_attempts
        @home_shootout_attempts ||= raw_data.dig(:shootoutDetails, :homeTeamShots)&.map&.with_index { |a, i| a.merge(number: i + 1) } || []
      end

      def away_shootout_attempts
        @away_shootout_attempts ||= raw_data.dig(:shootoutDetails, :visitingTeamShots)&.map&.with_index { |a, i| a.merge(number: i + 1) } || []
      end

      def referees
        @referees ||= (raw_data[:referees] + raw_data[:linesmen]).map { |r| OpenStruct.new(underscore_case(r)) } || []
      end

      def three_stars
        @three_stars ||= raw_data[:mostValuablePlayers].map.with_index { |t, i| OpenStruct.new(underscore_case(t).merge!(number: i + 1)) } || []
      end

      def winning_team
        @winning_team ||= home_team.score > away_team.score ? home_team : away_team
      end

      def overtime?
        overtimes.length.positive?
      end

      def periods
        @periods ||= raw_data[:periods][0..2]
      end

      def overtimes
        @overtimes ||= raw_data[:periods][3..-1].map.with_index { |o, i| { **o, number: i + 1 } }
      end

      def played?
        true # TODO: FIX THIS TO TAKE FORFEITS INTO ACCOUNT
      end

      private

      def sanitize_skater(skater)
        skater[:stats] = underscore_case(skater[:stats])
                         .merge!(shots_as: skater[:stats][:shots])
                         .merge!(scoring_statlines[skater[:info][:id]] || blank_scoresheet)
                         .except!(:shots, :goals, :assists, :points)
        skater[:info] = underscore_case(skater[:info])

        { **skater[:info], **skater[:stats], captaincy: skater[:status], starting: skater[:starting] == 1 }
      end

      def underscore_case(object)
        object.each_key do |key|
          underscore_key = key.to_s
                              .gsub(/::/, "/")
                              .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
                              .gsub(/([a-z\d])([A-Z])/, '\1_\2')
                              .tr("-", "_")
                              .downcase
                              .to_sym

          object[underscore_key] = object.delete(key)
        end

        object
      end

      def convert_time(game_time)
        time = game_time.split(":")
        time[0].to_i * 60 + time[1].to_i
      end
    end
  end
end
