require 'proc_buffer/version'

# TODO: Documentation
# ProcBuffer
class ProcBuffer
  include Enumerable

  def initialize(*actions)
    # For now we will not handle actions that do not respond to #call
    @actions = actions.select { |action| action.respond_to?(:call) }
  end

  def actions
    @actions.dup
  end

  def each
    @actions.each { |action| yield action }
  end

  def run
    map(&:call)
  end

  def reverse_run
    @actions.reverse.map { |action| call(action) }
  end

  def append(&block)
    @actions << block
  end

  alias push append

  def pop(n = nil)
    return @actions.pop.call unless n
    (1..n).map { @actions.pop.call }
  end
end

