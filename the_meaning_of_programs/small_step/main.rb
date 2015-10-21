
require './number'
require './add'
require './multiply'

expression = Add.new(
  Multiply.new(Number.new(1), Number.new(2)),
  Multiply.new(Number.new(3), Number.new(4))
)
p expression


number_instance = Number.new(1)
p "number_instance.reducible? : ", number_instance.reducible?

add_expression = Add.new(Number.new(1), Number.new(2))
p "add_expression.redusible? : ", add_expression.reducible?


p "expression reduce loop"

p expression.reducible? # true
expression = expression.reduce
p expression # <<2 + 3 * 4>>

p expression.reducible? # true
expression = expression.reduce
p expression # <<2+12>>

p expression.reducible? # true
expression = expression.reduce
p expression # <<14>>

p expression.reducible? # false
