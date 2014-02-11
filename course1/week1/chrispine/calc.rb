input = 1
word_ary = []
while input != ''
  puts "Give me a name"
  input = gets.chomp.capitalize
  if input != input.capitalize
    puts "Give me a name with PROPER capitalization!"
    input = gets.chomp
  else
    puts "good"
  end
  word_ary.push input

end
  puts "---------heres the array in alphabetical order w/ proper capitalization-------"

  puts word_ary.sort
