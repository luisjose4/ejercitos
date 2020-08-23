class TipoUnidad
  def initialize
    @puntos_de_fuerza
    @puntos_obtenidos_al_entrenar
    @costo_de_entrenamiento
    @costo_de_transformacion
  end

  attr_reader :puntos_de_fuerza, :puntos_obtenidos_al_entrenar, :costo_de_entrenamiento, :costo_de_transformacion

  def transformar_unidad unidad
    raise ArgumentError, 'La unidad no puede ser transformada'
  end
end