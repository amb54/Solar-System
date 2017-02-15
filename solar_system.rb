
# An array of hashes. One hash for each one of the planets in our solar system
planets = [
  {
    name: "Earth",
    radius: 6371.0,
    mass: 5.97237*10**24,
    sattelites: 1,
    distance_from_sun: 149.6*10**6,
    stellar_day: 0.997, # earth days
    orbital_period: 1.00001742096 # earth years
  },

  {
    name: "Jupiter",
    radius: 69911,
    mass: 1.8986*10**27,
    sattelites: 67,
    distance_from_sun: 778.3*10**6,
    stellar_day: 0.41354, # earth days
    orbital_period: 11.8618 # earth years
  },

  {
    name: "Mars",
    radius: 3389.5,
    mass: 6.4171*10**23,
    sattelites: 2,
    distance_from_sun: 227.9*10**6,
    stellar_day: 1.025957, # earth days
    orbital_period: 1.8808 # earth years
  },

  {
    name: "Mercury",
    radius: 2439.7,
    mass: 3.3011*10**23,
    sattelites: 0,
    distance_from_sun: 57.9*10**6,
    stellar_day: 58.646, # earth days
    orbital_period: 0.240846 # earth years
  },

  {
    name: "Neptune",
    radius: 24622,
    mass: 1.0243*10**26,
    sattelites: 14,
    distance_from_sun: 4497.1*10**6,
    stellar_day: 0.6713, # earth days
    orbital_period: 164.8 # earth years
  },

  {
    name: "Saturn",
    radius: 58232,
    mass: 5.6836*10**26,
    sattelites: 62,
    distance_from_sun: 1427.0*10**6,
    stellar_day: 0.43958, # earth days
    orbital_period: 29.4571 # earth years
  },

  {
    name: "Uranus",
    radius: 25362,
    mass: 8.6810*10**25,
    sattelites: 25,
    distance_from_sun: 2871.0*10**6,
    stellar_day: 0.71833, # earth days
    orbital_period: 84.0205 # earth years
  },

  {
    name: "Venus",
    radius: 6051.8,
    mass: 4.8675*10**24,
    sattelites: 0,
    distance_from_sun: 108.2*10**6,
    stellar_day: 243.025, # earth days
    orbital_period: 0.615198 # earth years
  }
]





# The class SolarSystem
class SolarSystem
  attr_reader :age, :planets
  def initialize(age)
    @planets = []
    @age = age # In Earth years
  end

  # Method that returns a Planet object corresponding to a specific planet name
  def planet_object(planet_name)
    @planets.each do |planet|
      if planet.name == planet_name
        return planet
      end
    end
  end

 # Method for adding a Planet instance to the array @planets
  def add_planet(planet)
    @planets.push planet
  end

  # Method for adding an array of Planet objects to the array @planet
  def add_planets(list_of_planets)
    @planets += list_of_planets
  end

  # Method that returns the names of the planets either as a string or in an array
  def planet_names(format)
    name_list = []
    @planets.each do |planet|
      name_list.push planet.name
    end
    if format == "string"
      return name_list.join(", ")
    elsif format == "list"
      return name_list
    end
  end

  # Method that calculates and returns the distance between two planets
  def distance_between_two_planets(planet1, planet2)
    return "#{sprintf( "%0.2g", (planet_object(planet1).distance_from_sun - planet_object(planet2).distance_from_sun).abs) } km"
  end

  # Method that calculates and returns the local age of a specific planet
  def local_age(planet)
    return "The local age of #{planet} is #{sprintf( "%0.3g", @age/planet_object(planet).orbital_period)} years"
  end

end


# The class Planet
class Planet
  attr_accessor :radius, :mass, :sattelites, :stellar_day, :distance_from_sun, :orbital_period
  attr_reader :name
  attr_reader :distance_unit, :mass_unit, :day_time_unit, :year_time_unit
  def initialize(planet_hash)
    @name = planet_hash[:name]
    @radius = planet_hash[:radius]
    @mass = planet_hash[:mass]
    @sattelites = planet_hash[:sattelites]
    @distance_from_sun = planet_hash[:distance_from_sun]
    @stellar_day = planet_hash[:stellar_day]
    @orbital_period = planet_hash[:orbital_period]
  end
