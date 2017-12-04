require 'proc_buffer/version'

# TODO: Documentation
# ProcBuffer
class ProcBuffer
  include Enumerable

  def initialize(*actions)
    @actions = actions
  end

  attr_reader :actions

  def each
    actions.each { |action| yield action }
  end

  def run
    map { |action| call(action) }
  end

  def reverse_run
    actions.reverse.map { |action| call(action) }
  end

  def append(&block)
    actions << block 
  end

  alias push append

  def call(obj)
    obj.respond_to?(:call) ? obj.call : obj
  end

  def pop(n = nil)
    pop = proc do
      actions.last.respond_to?(:call) ? actions.pop.call : actions.pop
    end
    return pop.call unless n
    (1..n).map { pop.call }
  end
end

