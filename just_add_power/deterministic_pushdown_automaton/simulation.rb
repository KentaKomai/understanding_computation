
require './stack'
require './pda_rule'
require './pda_configuration'
require './dpda_rulebook'
require './dpda'
require './dpda_design'

stack = Stack.new(['a', 'b', 'c', 'd', 'e'])
p stack
p stack.top
p stack.pop.pop.pop
p stack.push('x').push('y').top
p stack.push('x').push('y').pop.top

rule = PDARule.new(1, '(', 2, '$', ['b', '$'])
p rule

configuration = PDAConfiguration.new(1, Stack.new(['$']))
p configuration
p rule.applies_to?(configuration, '(')
p rule.follow(configuration)

rulebook = DPDARulebook.new(
  [
    PDARule.new(1, '(', 2, '$', ['b', '$']),
    PDARule.new(2, '(', 2, 'b', ['b', 'b']),
    PDARule.new(2, ')', 2, 'b', []),
    PDARule.new(2, nil, 1, '$', ['$'])
  ]
)
p configuration = rulebook.next_configuration(configuration, '(')
p configuration = rulebook.next_configuration(configuration, '(')
p configuration = rulebook.next_configuration(configuration, ')')


p '------------------------------'
dpda = DPDA.new(PDAConfiguration.new(1, Stack.new(['$'])), [1], rulebook)
p dpda.accepting?
dpda.read_string('(()')
p dpda.accepting?
p dpda.current_configuration

p '------------------------------'
dpda_design = DPDADesign.new(1, '$', [1], rulebook)
p dpda_design.accepts?('(())')
p dpda_design.accepts?('(((())))')
p dpda_design.accepts?('(((()))')
p dpda_design.accepts?('()()()(())(()())')
