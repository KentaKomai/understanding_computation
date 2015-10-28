require './if'
require './sequence'

class While < Struct.new(:condition, :body)
  def to_s
    "while (#{condition}) { #{body} }"
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible?
    true
  end

  def evaluate(environment)
    case condition.evaluate(environment)
      when Boolean.new(true)
        evaluate(body.evaluate(environment))
      when Boolean.new(false)
        environment
    end
  end

  def to_ruby
    "-> e {" +
      "while (#{condition.to_ruby}).call(e); e = (#{body.to_ruby}).call(e); end;" +
      "e" +
      "}"
  end
end