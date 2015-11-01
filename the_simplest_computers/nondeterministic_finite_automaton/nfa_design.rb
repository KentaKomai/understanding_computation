
require './nfa'

class NFADesign < Struct.new(:start_state, :accept_states, :rulebook)

  def to_dfa
    NFA.new(start_state, accept_states, rulebook)
  end

  def accepts?(string)
    to_dfa.tap { |dfa| dfa.read_string(string) }.accepting?
  end
end