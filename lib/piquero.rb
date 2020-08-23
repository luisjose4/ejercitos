require_relative 'tipo_unidad'
require_relative 'arquero'

class Piquero < TipoUnidad
  def initialize
    @puntos_de_fuerza = 5
    @puntos_obtenidos_al_entrenar = 3
    @costo_de_entrenamiento = 10
    @costo_de_transformacion = 30
  end

  def transformar_unidad unidad
    unidad.nuevo_tipo Arquero.new
  end
end
