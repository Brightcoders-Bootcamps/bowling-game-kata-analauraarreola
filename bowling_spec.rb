require 'spec_helper'
require 'turn'
# Assertions are called expectations
# describe
# it 
# context

  describe Turn do
    it 'returns Strike when you knock 10 pins in one turn' do
        turn = Turn.new
        turn.name.should == 10 
   end
end
