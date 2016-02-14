module PrpmTools
  # Log line parsers should only return GET requests and 200 or 206 responses
  # as these are the only ones of interest to us


  # Fields: date time cs-ip cs-method cs-uri sc-status sc-bytes time-taken cs(Referer) cs(User-Agent) cs(Cookie)
  # 2016-01-31	15:39:05	207.229.180.210	GET	/npr.download.akamai.com/npr-mp4/npr/underwriting/042914_AppPermissions_MPX.mp4	200	227434	52	"-"	"NPRRadio/161 CFNetwork/711.1.16 Darwin/14.0.0"	"-"
  class AkamaiLogLineParser

    def initialize(line)
      @line = line
    end

    def parse
      %r{
        (?<date>\d{4}-\d{2}-\d{2})
        \s+
        (?<time>\d{2}:\d{2}:\d{2})
        \s+
        (?<ip>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})
        \s+
        GET
        \s+
        (?<url>[^\s]+)
        \s+
        (?<status>200|206)
        \s+
        (?<bytes_sent>\d+)
        \s+
        \d+
        \s+
        "[^"]"
        \s+
        "(?<user_agent>[^"]+)"
        \s+
        "(?<cookie>[^"]+)"
        }xi =~ @line &&
        {ip: ip, timestamp: date + ' ' + time , url: url, status: status.to_i, bytes_sent: bytes_sent.to_i, user_agent: user_agent, range: nil, last_byte: nil}
    end

  end

end
