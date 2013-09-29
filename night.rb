class Night
  include Multidispatch

  def say
    puts "Good night!"
  end

  def say(name)
    puts "Good night, #{name}!"
  end

  def say(name, n)
    n.times { |i| puts "#{i+1}. Good night, #{name}!" }
  end
end
