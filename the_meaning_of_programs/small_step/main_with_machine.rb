require './number'
require './add'
require './multiply'
require './machine'
require './lessthan'
require './boolean'
require './variable'
require './do_nothing'
require './assign'
require './if'
require './sequence'
require './while'


p '------------------------------'
p '1*2 + 3*4'
p '------------------------------'
Machine.new(
  Add.new(
    Multiply.new(Number.new(1), Number.new(2)),
    Multiply.new(Number.new(3), Number.new(4))
  ), {}
).run

p '------------------------------'
p '5 < 2 + 2'
p '------------------------------'
Machine.new(
  LessThan.new(Number.new(5), Add.new(Number.new(2), Number.new(2))),
  {}
).run


=begin
p 'support environment'
Machine.new(
  Add.new(Variable.new(:x), Variable.new(:y)),
  { x:Number.new(3), y:Number.new(4) }
).run
=end

p '------------------------------'
p 'support variable assign'
p '------------------------------'
Machine.new(
  Assign.new(:x, Add.new(Variable.new(:x), Number.new(1))),
  {x: Number.new(2)}
).run

p '------------------------------'
p 'support if statement'
p '------------------------------'
Machine.new(
  If.new(
    Variable.new(:x),
    Assign.new(:y, Number.new(1)),
    Assign.new(:y, Number.new(2))
  ),
  {x: Boolean.new(true)}
).run

Machine.new(
  If.new(
    Variable.new(:x), Assign.new(:y, Number.new(1)), DoNothing.new
  ),
  {x: Boolean.new(false)}
).run

p '------------------------------'
p 'support sequence'
p '------------------------------'
Machine.new(
  Sequence.new(
    Assign.new(:x, Add.new(Number.new(1), Number.new(1))),
    Assign.new(:y, Add.new(Variable.new(:x), Number.new(3)))
  ),
  {}
).run

p '------------------------------'
p 'support while loop'
p '------------------------------'
Machine.new(
  While.new(
    LessThan.new(Variable.new(:x), Number.new(5)),
    Assign.new(:x, Multiply.new(Variable.new(:x), Number.new(3)))
  ),
  {x:Number.new(1)}
).run
