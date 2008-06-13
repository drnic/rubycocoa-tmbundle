module RubyCocoa
  module MessageParser
    extend self
    
    # objectValueForTableColumn -> tableColumn
    # numberOfRowsInTableView -> tableView
    def find_concept(messageName)
      if messageName =~ /(?:For|In|Set|From|Find|Remove)([A-Z]\w*)$/
        concept = $1
        return concept[0..0].downcase + concept[1..-1]
      else
        messageName
      end
    end
  end
end