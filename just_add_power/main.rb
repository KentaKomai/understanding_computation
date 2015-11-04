require './fa_rule'
require './nfa_rulebook'
require './nfa_design'
require './nfa_simulation'

p '------------------------------'
rulebook = NFARulebook.new(
  [
    FARule.new(0, '(', 1), FARule.new(1, ')', 0),
    FARule.new(1, '(', 2), FARule.new(2, ')', 1),
    FARule.new(2, '(', 3), FARule.new(3, ')', 2)
  ]
)
p rulebook
nfa_design = NFADesign.new(0, [0], rulebook)
p nfa_design
p nfa_design.accepts? '()'
p nfa_design.accepts? '(())'
p nfa_design.accepts? '((()))'
p nfa_design.accepts? '(()'

p nfa_design.accepts? '(((())))'
