class Evaluador

  attr_reader :regexp

  def initialize(regexp_string)
    # agrega modificador \A a expresion regular para que solo evalue si la expresion esta al inicio de cadena
    regexp_string_solo_inicio = "\\A" + regexp_string
    # crea objeto en base a cadena con expresion regular
    @regexp = Regexp.new regexp_string_solo_inicio
  end

  def evaluar(entrada_parser)
    # evalua entrada con expresion regular
    match_data =  @regexp.match(entrada_parser.string)

    # si encontro resultado...
    if MatchData === match_data
      entrada_parser.matched(match_data)
      return match_data[0]
    end
    return
  end
end
