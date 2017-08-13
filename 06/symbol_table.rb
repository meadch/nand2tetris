class SymbolTable
  def initialize
    @RAM_location = 16
    @table = initialize_table
  end

  def add_entry(symbol)
    @table[symbol.to_sym] = @RAM_location
    @RAM_location += 1
  end

  def contains(symbol)
    !@table[symbol.to_sym].nil?
  end

  def get_address(symbol)
    @table[symbol.to_sym]
  end

  private

  def initialize_table
    table = {
      SP: 0,
      LCL: 1,
      ARG: 2,
      THIS: 3,
      THAT: 4,
      SCREEN: 16_364,
      KBD: 24_576
    }

    (0..15).each do |location|
      table["R#{location}".to_sym] = location
    end

    table
  end
end
