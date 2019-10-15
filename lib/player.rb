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
        puts "#{@name} a #{@life_points} points de vie"
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
    attr_accessor :name, :weapon_level, :life_points

    #je n'ai pas réussi à utiliser le super pour modifier le life_points à 100, donc pour avancer je rajoute ça manuellement
    def initialize(name_player)
        @weapon_level = 1
        @name = name_player
        @life_points = 100
    end

    def compute_damage 
        #pour calculer les dommages du joueur
        dice = rand(1..6) * @weapon_level
    end

    def show_state #pour le joueur avec l'état de son arme
        puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}."
    end

    def search_weapon
        #lancé de dès pour l'arme
        random = rand(1..6)
        puts "Tu as trouvé une arme de niveau #{random}"

        #est-ce qu'elle est meilleur que l'actuelle ou non ?
        if random > @weapon_level
            puts "Génial ! Elle est meilleur que ton arme actuelle, tu la prend !"
            @weapon_level = random
        else 
            puts "Elle n'est pas mieux que ton arme actuelle, autant garder celle que tu as déjà"
        end

        return @weapon_level
    end

    def search_health_pack
        life_pack = rand(1..6)

        #Pack de vie en fonction du lancé de dès. 
        if life_pack == 1
            puts "Tu n'as rien trouvé..."
        elsif life_pack == 6
            puts "WHOA! Tu as trouvé un pack de 80 points de vie !"
            self.life_points = self.life_points + 80
            if life_points > 100
                self.life_points = 100
            end
            puts "Tu as maintenant #{self.life_points} points de vie"
        else 
            puts "Bravo ! Tu as trouvé un pack de 50 points de vie"
            self.life_points = self.life_points + 50
            if life_points > 100
                self.life_points = 100
            end
            puts "Tu as maintenant #{self.life_points} points de vie"
        end

        return @life_points
    end
        
end
