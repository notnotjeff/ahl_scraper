# frozen_string_literal: true

module AhlScraper
  class SeasonEndDateFetcher
    def initialize(season_id, season_type)
      @season_id = season_id
      @season_type = season_type
    end

    def call
      return if %i[all_star_game exhibition].include? @season_type

      return SeasonDatesHelper::DATE_EXCEPTIONS[@season_id][:end_date] if SeasonDatesHelper::DATE_EXCEPTIONS.keys.include? @season_id

      JSON.parse(Nokogiri::HTML(URI.parse(url).open).text[5..-2], symbolize_names: true)
        &.first
        &.dig(:sections)
        &.first
        &.dig(:data)
        &.last
        &.dig(:row, :date_with_day)
    end

    private

    def end_month
      SeasonDatesHelper::SEASON_MONTH_KEY[@season_type.to_sym][:end_month]
    end

    def url
      "https://lscluster.hockeytech.com/feed/index.php?feed=statviewfeed&view=schedule&team=-1&season=#{@season_id}&month=#{@end_month}&location=homeaway&key=50c2cd9b5e18e390&client_code=ahl&site_id=1&league_id=4&division_id=-1&lang=en&callback=json"
    end
  end
end
