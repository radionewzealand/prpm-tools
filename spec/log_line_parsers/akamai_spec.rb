require 'spec_helper'

include PrpmTools

describe AkamaiLogLineParser do
  subject { AkamaiLogLineParser.new(line).parse }

  context 'akamai log' do
    context 'GET 200' do
      let(:line){ %q!2016-01-31	15:17:09	24.148.50.110	GET	/npr.download.akamai.com/npr-mp4/sonicid/01/309.mp4	200	212636	351	"-"	"NPR%20One/9 CFNetwork/758.2.8 Darwin/15.0.0"	"-"! }
      it do
        is_expected.to eq( {:ip=>"24.148.50.110", :timestamp=>"2016-01-31 15:17:09", :url=>"/npr.download.akamai.com/npr-mp4/sonicid/01/309.mp4", :status=>200, :bytes_sent=>212636, :user_agent=>"NPR%20One/9 CFNetwork/758.2.8 Darwin/15.0.0", :range=>nil, :last_byte=>nil} )
      end
    end

    context 'GET 206' do
      let(:line){ %q!2016-01-31	17:18:53	66.87.76.235	GET	/npr.download.akamai.com/npr-mp4/nprone/hello/magictime1/309.mp4	206	127331	0	"-"	"AppleCoreMedia/1.0.0.13D15 (iPhone; U; CPU OS 9_2_1 like Mac OS X; en_us)"	"-"! }
      it do
        is_expected.to eq( {:ip=>"66.87.76.235", :timestamp=>"2016-01-31 17:18:53", :url=>"/npr.download.akamai.com/npr-mp4/nprone/hello/magictime1/309.mp4", :status=>206, :bytes_sent=>127331, :user_agent=>"AppleCoreMedia/1.0.0.13D15 (iPhone; U; CPU OS 9_2_1 like Mac OS X; en_us)", :range=>nil, :last_byte=>nil} )
      end
    end

  end
end
