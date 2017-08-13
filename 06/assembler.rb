require_relative 'code'

class Assembler
  include Code

  def initialize(file_path)
    @output = []
    @output_file_name = generate_file_name(file_path)
  end

  def assemble(parser, symbol_table)
    build_symbol_table! parser, symbol_table
    translate parser, symbol_table
    write_output
  end

  private

  def build_symbol_table!(parser, symbol_table)
    line_num = 0
    while parser.has_more_commands?
      parser.advance
      if parser.command_type == 'L_COMMAND'
        symbol_table.add_entry(parser.symbol, line_num)
      else
        line_num += 1
      end
    end
  end

  def write_output
    File.open("output/#{@output_file_name}", 'w+') do |f|
      f.puts(@output)
    end
  end

  def generate_file_name(path)
    path.split('/').last.split('.').first + '.hack'
  end

  def translate(parser, symbol_table)
    parser.reset
    @RAMlocation = 16
    while parser.has_more_commands?
      parser.advance
      type = parser.command_type
      if type == 'A_COMMAND'
        @output << a_command(parser, symbol_table)
      elsif type == 'C_COMMAND'
        @output << c_command(parser)
      end
    end
  end

  def a_command(parser, symbol_table)
    mem_location = find_mem_location parser.symbol, symbol_table
    command = mem_location.to_s(2)
    command.prepend('0') until command.length >= 16
    command
  end

  def find_mem_location(symbol, table)
    return symbol.to_i if is_positive_integer?(symbol)
    return table.get_address(symbol) if table.contains?(symbol)
    current_location = @RAMlocation
    @RAMlocation += 1
    table.add_entry(symbol, current_location)
    current_location
  end

  def c_command(parser)
    '111' + comp(parser.comp) + dest(parser.dest) + jump(parser.jump)
  end
end
