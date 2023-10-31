pycg <- function() {
   print("Welcome, challenger!  Are you ready to play Rock, Paper, Scissors!")
   flush.console()
   print("Choose your weapon wisely!")
   flush.console()
   print("✊🏻 Type R for Rock")
   flush.console()
   print("✌🏻 Type P for Paper")
   flush.console()
   print("✋🏻 Type S for Scissors")
   flush.console()
   print("Leaving the game? Type 'exit' to say goodbye.")
   flush.console()
   print("---------------------------------------")
   flush.console()
  
   options = c("R", "P", "S")
   turns = 0
   score = 0
   tie = 0

   while (TRUE) {
     bot = sample(options,1)
     player = readline ("Choose your weapon!: ")
     if (toupper(player) == "EXIT"){
        print("The End! Thanks for Playing!")
        print("---------------------------------------")
        print("Let's See How You Did")
        print(paste("Rounds Played:", turns))
        print(paste("Total Wins (Score):", score))
        print(paste("Tied Games:", tie))
        if (turns != 0) {
            win_rate = round((score/(turns-tie)) * 100, 2)
            print(paste("Your Win Rate is", win_rate, "%"))
            }
        else { cat("Your Win Rate is ERROR!")
      }
      break
       }
         else if (toupper(player) != "R" & toupper(player) != "S" & toupper(player) != "P" & toupper(player) != "exit") {
      print("Please type only 'R', 'S', or 'P")
    }
      else {
      print(paste("I'm going with:", bot))
      flush.console()
      if ((toupper(player) == "R" & toupper(bot) == "S") | (toupper(player) == "S" & toupper(bot) == "P") | (toupper(player) == "P" & toupper(bot) == "R")) {
        turns <- turns + 1
        score <- score + 1
        tie <- tie + 0
        print("Victory is yours!")
        flush.console()
      } 
        else if (toupper(player) == toupper(bot)) {
        turns <- turns + 1
        score <- score + 0
        tie <- tie + 1
        print("No winner this time.")
        flush.console()
      } 
        else {
        turns <- turns + 1
        score <- score + 0
        tie <- tie + 0
        print("Better luck next time!")
        flush.console()
      }
    }
   }
}
