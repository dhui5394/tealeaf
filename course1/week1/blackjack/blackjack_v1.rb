# ==== Create the assets ====
# Create a deck with 52 cards
deck = []
numbers = ["a",2,3,4,5,6,7,8,9,10,"j","q","k"]
numbers.each do |num|
  deck << num
  deck << num
  deck << num
  deck << num
end

# Create starting player and dealer hand totals
player_hand = 0
dealer_hand = 0

# ==== Create the methods ====
def deal_card(d,p) # pass in the deck and protagonist
  card = d.sample
  case
  when card == 'a'
    puts "I dealt an ace!"
    if p == "player"
      puts 'Do you want the ace to represent one[type "one"] or eleven[type "eleven"]?'
      ace_choice = gets.chomp
      if ace_choice == "one"
        return 1
      elsif ace_choice == "eleven"
        return 11
      else
        puts 'Obviously you\'re too drunk to make decision or type properly. I\'ll assume you meant 1.'
        return 1
      end
    end

    return 1
  when card == 'j'
    puts "I dealt a jack!"
    return 10
  when card == 'q'
    puts "I dealt a queen!"
    return 10
  when card == 'k'
    puts "I dealt a king!"
    return 10
  else
    puts "I dealt a " + card.to_s + "."
    return card.to_i
  end
  puts
  puts 'Dealer pulled out a ' + card.to_s
  puts
end


# Start with introductions
puts "Welcome to Tealeaf Casino. What's your name?"
player_name = gets.chomp
puts
puts "Please have a seat, " + player_name + ". Let's get started. "
puts

# Deal
player_hand = player_hand + deal_card(deck, "player") + deal_card(deck, "player")
puts 'Your total is ' + player_hand.to_s
while player_hand < 22
  puts "Do you want to hit(h) or stand(s)?"
  decision = gets.chomp
  if decision == "h"
    player_hand = player_hand + deal_card(deck, "player") 
    puts 'Your total is ' + player_hand.to_s
  elsif decision == "s"
    puts 
    puts 'Okay. My turn. FYI, your total is ' + player_hand.to_s
    dealer_hand = dealer_hand + deal_card(deck, "dealer") + deal_card(deck, "dealer")
    puts 'My total is ' + dealer_hand.to_s
    while dealer_hand < 17
      puts "I have to hit..." 
      dealer_hand = dealer_hand + deal_card(deck, "dealer")
      puts "My total is now " + dealer_hand.to_s
    end
    puts "Your total is " + player_hand.to_s + " and my total is " + dealer_hand.to_s
    if dealer_hand > 21
      puts "Dealer busts! You win!"
    elsif player_hand > dealer_hand
      puts "You win!"
    elsif player_hand == dealer_hand
      puts "Push!"
    else
      puts "Dealer wins. Sorry."
    end
    break
  else
    puts "Have you had too much tea to type correctly?"
  end 
end
if player_hand > 21
  puts "You busted! Goodbye."
end