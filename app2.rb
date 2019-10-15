require 'bundler'
Bundler.require

#require_relative 'lib/game'
require_relative 'lib/player'

def start
    puts " "
    puts "-" * 50
    puts "BIENVENUE SUR 'ILS VEULENT TOUS MA POO !' "
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

def start_game_ennemies #pour paramètrer les bot
    ennemies = []
    player1 = Player.new("Josiane")
    ennemies << player1
    player2 = Player.new("José")
    ennemies << player2
    return ennemies
end

def start_game_player #pour paramètrer le joueur
    pseudo = name_player
    player0 = HumanPlayer.new("#{pseudo}")
    return player0
end

def battle_phase
    player0 = start_game_player
    ennemies = start_game_ennemies

    #pour sortir les bot de l'array
    player1 = ennemies[0]
    player2 = ennemies[1]
    n = 1

    while player0.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0)
        puts " "
        puts "---------- TOUR #{n}"
        player0.show_state
        n = n + 1 #pour le compteur de tours 

        #demande au joueur qu'est ce qu'il veut faire
        puts " "
        puts "Quelle action veux-tu effectuer ?"
        puts "a - Chercher une meilleur arme"
        puts "b - Chercher à se soigner"
        puts " "
        puts "Attaque un joueur : "

        print "c - "
            #pour afficher si le joueur est déjà mort ou pas
            if player1.life_points > 0
                player1.show_state
            else 
                puts "#{player1.name} est mort !"
            end
        print "d - "
            #pour afficher si le joueur est déjà mort ou pas
            if player2.life_points > 0
                player2.show_state
            else 
                puts "#{player2.name} est mort !"
            end

        puts " "
        print "> "
        ask = gets.chomp.to_s
        puts " "

        #choix du joueur
        if ask == "a"
            player0.search_weapon
        elsif ask == "b"
            player0.search_health_pack
        elsif ask == "c"
            player0.attacks(player1)
            #pour afficher si le joueur est déjà mort ou pas
            if player1.life_points > 0
                player1.show_state
            else 
                puts "#{player1.name} est mort !"
            end
        elsif ask == "d"
            player0.attacks(player2)
            #pour afficher si le joueur est déjà mort ou pas
            if player2.life_points > 0
                player2.show_state
            else 
                puts "#{player2.name} est mort !"
            end
        else 
            puts "Tu passes ton tour, la prochaine fois tape juste la lettre correspondante"
        end

        #pour ne pas que les bot attaquent si ils sont tous morts
        break if (player1.life_points < 0 && player2.life_points < 0)

        #attaque des bot
        puts " "
        puts "Les autres joueurs t'attaquent !"
        ennemies.each do |bot|
            if bot.life_points > 0
            bot.attacks(player0)
            end
        end

        #pour afficher la suite
        puts " "
        puts "Appuie sur entrée pour continuer"
        gets.chomp
    end

    #pour déterminer qui est le gagnant
    if player0.life_points > 0
        looser = "Les ennemies"
    else
        looser = player0.name
    end

    return looser
end

def end_phase
    looser = battle_phase

    puts " "
    puts "-" * 50
    if looser == "Les ennemies"
        puts "LA PARTIE EST FINIE !"
        puts " "
        puts "BRAVO ! TU AS GAGNE !"
        puts "#{looser} ont été défaits !"
    else
        puts "Tu es mort..."
        puts " "
        puts "LA PARTIE EST FINIE !"
        puts "Loser ! Tu as perdu !"
    end
    puts "-" * 50
    puts " "
end

def perform
    start
    end_phase
end

perform