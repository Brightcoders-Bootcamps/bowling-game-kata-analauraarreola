# frozen_string_literal: true

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
end
