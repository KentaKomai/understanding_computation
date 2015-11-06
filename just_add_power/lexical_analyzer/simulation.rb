
require './stack'
require './pda_rule'
require './pda_configuration'
require './dpda_rulebook'
require './dpda'
require './dpda_design'

require './npda'
require './npda_rulebook'
require './npda_design'

require './lexical_analyzer'

p '------------------------------'

p LexicalAnalyzer.new('y = x * 7').analyze
