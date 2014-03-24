require 'rubygems'
require 'sinatra'

set :sessions, true

BLACKJACK_NUMBER = 21
DEALER_MIN_NUMBER = 17

helpers do

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
      total -= 10 if total > BLACKJACK_NUMBER   
    end

    total
  end

  def player_wins!(message)
    @success = "<strong>#{message}</strong> #{session[:player_name]} has #{calc_hand_total(session[:player_cards])}. Dealer has #{calc_hand_total(session[:dealer_cards])}"
    @play_again = true
  end

  def player_loses!(message)
    @error = "<strong>#{message}</strong> #{session[:player_name]} has #{calc_hand_total(session[:player_cards])}. Dealer has #{calc_hand_total(session[:dealer_cards])}"
    @play_again = true
  end

  def player_ties!(message)
    @success = "<strong>#{message}</strong> #{session[:player_name]} has #{calc_hand_total(session[:player_cards])}. Dealer has #{calc_hand_total(session[:dealer_cards])}"
    @play_again = true
  end
end

before do
  @show_hit_or_stay_option = true
  @show_dealer_playing_cards = false
  @play_again = false
end

get '/' do
  if session[:player_name]
    redirect '/play_game'
  else
    redirect '/set_player_name'
  end 
end

get '/set_player_name' do
  erb :set_player_name
end

post '/set_player_name' do
  if params[:player_name].empty?
    @error = "Please enter your name."
    halt erb(:set_player_name)
  end
  session[:player_name] = params[:player_name]
  redirect '/play_game'
end

get '/play_game' do

  # ==== Create a shuffled deck with 52 unique cards ====
  numbers = ['ace','2','3','4','5','6','7','8','9','10',"jack","queen","king"]
  suits = ['spades','clubs', 'hearts', 'diamonds']
  session[:deck] = numbers.product(suits).shuffle!

  # ==== Create starting player hand and dealer hand and respective totals ====
  session[:player_hand_total] = 0
  session[:dealer_hand_total] = 0
  session[:player_cards] = []
  session[:dealer_cards] =[]

  # ==== Deal the Cards ====
  session[:player_cards] << session[:deck].pop
  session[:dealer_cards] << session[:deck].pop 
  session[:player_cards] << session[:deck].pop
  session[:dealer_cards] << session[:deck].pop

  # ==== Check is player happens to start with a blackjack ====
  if calc_hand_total(session[:player_cards]) == BLACKJACK_NUMBER
    @show_hit_or_stay_option = false
    player_wins!(session[:player_name] + " hit BLACKJACK!")
  end

  erb :play_game
end

post '/play_game/player/hit' do
  session[:player_cards] << session[:deck].pop

  if calc_hand_total(session[:player_cards]) > BLACKJACK_NUMBER
    @show_hit_or_stay_option = false
    player_loses!(session[:player_name] + " BUSTED.")
  elsif calc_hand_total(session[:player_cards]) == BLACKJACK_NUMBER
    @show_hit_or_stay_option = false
    player_wins!(session[:player_name] + " hit BLACKJACK!")
  end
    
  erb :play_game
end

post '/play_game/player/stay' do
  @show_hit_or_stay_option = false
  @player_chose_to_stay = session[:player_name] + " chose to stay."
  @show_dealer_play_button = true
  erb :play_game
end

post '/play_game/dealer/play' do
  @show_dealer_playing_cards = true 

  if calc_hand_total(session[:dealer_cards]) == BLACKJACK_NUMBER
    player_loses!("Dealer has blackjack!")
  end

  # ==== If the Player Hasn't Busted, Run the Dealer's Hand ====
  while calc_hand_total(session[:dealer_cards]) < DEALER_MIN_NUMBER
    session[:dealer_cards] << session[:deck].pop
    if calc_hand_total(session[:dealer_cards]) > BLACKJACK_NUMBER
      player_wins!("Dealer busts!")
      @show_dealer_play_button = false
    elsif calc_hand_total(session[:dealer_cards]) == BLACKJACK_NUMBER
      player_loses!("Dealer has blackjack!")
      @show_dealer_play_button = false
    end
  end

  # ==== If neither person has blackjacked or busted, compare the hands ====
  if calc_hand_total(session[:dealer_cards]) > DEALER_MIN_NUMBER && calc_hand_total(session[:dealer_cards]) < BLACKJACK_NUMBER
    if calc_hand_total(session[:dealer_cards]) > calc_hand_total(session[:player_cards])
      player_loses!("Dealer wins!")
    elsif calc_hand_total(session[:dealer_cards]) < calc_hand_total(session[:player_cards])
      player_wins!(session[:player_name] + " wins!")
    else
      player_ties!("It's a tie. PUSH!")
    end
  end

  @show_hit_or_stay_option = false
  erb :play_game
end

get '/end_game' do
  erb :end_game
end