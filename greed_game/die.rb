# frozen_string_literal: true

class Die
  attr_reader :value

  def initialize
    @value = nil
  end

  def roll
    @value = rand(1..6)
  end

  def unroll
    @value = nil
  end
end
