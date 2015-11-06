
require './stack'
require './pda_rule'
require './pda_configuration'
require './dpda_rulebook'
require './dpda'
require './dpda_design'

require './npda'
require './npda_rulebook'
require './npda_design'

p '------------------------------'

rulebook = DPDARulebook.new(
  [
    PDARule.new(1, 'a', 2, '$', ['a', '$']),
    PDARule.new(1, 'b', 2, '$', ['b', '$']),
    PDARule.new(2, 'a', 2, 'a', ['a', 'a']),
    PDARule.new(2, 'b', 2, 'b', ['b', 'b']),
    PDARule.new(2, 'a', 2, 'b', []),
    PDARule.new(2, 'b', 2, 'a', []),
    PDARule.new(2, nil, 1, '$', ['$']),
  ]
)
p rulebook
dpda_design = DPDADesign.new(1, '$', [1], rulebook)
p dpda_design.accepts?('ababab')
p dpda_design.accepts?('abababaaab')
p dpda_design.accepts?('bbbbaaabaa')

p '------------------------------'

rulebook = DPDARulebook.new(
  [
    PDARule.new(1, 'a', 1, '$', ['a', '$']),
    PDARule.new(1, 'a', 1, 'a', ['a', 'a']),
    PDARule.new(1, 'a', 1, 'b', ['a', 'b']),
    PDARule.new(1, 'b', 1, '$', ['b', '$']),
    PDARule.new(1, 'b', 1, 'a', ['b', 'a']),
    PDARule.new(1, 'b', 1, 'b', ['b', 'b']),
    PDARule.new(1, 'm', 2, '$', ['$']),
    PDARule.new(1, 'm', 2, 'a', ['a']),
    PDARule.new(1, 'm', 2, 'b', ['b']),
    PDARule.new(2, 'a', 2, 'a', []),
    PDARule.new(2, 'b', 2, 'b', []),
    PDARule.new(2, nil, 3, '$', ['$']),
  ]
)
dpda_design = DPDADesign.new(1, '$', [3], rulebook)
p dpda_design.accepts?('abmba')
p dpda_design.accepts?('babbamabbab')
p dpda_design.accepts?('abmb')
p dpda_design.accepts?('baabmbaa')

p '------------------------------'
rulebook = NPDARulebook.new(
  [
    PDARule.new(1, 'a', 1, '$', %w(a $) ),
    PDARule.new(1, 'a', 1, 'a', %w(a a) ),
    PDARule.new(1, 'a', 1, 'b', %w(a b) ),
    PDARule.new(1, 'b', 1, '$', %w(b $) ),
    PDARule.new(1, 'b', 1, 'a', %w(b a) ),
    PDARule.new(1, 'b', 1, 'b', %w(b b) ),
    PDARule.new(1, nil, 2, '$', ['$']),
    PDARule.new(1, nil, 2, 'a', ['a']),
    PDARule.new(1, nil, 2, 'b', ['b']),
    PDARule.new(2, 'a', 2, 'a', []),
    PDARule.new(2, 'b', 2, 'b', []),
    PDARule.new(2, nil, 3, '$', ['$'])
  ]
)
configuration = PDAConfiguration.new(1, Stack.new(['$']))
npda = NPDA.new(Set[configuration], [3], rulebook)
p npda.accepting?
p npda.current_configurations
npda.read_string('abb')
p npda.accepting?
p npda.current_configurations
npda.read_string('a')
p npda.accepting?
p npda.current_configurations

p '------------------------------'
npda_design = NPDADesign.new(1, '$', [3], rulebook)
p npda_design.accepts?('abba')
p npda_design.accepts?('babbaabbab')
p npda_design.accepts?('abb')
p npda_design.accepts?('baabaa')
