require 'pry'
require_relative 'player'

class Game
    attr_accessor :human_player, :ennemies_list

    def initialize(name)
        @human_player = HumanPlayer.new("#{name}")
        @ennemies_list = [Player.new("Bot1"), Player.new("Bot2"), Player.new("Bot3"), Player.new("Bot4")]
    end

    #pour supprimer un joueur, def à faire
    def kill_player
        ennemies_list.delete(1)
        puts ennemies_list
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

        n = 0
        ennemies_list.each do |bot|
            if bot.life_points > 0
            print "#{n} - "
            print "#{bot.show_state}"
            end
            n = n + 1
        end
    end

    def menu_choice
        puts "Que veux-tu faire ?"
        print "> "
        ask = gets.chomp

        if ask == "a"
            human_player.search_weapon
        elsif ask == "b"
            human_player.search_health_pack
        elsif ask == "0" || ask == "1" || ask == "2" || ask == "3" || ask == "4"
            ask = ask.to_i
            human_player.attacks(ennemies_list[ask])
            if ennemies_list[ask].life_points < 1
                puts "#{ennemies_list[ask].name} est mort !"
            end
        else
            puts "Ce n'est pas un choix possible"
            puts "Tant pis pour toi, tu perds un tour. Fais attention la prochaine fois ! "
        end
    end

    def ennemies_attack
        ennemies_list.each do |bot|
            if bot.life_points > 0
                dice = rand(1..6)
                puts "#{bot.name} t'attaque ! Il t'inflige #{dice} points de dégâts"
                human_player.life_points = human_player.life_points - dice
            end
        end
    end

    def end_game
        if human_player.life_points > 0 
            puts " BRAVO ! Tu as survécu ! "
        else
            puts "Bon... Tu es mort. Essaie encore !"
        end
    end
end
