reservation_bot <- function() {
    name = readline("What's your name?: ")
     print(paste("Hello", name))
     welcome = readline ("Welcome to Ichi Ni San Udon, your go-to place for homemade udon! How can we assist you today? 
                            1. I'd like to make a reservation.
                            2. I'd like to see the special menu of the month.
                        Please Chooes Number 1 or 2")
        
        if ( welcome == "1") {
            people = readline("How many people will be joining you for your udon experience? : ")
            datetime = readline("When would you like to dine with us? Please specify the date and time.? : ")
            special = readline("Are you interested in trying our special udon menu of the month? Please Chooes Yes Or No")
            if (special == "Yes") {
                order = readline("Today, we have two specials: Spicy Beef Udon priced at 245 baht and Curry Chicken Udon priced at 200 baht. Which one would you like?: ")
                }
                else if (special == "No") {
                    print ("Okay")
                    }
            allergies = readline ("Do you have any allergies we should be aware of?")
            celebration = readline ("Do you have any additional special requests or celebrations we should know about?")
            phone = readline ("To complete your reservation, we'll need your contact number. What's your phone number?")
            print(paste("Thank you for choosing Ichi Ni San Udon! Your reservation for" ,datetime, "has been confirmed."))
            }
        else if (welcome == "2"){
                print("1. Spicy Beef Udon priced at 245 baht: Flank steak cut into cubes, served with our house-made spicy beef broth.
                    2.Curry Chicken Udon priced at 200 baht: Chicken leg cut into cubes, along with potatoes and eggplant, served in a special curry soup.")

        }
}
