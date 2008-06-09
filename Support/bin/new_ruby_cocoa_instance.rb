#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/../lib/new_ruby_cocoa_instance'
current_line  = ENV['TM_CURRENT_LINE']
column_number = ENV['TM_COLUMN_NUMBER'].to_i
current_file  = ENV['TM_FILEPATH']
print NewRubyCocoaInstance.run(current_line, column_number, current_file)
