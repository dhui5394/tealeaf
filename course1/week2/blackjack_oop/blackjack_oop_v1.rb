# player sits down to begin a SESSION
# dealer shuffles a DECK of CARDS to begin a GAME.
# dealer passes CARDS into PLAYER HAND and DEALER HAND.

# Sessions
# - deals CARDS
# - player plays
# - dealer plays
# - compare cards

# DECK
# - create new shuffled

# CARDS

# Player HAND
# - is bust? 
# - is blackjack? 

# Dealer hand
# - is bust? 
# - is blackjack? 
# - is below 17? 

require 'pry'
puts "Welcome to BlackJack."

hui = Session.new

class Session
  attr_accessor :deck, :player_hand, :dealer_hand
  def initialize
    deck = Deck.new
    player_hand = PlayerHand.new
    dealer_hand = DealerHand.new
    puts "Welcome to BlackJack. A new deck has been shuffled with #{cards_left} cards left."
  end
end

class Deck
  attr_accessor :deck
  def initialize
    suits = ['spades', 'hearts', 'clubs', 'diamonds']
    numbers = ['ace', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'jack', 'queen', 'king']
    suits.each do |s|
      numbers.each do |n|
        deck << Card.new(numbers, suits)
      end
    end
    deck.shuffle!
  end

  def pull_a_card
    deck.pop
  end

  def cards_left
    deck.size
  end

end

class Card
  attr_accessor :suit, :number
  def initialize(s,n)
    @suit = s
    @number = n   
  end

  def to_s
    puts "The card has a number of #{number} and a suit of #{suit}."
  end
end

class PlayerHand
  include Playable
  attr_accessor :cards, :name
  def initialize(n)
    @cards = []
    @name = n
  end

end

class DealerHand
  include Playable
  attr_accessor :total, :name
  def initialize
    @cards = []
    @name = "Dealer Dan"
  end
end
  
module Playable
  def total_hand
  end

  def show_hand
    cards.each do |n|
      puts "Hand includes #{n}"
    end
  end

  def add_card
  end
end