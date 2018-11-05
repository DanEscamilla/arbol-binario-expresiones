class EntradaParser

  attr_accessor :string

  def initialize(string)
    @string = string
    @ignorados = []
  end

  # agrega evaluadores para eliminar caracteres no deseados
  def agregar_evaluadores_ignorados(*evaluadores)
    @ignorados.insert -1, *evaluadores
  end

  def matched(match_data)
    # se encontro un resultado, eliminalo
    self.eliminar_cadena_encontrada match_data
    #una vez eliminado el resultado, elimina los caracteres a ignorar
    self.eliminar_caracteres_ignorados
  end

  def eliminar_caracteres_ignorados
    @ignorados.each {|ignore_evaluator| ignore_evaluator.evaluar(self) }
  end

  def eliminar_cadena_encontrada(match_data)
    match_data_length = match_data[0].length
    # regresa substring apartir de donde termina la cadena encontrada y el final de la cadena de entrada
    @string = @string[match_data_length..-1]
  end

end
