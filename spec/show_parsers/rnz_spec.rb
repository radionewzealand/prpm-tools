require 'spec_helper'

include PrpmTools

describe RnzShowParser do

  subject{ RnzShowParser.new.extract_show(url) }

  context "a show" do
    let(:url){ '/mnr/mnr-20151210-0828-petition_to_ban_donald_trump_from_entering_the_uk-048.mp3'}
    it "returns the show code" do
      is_expected.to eq('mnr')
    end
  end

  context "a new bulletin" do
    let(:url){ '/news/20160131-0600-048.mp3' }
    it "returns the show code" do
      is_expected.to eq('news')
    end
  end

end
