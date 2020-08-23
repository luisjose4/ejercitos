require_relative 'tipo_unidad'
require_relative 'caballero'

class Arquero < TipoUnidad
  def initialize
    @puntos_de_fuerza = 10
    @puntos_obtenidos_al_entrenar = 7
    @costo_de_entrenamiento = 20
    @costo_de_transformacion = 40
  end

  def transformar_unidad unidad
    unidad.nuevo_tipo Caballero.new
  end
end