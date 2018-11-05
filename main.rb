require_relative "parser"


parser = Parser.new

puts "Entrada: "
arbol = parser.parse gets

puts
puts "Forma prefija"
puts arbol.prefijo
puts "Forma infija"
puts arbol.infijo
puts "Forma postfija"
puts arbol.postfijo
puts

puts "Evaluacion"
puts arbol.evaluar
puts
