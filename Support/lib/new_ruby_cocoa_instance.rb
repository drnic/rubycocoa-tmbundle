module NewRubyCocoaInstance
  extend self
  
  # column_number starts at 1 and represents a range of 0 characters
  def run(current_line, column_number, current_file = nil)
    cursor_index = (column_number - 2) < 0 ? 0 : (column_number-2)
    partial_line = current_line[0..cursor_index]
    return current_line unless partial_line =~ %r{(.*)\b([A-Z]\w+)$}
    constant_str, prefix = $2, $1
    load_env(current_file)
    constant = to_constant constant_str
    return current_line unless constant
    instantiator = constant.ancestors.include?(OSX::NSObject) ? "alloc.init" : "new"
    "#{prefix}#{constant_str}.#{instantiator}$0"
  end
  
  def load_env(current_file = nil)
    require 'osx/cocoa'
    require current_file rescue nil if current_file
    Test::Unit.run = true if defined? Test::Unit
  end
  
  def to_constant(constant_str)
    (Object.const_get(constant_str) rescue nil) ||
    (OSX.const_get(constant_str) rescue nil)
  end
end