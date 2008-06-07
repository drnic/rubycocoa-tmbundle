require File.dirname(__FILE__) + '/test_helper'
require File.dirname(__FILE__) + '/../lib/new_ruby_cocoa_instance'

class TestNewRubyCocoaInstance < Test::Unit::TestCase
  def test_valid_activation_of_NSObject
    # Array structure:
    # [current_line, column_number, expected]
    [
      ['NSTextField.', 13, 'NSTextField.init.alloc'],
    ].each do |current_line, column_number, expected|
      replacement_line = NewRubyCocoaInstance.run(current_line, column_number)
      assert_equal(expected, replacement_line)
    end
  end
  
  def test_valid_activation_of_normal_class
    # Array structure:
    # [current_line, column_number, expected]
    [
      ['String.', 8, 'String.new'],
    ].each do |current_line, column_number, expected|
      replacement_line = NewRubyCocoaInstance.run(current_line, column_number)
      assert_equal(expected, replacement_line)
    end
  end
  
  def test_invalid_activation
    # Array structure:
    # [current_line, column_number]
    [
      ['    ', 3],
      ['SomeConstant.', 1],
      ['SomeConstant.', 14],
      ['String.', 1],
      ['String.', 7], # cursor not after .
      ['NSTextField.', 4] # cursor not at correct position
    ].each do |current_line, column_number|
      replacement_line = NewRubyCocoaInstance.run(current_line, column_number)
      assert_equal(current_line, replacement_line, 
        "'#{current_line}' (cursor #{column_number}) should not activate to anything but itself")
    end
  end
end