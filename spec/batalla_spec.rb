require_relative '../lib/batalla'
require_relative '../lib/ejercito'

describe 'tests battles' do
  it 'tests that armies can not battle without a rival' do
    ejercito1 = Ejercito.new :Ingleses
    expect { ejercito1.batallar }.to raise_exception ArgumentError
  end

  it 'tests that armies can battle against a rival' do
    ejercito1 = Ejercito.new :Ingleses
    ejercito2 = Ejercito.new :Chinos
    expect { ejercito1.batallar ejercito2 }.not_to raise_exception
  end

  it 'tests that battles are added to armies historical battles' do
    ejercito1 = Ejercito.new :Ingleses
    ejercito2 = Ejercito.new :Chinos
    expect( ejercito1.batallas.count ).to equal(0)
    expect( ejercito2.batallas.count ).to equal(0)

    ejercito1.batallar ejercito2

    expect( ejercito1.batallas.count ).to equal(1)
    expect( ejercito2.batallas.count ).to equal(1)
  end

  it 'tests that battles for both contenders are the same' do
    ejercito1 = Ejercito.new :Ingleses
    ejercito2 = Ejercito.new :Chinos

    ejercito1.batallar ejercito2

    expect( ejercito1.batallas.first ).to eq( ejercito2.batallas.first )
  end

  it 'tests that battle contenders can be accessed from the battle' do
    ejercito1 = Ejercito.new :Ingleses
    ejercito2 = Ejercito.new :Chinos

    ejercito1.batallar ejercito2
    batalla = ejercito1.batallas.first

    expect( batalla.atacante ).to be_instance_of Ejercito
    expect( batalla.defensor ).to be_instance_of Ejercito
    expect( batalla.ganador ).to be_instance_of Ejercito
    expect( batalla.perdedor ).to be_instance_of Ejercito
  end

  it 'tests correct battle results for attacker stronger than defender' do
    ejercito1 = Ejercito.new :Ingleses
    ejercito2 = Ejercito.new :Chinos

    ejercito1.batallar ejercito2
    batalla = ejercito1.batallas.first

    expect( batalla.ganador ).to equal ejercito1
    expect( batalla.perdedor ).to equal ejercito2
  end

  it 'tests correct battle results for attacker weaker than defender' do
    ejercito1 = Ejercito.new :Chinos
    ejercito2 = Ejercito.new :Ingleses

    ejercito1.batallar ejercito2
    batalla = ejercito1.batallas.first

    expect( batalla.ganador ).to equal ejercito2
    expect( batalla.perdedor ).to equal ejercito1
  end

  it 'tests that battle has no winner and loser when contenders are equally strong' do
    ejercito1 = Ejercito.new :Chinos
    ejercito2 = Ejercito.new :Chinos

    ejercito1.batallar ejercito2
    batalla = ejercito1.batallas.first

    expect( batalla.ganador ).to equal nil
    expect( batalla.perdedor ).to equal nil
  end

  it 'tests that winner receives 100 gold coins' do
    ejercito1 = Ejercito.new :Ingleses
    ejercito2 = Ejercito.new :Chinos
    initial_coins = ejercito1.monedas

    ejercito1.batallar ejercito2

    expect( ejercito1.monedas ).to eq( initial_coins + 100 )
  end

  it 'tests that the loser of the battle loses his two strongest units' do
    ejercito1 = Ejercito.new :Chinos
    ejercito1.unidades.sort_by(&:puntos_de_fuerza)
    expect( ejercito1.unidades.count ).to equal(29)
    strongest_unit1 = ejercito1.unidades[0]
    strongest_unit2 = ejercito1.unidades[1]

    ejercito2 = Ejercito.new :Ingleses
    ejercito1.batallar ejercito2

    expect( ejercito1.unidades.count ).to equal(27)
    expect( ejercito1.unidades ).not_to include strongest_unit1, strongest_unit2
  end

  it 'tests that in case of a draw both armies lose their strongest unit' do
    ejercito1 = Ejercito.new :Chinos
    ejercito2 = Ejercito.new :Chinos
    ejercito1.unidades.sort_by(&:puntos_de_fuerza)
    ejercito2.unidades.sort_by(&:puntos_de_fuerza)
    strongest_unit_army1 = ejercito1.unidades[0]
    strongest_unit_army2 = ejercito2.unidades[0]

    ejercito1.batallar ejercito2

    expect( ejercito1.unidades ).not_to include strongest_unit_army1
    expect( ejercito2.unidades ).not_to include strongest_unit_army2
  end
end