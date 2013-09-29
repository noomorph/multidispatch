require './multidispatch'
require './morning'
require './night'

morning, night = Morning.new, Night.new

morning.say
night.say

morning.say("Foo")
night.say("Foo")

morning.say("Foo", 5)
night.say("Foo", 5)
