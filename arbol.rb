
# se agrega operador ^ a flotantes, sera equivalente a **
class Float
  def ^(op2)
    return self ** op2
  end
end

class Arbol
  attr_accessor :izquierda, :derecha
  attr_reader :valor, :precedencia,:tipo

  def initialize(valor,tipo)
    init(valor,tipo)
  end

  # se inicializan las variables de instancia
  def init(valor,tipo)
    @valor = valor
    @tipo = tipo
    # jerarquia de operadores y operando, entre mas alta la precedencia mas abajo dentro del arbol quedara le nodo.
    if valor=="^"
      @precedencia = 3
    elsif valor == "*" || valor == "/"
      @precedencia = 2
    elsif valor=="+" || valor == "-"
      @precedencia = 1
    else
      # precedencia de operando es la mas alta, pues se espera que siempre termine en las ramas del arbol
      @precedencia = 1000
    end
    @izquierda = @derecha = nil
  end

  # sustituye instancia con otro nodo nuevo, y agrega la instancia al nodo nuevo como hijo
  def remplazar_nodo(nodo)
    temp = Arbol.new(@valor,@tipo)
    temp.izquierda = @izquierda
    temp.derecha = @derecha
    init(nodo.valor,nodo.tipo)
    @izquierda = temp
  end

  # RECORRIDOS

  def infijo
    string = ""
    string += @izquierda.infijo if @izquierda
    string += @valor
    string += @derecha.infijo if @derecha
    return string
  end

  def postfijo
    string = ""
    string += @izquierda.postfijo if @izquierda
    string += @derecha.postfijo if @derecha
    return string += @valor
  end

  def prefijo
    string = ""
    string += @valor
    string += @izquierda.prefijo if @izquierda
    string += @derecha.prefijo if @derecha
    return string
  end

  def agregar_nodo(nodo)
    return false if (nodo.tipo == :operando && @tipo == :operando)

    # si el nodo nuevo tiene menor precedencia, remplaza nodo actual con nuevo nodo y baja nodo actual un nivel.
    if (nodo.precedencia <= @precedencia)
      return remplazar_nodo(nodo)
    end

    return @derecha = nodo unless @derecha
    return @izquierda = nodo unless @izquierda
    return true  if @derecha.agregar_nodo(nodo)
    return true if @izquierda.agregar_nodo(nodo)
    return false
  end

  # evalua la expresion (si la expresion tiene simbolos, les da el valor de 0 a la hora de convertir a flotantes)
  def evaluar
    return @valor.to_f if @tipo == :operando
    operando2 = @derecha.evaluar if @derecha
    operando1 = @izquierda.evaluar if @izquierda
    puts "#{operando1} #{@valor} #{operando2} = #{operando1.send(@valor,operando2)}"
    return operando1.send(@valor,operando2)
  end

end
