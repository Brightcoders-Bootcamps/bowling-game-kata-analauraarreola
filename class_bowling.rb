# frozen_string_literal: true

# This is class constructor
class Turn
  def initialize
    @total_pins = 0
    @frames = []
    @current_frame = Frame.new
  end

  def roll(down_pins)
    @current_frame << down_pins
    if @current_frame.done? && @frames.length <= 9
      @frames << @current_frame
      @current_frame = Frame.new
    end
  end


  def score
    @frames.each.with_index do |actual_frame, index|
      @total_pins += actual_frame.score

      new_score(actual_frame, index)
      puts @total_pins
    end
  end

  def new_score(actual_frame, index)
    if actual_frame.strike?
      @total_pins += rules(index)
      @frames[index + 1].first
    elsif actual_frame.spare? && index != 9
      @total_pins += @frames[index + 1].first
    end
  end

  def rules(index)
    if @frames[index + 1].strike?
      @frames[index + 2].first
    else
      @frames[index + 1].last
    end
  end

  def last_frame?
    @frames.count >= 10
  end
end

# Class new
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

new_game = Turn.new
[5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5].each do |down_pins|
  new_game.roll(down_pins)
end

print new_game.score
