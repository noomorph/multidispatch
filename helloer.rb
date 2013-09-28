class Helloer
  include Multidispatch

  def say_long(name = nil, n = nil)
    if name
      if n
        n.times do |i|
          puts "#{i+1}. Hello, #{name}"
        end
      else
        puts "Hello, #{name}"
      end
    else
      puts "Hello"
    end
  end
  
  def say(name = nil, n = nil)
    puts "Hello" unless name || n
    puts "Hello, #{name}" if name && !n
    n.times { |i| puts "#{i+1}. Hello, #{name}" } if name && n
  end
end
