class EmptyExpense

  def description
    "empty"
  end

  def value
    "empty"
  end

  def method_missing(*args, &block)
    self
  end

  def to_ary; []; end
  def to_a; []; end

  def ==(o)
    o.class == self.class
  end
end