require_relative '../lib/ejercito'

describe 'tests for Ejercitos' do
  describe 'tests army\'s creation' do
    it 'should create successfully an army if Civilization is valid' do
      expect { Ejercito.new :Chinos }.not_to raise_exception
      expect { Ejercito.new :Ingleses }.not_to raise_exception
      expect { Ejercito.new :Bizantinos }.not_to raise_exception
      expect { Ejercito.new 'civilization' }.to raise_exception(ArgumentError, 'Civilizacion invalida')  
    end

    it 'should create Chinos army with correct amount and type of units' do
      ejercito = Ejercito.new :Chinos
      unidades = ejercito.cantidad_unidades
      expect( unidades[:piqueros] ).to equal(2)
      expect( unidades[:arqueros] ).to equal(25)
      expect( unidades[:caballeros] ).to equal(2)
    end

    it 'should create Ingleses army with correct amount and type of units' do
      ejercito = Ejercito.new :Ingleses
      unidades = ejercito.cantidad_unidades
      expect( unidades[:piqueros] ).to equal(10)
      expect( unidades[:arqueros] ).to equal(10)
      expect( unidades[:caballeros] ).to equal(10)
    end

    it 'should create Bizantinos army with correct amount and type of units' do
      ejercito = Ejercito.new :Bizantinos
      unidades = ejercito.cantidad_unidades
      expect( unidades[:piqueros] ).to equal(5)
      expect( unidades[:arqueros] ).to equal(8)
      expect( unidades[:caballeros] ).to equal(15)
    end

    it 'should create armies with correct amount of coins' do
      ejercito1 = Ejercito.new :Bizantinos
      ejercito2 = Ejercito.new :Chinos
      ejercito3 = Ejercito.new :Ingleses
      expect( ejercito1.monedas ).to equal(1000)
      expect( ejercito2.monedas ).to equal(1000)
      expect( ejercito3.monedas ).to equal(1000)
    end

    it 'can get strength points for an army' do
      ejercito = Ejercito.new :Ingleses
      expect( ejercito ).to respond_to(:puntos_de_fuerza)
    end

    it 'should get correct strength points for an army' do
      ejercito = Ejercito.new :Ingleses
      expect( ejercito.puntos_de_fuerza ).to equal(350)
    end
  end

  describe 'tests transform of armies units' do
    it 'should raise error when the army does not have unit of type that is requesting to transform' do
      ejercito = Ejercito.new :Chinos
      cantidad_piqueros = ejercito.unidades.select {|unidad| unidad.tipo === :piquero}.count
      cantidad_piqueros.times { ejercito.transformar_unidad :piquero }

      expect( ejercito.unidades.select {|unidad| unidad.tipo === :piquero}.count ).to equal(0)
      expect{ ejercito.transformar_unidad :piquero }.to raise_exception( ArgumentError, 'No hay unidades de este tipo en el ejercito' )
    end

    it 'should raise error when the army does not have unit of type that is requesting to train' do
      ejercito = Ejercito.new :Chinos
      cantidad_piqueros = ejercito.unidades.select {|unidad| unidad.tipo === :piquero}.count
      cantidad_piqueros.times { ejercito.transformar_unidad :piquero }

      expect( ejercito.unidades.select {|unidad| unidad.tipo === :piquero}.count ).to equal(0)
      expect{ ejercito.entrenar_unidad :piquero }.to raise_exception( ArgumentError, 'No hay unidades de este tipo en el ejercito' )
    end
  end
end