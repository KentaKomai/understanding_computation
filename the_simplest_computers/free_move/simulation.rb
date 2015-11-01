
require 'set'

require './fa_rule'
require './nfa_rulebook'
require './nfa'
require './nfa_design'


p '------------------------------'
rulebook = NFARulebook.new(
  [
    FARule.new(1, 'a', 1), FARule.new(1, 'b', 1), FARule.new(1, 'b' ,2),
    FARule.new(2, 'a', 3), FARule.new(2, 'b', 3),
    FARule.new(3, 'a', 4), FARule.new(3, 'b', 4)
  ]
)
p rulebook.next_states(Set[1], 'b')
p rulebook.next_states(Set[1, 2], 'a')
p rulebook.next_states(Set[1, 3], 'b')


p '------------------------------'
nfa = NFA.new(Set[1], [4], rulebook)
p nfa.accepting?
nfa = NFA.new(Set[1, 2,4], [4], rulebook)
p nfa.accepting?

p '------------------------------'
nfa = NFA.new(Set[1], [4], rulebook)
p nfa.accepting?
nfa.read_character('b')
p nfa.accepting?
nfa.read_character('a')
p nfa.accepting?
nfa.read_character('b')
p nfa.accepting?

nfa = NFA.new(Set[1], [4], rulebook)
p nfa.accepting?
nfa.read_string('bbbbb')
p nfa.accepting?

p '------------------------------'
nfa_design = NFADesign.new(Set[1], [4], rulebook)
p nfa_design.accepts?('bab')
p nfa_design.accepts?('bbbb')
p nfa_design.accepts?('bbabb')


p '------------------------------'
rulebook = NFARulebook.new(
  [
    FARule.new(1, nil, 2), FARule.new(1, nil, 4),
    FARule.new(2, 'a', 3),
    FARule.new(3, 'a', 2),
    FARule.new(4, 'a', 5),
    FARule.new(5, 'a', 6),
    FARule.new(6, 'a', 4)
  ]
)

p rulebook.follow_free_moves(Set[1])

p '------------------------------'
nfa_design = NFADesign.new(Set[1], [2,4], rulebook)
p nfa_design.rulebook.rules
p nfa_design.accepts?('aa')
p nfa_design.accepts?('aaa')
p nfa_design.accepts?('aaaaa')
p nfa_design.accepts?('aaaaaa')
