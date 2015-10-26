class Number < Struct.new(:value)

  def to_s
    values.to_s
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible?
    false
  end

  def evaluate(environment)
    self
  end
end