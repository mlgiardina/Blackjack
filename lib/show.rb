class Show
  def initialize
    @cards = []
    suits = [:hearts, :diamonds, :clubs, :spades]
      7.times do
        suits.each do |suit|
          (2..10).each do |value|
            @cards.push(Card.new(suit, value))
          end
          @cards.push(Card.new(suit, 10.1)) #J
          @cards.push(Card.new(suit, 10.2)) #Q
          @cards.push(Card.new(suit, 10.3)) #K
          @cards.push(Card.new(suit, 11)) #A
        end
      end
    @cards.shuffle!
  end
  def count
    @cards.length
  end
  def draw
    @cards.pop
  end
end
