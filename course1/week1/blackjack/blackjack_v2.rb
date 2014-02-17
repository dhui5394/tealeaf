# ==== Create a shuffled deck with 52 unique cards ====
numbers = ['ace','2','3','4','5','6','7','8','9','10',"jack","queen","king"]
suits = ['spades','clubs', 'hearts', 'diamonds']
deck = numbers.product(suits)
deck.shuffle!

# ==== Create starting player hand and dealer hand and respective totals ====
player_hand_total = 0
dealer_hand_total = 0
player_cards = []
dealer_cards =[]

# ==== Create the methods ====
def calc_hand_total(cards)
  total = 0
  numbers_only_array = cards.map {|g| g[0]}
  numbers_only_array.each do |h|
    if h == 'ace'
      total += 11
    elsif h.to_i == 0
      total += 10
    else
      total += h.to_i
    end
  end

  numbers_only_array.select {|k| k == "ace"}.count.times do
    total -= 10 if total > 21   
  end

  total
end

# ==== Deal the Cards ====
puts '='*50
puts 'Welcome to Tealeaf Casino\'s blackjack table!' 
player_cards << deck.pop
dealer_cards << deck.pop 
player_cards << deck.pop
dealer_cards << deck.pop 
player_hand_total = calc_hand_total(player_cards)
dealer_hand_total = calc_hand_total(dealer_cards)
puts "Your starting hand is #{player_cards} for a total of #{player_hand_total}."
puts "Dealer hand is #{dealer_cards}  for a total of #{dealer_hand_total}."

# ==== Run the Player's Hand ====
puts ''
while player_hand_total < 21
  puts 'Do you want to hit(h) or stay(s)?'
  decision = gets.chomp
  if !['h','s'].include?(decision)
    puts "Gimme an 'h' or 's' please!"
    next
  end
  if decision == 'h'
    new_card = deck.pop
    puts "Dealer just dealt #{new_card}"
    player_cards << new_card
    player_hand_total = calc_hand_total(player_cards)
    puts "Player total is now #{player_hand_total}"
  elsif decision == "s"
    puts "player chose to stay"
    break
  end

  if player_hand_total == 21
    puts "Blackjack! You win!" 
    exit
  elsif player_hand_total > 21
    puts "BUST. You lose." 
    exit
  end
end


# ==== If the Player Hasn't Busted, Run the Dealer's Hand ====

puts ''
while dealer_hand_total < 17
  new_card = deck.pop
  puts "Dealer just dealt #{new_card}."
  dealer_cards << new_card
  dealer_hand_total = calc_hand_total(dealer_cards)
  puts "Dealer total is now #{dealer_hand_total}."
  if dealer_hand_total > 21
    puts "DEALER BUSTS. YOU WIN!" if dealer_hand_total > 21
    exit
  elsif dealer_hand_total == 21
    puts "Dealer has blackjack. You lose."
    exit    
  end
end

# ==== If neither person has blackjacked or busted, compare the hands ====
puts "Here's the rundown.... Player has #{player_hand_total} and Dealer has #{dealer_hand_total}."
if dealer_hand_total > player_hand_total
  puts "Dealer wins."
elsif dealer_hand_total < player_hand_total
  puts "PLAYER WINS!"
else
  puts "It's a tie. PUSH!"
end
