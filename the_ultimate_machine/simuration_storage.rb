
require './dtm_rulebook'
require './tm_rule'
require './tape'
require './dtm'
require './tm_configuration'


# copy head character of strings to tail

rulebook = DTMRulebook.new(
  [
    # State 1: read first character from tape
    TMRule.new(1, 'a', 2, 'a', :right),
    TMRule.new(1, 'b', 3, 'b', :right),
    TMRule.new(1, 'c', 4, 'c', :right),
    # State 2: scan to right to search string's tail (remember 'a')
    TMRule.new(2, 'a', 2, 'a', :right), # skip 'a'
    TMRule.new(2, 'b', 2, 'b', :right), # skip 'b'
    TMRule.new(2, 'c', 2, 'c', :right), # skip 'c'
    TMRule.new(2, '_', 5, 'a', :right), # find space and write 'a'
    # State 3: scan to right to search string's tail (remember 'b')
    TMRule.new(3, 'a', 3, 'a', :right), # skip 'a'
    TMRule.new(3, 'b', 3, 'b', :right), # skip 'b'
    TMRule.new(3, 'c', 3, 'c', :right), # skip 'c'
    TMRule.new(3, '_', 5, 'b', :right), # find space and write 'b'
    # State 4: scan to right to search string's tail (remember 'c')
    TMRule.new(4, 'a', 4, 'a', :right), # skip 'a'
    TMRule.new(4, 'b', 4, 'b', :right), # skip 'b'
    TMRule.new(4, 'c', 4, 'c', :right), # skip 'c'
    TMRule.new(4, '_', 5, 'c', :right), # find space and write 'c'
  ]
)

tape = Tape.new([], 'b', ['c', 'b', 'c', 'a'], '_')
dtm = DTM.new(TMConfiguration.new(1, tape), [5], rulebook)
dtm.run
p dtm.current_configuration.tape
