=begin
  
1 Create a local variable and modify it at an inner scope (in between a do/end block). You can try

a) re-assigning the variable to something else
b) call a method that doesn’t mutate the caller
c) call a method that mutates the caller.
2 Create a local variable at an inner scope (within a do/end block) and try to reference it in the outer scope. What happens when you have nested do/end blocks?
  
=end

ary = [0,1,2]

ary.each do |g|
  random_number = rand(3)
  if random_number == g
    puts "There happens to be match!"
    puts random_number
  end

  puts random_number

end

# puts random_number
