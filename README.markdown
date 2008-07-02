RubyCocoa TextMate bundle
--------------------

Installation
============

To install via Git:

		cd ~/"Library/Application Support/TextMate/Bundles/"
		git clone git://github.com/drnic/rubycocoa-tmbundle.git "RubyCocoa.tmbundle"
		osascript -e 'tell app "TextMate" to reload bundles'

Source can be viewed or forked via GitHub: [http://github.com/drnic/rubycocoa-tmbundle/tree/master](http://github.com/drnic/rubycocoa-tmbundle/tree/master)

Features
========

* Cannot remember whether to use NSRange.new or NSRange.init.alloc? Let the bundle help. Type "NSRange." and press tab and it will attempt to guess for you.
* 'clan' expands into a class definition for the current file name, as an `OSX::NSObject` subclass (the tab completion comes from: **cla**ss **N**SObject)

Cut-n-pasted

    - (void)bind:(NSString *)binding toObject:(id)observableController withKeyPath:(NSString *)keyPath options:(NSDictionary *)options
    
from the doco?

Select and do cmd-M to convert into a RubyCocoa method:
  
    def bind_toObject_withKeyPath_options(binding,observableController,keyPath,options)
    end
    
Cmd-Shift-M converts it into a RubyCocoa-style call:
  
    obj.bind_toObject_withKeyPath_options(binding,observableController,keyPath,options)
  

Maintainer
==========

Dr Nic Williams, drnicwilliams@gmail.com, [http://drnicwilliams.com](http://drnicwilliams.com)