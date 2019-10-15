require 'pry'

class Player
    attr_accessor :name, :life_points

    #la base pour entrer un nouveau joueur
    def initialize(name_player)
        @life_points = 10
        @name = name_player
    end

    #affiche l'état des LP du joueur
    def show_state
        puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}."
    end

    #effectue des dommages à un joueur
    def gets_damage(n)
        @life_points = @life_points - n

        if @life_points < 1
            puts "Le joueur #{@name} a été tué."
        else
            puts "Points de vie restants : #{@life_points}"
        end
    end
        
    #pour qu'un joueur attaque un autre
    def attacks(player)
        dice = compute_damage
        puts "#{@name} attaque #{player.name} : Il lui inflige #{dice} points de dommages"
        player.life_points = player.life_points - dice
    end

    def compute_damage
        return rand(1..6)
    end


end


class HumanPlayer < Player
    attr_accessor :weapon_level

    def initialize(name_player, weapon_lvl)
        @life_points = @life_points + 90
        @weapon_level = weapon_lvl

        super (name_player)
    end

end

binding.pry