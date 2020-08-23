class Batalla
	def initialize( atacante, defensor )
		@atacante = atacante
		@defensor = defensor
		ejecutar
  end
  
  attr_reader :defensor, :atacante, :ganador, :perdedor

  private
  
	def ejecutar
		definir_resultado
		recompensar
	end

	def definir_resultado
		if @atacante.puntos_de_fuerza > @defensor.puntos_de_fuerza
			gana_atacante
		elsif @defensor.puntos_de_fuerza > @atacante.puntos_de_fuerza
			gana_defensor
		else
			empate
		end
	end

	def gana_atacante
		@ganador = @atacante
		@perdedor = @defensor
	end

	def gana_defensor
		@ganador = @defensor
		@perdedor = @atacante
	end

	def empate
		@ganador = nil
		@perdedor = nil
	end

	def premiar_batalla
		recompensar_ganador
		castigar_perdedor
	end

	def recompensar
		@ganador ? (recompensar_ganador; castigar_perdedor) : castigar_empate
	end

	def recompensar_ganador
		@ganador.ganar_monedas_por_victoria 100
	end

	def castigar_perdedor
		@perdedor.perder_dos_unidades
	end

	def castigar_empate
		@atacante.perder_una_unidad
		@defensor.perder_una_unidad
	end
end