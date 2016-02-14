require 'digest'
require 'date'

module PrpmTools

  class LineFilter

    def initialize(bot_filter, show_filter)
      @bot_filter = bot_filter
      @show_filter = show_filter
    end

    def filter(line_data, date_format='%d/%b/%Y:%H:%M:%S %z')
      convert_line_to_unique_downloader(line_data, date_format)
    end

    private

    def convert_line_to_unique_downloader(data, date_format='%d/%b/%Y:%H:%M:%S %z')

      return if bot_filter(data[:user_agent])
      return if data[:bytes_sent] < 200000

      # If the log file has NO range (nil) we use a slightly looser match on 206 lines
      # These will be filtered later through the use of 'unique'
      if ((data[:status] == 200) || (data[:status] == 206 && (data[:range] =~ /^(0-\d|-)/ || data[:range].nil?) ))
        data[:date] = DateTime.strptime(data[:timestamp], date_format).to_date.to_s  # outputs yyyy-mm-dd
        data[:downloader_uid] = Digest::SHA1.hexdigest(data[:ip] + data[:user_agent])
        data[:download_uid] = Digest::SHA1.hexdigest(data[:ip] + data[:user_agent] + data[:url] + data[:date])
        data[:show_code] = extract_show(data[:url])
        data
      end
    end

    def bot_filter(user_agent)
      @bot_filter.check_agent(user_agent)
    end

    def extract_show(url)
      @show_filter.extract_show(url)
    end

  end

end
