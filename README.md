multidispatch
==================

[![Build Status](https://travis-ci.org/noomorph/multidispatch.png)](https://travis-ci.org/noomorph/multidispatch)

Very basic multidispatch in **Ruby** using natural syntax.
Currently supports overloads by count of mandatory parameters.
So, it solves only one problem. Converts the following code:

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

to this nice one:

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

## Installation

Add this line to your application's Gemfile:

    gem 'multidispatch'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install multidispatch

## Usage

See **sample/** folder:

* morning.rb - sample class using **multidispatch** module
* main.rb - quick CLI test for **Morning**
* Gemfile - sample gemfile

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

... do not forget tests
... and Happy Hacking!
