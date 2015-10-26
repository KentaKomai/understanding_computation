require './variable'
require './boolean'

class LessThan < Struct.new(:left, :right)
  def to_s
    "#{left} < #{right}"
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible?
    true
  end

  def evaluate(environment)
    Boolean.new( left.evaluate(environment).value < right.evaluate(environment).value )
  end
end