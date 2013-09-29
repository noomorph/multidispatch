ruby-multidispatch
==================

Very basic multidispatch in Ruby using natural syntax.
It solves only one problem: converts

```ruby
class BoilerplateClass
  def foo(a = nil, b = nil)
    unless a || b
      # do action 1
      # ...
    end
    if a && !b
      # do action 2
      # ...
    end
    if a && b
      # do action 3
      # ...
    end
  end
end
```

to 

```ruby
class MultidispatchClass
  include Multidispatch

  def foo
    # do action 1
    # ...
  end

  def foo(a)
    # do action 2
    # ...
  end

  def foo(a,b)
    # do action 3
    # ...
  end
end
```

See samples:

* multidispatch.rb - the module itself
* morning.rb, night.rb - sample classes using multidispatch module
* main.rb - quick CLI test for **Morning** and **Night**

Currently supports overloads by count of mandatory parameters.

Happy Hacking!
