
class Sequence < Struct.new(:first, :second)

  def to_s
    "#{first}; #{second}"
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible?
    true
  end

  def evaluate(environment)
    second.evaluate(first.evaluate(environment))
  end

  def to_ruby
    "-> e { (#{second.to_ruby}).call((#{first.to_ruby}).call(e)) }"
  end
end