require './tape.rb'
require './tm_configuration'
require './tm_rule'
require './dtm_rulebook'
require './dtm'

tape = Tape.new(['1','0','1'], '1', [], '_')
p tape
p tape.middle

tape = tape.move_head_left
p tape

tape = tape.move_head_right
p tape

tape = tape.move_head_right.write('0')
p tape

rulebook = DTMRulebook.new(
  [
    TMRule.new(1, '0', 2, '1', :right),
    TMRule.new(1, '1', 1, '0', :left),
    TMRule.new(1, '_', 2, '1', :right),
    TMRule.new(2, '0', 2, '0', :right),
    TMRule.new(2, '1', 2, '1', :right),
    TMRule.new(2, '_', 3, '_', :left)
  ]
)
p rulebook

tape = Tape.new(['1','0','1'], '1', [], '_')
configuration = TMConfiguration.new(1, tape)
p configuration
configuration = rulebook.next_configuration(configuration)
p configuration
configuration = rulebook.next_configuration(configuration)
p configuration
configuration = rulebook.next_configuration(configuration)
p configuration


dtm = DTM.new(TMConfiguration.new(1, tape), [3], rulebook)
p dtm
p dtm.current_configuration
p dtm.accepting?
dtm.step
p dtm.current_configuration
p dtm.accepting?
p dtm.run
p dtm.current_configuration
p dtm.accepting?


p "simulation 'Deterministic Turing Machine'"
rulebook = DTMRulebook.new([
    # state 1: search 'a' scan to right
    TMRule.new(1, 'X', 1, 'X', :right),   # skip X
    TMRule.new(1, 'a', 2, 'X', :right),   # delete 'a' and go state 2
    TMRule.new(1, '_', 6, '_', :left),   # when find _ , go state 6
    # state 2: search 'b' scan to right
    TMRule.new(2, 'a', 2, 'a', :right),   # skip 'a'
    TMRule.new(2, 'X', 2, 'X', :right),   # skip 'X'
    TMRule.new(2, 'b', 3, 'X', :right),   # delete 'b' and go state 3
    # state 3: search 'c' scan to right
    TMRule.new(3, 'b', 3, 'b', :right),   # skip 'b'
    TMRule.new(3, 'X', 3, 'X', :right),   # skip 'X'
    TMRule.new(3, 'c', 4, 'X', :right),   # delete 'c' and go state 4
    # state 4: scan string end scan to right
    TMRule.new(4, 'c', 4, 'c', :right),   # skip 'c'
    TMRule.new(4, '_', 5, '_', :left),   # go state 5 when find '_'
    # state 5: find string head scan to left
    TMRule.new(5, 'a', 5, 'a', :left),    # skip 'a'
    TMRule.new(5, 'b', 5, 'b', :left),    # skip 'b'
    TMRule.new(5, 'c', 5, 'c', :left),    # skip 'c'
    TMRule.new(5, 'X', 5, 'X', :left),    # skip 'X'
    TMRule.new(5, '_', 1, '_', :right)    # go state 1 when find '_'
])
tape = Tape.new([], 'a', ['a', 'a', 'b', 'b', 'b', 'c', 'c', 'c'], '_')
dtm = DTM.new(TMConfiguration.new(1, tape), [6], rulebook)

p dtm.current_configuration
dtm.run
p dtm.stuck?
p dtm.current_configuration
p dtm.accepting?

