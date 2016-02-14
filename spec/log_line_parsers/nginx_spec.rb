require 'spec_helper'

include PrpmTools

describe NginxLogLineParser do
  subject { NginxLogLineParser.new(line).parse }

  context 'nginx log' do
    context 'GET 200' do
      let(:line){ %q!113.171.224.210 - - [09/Feb/2016:06:59:37 +1300] "GET /mnr/mnr-20151210-0828-petition_to_ban_donald_trump_from_entering_the_uk-048.mp3 HTTP/1.1" 200 59559 "-" "Mozilla/5.0 Gecko/20100115 Firefox/3.6"! }
      it do
        is_expected.to eq({:ip=>"113.171.224.210", :timestamp=>"09/Feb/2016:06:59:37 +1300", :url=>"/mnr/mnr-20151210-0828-petition_to_ban_donald_trump_from_entering_the_uk-048.mp3", :status=>200, :bytes_sent=>59559, :user_agent=>"Mozilla/5.0 Gecko/20100115 Firefox/3.6", :range=>nil, :last_byte=>nil})
      end
    end

    context 'GET 206' do
      let(:line){ %q!113.171.224.210 - - [09/Feb/2016:06:59:37 +1300] "GET /mnr/mnr-20151210-0828-petition_to_ban_donald_trump_from_entering_the_uk-048.mp3 HTTP/1.1" 206 59559 "-" "Mozilla/5.0 Gecko/20100115 Firefox/3.6"! }
      it do
        is_expected.to eq({:ip=>"113.171.224.210", :timestamp=>"09/Feb/2016:06:59:37 +1300", :url=>"/mnr/mnr-20151210-0828-petition_to_ban_donald_trump_from_entering_the_uk-048.mp3", :status=>206, :bytes_sent=>59559, :user_agent=>"Mozilla/5.0 Gecko/20100115 Firefox/3.6", :range=>nil, :last_byte=>nil})
      end
    end

    context 'HEAD 200' do
      let(:line){ %q!113.171.224.210 - - [09/Feb/2016:06:59:37 +1300] "HEAD /mnr/mnr-20151210-0828-petition_to_ban_donald_trump_from_entering_the_uk-048.mp3 HTTP/1.1" 200 59559 "-" "Mozilla/5.0 Gecko/20100115 Firefox/3.6"! }
      it do
        is_expected.to eq(nil)
      end
    end

  end
end
