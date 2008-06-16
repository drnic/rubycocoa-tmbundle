#!/usr/bin/env ruby

require "ui"
require "message_parser"

keynames = []
lines = STDIN.read.split("\n")
lines.each do |line|
  # parsing lines like:
  # kvc_array_accessor :items
  if line =~ /kvc_array_accessor[\s\t]+(.*)$/
    keynames.concat eval("[#{$1}]")
  end
end


keyname = if keynames.length > 1
  TextMate::UI.request_item(:items => keynames.map {|s| s.to_s}.sort, :title => "Select a kvc_array_accessor:")
else
  keynames.first
end

keyname = keyname.to_s
keyname[0..0] = keyname[0..0].upcase

methods = {
  "countOf#{keyname}" => 0,
  "objectIn#{keyname}AtIndex" => 1,
  "insertObject_in#{keyname}AtIndex" => 2,
  "removeObjectFrom#{keyname}AtIndex" => 1, 
  "replaceObjectIn#{keyname}AtIndex_withObject" => 2
}
method = TextMate::UI.request_item(:items => methods.keys.sort, :title => "Pick #{keyname} helper:")
argumentCount = methods[method]
if argumentCount > 0
  index = 1
  arguments = method.split("_").
    map { |arg| RubyCocoa::MessageParser.find_concept arg }.
    map { |arg| "${#{index += 1}:#{arg}}" }.
    join(", ")
  print "#{method}(#{arguments})"
else
  print method
end
