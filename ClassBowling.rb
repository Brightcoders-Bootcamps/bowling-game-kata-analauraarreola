# frozen_string_literal: true
class Turn
  def initialize
    @total_pins = 0
    @frames = []
    @current_frame = Frame.new
  end

  def roll(knocked_down_pins)
    @current_frame << knocked_down_pins
    if (@current_frame.done? && @frames.length <= 9) || (@frames.length == 10 && (@frames.last.spare? || @frames.last.strike?)) 
      @frames << @current_frame
	  @current_frame = Frame.new
   end
  end

  def score
   total_pins = 0

  @frames.each.with_index do |actual_frame, index|
   total_pins += actual_frame.score
   
   if actual_frame.strike?
        if @frames[index + 1].strike?
          total_pins += @frames[index + 1].first
          total_pins += @frames[index + 2].first
        else
          total_pins += @frames[index + 1].first 
          total_pins += @frames[index + 1].last
      end
      elsif actual_frame.spare? && index != 9
        total_pins += @frames[index + 1].first
     end
      puts total_pins
  end

    total_pins
 end

  def last_frame?
		@frames.count >= 10
  end
end

class Frame < Array
  def strike?
   length == 1 && spare?
  end

  def spare?
    score == 10
  end

  def score
    reduce(&:+)
    # este metodo te suma el contenido del array
  end

  def done?
   length == 2 || strike? || spare?
  end
end

new_game = Frame.new

print new_game
