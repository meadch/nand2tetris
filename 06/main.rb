require_relative 'assembler'
require_relative 'parser'
require_relative 'symbol_table'

file = ARGV[0]
parser = Parser.new file
symbol_table = SymbolTable.new
assembler = Assembler.new file
assembler.assemble parser, symbol_table
