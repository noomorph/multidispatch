require 'multidispatch'
require './morning'

morning = Morning.new
morning.say
morning.say("Foo")
morning.say("Foo", 5)
