module TestDifferenceHelper
  
  def assert_created(model, &block)
    assert_positive_difference(model, &block)
  end

  def assert_not_created(model, &block)
    assert_no_difference(model, &block)
  end

  def assert_destroyed(model, &block)
    assert_negative_difference(model, &block)
  end

  def assert_difference(object, opts = {})
    difference = opts[:difference]
    method = opts[:on] || :count
    message = opts[:message] || "assert_difference failed on #{object}##{method}"
    initial_value = object.__send__(method)
    yield
    if difference.blank?
      assert initial_value != object.__send__(method), message
    else
      assert_equal initial_value + difference, object.send(method), message
    end
  end
  
  def assert_negative_difference(object, opts = {})
    method = opts[:on] || :count
    message = opts[:message] || "assert_difference failed on #{object}##{method}"
    initial_value = object.__send__(method)
    yield
    assert initial_value > object.__send__(method), message
  end
  
  def assert_positive_difference(object, opts = {})
    method = opts[:on] || :count
    initial_value = object.__send__(method)
    yield
    value = object.__send__(method)
    message = opts[:message] || "assert_positive_difference failed on #{object}##{method}: #{initial_value} <> #{value}"
    assert initial_value < value, message
  end
  
  def assert_any_difference(object, opts = {}, &block)
    opts[:difference] = nil
    assert_difference object, opts, &block
  end
  
  def assert_no_difference(object, opts = {}, &block)
    opts.merge!(:difference => 0)
    assert_difference object, opts, &block
  end
  
end