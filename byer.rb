class Byer
  include Multidispatch

  define :say do
    puts "Bye"
  end

  define :say do |name| 
    puts "Bye, #{name}"
  end

  define :say do |name, n| 
    n.times { |i| puts "#{i+1}. Bye, #{name}" }
  end
end