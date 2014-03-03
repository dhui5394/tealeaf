# ===== Dave BlackJack OOP =====
require "rubygems"
# require 'pry'

class Card
  attr_accessor :suit, :number

  def initialize(n,s)
    @number = n  
    @suit = s
  end

  def to_s
    "-----> The #{number} of #{suit}."
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    ['spades', 'hearts', 'clubs', 'diamonds'].each do |suit|
      ['ace', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'jack', 'queen', 'king'].each do |number|
        @cards << Card.new(number, suit)
        @cards.shuffle!
      end
    end
  end

  def pull_a_card_out
    cards.pop
  end

  def cards_left
    cards.size
  end
end

module Playable

  def calc_hand_total
    total = 0
    numbers_only_array = cards.map {|g| g.number}
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
      total -= 10 if total > BlackJackSitting::BLACK_JACK_LIMIT  
    end

    total
  end

  def show_hand
    puts "#{name} has the following cards:"
    cards.each do |n|
      puts "#{n}"
    end
    puts "=====> #{name} has a total of #{calc_hand_total}"
  end

  def show_covered_dealer_hand
    puts "#{name} is showing the following cards:"
    puts "#{cards[1]}"
  end

  def add_card(new_card_from_deck)
    cards << new_card_from_deck
  end

  def bust?
    total > BlackJackSitting::BLACK_JACK_LIMIT
  end
end

class PlayerHand
  include Playable
  attr_accessor :cards, :name

  def initialize()
    @cards = []
    @name = "Anonymous Player"
  end
end

class DealerHand
  include Playable
  attr_accessor :cards, :name

  def initialize
    @cards = []
    @name = "Dealer Dan"
  end
end

class BlackJackSitting
  attr_accessor :player_hand, :dealer_hand, :deck
  BLACK_JACK_LIMIT = 21
  DEALER_MINIMUM = 17

  def initialize
    @deck = Deck.new
    @player_hand = PlayerHand.new
    @dealer_hand = DealerHand.new
  end

  def aquire_player_name
    puts "="*70
    puts "Welcome to BlackJack. What is your name?"
    player_hand.name = gets.chomp
  end

  def deal_cards
    puts ""
    player_hand.add_card(deck.pull_a_card_out)
    dealer_hand.add_card(deck.pull_a_card_out)
    player_hand.add_card(deck.pull_a_card_out)
    dealer_hand.add_card(deck.pull_a_card_out)
    puts "#{player_hand.show_hand}"
    puts "#{dealer_hand.show_covered_dealer_hand}"
  end

  def blackjack_or_bust?(one_of_the_hands)
    if one_of_the_hands.calc_hand_total == BlackJackSitting::BLACK_JACK_LIMIT
      puts "#{one_of_the_hands.name} wins with a BlackJack!"
      play_again
    elsif one_of_the_hands.calc_hand_total > BlackJackSitting::BLACK_JACK_LIMIT
      puts "#{one_of_the_hands.name} busts and loses."
      play_again
    end   
  end

  def run_player_cards
    while !blackjack_or_bust?(player_hand)
      puts "Would you like to hit(1) or stay(2)?"
      decision = gets.chomp
      if !['1','2'].include?(decision)
        puts "Gimme an 'h' or 's' please!"
      elsif decision == '1'
        player_hand.add_card(deck.pull_a_card_out)
        player_hand.show_hand
      else
        print "#{player_hand.name} chose to stay. "
        break
      end
    end
  end

  def run_dealer_cards
    puts "#{dealer_hand.name}'s turn..."
    blackjack_or_bust?(dealer_hand)
    while dealer_hand.calc_hand_total < DEALER_MINIMUM
      puts "xx"
      dealer_hand.add_card(deck.pull_a_card_out)
      dealer_hand.show_hand
    end
    blackjack_or_bust?(dealer_hand)
    puts "#{dealer_hand.name}'s total is #{dealer_hand.calc_hand_total}"
  end 

  def compare_cards
    puts "#{player_hand.name} has #{player_hand.calc_hand_total} and #{dealer_hand.name} has #{dealer_hand.calc_hand_total}."
    if dealer_hand.calc_hand_total > player_hand.calc_hand_total
      puts "#{dealer_hand.name} wins!"
    elsif dealer_hand.calc_hand_total < player_hand.calc_hand_total
      puts "#{player_hand.name} wins!"
    else
      puts "It's a push!"
    end
  end

  def play_again
    puts "Play again? Yes(1) or No(2)."
    new_game_decision = gets.chomp

    while !['1','2'].include?(new_game_decision)
      puts "Gime me a 1 or 2."
      new_game_decision = gets.chomp
    end

    if new_game_decision == '1'
      deck = Deck.new
      player_hand.cards = []
      dealer_hand.cards = []
      start_round
    else
      puts "Thanks for playing. See you next time."
      exit
    end
  end

  def start_round
    deal_cards
    run_player_cards
    run_dealer_cards
    compare_cards
    play_again
  end

  def start_first_round
    aquire_player_name
    start_round
  end

end
  
sitting = BlackJackSitting.new
sitting.start_first_round