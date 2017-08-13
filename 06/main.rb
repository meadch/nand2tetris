require_relative 'assembler'
require_relative 'parser'

parser = Parser.new ARGV[0]
assembler = Assembler.new ARGV[0], parser
assembler.write_output
