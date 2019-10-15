require 'bundler'
Bundler.require

#require_relative 'lib/game'
require_relative 'lib/player'

def start_game1 #pour paramètrer le premier joueur
    player1 = Player.new("Josiane")
    return player1
end

def start_game2 #pour paramètrer le second joueur
    player2 = Player.new("José")
    return player2
end

def new_game #juste pour afficher un petit message d'intro
    player1 = start_game1
    player2 = start_game2

    puts "Nouveau joueur : #{player1.name}"
    puts "Nouveau joueur : #{player2.name}"
    puts "La partie peut commencer !"
    puts " "

    puts "Voici l'état de chaque joueur :"
    player1.show_state
    player2.show_state
    puts " "
end

def attack_phase
    player1 = start_game1
    player2 = start_game2

    puts "Passons à la phase d'attaque !"
    puts " "
    t = 1

    #les phases d'attaque
    while player1.life_points > 0 || player2.life_points > 0
        puts "------ TOUR #{t}"
        t = t + 1 
        #phrase d'attaque
        player1.attacks(player2)
        player2.show_state
        break if player2.life_points < 1
        player2.attacks(player1)
        player1.show_state
        break if player1.life_points < 1
        puts " "
    end
    
    #pour return le nom du perdant
    if player1.life_points < 1
        looser = player1.name
    else
        looser = player2.name
    end

    return looser

end

def end_game
    player1 = start_game1
    player2 = start_game2
    looser = attack_phase

    #affichage des scores de fin
    puts " "
    puts "#{looser} a été tué... Fin de la partie !"
end

def perform
    new_game
    end_game
end

perform

binding.pry