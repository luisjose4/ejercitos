require_relative 'piquero'
require_relative 'arquero'
require_relative 'caballero'

class Unidad
  @@CANTIDAD_EJERCITOS = 1

  def initialize tipo
    inicializar_tipo tipo
    @ejercito_id = @@CANTIDAD_EJERCITOS
    @@CANTIDAD_EJERCITOS += 1
  end

  attr_reader :puntos_de_fuerza, :ejercito_id

  def nuevo_tipo tipo
    @tipo_unidad = tipo
    refrescar_unidad
  end

  def tipo
    @tipo_unidad.class.to_s.downcase.to_sym
  end

  def entrenar
    @puntos_de_fuerza += @tipo_unidad.puntos_obtenidos_al_entrenar
  end

  def transformar
    @tipo_unidad.transformar_unidad self
  end

  def costo_de_entrenamiento
    @tipo_unidad.costo_de_entrenamiento
  end

  def costo_de_transformacion
    @tipo_unidad.costo_de_transformacion
  end

  def puntos_obtenidos_al_entrenar
    @tipo_unidad.puntos_obtenidos_al_entrenar
  end

  private
  def inicializar_tipo tipo
    case tipo
    when :piquero then nuevo_tipo Piquero.new
    when :arquero then nuevo_tipo Arquero.new
    when :caballero then nuevo_tipo Caballero.new
    else
      raise ArgumentError, 'Tipo de unidad invalido'
    end 
  end

  def refrescar_unidad
    @puntos_de_fuerza = @tipo_unidad.puntos_de_fuerza
  end
end