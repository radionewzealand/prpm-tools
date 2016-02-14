require 'spec_helper'

include PrpmTools

describe LineFilter do
  subject { LineFilter.new(BotFilter.new, RnzShowParser.new).filter(data) }

  context "valid lines" do

    context "Full GET request (200)" do
      let(:data){ {:ip=>"113.171.224.210", :timestamp=>"09/Feb/2016:06:59:37 +1300", :url=>"/mnr/mnr-20151210-0828-petition_to_ban_donald_trump_from_entering_the_uk-048.mp3", :status=>200, :bytes_sent=>200005, :user_agent=>"Mozilla/5.0 Gecko/20100115 Firefox/3.6", :date=>"2016-02-09 06:59:37 +1300", :downloader_uid=>"31e3037a0b793e96b070de3206e5a928353815c1", :download_uid=>"daeddaff3d673bacd9b57b635e0037c01cd28ef6"} }
      it { is_expected.to eq(data) }
    end

    context "Partial GET request (206)" do
      let(:data){ {:ip=>"113.171.224.210", :timestamp=>"09/Feb/2016:06:59:37 +1300", :url=>"/mnr/mnr-20151210-0828-petition_to_ban_donald_trump_from_entering_the_uk-048.mp3", :status=>206, :bytes_sent=>200005, :user_agent=>"Mozilla/5.0 Gecko/20100115 Firefox/3.6"} }
      it { is_expected.to eq( {:ip=>"113.171.224.210", :timestamp=>"09/Feb/2016:06:59:37 +1300", :url=>"/mnr/mnr-20151210-0828-petition_to_ban_donald_trump_from_entering_the_uk-048.mp3", :status=>206, :bytes_sent=>200005, :user_agent=>"Mozilla/5.0 Gecko/20100115 Firefox/3.6", :date=>"2016-02-09", :downloader_uid=>"31e3037a0b793e96b070de3206e5a928353815c1", :download_uid=>"4af2f2c69df21ee8d4abf3b179eae9f3dc3d9b83", :show_code=>"mnr"} ) }
    end

  end

  context "invalid lines" do

    context "Full GET request (200), under 200,000 bytes" do
      let(:data){ {:ip=>"113.171.224.210", :timestamp=>"09/Feb/2016:06:59:37 +1300", :url=>"/mnr/mnr-20151210-0828-petition_to_ban_donald_trump_from_entering_the_uk-048.mp3", :status=>200, :bytes_sent=>3214, :user_agent=>"Mozilla/5.0 Gecko/20100115 Firefox/3.6", :date=>"2016-02-09 06:59:37 +1300", :downloader_uid=>"31e3037a0b793e96b070de3206e5a928353815c1", :download_uid=>"daeddaff3d673bacd9b57b635e0037c01cd28ef6"} }
      it { is_expected.to eq(nil) }
    end

    context "Partial GET request (206) under 200,000 bytes" do
      let(:data){ {:ip=>"113.171.224.210", :timestamp=>"09/Feb/2016:06:59:37 +1300", :url=>"/mnr/mnr-20151210-0828-petition_to_ban_donald_trump_from_entering_the_uk-048.mp3", :status=>200, :bytes_sent=>2153, :user_agent=>"Mozilla/5.0 Gecko/20100115 Firefox/3.6"} }
      it { is_expected.to eq(nil) }
    end

  end

end
