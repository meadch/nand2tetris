class Code
  def dest(string = '')
    dest = '000'
    dest[0] = '1' if string.include? 'A'
    dest[1] = '1' if string.include? 'D'
    dest[2] = '1' if string.include? 'M'
    dest
  end

  def comp(string)
    a_bit = (string.include?('M')) ? '1' : '0'
    c_bits = case string
              when '0'
                '101010'
              when '1'
                '111111'
              when '-1'
                '111010'
              when 'D'
                '001100'
              when 'A', 'M'
                '110000'
              when '!D'
                '001101'
              when '!A', '!M'
                '110001'
              when '-D'
                '001111'
              when '-A', '-M'
                '110011'
              when 'D+1'
                '011111'
              when 'A+1', 'M+1'
                '110111'
              when 'D-1'
                '001110'
              when 'A-1', 'M-1'
                '110010'
              when 'D+A', 'D+M'
                '000010'
              when 'D-A', 'D-M'
                '010011'
              when 'A-D', 'M-D'
                '000111'
              when 'D&A', 'D&M'
                '000000'
              when 'D|A', 'D|M'
                '010101'
             end
    a_bit + c_bits
  end

  def jump(string = nil)
    case string
      when nil
        '000'
      when 'JGT'
        '001'
      when 'JEQ'
        '010'
      when 'JGE'
        '011'
      when 'JLT'
        '100'
      when 'JNE'
        '101'
      when 'JLE'
        '110'
      when 'JMP'
        '111'
    end
  end
end
