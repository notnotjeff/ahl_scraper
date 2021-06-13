# frozen_string_literal: true

RSpec.describe AhlScraper::Games::Events::Shot do
  let(:raw_data) do
    {}
  end

  it "converts raw data into Shot record" do
    described_class.new(raw_data)
  end
end
