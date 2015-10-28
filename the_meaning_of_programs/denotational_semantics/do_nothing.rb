class DoNothing
  def evaluate(environment)
    environment
  end

  def to_ruby
    '-> e { e }'
  end
end