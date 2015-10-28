require './boolean'

class If < Struct.new(:condition, :consequence, :alternative)
  def to_s
    "if (#{condition}) { #{consequence}} else { #{alternative} }"
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
        consequence.evaluate(environment)
      when Boolean.new(false)
        alternative.evaluate(environment)
    end
  end

  def to_ruby
    "-> e { if (#{condition.to_ruby}).call(e)}" +
      " then (#{consequence.to_ruby}).call(e)" +
      " else (#{alternative.to_ruby}).call(e)" +
      'end }'
  end
end