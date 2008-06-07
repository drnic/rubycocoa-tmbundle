module NewRubyCocoaInstance
  extend self
  
  # column_number starts at 1 and represents a range of 0 characters
  def run(current_line, column_number)
    cursor_index = (column_number - 2) < 0 ? 0 : (column_number-2)
    partial_line = current_line[0..cursor_index]
    return current_line unless partial_line =~ %r{([A-Z]\w+)\.$}
    constant_str = $1
    load_env
    constant = to_constant constant_str
    return current_line unless constant
    instantiator = constant.ancestors.include?(OSX::NSObject) ? "init.alloc" : "new"
    "#{constant_str}.#{instantiator}"
  end
  
  def load_env
    require 'osx/cocoa'
    # TODO - load current file too
  end
  
  def to_constant(constant_str)
    (Object.const_get(constant_str) rescue nil) ||
    (OSX.const_get(constant_str) rescue nil)
  end
end