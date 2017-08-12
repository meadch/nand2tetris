require_relative '../parser'

describe 'Parser' do
  context 'add' do
    before (:each) do
      @parser = Parser.new('add/Add.asm')
    end

    it 'can load the contents of the add file' do
      expect(@parser.valid_lines.count).to eq 6
      expect(@parser.has_more_commands?).to eq true
    end

    it 'can advance to the next command' do
      @parser.advance
      expect(@parser.current_command).to eq '@2'
    end

    it 'can return the correct command type' do
      @parser.advance
      expect(@parser.command_type).to eq 'A_COMMAND'
      @parser.advance
      expect(@parser.command_type).to eq 'C_COMMAND'
    end

    it 'can return the correct symbol' do
      @parser.advance
      expect(@parser.symbol).to eq '2'
    end

    it 'can return the correct destination' do
      @parser.advance
      expect(@parser.dest).to eq nil
      @parser.advance
      expect(@parser.dest).to eq 'D'
    end

    it 'can return the correct comp' do
      @parser.advance
      expect(@parser.comp).to eq nil
      @parser.advance
      expect(@parser.comp).to eq 'A'
      @parser.advance
      @parser.advance
      expect(@parser.comp).to eq 'D+A'
    end

    it 'can return the correct jump' do
      @parser.advance
      expect(@parser.jump).to eq nil
      @parser.advance
      expect(@parser.jump).to eq nil
    end
  end
end
