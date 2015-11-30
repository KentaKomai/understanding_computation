
require './dtm_rulebook'
require './tm_rule'
require './tape'
require './dtm'
require './tm_configuration'

def increment_rules(start_state, return_state)
  incrementing = start_state
  finishing = Object.new
  finished = return_state

  [
    TMRule.new(incrementing, '0', finishing,    '1', :right),
    TMRule.new(incrementing, '1', incrementing, '0', :left),
    TMRule.new(incrementing, '_', finishing,    '1', :right),
    TMRule.new(finishing,    '0', finishing,    '0', :right),
    TMRule.new(finishing,    '1', finishing,    '1', :right),
    TMRule.new(finishing,    '_', finished,     '_', :left)
  ]
end

added_zero, added_one, added_two, added_three = 0,1,2,3
rulebook = DTMRulebook.new(
  increment_rules(added_zero, added_one) +
    increment_rules(added_one, added_two) +
    increment_rules(added_two, added_three)
)

p rulebook.rules.length
tape = Tape.new(['1', '0', '1'], '1', [], '_')   # b(1011) = 11
dtm = DTM.new(TMConfiguration.new(added_zero, tape), [added_three], rulebook)
dtm.run
p dtm.accepting?
p dtm.current_configuration.tape # b(1011) + b(0011) = b(1110) = 14
