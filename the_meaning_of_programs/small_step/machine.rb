require './number'
require './add'
require './multiply'

class Machine < Struct.new(:statement, :environment)
  def step
    self.statement, self.environment = statement.reduce(environment)
  end

  def run
    while statement.reducible?
      puts "statement: #{statement}, environment:#{environment}"
      step
    end
    puts "#{statement}, #{environment}"
  end
end
