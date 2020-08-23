require_relative 'unidad.rb'
require_relative 'batalla.rb'

class Ejercito
  @@CANTIDAD_EJERCITOS = 0

  def initialize civilizacion
    @monedas = 1000
    @unidades = []
    @batallas = []
    @id = @@CANTIDAD_EJERCITOS
    reclutar_unidades civilizacion
    civilizacion = civilizacion
    @@CANTIDAD_EJERCITOS += 1
  end

  attr_reader :civilizacion, :batallas, :unidades, :id, :monedas

  def puntos_de_fuerza
    @unidades.reduce(0) { |suma, unidad| suma + unidad.puntos_de_fuerza }
  end

  def ganar_monedas_por_victoria cantidad
    @monedas += cantidad
  end

  def perder_una_unidad
    @unidades.sort_by(&:puntos_de_fuerza)
    @unidades.shift
  end

  def perder_dos_unidades
    2.times { perder_una_unidad }
  end

  def entrenar_unidad tipo
    raise_error_tipo_invalido unless tipo_valido? tipo
    entrenar_unidad_valida tipo
  end

  def transformar_unidad tipo
    raise_error_tipo_invalido unless tipo_valido? tipo
    transformar_unidad_valida tipo
  end

  def nueva_unidad tipo
    raise_error_tipo_invalido unless tipo_valido? tipo
    unidad_creada = Unidad.new tipo
    @unidades.unshift(unidad_creada)
    @unidades.sort_by { |unidad| unidad.puntos_de_fuerza }
  end

  def batallar ejercito_rival
    batalla = Batalla.new( self, ejercito_rival )
    agregar_batalla batalla
    ejercito_rival.agregar_batalla batalla
  end

  def agregar_batalla batalla
    @batallas.push batalla
  end

  def cantidad_unidades
    cantidades = Hash.new(0)
    @unidades.each do |unidad|
      cantidades[:piqueros] += 1 if unidad.tipo == :piquero
      cantidades[:arqueros] += 1 if unidad.tipo == :arquero
      cantidades[:caballeros] += 1 if unidad.tipo == :caballero
    end
    cantidades
  end

  private

  def reclutar_unidades civilizacion
    case civilizacion
    when :Chinos then cantidades = { piqueros: 2, arqueros: 25, caballeros: 2 }
    when :Ingleses then cantidades = { piqueros: 10, arqueros: 10, caballeros: 10 }
    when :Bizantinos then cantidades = { piqueros: 5, arqueros: 8, caballeros: 15 }
    else
      raise ArgumentError, 'Civilizacion invalida'
    end
    crear_unidades_iniciales cantidades
  end

  def crear_unidades_iniciales cantidades
    cantidades[:piqueros].times { nueva_unidad :piquero }
    cantidades[:arqueros].times { nueva_unidad :arquero }
    cantidades[:caballeros].times { nueva_unidad :caballero }
  end

  def raise_error_tipo_invalido
    raise ArgumentError, 'Tipo de unidad invalida'
  end

  def raise_error_tipo_inexistente
    raise ArgumentError, 'No hay unidades de este tipo en el ejercito'
  end

  def raise_error_monedas_insuficientes
    raise ArgumentError, 'No hay unidades de este tipo en el ejercito'
  end

  def tipo_valido? tipo
    return [:piquero, :arquero, :caballero].include?( tipo.downcase.to_sym )
  end

  def entrenar_unidad_valida tipo
    unidad = buscar_unidad tipo 
    if !unidad
      raise_error_tipo_inexistente
    elsif @monedas < unidad.costo_de_entrenamiento
      raise_error_monedas_insuficientes
    else
      unidad.entrenar
      restar_monedas unidad.costo_de_entrenamiento
    end
  end
  
  def transformar_unidad_valida tipo
    unidad = buscar_unidad tipo
    if !unidad
      raise_error_tipo_inexistente
    elsif @monedas < unidad.costo_de_entrenamiento
      raise_error_monedas_insuficientes
    else
      unidad.transformar
      restar_monedas unidad.costo_de_transformacion
    end
  end

  def buscar_unidad tipo
    salida = nil
    @unidades.each { |unidad| unidad.tipo === tipo ? salida = unidad : salida ||= nil}
    return salida
  end

  def restar_monedas cantidad
    @monedas -= cantidad
  end
end
