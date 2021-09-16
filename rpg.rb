module Combat
  attr_reader :attack, :defence
  attr_accessor :health

  def combat_setup(attack: 0, defence: 0)
    @attack = attack
    @defence = defence
    @health = 20
  end

  def dead?
    @health < 1
  end

  def battle(opponent)
    if !opponent.instance_of? Combat
      puts "#{opponent.name} cannot be attacked!"
      return
    end
    puts "#{name} engaged #{opponent.name} in a battle to the death!"
    while !dead? && !opponent.dead?
      # Opponents attack simultaneously during each round
      sleep 2
      damage(opponent)
      opponent.damage(self)
      puts "HEALTH --> #{name}: #{health}\t#{opponent.name}: #{opponent.health}"
    end
    if dead? && opponent.dead?
      puts "#{name} and #{opponent.name} killed each other !!"
    else
      puts "#{dead? ? name : opponent.name} was killed by #{dead? ? opponent.name : name} !!"
    end
  end

  def damage(opponent)
    dmg = (attack + rand(1..6)) - (opponent.defence + rand(1..6))
    print "#{name} attacks #{opponent.name} "
    if dmg > 0
      puts "for #{dmg} damage!"
      opponent.health = [opponent.health - dmg, 0].max
    else
      puts "and misses!"
    end
  end
end

class Character
  attr_reader :name, :race

  def initialize(name, race)
    @name = name
    @race = race
  end

  def battle(opponent)
    puts "#{name} cannot engage in battle!"
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
  attr_reader :goods, :gold

  def initialize(name, race)
    super(name, race)
    @goods = []
    @gold = 1000
  end
end

conan = Warrior.new('Conan', 'Human')
galadriel = Mage.new('Galadriel', 'Elf')
grok = Vendor.new('Grok', 'Ogre')

# conan.battle(galadriel)
galadriel.battle(grok)
# grok.battle(galadriel)
