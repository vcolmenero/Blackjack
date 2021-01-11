

class Player
    attr_accessor :name
    attr_accessor :bankroll
    attr_accessor :hand
    attr_accessor :total
    def initialize name, bankroll, hand, total
      @name = name
      @bankroll = bankroll 
      @hand = []
      @total = total
    end
  end

    human_player = Player.new "Human", 100, [], 0

    the_house = Player.new "The House", 1000, [], 0

 class Card
  attr_accessor :face
  attr_accessor :suit
  attr_accessor :value
  def initialize face, suit, value
	@face = face
	@suit = suit
    @value = value
  end
  def get_card(player)
    new_card = Card.new face, suit, value 
    player.hand << new_card
    player.total = player.total + new_card.value
  end
end

class Deck
    def initialize
	  @faces = [*(2..10), 'Jack', 'Queen', 'King', 'Ace']
	  @suits = ['clubs', 'spades', 'hearts', 'diamonds']
      @cards = []
      @faces.each do |face|
        if face.class == Integer
          value = face
        elsif face == 'Ace'
          value = 11
        else
          value = 10
	  end
	  @suits.each do |suit|
			@cards << Card.new(face, suit, value)
		end
    end
    @cards.shuffle!
    end
    def deal (num, player)
      num.times {@cards.shift.get_card(player)}
      end
    end

  puts "Hey there, what's your name?"
  name = gets.chomp
  puts "\n\nLet's do this, #{name}"
  human_player.name = "#{name}"


loop do
  puts "(d)eal me or (q)uit"
	deal_me = gets.chomp.downcase
		
		if deal_me == "q"
			puts "Bye Bye!"
			break
		else
			
			human_player.hand.clear
			human_player.total = 0
			the_house.hand.clear
			the_house.total = 0

			
			puts "\n\nYour Cards:"
			deck = Deck.new
			deck.deal(2, human_player)
		    puts "First Card: #{human_player.hand[0].face}"
			puts "Second Card: #{human_player.hand[1].face}"

			deck.deal(2, the_house)
			puts "The dealer has one card showing:"
			puts "It's value is: #{the_house.hand[0].face}"

			until human_player.total >= 21 do
				puts "What do you want to do, (h)it or (s)tay?"
				choice = gets.chomp.downcase

				if choice == 'h'
					deck.deal(1, human_player)
					puts "Your new card value is:"
					puts "#{human_player.hand[0].face}"
					puts "The total value in your hand is:"
					puts "#{human_player.total}"
					puts "The dealer has one card showing:"
					puts "The value is: #{the_house.hand[0].face}"
				else
					break
				end
    end
    puts "Your hand has a total value of #{human_player.total}"
		puts "The computer has a hand value of #{the_house.total}"

			if human_player.total <= 21 && the_house.total <= 21
				if human_player.total > the_house.total
					puts "You win!\n\n"

					human_player.bankroll += 10
		      		the_house.bankroll -= 10

				elsif human_player.total < the_house.total
					puts "House wins."

					human_player.bankroll -= 10
					the_house.bankroll += 10

				else
					puts "We have a tied"
                end
                
			elsif human_player.total > 21 && the_house.total <= 21
				puts "You went over 21. House wins!"


				human_player.bankroll -= 10
				the_house.bankroll += 10

			elsif human_player.total <= 21 && the_house.total > 21
				puts "Dealer went over 21. You win!"

				human_player.bankroll += 10
				the_house.bankroll -= 10
			else
				puts "You both went over 21. No one wins this round."
			end
			puts "You now have $#{human_player.bankroll}"
			puts "The dealer now has $#{the_house.bankroll}\n\n"
				if human_player.bankroll <= 0
					puts "Sorry you're out of money, next player"
					break
				else
				puts "Up for another round?"
				end
		end
	end

  
