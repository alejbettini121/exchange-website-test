require File.expand_path('../../test_helper', __FILE__)
require 'mocha/object_methods'
require 'mocha/mockery'
require 'mocha/mock'
require 'mocha/expectation_error_factory'
require 'mocha/names'

class ObjectMethodsTest < Mocha::TestCase

  def setup
    Mocha::Mockery.setup
    @object = Object.new.extend(Mocha::ObjectMethods)
  end

  def teardown
    Mocha::Mockery.teardown
  end

  def test_should_build_mocha_referring_to_self
    mocha = @object.mocha
    assert_not_nil mocha
    assert mocha.is_a?(Mocha::Mock)
    expected_name = Mocha::ImpersonatingName.new(@object).mocha_inspect
    assert_equal expected_name, mocha.mocha_inspect
  end

  def test_should_not_build_mocha_if_instantiate_is_false
    assert_nil @object.mocha(false)
  end

  def test_should_reuse_existing_mocha
    mocha_1 = @object.mocha
    mocha_2 = @object.mocha
    assert_equal mocha_1, mocha_2
  end

  def test_should_reuse_existing_mocha_even_if_instantiate_is_false
    mocha_1 = @object.mocha
    mocha_2 = @object.mocha(false)
    assert_equal mocha_1, mocha_2
  end

  def test_should_reset_mocha
    assert_nil @object.reset_mocha
  end

  def test_should_use_stubba_instance_method_for_object
    assert_equal Mocha::InstanceMethod, Object.new.stubba_method
  end

  def test_should_stub_self_for_object
    assert_equal @object, @object.stubba_object
  end

  def test_nobody_expects_the_spanish_inquisition
    assert_raise(Mocha::ExpectationErrorFactory.exception_class) { @object.expects(:the_spanish_inquisition) }
  end

  def test_should_alias_object_method
    klass = Class.new { def self.method_x; end }
    assert_equal klass._method(:method_x), klass.method(:method_x)
  end

end
