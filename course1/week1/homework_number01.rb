
#1. Use the "each" method of Array to iterate over [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], and print out each value.
puts
puts "================= #1 ================="
puts

ary = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
ary.each do |g|
  puts g
end

#2. Same as above, but only print out values greater than 5.
puts
puts "================= #2 ================="
puts

ary.each do |g|
  if g > 5
    puts g
  end
end


#3. Now, using the same array from #2, use the "select" method to extract all odd numbers into a new array.
puts
puts "================= #3 ================="
puts

odd_ary = ary.select { |g| (g%2) == 1}
puts odd_ary

#4. Append "11" to the end of the array. Prepend "0" to the beginning.
puts
puts "================= #4 ================="
puts

ary << "11"
ary.unshift "0"
puts ary

#5. Get rid of "11". And append a "3".
puts
puts "================= #5 ================="
puts

ary.pop
ary.push 3
puts ary


#6. Get rid of duplicates without specifically removing any one value. 
puts
puts "================= #6 ================="
puts

ary.uniq!
puts ary


#7. What's the major difference between an Array and a Hash?
puts
puts "================= #7 ================="
puts

puts "Arrays are better for ordered lists. Hashs are better for pairs of keys and values that linked to each other."

#8. Create a Hash using both Ruby 1.8 and 1.9 syntax.
puts
puts "================= #8 ================="
puts

puts "Here's the Ruby 1.8 way:"
dave_hash = {:color => "red", :height => 5, :weight => 180}
puts dave_hash
puts

puts "Here's the Ruby 1.9 way:"
dave_hash = {color: "red", height: 5, weight: 180}
puts dave_hash

#Suppose you have a h = {a:1, b:2, c:3, d:4}

#9. Get the value of key "b".
puts
puts "================= #9 ================="
puts

h = {a:1, b:2, c:3, d:4}
puts h[:b]

#10. Add to this hash the key:value pair {e:5}
puts
puts "================= #10 ================="
puts

h[:e] = 5
puts h

#13. Remove all key:value pairs whose value is less than 3.5
puts
puts "================= #13 ================="
puts

h.delete_if{|k, v| v < 3.5}
puts h

#14. Can hash values be arrays? Can you have an array of hashes? (give examples)
puts
puts "================= #14 ================="
puts

puts "Yes, hash values can be arrays and you can have an array oh hashes"

h[:f] = ["tom", "jerry"]
puts h
puts

j = ["green", "blue", {a: "bright", b: "dull"}]
puts j

#15. Look at several Rails/Ruby online API sources and say which one your like best and why.
puts
puts "================= #15 ================="
puts

puts "http://www.ruby-doc.org/"
