
require './pattern'

pattern = Repeat.new(
  Choose.new(
    Concatenate.new(Literal.new('a'), Literal.new('b')),
    Literal.new('a')
  )
)
p pattern


nfa_design = Empty.new.to_nfa_design
p nfa_design
p nfa_design.accepts?('')
p nfa_design.accepts?('a')


p '------------------------------'
nfa_design = Literal.new('a').to_nfa_design
p nfa_design.accepts?('')
p nfa_design.accepts?('a')
p nfa_design.accepts?('b')


p '------------------------------'
p Empty.new.matches? 'a'
p Literal.new('a').matches?('a')


p '------------------------------'
lit1 = Literal.new('a')
lit2 = Literal.new('b')
p lit1.matches?('a')
p lit2.matches?('b')
pattern = Concatenate.new(lit1, lit2)
p pattern.matches?('a')
p pattern.matches?('ab')
p pattern.matches?('abc')

p '------------------------------'
pattern = Choose.new(Literal.new('a'), Literal.new('b'))
p pattern.matches? 'a'
p pattern.matches? 'b'
p pattern.matches? 'c'

p '------------------------------'
pattern = Repeat.new(Literal.new('a'))
p pattern
p pattern.matches? ''
p pattern.matches? 'a'
p pattern.matches? 'aaaa'
p pattern.matches? 'b'
