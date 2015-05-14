require_relative 'player'
require_relative 'deck'
require_relative 'card'
require_relative 'show'

class Blackjack

  def initialize
    @player_one = Player.new
    @dealer = Player.new
    @shoe = Show.new
    @dealer_hand_value = 0
    @player_hand_value = 0
    @player_status = "hit"
    @dealer_status = "hit"
    @dealer_score = 0
    @player_score = 0
    @player_card_count = 0
  end

  def start
    puts "Welcome!\nLet's play Blackjack!"
  end

  def player_draw
    drawn_card = @shoe.draw
    drawn_card_value = drawn_card.value
    if drawn_card_value == 11
      puts "You drew an Ace, how much would you like it to count for? (1 or 11)"
      ace_choice = gets.chomp.to_i
      if ace_choice == 1
        drawn_card_value = 1
      else
        drawn_card_value = 11
      end
    end
    @player_hand_value += drawn_card_value.floor
    @player_card_count += 1

    puts "You drew a " + drawn_card.display + "which puts your hand total at #{@player_hand_value}"
  end

  def dealer_draw
    if @dealer_hand_value < 16
      dealer_card = @shoe.draw
      @dealer_hand_value += dealer_card.value.floor
      puts "Dealer drew a " + dealer_card.dealer_display
    elsif @dealer_hand_value > 21
        puts "Dealer busts! You win!!"
        @player_score += 1
        replay
    else
      puts "Dealer stands at #{@dealer_hand_value}."
      @dealer_status = "stand"
      if @player_hand_value > @dealer_hand_value
        puts "Dealer's total is #{@dealer_hand_value} and your total is #{@player_hand_value}. You win!!"
        @player_score += 1
      elsif @dealer_hand_value == @player_hand_value
        puts "It's a tie! No one wins."
      else
        puts "Dealer's total is #{@dealer_hand_value} and your total is #{@player_hand_value}. You lose!"
        @dealer_score += 1
      end
    end
  end
  def first_draw
    check_shoe
    player_draw
    player_draw
    dealer_draw
    dealer_card = @shoe.draw
    @dealer_hand_value += dealer_card.value.floor
  end

  def check_shoe
    if @shoe.count == 0
      puts "Out of cards! Reshuffling..."
      @shoe = Show.new
      sleep 0.4
      replay
    end
  end

  def replay
    puts "Dealer's score: #{@dealer_score}."
    puts "Your score: #{@player_score}."
    puts "Would you like to play again? (yes or no)"
    replay_choice = gets.chomp.downcase
    if replay_choice == "yes"
      @player_hand_value = 0
      @dealer_hand_value = 0
      @player_status = "hit"
      @dealer_status = "hit"
      # @shoe = Show.new
      @player_card_count = 0
      check_shoe
      start
      first_draw
      subsequent_draws
    else
      puts "Thanks for playing!"
      exit
    end
  end

  def subsequent_draws
    check_shoe
    while @player_status == "hit"
      if @player_hand_value < 21 && @player_card_count >= 6
        puts "Your card count is over 5 and your hand is under 21. You win!!"
        @player_score += 1
        replay
      elsif @dealer_hand_value == 21 && @player_hand_value == 21
        puts "You both have 21! It's a tie!"
        replay
      elsif @dealer_hand_value == 21
        puts "Dealer has 21! Dealer wins!"
        @dealer_score += 1
        replay
      elsif @player_hand_value == 21
        puts "You have 21! You win!!!"
        @player_score += 1
        replay
      elsif @player_hand_value > 21
        puts "You bust! Dealer wins!"
        @dealer_score += 1
        replay
      elsif @dealer_hand_value > 21
        puts "Dealer busts! You win!!"
        @player_score += 1
        replay
      elsif @player_hand_value < 21
        puts "Your hand is at #{@player_hand_value}. Would you like to hit or stand?"
        player_choice = gets.chomp.downcase
        if player_choice == "hit"
          player_draw
        else
          puts "You chose to stand. Your total hand value is #{@player_hand_value}."
          @player_status = "stand"
        end
      end
    end
    while @dealer_status == "hit"
      dealer_draw
    end
  replay
  end
end

game = Blackjack.new
game.start
game.first_draw
game.subsequent_draws
