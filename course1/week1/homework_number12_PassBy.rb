=begin
  
Create a method that takes an array as a parameter. Within that method, try calling methods that do not mutate the caller. How does that affect the array outside of the method? What about when you call a method that mutates the caller within the method?
  
=end

puts "==============method that doesn't mutate the caller =============="

def shout_it_out ary
  ary.each do |g|
    puts g.to_s.upcase + "!!!!!!!!!"
  end
  return
end

my_ary = ["cats", "giraffes", "houses", 4, 5, "stores"]

puts shout_it_out(my_ary)
puts my_ary

puts "==============method that DOES mutate the caller =============="

def shout_it_out ary
  ary.each do |g|
    puts g.to_s.upcase + "!!!!!!!!!"
  end
  ary << "see if this appends to the array"
  return
end

my_ary = ["cats", "giraffes", "houses", 4, 5, "stores"]

puts shout_it_out(my_ary)
puts my_ary