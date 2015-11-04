class DPDA < Struct.new(:current_configuration, :accept_states, :rulebook)
  def accepting?
    accept_states.include?(current_configuration.state)
  end

  def read_character(character)
    self.current_configuration = rulebook.next_configuration(current_configuration, character)
  end

  def current_configuration
    rulebook.follow_free_moves(super)
  end

  def read_string(string)
    string.chars.each do |character|
      read_character(character)
    end
  end
end