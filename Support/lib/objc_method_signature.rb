class ObjcMethodSignature
  KEY_RE = %r{(\w+):}
  TYPE_RE = %r{
    \(
    ([\w\s\*]+)
    \)
  }x
  VAR_RE = %r{
    (\w+)
  }x

  SIG_RE = %r{
    #{KEY_RE}
    \s*
    #{TYPE_RE}
    \s*
    #{VAR_RE}
  }x

  RETURN_TYPE_RE = %r[
    ([\+-])
    \s*
    (?:#{TYPE_RE}|)
    (\w+)
  ]x
  
  def initialize(text)
      @text = text
      @keys = []
      @vars = []

      text.scan(SIG_RE) {|(key,type,var)| @keys << key; @vars << var}
      _,@scope,@type,@first_key = *text.match(RETURN_TYPE_RE)
  end

  # text = ENV['TM_SELECTED_TEXT']

  
  def signature
    unless @keys.empty?
      method = @keys * '_'
      args   = "(#{@vars * ','})"
    else
      method = @first_key
      args = ''
    end
    
    "#{method}#{args}"
  end
  
  def cast_type
    unless @cast_type
      @cast_type = @type
      @cast_type ||= 'id'
      @cast_type.sub(/^[A-Z]{2}/,'').gsub(/[\s\*]/,'').downcase
      @cast_type = 'obj' if @cast_type == 'id'
    end
    @cast_type
  end
  
  def ret
    type = cast_type
    type == 'void' ? '$0' : "\n  $1\n  return ${0:#{type}}"
  end
    

  def to_def
    ruby_scope = @scope == '+' ? 'self.' : ''
    
    <<-SNIPPET
# #{@text}
def #{ruby_scope}#{signature}
  #{ret}
end
    SNIPPET
  end
  
  def to_call
    "${0:obj}\.#{signature}"
  end
end

if $0 == __FILE__
  sigs = [
    "- (void)bind:(NSString *)binding toObject:(id)observableController withKeyPath:(NSString *)keyPath options:(NSDictionary *)options",
    "- (void)bind",
    "- (NSString *)bind",
    "+ (NSString *)bind",
    "+ bind"
  ].each do |sig|
    o = ObjcMethodSignature.new(sig)
    puts 
    puts sig
    puts "def : #{o.to_def}"
    puts "call: #{o.to_call}"

  end
end