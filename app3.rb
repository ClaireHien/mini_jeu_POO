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
    puts "Appuie sur entrée pour lancer le jeu"
    gets.chomp
    return pseudo
end

def my_game
    pseudo = name_player
    my_game = Game.new(pseudo)

    puts "Tous les joueurs sont prêts..."
    puts " "
    my_game.show_players

    puts " "

    n = 1

  
end

def perform
    start
    my_game
end

perform