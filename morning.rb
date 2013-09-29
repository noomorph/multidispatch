class Morning
  include Multidispatch

  def say
    puts "Good morning!"
  end

  def say(name)
    puts "Good morning, #{name}!"
  end

  def say(name, n)
    n.times { |i| puts "#{i+1}. Good morning, #{name}!" }
  end
end
