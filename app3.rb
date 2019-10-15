require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

#affichage du départ
def start
    puts " "
    puts "-" * 50
    puts "BIENVENUE SUR 'ILS VEULENT TOUS MA POO !' "
    puts "VERSION, SEUL CONTRE TOUS !"
    puts " "
    puts "Le but du jeu est d'être le dernier survivant..."
    puts "Si tu y arrives. Méfie toi, des renforts sont suceptibles d'arriver... "
    puts "-" * 50
    puts " "
end

#demande de pseudo
def name_player
    puts "Tout d'abord, quel est ton pseudo ? "
    print "> "
    pseudo = gets.chomp
    puts "C'est parfait ! le jeu va commencer..."
    puts "Bonne chance #{pseudo} ! "
    puts " "
    return pseudo
end

#le déroulement du jeu
def my_game
    pseudo = name_player
    my_game = Game.new(pseudo)

    puts "Tous les joueurs sont prêts..."
    puts " "
    my_game.show_players

    puts " "

    puts "Appuie sur entrée pour lancer le jeu"
    gets.chomp

    n = 1

    #tant que le jeu n'est pas terminé, la boucle continue
    while my_game.human_player.life_points > 0 && my_game.ennemies_list.each { |bot| bot.life_points > 0}
        puts " "
        puts "---------- TOUR #{n}"
        n = n + 1 #pour le compteur de tours
        my_game.menu #liste des choix du joueurs
        puts " "
        my_game.menu_choice #demande au joueur quel choix faire
        puts " "
        my_game.ennemies_attack #les ennemies attaquent

        #pour limiter les ennemies, ils apparaissent jusqu'au 19ème
        if my_game.ennemies_list.size < 20
            my_game.add_player #lancé de dès pour savoir si des ennemies arrivent
        end
    
        puts " "
        puts " "
        my_game.human_player.show_state #affiche les stat du joueur

        puts "Appuie sur entrer pour continuer"
        gets.chomp
    end

    my_game.end_game
    puts " "
    puts "-" * 50
    puts "Tu auras effectué #{n} tour !"
    puts "Essaie de faire mieux la prochaine fois !"

  
end

def perform
    start
    my_game
end

perform