# ===== Dave BlackJack OOP =====
require "rubygems"
# require 'pry'

class Card
  attr_accessor :suit, :number

  def initialize(s,n)
    @suit = s
    @number = n   
  end

  def to_s
    puts "The #{number} of #{suit}."
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

    numbers_only_array.select {|k| k == "ace"}.count.times do
      total -= 10 if total > 21   
    end

    total
  end

  end

  def show_hand
    cards.each do |n|
      puts "Hand includes #{n}"
    end
  end

  def add_card
    cards << deck.pop
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
  attr_accessor :total, :name

  def initialize
    @cards = []
    @name = "Dealer Dan"
  end
end

class BlackJackSitting
  attr_accessor :player_hand, :dealer_hand, :deck
  def initialize
    @deck = Deck.new
    @player_hand = PlayerHand.new
    @dealer_hand = DealerHand.new
  end

  def aquire_player_name
    puts "="*70
    puts "Welcome to BlackJack. A shuffled deck has #{deck.cards_left} cards left."
    puts ""
    puts "What is your name?"
    name = gets.chomp
  end

  def deal_cards
  end

  def run_player_cards
  end

  def run_dealer_cards
  end 

  def compare_cards
  end

  def play_again
  end

  def start
    aquire_player_name
    deal_cards
    run_player_cards
    run_dealer_cards
    compare_cards
    play_again
  end
end
  
first_sitting = BlackJackSitting.new
first_sitting.start