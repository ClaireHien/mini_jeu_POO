require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'


def start
    puts " "
    puts "-" * 50
    puts "BIENVENUE SUR 'ILS VEULENT TOUS MA POO !' "
    puts "VERSION, SEUL CONTRE TOUS !"
    puts " "
    puts "Le but du jeu est d'être le dernier survivant..."
    puts "-" * 50
    puts " "
end

def name_player
    puts "Tout d'abord, quel est ton pseudo ? "
    print "> "
    pseudo = gets.chomp
    puts "C'est parfait ! le jeu va commencer..."
    puts "Bonne chance #{pseudo} ! "
    puts " "
    return pseudo
end

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

    while my_game.human_player.life_points > 0 && (my_game.ennemies_list[0].life_points > 0 || my_game.ennemies_list[1].life_points > 0 || my_game.ennemies_list[2].life_points > 0 || my_game.ennemies_list[3].life_points > 0)
    puts " "
    puts "---------- TOUR #{n}"
    n = n + 1 #pour le compteur de tours
    my_game.menu
    puts " "
    my_game.menu_choice
    puts " "
    my_game.ennemies_attack
    puts " "
    puts " "
    my_game.human_player.show_state
    puts "Appuie sur entrer pour continuer"
    gets.chomp
    end

    my_game.end_game

  
end

def perform
    start
    my_game
end

perform