# frozen_string_literal: true

module AhlScraper
  class Scoreboard < Resource
    def initialize(raw_data)
      super(raw_data, {})
    end

    def id
      @id ||= @raw_data[:ID].to_i
    end

    def season_id
      @season_id ||= @raw_data[:SeasonID].to_i
    end

    def game_number
      @game_number ||= @raw_data[:game_number].to_i
    end

    def game_date
      @game_date ||= @raw_data[:Date]
    end

    def htv_game_id
      @htv_game_id ||= @raw_data[:HtvGameID].to_i
    end

    def game_date_words
      @game_date_words ||= @raw_data[:GameDate]
    end

    def game_date_ISO8601
      @game_date_ISO8601 ||= @raw_data[:GameDateISO8601]
    end

    def scheduled_time
      @scheduled_time ||= @raw_data[:ScheduledTime]
    end

    def scheduled_time_formatted
      @scheduled_time_formatted ||= @raw_data[:ScheduledFormattedTime]
    end

    def timezone
      @timezone ||= @raw_data[:Timezone]
    end

    def ticket_url
      @ticket_url ||= @raw_data[:TicketUrl]
    end

    def period
      @period ||= @raw_data[:Period].to_i
    end

    def period_long_name
      @period_long_name ||= @raw_data[:PeriodNameLong]
    end

    def game_clock
      @game_clock ||= @raw_data[:GameClock]
    end

    def intermission?
      @intermission ||= @raw_data[:Intermission] == "1"
    end

    def game_status
      @game_status ||= @raw_data[:GameStatusString]
    end

    def game_status_string_long
      @game_status_string_long ||= @raw_data[:GameStatusStringLong]
    end

    def venue_name
      @venue_name ||= @raw_data[:venue_name]
    end

    def venue_location
      @venue_location ||= @raw_data[:venue_location]
    end

    def timezone_short
      @timezone_short ||= @raw_data[:TimezoneShort]
    end

    def home_score
      @home_score ||= @raw_data[:HomeGoals].to_i
    end

    def home_team
      @home_team ||= Scoreboards::Team.new(home_team_data)
    end

    def away_score
      @away_score ||= @raw_data[:VisitorGoals].to_i
    end

    def away_team
      @away_team ||= Scoreboards::Team.new(away_team_data)
    end

    private

    def away_team_data
      {
        id: @raw_data[:VisitorID],
        abbreviation: @raw_data[:VisitorCode],
        city: @raw_data[:VisitorCity],
        name: @raw_data[:VisitorNickname],
        full_name: @raw_data[:VisitorLongName],
        division: @raw_data[:VisitingDivision],
        score: @raw_data[:VisitorGoals],
        audio_url: @raw_data[:VisitorAudioUrl],
        video_url: @raw_data[:VisitorVideoUrl],
        webcasts_url: @raw_data[:VisitorWebcastUrl],
        wins: @raw_data[:VisitorWins],
        regulation_losses: @raw_data[:VisitorRegulationLosses],
        ot_losses: @raw_data[:VisitorOTLosses],
        shootout_losses: @raw_data[:VisitorShootoutLosses],
        logo: @raw_data[:VisitorLogo],
      }
    end

    def home_team_data
      {
        id: @raw_data[:HomeID],
        abbreviation: @raw_data[:HomeCode],
        city: @raw_data[:HomeCity],
        name: @raw_data[:HomeNickname],
        full_name: @raw_data[:HomeLongName],
        division: @raw_data[:HomeDivision],
        score: @raw_data[:HomeGoals],
        audio_url: @raw_data[:HomeAudioUrl],
        video_url: @raw_data[:HomeVideoUrl],
        webcasts_url: @raw_data[:HomeWebcastUrl],
        wins: @raw_data[:HomeWins],
        regulation_losses: @raw_data[:HomeRegulationLosses],
        ot_losses: @raw_data[:HomeOTLosses],
        shootout_losses: @raw_data[:HomeShootoutLosses],
        logo: @raw_data[:HomeLogo],
      }
    end
  end
end
