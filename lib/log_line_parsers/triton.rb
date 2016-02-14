module PrpmTools
  # Log line parsers should only return GET requests and 200 or 206 responses
  # as these are the only ones of interest to us


  #Fields: ip client_id username timestamp request response bytes_sent referer user_agent object_size byte_range last_byte
  # 162.207.92.164 - "cookie:97819a53-cbad-430d-a068-9e2b77993b8b" [01/Feb/2016:00:04:43 -0500] "GET /NPR_381444908/media-session/8621a9ec-1bfe-4688-82c1-ef0119226ec4/anon.npr-podcasts/podcast/381444908/462702123/npr_462702123.mp3?STW_NEW_UUID=1&d=2864&e=462702123&f=381444908&ft=pod&orgId=1&p=381444908&story=462702123&t=podcast HTTP/1.1" 200 94120 - "AppleCoreMedia/1.0.0.12D508 (iPad; U; CPU OS 8_2 like Mac OS X; en_us)" 23053548 0-23053547 0
  class TritonLogLineParser

    def initialize(line)
      @line = line
    end

    def parse
      %r{
        (?<ip>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})
        \s+
        -
        \s+
        .+
        \s+
        \[(?<timestamp>[^\]]+?)\]
        \s+
        "GET\s(?<url>[^\s]+?)\s(HTTP\/1\.1)"
        \s+
        (?<status>200|206)
        \s+
        (?<bytes_sent>\d+)
        \s+
        -
        \s+
        "(?<user_agent>.*)"
        \s+
        (?<total_bytes>\d+)
        \s+
        (?<range>(\d+-\d+|-))
        \s+
        (?<last_byte>\d)
        }xi =~ @line &&
        {ip: ip, timestamp: timestamp, url: url, status: status.to_i, bytes_sent: bytes_sent.to_i, user_agent: user_agent, total_bytes: total_bytes, range: range, last_byte: last_byte}
    end
  end

end
