require 'rspec'
require_relative 'turn'
# Assertions are called expectations
# describe
# it 
# context

  describe Turn do
    it 'returns Strike when you knock 10 pins in one turn' do
        turn = Turn.new
        turn.score.expect == 10 
   end
   it 'is strike' do
    turn = Turn.new
    turn.is_strike?.expect == true
   end
end
