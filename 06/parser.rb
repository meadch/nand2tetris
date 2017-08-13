class Parser
  attr_reader :valid_lines, :current_command
  EMPTY_STRING = /^$/
  COMMENT = /^\/\//
  A_COMMAND = /^@/
  C_COMMAND = /(=|;)/
  L_COMMAND = /^\(\.+\)/
  COMP_PATTERN = /=(.+)/

  def initialize(filename)
    @line_num = 0
    @valid_lines = generate_valid_lines(filename)
    @current_command = nil
  end

  def reset
    @line_num = 0
  end

  def has_more_commands?
    @line_num < @valid_lines.count
  end

  def advance
    @current_command = @valid_lines[@line_num] if has_more_commands?
    @line_num += 1
  end

  def command_type
    case @current_command
    when A_COMMAND
      return 'A_COMMAND'
    when C_COMMAND
      return 'C_COMMAND'
    when L_COMMAND
      return 'L_COMMAND'
    end
  end

  def symbol
    return a_symbol if command_type == 'A_COMMAND'
    return l_symbol if command_type == 'L_COMMAND'
  end

  def dest
    return nil unless command_type == 'C_COMMAND'
    return '' unless @current_command.include? '='
    @current_command.split(/=/).first
  end

  def comp
    return nil unless command_type == 'C_COMMAND'
    @current_command.split(/=/).last.split(/;/).first
  end

  def jump
    return nil unless command_type == 'C_COMMAND'
    return nil unless /;(.+)/.match(@current_command)
    @current_command.split(/;/).last
  end

  private

  def a_symbol
    @current_command.tr('@', '')
  end

  def l_symbol
    @current_command.tr('()', '')
  end

  def generate_valid_lines(filename)
    File.open(filename).select do |line|
      line.gsub!(/\s+/, '')
      is_valid_command?(line)
    end
  end

  def is_valid_command?(line)
    return false if line.empty?
    return false if COMMENT.match(line)
    true
  end
end
