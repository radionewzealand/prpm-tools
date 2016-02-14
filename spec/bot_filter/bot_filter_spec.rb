require 'spec_helper'

include PrpmTools

describe BotFilter do

  subject { BotFilter.new.check_agent(user_agent) }

  context "a bot" do
    let(:user_agent){ 'Googlebot' }
    it "should return false" do
      is_expected.to eq(true)
    end
  end

  context "a browser" do
    let(:user_agent){ 'Mozilla/5.0 Gecko/20100115 Firefox/3.6' }
    it "should return false" do
      is_expected.to eq(false)
    end
  end

end
