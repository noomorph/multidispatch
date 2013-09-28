require './multidispatch'
require './helloer'
require './byer'

hello, bye = Helloer.new, Byer.new

hello.say
bye.say 

hello.say("Foo")
bye.say("Foo")

hello.say("Foo", 5)
bye.say("Foo", 5)
