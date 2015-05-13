require_relative 'player'
require_relative 'deck'
require_relative 'card'

class Blackjack

  def initialize
    @player_one = Player.new
    @dealer = Player.new
    @deck = Deck.new
    @player_one_name = "You"
    @dealer_name = "Dealer"
    @dealer_hand_value = 0
    @player_hand_value = 0
  end

  def start
    puts "Let's play Blackjack!"
  end

  def first_draw

    drawn_card = @deck.draw
    drawn_card_value = drawn_card.value
    @player_hand_value += drawn_card_value.floor

    puts "You drew a " + drawn_card.display + "which puts your hand total at #{@player_hand_value}"

    drawn_card = @deck.draw
    drawn_card_value = drawn_card.value
    @player_hand_value += drawn_card_value.floor

    puts "You drew a " + drawn_card.display + "which puts your hand total at #{@player_hand_value}"

    dealer_card = @deck.draw
    @dealer_hand_value += dealer_card.value.floor
    puts "Dealer drew a " + dealer_card.dealer_display

  end

  def subsequent_draws
    if @dealer_hand_value == 21
      puts "Dealer has Blackjack! Dealer wins!"
      exit
    elsif @player_hand_value == 21
      puts "You have Blackjack! You win!!!"
      exit
    elsif @player_hand_value > 21
      puts "You bust! Dealer wins!"
    elsif @dealer_hand_value > 21
      puts "Dealer busts! You win!!"
    end
  end
end
