require 'spec_helper'

include PrpmTools

describe TritonLogLineParser do
  subject { TritonLogLineParser.new(line).parse }

  context 'triton log' do
    context 'GET 200' do
      let(:line){ %q!71.127.9.53 - "cookie:c330ba98-8a90-426f-8fb4-aa3fc1d6d002" [01/Feb/2016:00:04:28 -0500] "GET /ALLSONGS_PODCAST/media-session/bb6f0ee5-dbe1-4848-827e-8b173741cff6/anon.npr-podcasts/podcast/510019/137506550/npr_137506550.mp3?STW_NEW_UUID=1&e=137506550&f=510019&ft=pod&orgId=1&p=510019&story=137506550&t=podcast HTTP/1.1" 200 908640 - "iTunes/12.3.2 (Macintosh; OS X 10.9.5) AppleWebKit/537.78.2" 31912148 - 0! }
      it do
        is_expected.to eq( {:ip=>"71.127.9.53", :timestamp=>"01/Feb/2016:00:04:28 -0500", :url=>"/ALLSONGS_PODCAST/media-session/bb6f0ee5-dbe1-4848-827e-8b173741cff6/anon.npr-podcasts/podcast/510019/137506550/npr_137506550.mp3?STW_NEW_UUID=1&e=137506550&f=510019&ft=pod&orgId=1&p=510019&story=137506550&t=podcast", :status=>200, :bytes_sent=>908640, :user_agent=>"iTunes/12.3.2 (Macintosh; OS X 10.9.5) AppleWebKit/537.78.2", :total_bytes=>"31912148", :range=>"-", :last_byte=>"0"} )
      end
    end

    context 'GET 206' do
      let(:line){ %q!211.44.151.53 - "cookie:ddf699f5-9068-424e-8c61-a75cf1abdc42" [01/Feb/2016:00:04:40 -0500] "GET /NPR_510298/media-session/9e6b6718-ddd5-4b05-8ddf-128e6a5acc7b/anon.npr-mp3/npr/ted/2015/11/20151106_ted_tedpod.mp3?STW_NEW_UUID=1&d=3141&e=454658996&f=510298&ft=pod&orgId=1&p=510298&story=454658996&t=podcast HTTP/1.1" 206 447 - "AppleCoreMedia/1.0.0.13C75 (iPhone; U; CPU OS 9_2 like Mac OS X; en_us)" 50507442 0-1 0! }
      it do
        is_expected.to eq( {:ip=>"211.44.151.53", :timestamp=>"01/Feb/2016:00:04:40 -0500", :url=>"/NPR_510298/media-session/9e6b6718-ddd5-4b05-8ddf-128e6a5acc7b/anon.npr-mp3/npr/ted/2015/11/20151106_ted_tedpod.mp3?STW_NEW_UUID=1&d=3141&e=454658996&f=510298&ft=pod&orgId=1&p=510298&story=454658996&t=podcast", :status=>206, :bytes_sent=>447, :user_agent=>"AppleCoreMedia/1.0.0.13C75 (iPhone; U; CPU OS 9_2 like Mac OS X; en_us)", :total_bytes=>"50507442", :range=>"0-1", :last_byte=>"0"} )
      end
    end

  end
end
