# DON'T RUN THIS TEST! IT WILL SEND YOUR HOSTNAME (hashed), RUBY_PLATFORM and RUBY_VERSION information to the authors of this gem

$LOAD_PATH << File.expand_path(sprintf('%s/../lib/', File.dirname(__FILE__)))

require 'test-unit'
require 'captchr'

class TestCaptchr < Test::Unit::TestCase

  def setup; end
  def teardown; end

  def test_et_phone_home
    captchr = Captchr.new
  end

  def test_add
    assert_equal(42, Captchr.add(15, 27))
  end

  def test_subtract
    assert_equal(27, Captchr.subtract(29, 2))
  end

end