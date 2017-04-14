class GeoipLimiter
  def initialize config
    @config = config
  end

  def permit? ipaddr
    # Is the source IP address in the IP address whitelist?
    ipaddr_find?(ipaddr_regexps, ipaddr) ? true : false

    maxminddb.lookup_string ipaddr

    # Is the source country_code in the country_code whitelist?
    country_white_list.include?(maxminddb.country_code) ? true : false
  end

  def maxminddb
    unless @_maxminddb
      begin
        maxminddb = MaxMindDB.new(@config['maxminddb'])
      rescue => e
        raise "maxminddb load error #{self.class}##{__method__} #{e}"
      end
    end
  end

  def country_white_list
    unless @_country_white_list
      begin
        @_country_white_list = YAML.load(File.open(@config['country_white_list']).read())
      rescue => e
        raise "country white list load error #{self.class}##{__method__} #{e}"
      end
    end
  end

  def ipaddr_white_list
    unless @_ipaddr_white_list
      begin
        @_ipaddr_white_list = YAML.load(File.open(@config['ipaddr_white_list']).read())
      rescue => e
        raise "ipaddr white list load error #{self.class}##{__method__} #{e}"
      end
    end
  end

  def ipaddr_regexps ipadd_list
    @_ipaddr_regexps ||= ipadd_list.map { |cidr| IPAddressMatcher::CIDR.new(cidr).to_regexp }
  end

  def ipaddr_find? ipaddr_regexps, ipaddr
    ipaddr_regexps.select { |regexp| ipaddr =~ allow_regexp }.empty?
  end
end

if Object.const_defined?(:MTest)
  class TestGeoipLimiter
    def setup

    end

    def test_permit

    end

  end
else

end
