require File.dirname(__FILE__) + '/test_helper'
require File.dirname(__FILE__) + '/../lib/new_ruby_cocoa_instance'

class TestNewRubyCocoaInstance < Test::Unit::TestCase
  def test_valid_activation_of_NSObject
    # Array structure:
    # [current_line, column_number, expected]
    [
      ['NSTextField', 12, 'NSTextField.init.alloc$0'],
      [' @var = NSTextField', 20, ' @var = NSTextField.init.alloc$0'],
    ].each do |current_line, column_number, expected|
      replacement_line = NewRubyCocoaInstance.run(current_line, column_number)
      assert_equal(expected, replacement_line)
    end
  end
  
  def test_valid_activation_of_normal_class
    # Array structure:
    # [current_line, column_number, expected]
    [
      ['String', 7, 'String.new$0'],
    ].each do |current_line, column_number, expected|
      replacement_line = NewRubyCocoaInstance.run(current_line, column_number)
      assert_equal(expected, replacement_line)
    end
  end
  
  def test_valid_activation_of_custom_NSObject_subclass
    current_line = "  @app = MyApp"
    column_number = 15
    current_file = File.dirname(__FILE__) + "/fixtures/my_app.rb"
    expected = "  @app = MyApp.init.alloc$0"
    assert_equal(expected, NewRubyCocoaInstance.run(current_line, column_number, current_file))
  end
  
  def todo_test_invalid_activation
    # Array structure:
    # [current_line, column_number]
    [
      ['    ', 3, '  $0  '],
      ['blah', 1, '$0blah'],
      ['SomeConstant', 13, 'SomeConstant$0'],
    ].each do |current_line, column_number, expected|
      replacement_line = NewRubyCocoaInstance.run(current_line, column_number)
      assert_equal(expected, replacement_line, 
        "'#{current_line}' (cursor #{column_number}) should not activate to anything but itself")
    end
  end
end