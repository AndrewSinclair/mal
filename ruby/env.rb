class Env
  def initialize(outer)
    @outer = outer
    @data = {}
  end

  def set(key, val)
    @data[key] = val
    val
  end

  def find(key)
    val = @data[key]

    if val == nil then
      if @outer != nil then @outer.find(key) else nil end
    else
      self
    end
  end

  def data()
    @data
  end

  def get(key)
    env = self.find(key)
    raise key + " not found error!" if env == nil
    env.data()[key]
  end
end
