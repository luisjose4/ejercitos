require_relative '../lib/unidad'

describe 'tests for Units' do
  describe 'units creation' do
    it 'should create unit of type Piquero' do
      expect { Unidad.new :piquero }.not_to raise_exception
    end

    it 'should create unit of type Arquero' do
      expect { Unidad.new :arquero }.not_to raise_exception
    end

    it 'should create unit of type Caballero' do
      expect { Unidad.new :caballero }.not_to raise_exception
    end

    it 'should not create units of invalid types' do
      expect { Unidad.new 'aldeano' }.to raise_exception(ArgumentError, 'Tipo de unidad invalido') 
    end

    it 'tests initial values for unit type Piquero' do
      unidad = Unidad.new :piquero
      expect(unidad.puntos_de_fuerza).to equal(5)
      expect(unidad.costo_de_entrenamiento).to equal(10)
      expect(unidad.costo_de_transformacion).to equal(30)
      expect(unidad.puntos_obtenidos_al_entrenar).to equal(3)
      expect(unidad.ejercito_id).to be_instance_of(Integer)
      expect(unidad.tipo).to equal(:piquero)
    end

    it 'tests initial values for unit type Arquero' do
      unidad = Unidad.new :arquero
      expect(unidad.puntos_de_fuerza).to equal(10)
      expect(unidad.costo_de_entrenamiento).to equal(20)
      expect(unidad.costo_de_transformacion).to equal(40)
      expect(unidad.puntos_obtenidos_al_entrenar).to equal(7)
      expect(unidad.ejercito_id).to be_instance_of(Integer)
      expect(unidad.tipo).to equal(:arquero)
    end

    it 'tests initial values for unit type Caballero' do
      unidad = Unidad.new :caballero
      expect(unidad.puntos_de_fuerza).to equal(20)
      expect(unidad.costo_de_entrenamiento).to equal(30)
      expect(unidad.costo_de_transformacion).to equal(0)
      expect(unidad.puntos_obtenidos_al_entrenar).to equal(10)
      expect(unidad.ejercito_id).to be_instance_of(Integer)
      expect(unidad.tipo).to equal(:caballero)
    end
  end

  describe 'units training' do
    describe 'trains all valid unit types once' do
      it 'trains Piquero' do
        unidad = Unidad.new :piquero
        expect { unidad.entrenar }.not_to raise_exception
        expect(unidad.puntos_de_fuerza).to equal(8)
      end

      it 'trains Arquero' do
        unidad = Unidad.new :arquero
        expect { unidad.entrenar }.not_to raise_exception
        expect(unidad.puntos_de_fuerza).to equal(17)

      end

      it 'trains Caballero' do
        unidad = Unidad.new :caballero
        expect { unidad.entrenar }.not_to raise_exception
        expect(unidad.puntos_de_fuerza).to equal(30)
      end
    end

    describe 'trains all valid unit types more than once' do
      it 'trains Piquero' do
        unidad = Unidad.new :piquero
        puntos_iniciales = unidad.puntos_de_fuerza
        expect { 3.times { unidad.entrenar } }.not_to raise_exception
        expect( unidad.puntos_de_fuerza ).to equal( puntos_iniciales + 3*unidad.puntos_obtenidos_al_entrenar )
      end

      it 'trains Arquero' do
        unidad = Unidad.new :arquero
        puntos_iniciales = unidad.puntos_de_fuerza
        expect { 3.times { unidad.entrenar } }.not_to raise_exception
        expect( unidad.puntos_de_fuerza ).to equal( puntos_iniciales + 3*unidad.puntos_obtenidos_al_entrenar )
      end

      it 'trains Caballero' do
        unidad = Unidad.new :caballero
        puntos_iniciales = unidad.puntos_de_fuerza
        expect { 3.times { unidad.entrenar } }.not_to raise_exception
        expect( unidad.puntos_de_fuerza ).to equal( puntos_iniciales + 3*unidad.puntos_obtenidos_al_entrenar )
      end
    end
  end

  describe 'units transformation' do
    it 'tests successful Piquero unit transformation' do
      unidad = Unidad.new :piquero
      expect { unidad.transformar }.not_to raise_exception
      expect( unidad.tipo ).to equal(:arquero)
      expect( unidad.puntos_de_fuerza ).to equal(10)
    end

    it 'tests successful Arquero unit transformation' do
      unidad = Unidad.new :arquero
      expect { unidad.transformar }.not_to raise_exception
      expect( unidad.tipo ).to equal(:caballero)
      expect( unidad.puntos_de_fuerza ).to equal(20)
    end

    it 'tests that Caballero unit can not be trained' do
      unidad = Unidad.new :caballero
      expect { unidad.transformar }.to raise_exception(ArgumentError, 'La unidad no puede ser transformada')
      expect( unidad.tipo ).to equal(:caballero)
    end
  end
end