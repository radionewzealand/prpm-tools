module PrpmTools

  class RnzShowParser

    def extract_show(url)
      if url =~ /news\/\d{8}/
        'news'
      elsif url =~ /\/[^\/]+\/(\w+)-/
          $1
      else
        nil
      end
    end

  end

end
