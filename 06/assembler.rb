require_relative 'code'

class Assembler
  include Code

  def initialize(file_path, parser)
    @output = []
    assemble parser
    @output_file_name = generate_file_name(file_path)
  end

  def write_output
    File.open(@output_file_name, 'w+') do |f|
      f.puts(@output)
    end
  end

  private

  def generate_file_name(path)
    path.split('/').last.split('.').first + '.hack'
  end

  def assemble(parser)
    while parser.has_more_commands?
      parser.advance
      type = parser.command_type
      if type == 'A_COMMAND'
        @output << a_command(parser)
      elsif type == 'C_COMMAND'
        @output << c_command(parser)
      end
    end
  end

  def a_command(parser)
    command = parser.symbol.to_i.to_s(2)
    command.prepend('0') until command.length >= 16
    command
  end

  def c_command(parser)
    '111' + comp(parser.comp) + dest(parser.dest) + jump(parser.jump)
  end
end
