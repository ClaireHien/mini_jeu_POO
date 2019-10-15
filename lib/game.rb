require 'pry'
require_relative 'player'

class Game
    attr_accessor :human_player, :ennemies_list

    def initialize(name)
        table = []
        4.times do
            a = rand(0..9999)
            bot = Player.new("Bot#{a}")
            table << bot
        end
        @human_player = HumanPlayer.new("#{name}")
        @ennemies_list = table
    end

    #pour supprimer un joueur : a faire. 
    def kill_player
        ennemies_list.delete(0)
        puts ennemies_list.size
    end

    #pour ajouter un joueur
    def add_player
        dice_add = rand(1..6) #lancé de dès

        #j'ai un peu changé la difficultée du jeu mais c'est mes gouts personnels !
        if dice_add == 3 || dice_add == 4 || dice_add == 5
            puts " "
            puts "Un ennemis vient s'ajouter : "
            a = rand(0..9999)
            bot = Player.new("Bot#{a}")
            ennemies_list << bot
            puts "#{bot.name} se joint à la bataille !"
        elsif dice_add == 6 
            puts " "
            puts "Les renforts ennemis arrivent !"
            2.times do 
                a = rand(0..9999)
                bot = Player.new("Bot#{a}")
                ennemies_list << bot
                puts "#{bot.name} se joint à la bataille !"
            end
        elsif dice_add == 1 || dice_add == 2
            puts "La bataille fait rage !"
        end
    end

    #pour demander si le jeu est toujours en cours
    def is_still_ongoing?
        if human_player.life_points > 0 && @ennemies_list.size > 0
            puts true
        else
            puts false
        end
    end

    #pour montrer l'état de tous les joueurs
    def show_players
        human_player.show_state
        ennemies_list.each do |bot|
            bot.show_state
        end
    end

    #le menu de toutes les actions pouvant être effectuées
    def menu
        puts "Voici les actions que tu peux effectuer :"
        puts " "
        puts "a - Chercher une meilleur arme"
        puts "b - Chercher à se soigner"
        puts " "
        puts "Attaque un joueur : "

        #pour chaque ennemis, montrer les stats
        n = 0
        ennemies_list.each do |bot|
            if bot.life_points > 0
            print "#{n} - "
            puts "#{bot.name} a #{bot.life_points} point de vie"
            end
            n = n + 1
        end
    end

    #demande au joueur ce qu'il veut faire
    def menu_choice
        puts "Que veux-tu faire ?"
        print "> "
        ask = gets.chomp
        nbr_ennemies = ennemies_list.size

        #pour les deux premières options
        if ask == "a" || ask == "b"
            if ask == "a"
                human_player.search_weapon
            elsif ask == "b"
                human_player.search_health_pack
            end
        else
            ask = ask.to_i
            if ask <= nbr_ennemies
                human_player.attacks(ennemies_list[ask])
                if ennemies_list[ask].life_points < 1
                    puts "#{ennemies_list[ask].name} est mort !"
                end
            else
            #sinon si l'entrée n'est pas correcte
                puts "Ce n'est pas un choix possible"
                puts "Tant pis pour toi, tu perds un tour. Fais attention la prochaine fois ! "
            end
        end
    end

    def ennemies_attack
        #chaque ennemie attaque une fois
        ennemies_list.each do |bot|
            if bot.life_points > 0
                dice = rand(1..6)
                puts "#{bot.name} t'attaque ! Il t'inflige #{dice} points de dégâts"
                human_player.life_points = human_player.life_points - dice
            end
        end
    end

    def end_game
        #annonce des résultats
        if human_player.life_points > 0 
            puts " BRAVO ! Tu as survécu ! "
        else
            puts "Bon... Tu es mort. Essaie encore !"
        end
    end
end
