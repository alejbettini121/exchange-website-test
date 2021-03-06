module Mocha

  class ObjectReceiver

    def initialize(object)
      @object = object
    end

    def mocks
      object, mocks = @object, []
      while object do
        mocha = object.mocha(false)
        mocks << mocha if mocha
        object = object.is_a?(Class) ? object.superclass : nil
      end
      mocks
    end

  end

  class AnyInstanceReceiver

    def initialize(klass)
      @klass = klass
    end

    def mocks
      klass, mocks = @klass, []
      while klass do
        mocha = klass.any_instance.mocha(false)
        mocks << mocha if mocha
        klass = klass.superclass
      end
      mocks
    end

  end

  class DefaultReceiver

    def initialize(mock)
      @mock = mock
    end

    def mocks
      [@mock]
    end

  end

end
