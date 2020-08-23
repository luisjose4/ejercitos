require_relative 'tipo_unidad'

class Caballero < TipoUnidad
  def initialize
    @puntos_de_fuerza = 20
    @puntos_obtenidos_al_entrenar = 10
    @costo_de_entrenamiento = 30
    @costo_de_transformacion = 0
  end
end