
require_relative './tape.rb'
require_relative './tm_configuration'

class TMRule < Struct.new(:state, :character, :next_state, :write_character, :direction)

  def applies_to?(configuration)
    state == configuration.state && character == configuration.tape.middle
  end

  def follow(configuration)
    TMConfiguration.new(next_state, next_tape(configuration))
  end

  def next_tape(configuration)
    writen_tape = configuration.tape.write(write_character)

    case direction
      when :left
        writen_tape.move_head_left
      when :right
        writen_tape.move_head_right
    end
  end
end