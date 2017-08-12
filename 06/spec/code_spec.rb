require_relative '../code'

describe 'Code' do
  before(:each) do
    @code = Object.new
    @code.extend(Code)
  end

  it 'can return the correct dest' do
    expect(@code.dest).to eq '000'
    expect(@code.dest('M')).to eq '001'
    expect(@code.dest('D')).to eq '010'
    expect(@code.dest('MD')).to eq '011'
    expect(@code.dest('A')).to eq '100'
    expect(@code.dest('AM')).to eq '101'
    expect(@code.dest('AD')).to eq '110'
    expect(@code.dest('AMD')).to eq '111'
  end

  it 'can return the correct comp' do
    expect(@code.comp('0')).to eq '0101010'
    expect(@code.comp('1')).to eq '0111111'
    expect(@code.comp('-1')).to eq '0111010'
    expect(@code.comp('D')).to eq '0001100'
    expect(@code.comp('A')).to eq '0110000'
    expect(@code.comp('!D')).to eq '0001101'
    expect(@code.comp('!A')).to eq '0110001'
    expect(@code.comp('-D')).to eq '0001111'
    expect(@code.comp('-A')).to eq '0110011'
    expect(@code.comp('D+1')).to eq '0011111'
    expect(@code.comp('A+1')).to eq '0110111'
    expect(@code.comp('D-1')).to eq '0001110'
    expect(@code.comp('A-1')).to eq '0110010'
    expect(@code.comp('D+A')).to eq '0000010'
    expect(@code.comp('D-A')).to eq '0010011'
    expect(@code.comp('A-D')).to eq '0000111'
    expect(@code.comp('D&A')).to eq '0000000'
    expect(@code.comp('D|A')).to eq '0010101'
    expect(@code.comp('M')).to eq '1110000'
    expect(@code.comp('!M')).to eq '1110001'
    expect(@code.comp('-M')).to eq '1110011'
    expect(@code.comp('M+1')).to eq '1110111'
    expect(@code.comp('M-1')).to eq '1110010'
    expect(@code.comp('D+M')).to eq '1000010'
    expect(@code.comp('D-M')).to eq '1010011'
    expect(@code.comp('M-D')).to eq '1000111'
    expect(@code.comp('D&M')).to eq '1000000'
    expect(@code.comp('D|M')).to eq '1010101'
  end

  it 'can return the correct jump' do
    expect(@code.jump).to eq '000'
    expect(@code.jump('JGT')).to eq '001'
    expect(@code.jump('JEQ')).to eq '010'
    expect(@code.jump('JGE')).to eq '011'
    expect(@code.jump('JLT')).to eq '100'
    expect(@code.jump('JNE')).to eq '101'
    expect(@code.jump('JLE')).to eq '110'
    expect(@code.jump('JMP')).to eq '111'
  end
end
