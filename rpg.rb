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
    a = self
    b = opponent
    a,b = b,a if rand > 0.5
    while !dead? && !opponent.dead?
      sleep 1
      dmg = (a.attack + rand(1..6)) - (b.defence + rand(1..6))
      b.health = [b.health - dmg, 0].max
      yield(a, b, dmg)
      a,b = b,a
    end
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

def start_battle(a, b)
  a.battle(b) do |attacker, defender, damage|
    puts "#{attacker.name} attacks #{defender.name} #{damage > 0 ? "for #{damage} damage!" : "and misses!"}"
    puts "HEALTH --> #{a.name}: #{a.health}\t#{b.name}: #{b.health}"
  end
  if a.dead? && b.dead?
    puts "#{a.name} and #{b.name} killed each other !!"
  else
    puts "#{a.dead? ? a.name : b.name} was killed by #{a.dead? ? b.name : a.name} !!"
  end
end

start_battle(conan, galadriel)
