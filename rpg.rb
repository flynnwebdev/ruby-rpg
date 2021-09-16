module Combat
  attr_reader :attack, :defence

  def combat_setup(attack: 0, defence: 0)
    @attack = attack
    @defence = defence
  end
end

class Character
  attr_reader :name, :race

  def initialize(name, race)
    @name = name
    @race = race
  end
end

class Warrior < Character
  include Combat

  def initialize(name, race)
    super(name, race)
    combat_setup(attack: 5, defence: 5)
  end
end

class Mage < Character
  include Combat

  def initialize(name, race)
    super(name, race)
    combat_setup(attack: 8, defence: 2)
  end
end

class Vendor < Character
  def initialize(name, race)
    super(name, race)
    @goods = []
    @cash = 1000
  end
end

conan = Warrior.new('Conan', 'Human')
galadriel = Mage.new('Galadriel', 'Elf')
grok = Vendor.new('Grok', 'Ogre')

p conan
p galadriel
p grok