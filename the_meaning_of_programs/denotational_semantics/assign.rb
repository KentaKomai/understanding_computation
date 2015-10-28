class Assign < Struct.new(:name, :expression)
  def to_s
    "#{name} = #{expression}"
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible?
    true
  end

  def evaluate(environment)
    environment.merge({name => expression.evaluate(environment)})
  end

  def to_ruby
    "-> e { e.merge({ #{name.inspect} => (#{expression.to_ruby}).call(e) }) }"
  end
end