end





# Method for printing a numbered list of the planets in the class SolarSystem
def print_numbered_list(planet_name_list)
  planet_name_list.length.times do |index|
    puts "#{index+1} -#{planet_name_list[index]}"
  end
end


# Create an instance of the class SolarSystem
# Our planetary system was formated 4.54 billion years ago.
our_solar_system = SolarSystem.new(4.54*10**9)

# Add planets to the object our_solar_system via the hash planets
planets.each do |planet_hash| # iterating over the array planets of hashes
  our_solar_system.add_planet(Planet.new(planet_hash))
end



# User request of information about planets
done = false
until done
  # Interact with a user and provide information about the planet the usera choose.
  puts "\nWhat planet would you like to learn more about? "
  puts "Enter the number of the planet from the list below.\n(Enter 13 to exit)"

  # Print out of list of planets
  planet_name_list = our_solar_system.planet_names("list")
  print_numbered_list(planet_name_list)
  puts "13 -Exit"

  # Input of the users choice
  print "Enter planet number: "
  entered_number = gets.chomp

  if entered_number == "13"
    done = true
  else
    planet_index = -1 + entered_number.to_i
    choosen_planet = planet_name_list[planet_index]
    the_planet_object = our_solar_system.planet_object(choosen_planet)
    print "\n#{choosen_planet}\'s radius is #{the_planet_object.radius} km, it has a mass of #{sprintf( "%0.3g",the_planet_object.mass)} kg\nand the distance from the sun is #{sprintf( "%0.3g",the_planet_object.distance_from_sun)} km.\n#{our_solar_system.local_age(choosen_planet)}\n\n\n"

    puts "Would you like to have this information about another planet?"
    print "(yes/no): "
    answer = gets.chomp.downcase[0]
    if answer == "n"
      done = true
    end
  end

end


# User request of finding out the distance between two given planets.
puts "\nWould you like to know the distance between two planets?"
print "(yes/no): "
answer = gets.chomp.downcase[0]

if answer == "y"
  # Find the distance between two planets
  done = false
  until done

    puts "\nWhat two planes do you want to know the distance between?"
    puts "Enter the numbers of the planets from the list below."

    # Print out of list of planets
    planet_name_list = our_solar_system.planet_names("list")
    print_numbered_list(planet_name_list)

    # Input of the users choice
    print "Planet number 1: "
    planet1 = planet_name_list[-1 + gets.chomp.to_i]
    print "Planet number 2: "
    planet2 = planet_name_list[-1 + gets.chomp.to_i]

    puts "\nThe distance between #{planet1} and #{planet2}\nis #{our_solar_system.distance_between_two_planets(planet1, planet2)}"

    puts "\nWould you like to konw the distance between two other planets?"
    print "(yes/no): "
    answer = gets.chomp.downcase[0]
    if answer == "n"
      done = true
    end

  end

end


puts "\n\n\n"
puts "This is a test of the metod \"add_planets\" in the SolarSystem class"
# Test of the method add_planets in the class SolarSystem
# Create an instance of the class SolarSystem
# our planetary system was formated 4.54 billion years ago.
solar_system_test = SolarSystem.new(4.54*10**9)

# Add planets to the object our_solar_system via the hash planets
planets.each do |planet_hash| # iterating over the array planets of hashes
  solar_system_test.add_planet(Planet.new(planet_hash))
end
puts "The original planets are now added to the object solar_system_test."
puts "This is a list of their names:"
planet_name_list = solar_system_test.planet_names("list")
print_numbered_list(planet_name_list)

list_of_additions = [
  Planet.new({name: "Laban"}),
  Planet.new({name: "Sune"})
]
solar_system_test.add_planets(list_of_additions)
puts "\nHere is the list after adding two Planet instances via a list:"
planet_name_list = solar_system_test.planet_names("list")
print_numbered_list(planet_name_list)
