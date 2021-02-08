# frozen_string_literal: true

RSpec.describe AhlScraper::Helpers::Birthdate do
  describe ".draft_year" do
    context "when born before September 15th of year" do
      it "returns 18 year old year as draft year" do
        expect(described_class.new("May 8th 1988").draft_year).to eq(2006)
      end
    end

    context "when born after September 15th of year" do
      it "returns 19 year old year as draft year" do
        expect(described_class.new("October 8th 1988").draft_year).to eq(2007)
      end
    end
  end

  describe ".current_age" do
    context "when birthday has not happend this year" do
      it "returns current age based on birthdate" do
        allow(Time).to receive(:now).and_return(Time.new(2021, 2, 7, 12))
        expect(described_class.new("October 8th 1988").current_age).to eq(32)
      end
    end

    context "when birthday has happend this year" do
      it "returns current age based on birthdate" do
        allow(Time).to receive(:now).and_return(Time.new(2021, 2, 7, 12))
        expect(described_class.new("February 1st 1988").current_age).to eq(33)
      end
    end
  end
end
