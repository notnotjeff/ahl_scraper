# frozen_string_literal: true

module AhlScraper
  class Game < Resource # rubocop:disable Metrics/ClassLength
    include Enumerable

    IRREGULAR_GAMES = {
      "1022174" => { status: "result_void", start_time_in_seconds: 0, end_time_in_seconds: 1200 },
    }.freeze

    ATTRIBUTES = %i[
      game_id
      season_type
      info
      current_time
      current_period
      current_period_number
      season_id
      played
      in_progress
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
      home_roster
      away_roster
      goals
      penalties
      penalty_shots
      periods
      overtimes
      overtime
      home_shootout_attempts
      away_shootout_attempts
      home_penalty_shots
      away_penalty_shots
      shootout
    ].freeze

    attr_reader(*ATTRIBUTES)

    def initialize(game_id, opts = {})
      raw_data = GameDataFetcher.new(game_id).call
      super(raw_data, opts)
      @game_id = game_id
      @raw_event_data = GameEventDataFetcher.new(game_id).call
      @season_type = opts[:season_type] || SeasonTypeFetcher.new(@raw_data[:details][:seasonId]).call
    end

    def values
      @values ||= ATTRIBUTES.index_with do |m|
        send(m)
      end.transform_keys(&:to_sym)
    end

    def status
      @status ||= set_game_status
    end

    def info
      @info ||= Games::Info.new(@raw_data[:details], { name: "#{away_team.abbreviation} @ #{home_team.abbreviation}" })
    end

    def current_time
      @current_time ||= set_current_game_time
    end

    def current_period
      @current_period ||= set_current_game_period
    end

    def current_period_number
      @current_period_number ||= @raw_data[:periods].length
    end

    def season_id
      @season_id ||= @raw_data[:details][:seasonId].to_i
    end

    def referees
      @referees ||= Array((@raw_data[:referees] + @raw_data[:linesmen])).uniq { |referee| referee.values_at(:lastName, :firstName, :jerseyNumber) }
        .map { |r| Games::Referee.new(r) }
    end

    def three_stars
      @three_stars ||= Array(@raw_data[:mostValuablePlayers]).map.with_index { |t, i| Games::Star.new(t, { number: i + 1 }) }
    end

    def home_coaches
      @home_coaches ||= Array(@raw_data[:homeTeam][:coaches]).uniq { |coach| coach.values_at(:lastName, :firstName) }
        .map { |coach| Games::Coach.new(coach, { team_id: home_team.id }) }
    end

    def away_coaches
      @away_coaches ||= Array(@raw_data[:visitingTeam][:coaches]).uniq { |coach| coach.values_at(:lastName, :firstName) }
        .map { |coach| Games::Coach.new(coach, { team_id: away_team.id }) }
    end

    def home_team
      @home_team ||= Games::Team.new(
        @raw_data[:homeTeam],
        {
          home_team: true,
          goals: raw_goals,
          current_state: current_state,
          game_properties: game_properties,
          shots: raw_period_shots,
          goal_totals: raw_period_goals,
          winning_team_id: winning_team_id,
        }
      )
    end

    def away_team
      @away_team ||= Games::Team.new(
        @raw_data[:visitingTeam],
        {
          home_team: false,
          goals: raw_goals,
          current_state: current_state,
          game_properties: game_properties,
          shots: raw_period_shots,
          goal_totals: raw_period_goals,
          winning_team_id: winning_team_id,
        }
      )
    end

    def winning_team
      @winning_team ||=
        if status == "finished"
          winning_team_id == home_team.id ? home_team : away_team
        end
    end

    def home_skaters
      @home_skaters ||= Games::CreateSkatersService.new(
        @raw_data[:homeTeam][:skaters],
        raw_goals,
        raw_penalties,
        raw_home_shootout_attempts,
        @raw_data[:penaltyShots][:homeTeam],
        { home_team: true, team_id: home_team.id, team_abbreviation: home_team.abbreviation, game_date: @raw_data[:details][:date] }
      ).call
    end

    def away_skaters
      @away_skaters ||= Games::CreateSkatersService.new(
        Array(@raw_data[:visitingTeam][:skaters]),
        raw_goals,
        raw_penalties,
        raw_away_shootout_attempts,
        @raw_data[:penaltyShots][:visitingTeam],
        { home_team: false, team_id: away_team.id, team_abbreviation: away_team.abbreviation, game_date: @raw_data[:details][:date] }
      ).call
    end

    def home_goalies
      @home_goalies ||= Array(@raw_data[:homeTeam][:goalies]).map do |g|
        Games::Goalie.new(
          g,
          {
            team_id: home_team.id,
            home_team: true,
            shootout_data: @raw_data.dig(:shootoutDetails, :visitingTeamShots),
            penalty_shot_data: @raw_data.dig(:penaltyShots, :visitingTeam),
            game_date: @raw_data[:details][:date],
          }
        )
      end
    end

    def away_goalies
      @away_goalies ||= Array(@raw_data[:visitingTeam][:goalies]).map do |g|
        Games::Goalie.new(
          g,
          {
            team_id: away_team.id,
            home_team: false,
            shootout_data: @raw_data.dig(:shootoutDetails, :homeTeamShots),
            penalty_shot_data: @raw_data.dig(:penaltyShots, :homeTeam),
            game_date: @raw_data[:details][:date],
          }
        )
      end
    end

    def home_roster
      @home_roster ||= [*home_skaters, *home_goalies]
    end

    def away_roster
      @away_roster ||= [*away_skaters, *away_goalies]
    end

    def goals
      @goals ||= raw_goals.map.with_index { |g, i| Games::Goal.new(g, { number: i + 1 }) }
    end

    def penalties
      @penalties ||= raw_penalties.map.with_index { |pn, i| Games::Penalty.new(pn, { number: i + 1 }) }
    end

    def penalty_shots
      @penalty_shots ||= (home_penalty_shots || []) + (away_penalty_shots || [])
    end

    def home_penalty_shots
      @home_penalty_shots ||= Games::PenaltyShotsService.new(@raw_data[:penaltyShots][:homeTeam]).call
    end

    def away_penalty_shots
      @away_penalty_shots ||= Games::PenaltyShotsService.new(@raw_data[:penaltyShots][:visitingTeam]).call
    end

    def periods
      @periods ||= Array(@raw_data[:periods][0..2]).map { |per| Games::Period.new(per) }
    end

    def overtimes
      @overtimes ||= Array(@raw_data[:periods][3..]).map { |o| Games::Overtime.new(o, { regular_season: season_type == :regular }) }
    end

    def overtime?
      @overtime ||= overtimes.length.positive?
    end

    def shootout_attempts
      @shootout_attempts ||= [*home_shootout_attempts, *away_shootout_attempts]
    end

    def home_shootout_attempts
      @home_shootout_attempts ||= raw_home_shootout_attempts&.map&.with_index do |att, i|
        Games::ShootoutAttempt.new(att, { number: i + 1, opposing_team: find_opposing_team(att[:shooterTeam][:id].to_i) })
      end || []
    end

    def away_shootout_attempts
      @away_shootout_attempts ||= raw_away_shootout_attempts&.map&.with_index do |att, i|
        Games::ShootoutAttempt.new(att, { number: i + 1, opposing_team: find_opposing_team(att[:shooterTeam][:id].to_i) })
      end || []
    end

    def shootout?
      @shootout ||= @raw_data[:hasShootout] == true
    end

    def played?
      @played ||= status == "finished"
    end

    def in_progress?
      @in_progress ||= status == "in_progress"
    end

    def ended_in
      @ended_in ||=
        if shootout?
          "SO"
        elsif overtime?
          "OT"
        else
          "REG"
        end
    end

    private

    def raw_goals
      @raw_goals ||= Array(@raw_data[:periods]).map { |a| a[:goals] }.flatten
    end

    def raw_penalties
      @raw_penalties ||= Array(@raw_data[:periods]).map { |a| a[:penalties] }.flatten
    end

    def raw_period_shots
      @raw_period_shots ||= Array(@raw_data[:periods]).map do |period|
        { home: period[:stats][:homeShots].to_i, away: period[:stats][:visitingShots].to_i }
      end
    end

    def raw_period_goals
      @raw_period_goals ||= Array(@raw_data[:periods]).map do |period|
        { home: period[:stats][:homeGoals].to_i, away: period[:stats][:visitingGoals].to_i }
      end
    end

    def raw_home_shootout_attempts
      @raw_home_shootout_attempts ||= @raw_data.dig(:shootoutDetails, :homeTeamShots)
    end

    def raw_away_shootout_attempts
      @raw_away_shootout_attempts ||= @raw_data.dig(:shootoutDetails, :visitingTeamShots)
    end

    def find_opposing_team(team_id)
      team_id == home_team.id ? away_team : home_team
    end

    def winning_team_id
      @winning_team_id ||= status == "finished" ? set_winning_team_id : nil
    end

    def set_winning_team_id
      if @raw_data[:homeTeam][:stats][:goals] > @raw_data[:visitingTeam][:stats][:goals]
        @raw_data[:homeTeam][:info][:id]
      elsif @raw_data[:homeTeam][:stats][:goals] < @raw_data[:visitingTeam][:stats][:goals]
        @raw_data[:visitingTeam][:info][:id]
      else
        @raw_data[:shootoutDetails][:winningTeam][:id]
      end
    end

    def current_state
      @current_state ||= {
        status: status,
        period: current_period,
        period_number: current_period_number,
        time: current_time,
        shootout: shootout?,
        overtime: overtime?,
      }
    end

    def game_properties
      @game_properties ||= {
        playoffs: @season_type == :playoffs,
        periods: periods.length,
        overtime_periods: overtimes.length,
        game_start_time_in_seconds: IRREGULAR_GAMES.dig(game_id.to_s, :start_time_in_seconds),
        game_end_time_in_seconds: IRREGULAR_GAMES.dig(game_id.to_s, :end_time_in_seconds),
      }
    end

    def set_game_status
      irregular_game_status = IRREGULAR_GAMES.dig(game_id.to_s, :status)
      return irregular_game_status if irregular_game_status

      return "postponed" if @raw_data[:details][:status] == "Postponed"
      # return "forfeited" if game is a forfeit, need to figure this out if it happens

      return "finished" if @raw_data[:details][:final] == "1"

      return "in_progress" if @raw_data[:details][:started] == "1"

      "not_started"
    end

    def set_current_game_time
      return if @raw_data[:details][:final] == "1" || @raw_data[:details][:started] == "0"

      game_time = @raw_data[:details][:status].match(/\d{1,2}:\d{2}/).to_s
      return if game_time.empty?

      game_time
    end

    def set_current_game_period
      return if /Final/.match?(@raw_data[:details][:status])

      period = @raw_data[:details][:status].match(/(1st|2nd|3rd|OT|[1-9]?[0-9]OT|SO)/).to_s
      return if period.empty?

      period
    end
  end
end
