require 'json'

module PrpmTools

  class BotFilter

    def initialize
      data_file = File.join(File.dirname(File.expand_path(__FILE__)),'bot_data.json')

      @bots = JSON.parse(File.read(data_file)).join('|')
    end

    def check_agent(user_agent)
      return true if user_agent =~ /#{@bots}/
      false
    end
  end

end
