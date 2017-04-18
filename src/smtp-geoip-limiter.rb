class GeoipLimiter
  def initialize config
    @maxminddb_path      = config[:maxminddb_path]
    @permit_country_list = config[:permit_country_list] # array
    @permit_ipaddr_list  = config[:permit_ipaddr_list]  # array
  end

  def permit? ipaddr
    # Is the source IP address in the IP address whitelist?
    return true if permit_ipaddr?(ipaddr)

    maxminddb.lookup_string ipaddr

    # Is the source country_code in the country_code whitelist?
    permit_country?(maxminddb.country_code)
  end

  def ipaddr_regexps
    @_ipaddr_regexps ||= @permit_ipaddr_list.map { |cidr| IPAddressMatcher::CIDR.new(cidr).to_regexp }
  end

  def permit_ipaddr? ipaddr
    ipaddr_regexps.select { |r| ipaddr =~ r }.empty?
  end

  def permit_country? country_code
    permit_country_list.include?(country_code)
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
end

if Object.const_defined?(:MTest)
  class TestGeoipLimiter < MTest::Unit::TestCase
    def setup
      maxminddb_path = "../GeoLite2-City.mmdb"

      permit_country = %w(
        JP
      )

      permit_ipaddr = %w(
        192.168.1.0/24
      )

      @limiter = GeoipLimiter.new(
        :maxminddb_path      => maxminddb_path,
        :permit_country_list => permit_country,
        :permit_ipaddr_list  => permit_ipaddr
      )
    end

    def test_permit
      assert_true(@limiter.permit?("192.168.1.1"))
      assert_false(@limiter.permit?("192.168.2.1"))
    end
  end
  
  MTest::Unit.new.run
else

end
