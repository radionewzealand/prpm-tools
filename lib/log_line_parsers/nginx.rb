module PrpmTools
  # Log line parsers should only return GET requests and 200 or 206 responses
  # as these are the only ones of interest to us

  class NginxLogLineParser

    def initialize(line)
      @line = line
    end

    def parse
      %r{
        (?<ip>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})
        \s+
        -
        \s+
        -
        \s+
        \[(?<timestamp>[^\]]+?)\]
        \s+
        "GET\s(?<url>[^\s]+?)\s(HTTP\/1\.1)"
        \s+
        (?<status>200|206)
        \s+
        (?<bytes_sent>\d+)
        \s+
        "-"
        \s+
        "(?<user_agent>.*)"
        }xi =~ @line &&
        {ip: ip, timestamp: timestamp, url: url, status: status.to_i, bytes_sent: bytes_sent.to_i, user_agent: user_agent, range: nil, last_byte: nil}
    end
  end

end
