require_relative "entradaParser"
require_relative "evaluador"
require_relative "arbol"


# toma un string con una expresion matematica y regresa un arbol binario
class Parser

  def initialize
    @evaluadores_ignorados = []
    # EVALUADORES A IGNORAR

    # ignora espacios en blanco
    @evaluadores_ignorados.push Evaluador.new " "

    # EVALUADORES

    #evaluador para operadores
    @operador = Evaluador.new "[\\+\\-\\*\\/^]"

    #evaluador para numeros
    @literal_numerica = Evaluador.new "\\d(\\.\\d)*"
    #evaluador para variables (empieza con letra o _ y pueden tener letras,numeros y _ en el nombre)
    @variable = Evaluador.new "[a-zA-Z_](\\w)*"

  end

  def parse(entrada)
    # limpia la variable de instancia arbol
    @arbol = nil
    # crea un objeto entrada_parser con el string que recibe el metodo parse
    entrada_parser = EntradaParser.new entrada
    # le pasa los evaluadores a ignorar del parser al objeto entrada_parser
    entrada_parser.agregar_evaluadores_ignorados *@evaluadores_ignorados

    self.buscar_operando(entrada_parser)
    begin
      self.buscar_operador(entrada_parser)
      self.buscar_operando(entrada_parser)
      # termina cuando la entrada solo tiene 1 character o menos faltantes
    end until entrada_parser.string.length <= 1

    return @arbol;
  end

  # espera encontrar un operando al inicio de la entrada
  def buscar_operador(entrada)
    # si encuentra un operando, lo regresa a operador y lo elimina de la entrada, si no regresa nil.
    operador = @operador.evaluar(entrada)
    # si operador esta vacio, levanta excepcion.
    raise "operador faltante o invalido" unless operador
    # crea un subarbol con operador como raiz y lo manda a agregar_nodo.
    agregar_nodo(Arbol.new(operador,:operador))
  end

  # espera encontrar un operando al inicio de la entrada
  def buscar_operando(entrada)
    # si encuentra un operando, lo regresa a operando y lo elimina de la entrada, si no regresa nil.
    operando =  @literal_numerica.evaluar(entrada) || @variable.evaluar(entrada)
    # si operando esta vacio, levanta excepcion.
    raise "operando  faltante o invalido" unless operando
    # crea un subarbol con operando como raiz y lo manda a agregar_nodo.
    agregar_nodo(Arbol.new(operando,:operando))
  end

  def agregar_nodo(nodo)
    # si @arbol no existe, asigna nodo a @arbol
    return @arbol = nodo unless @arbol
    # agrega nodo a arbol
    @arbol.agregar_nodo(nodo)
  end
end
