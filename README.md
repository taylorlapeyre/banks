**This is a very minimal "Bank" application that (for the time being) runs inside of irb**

Within this program, you can make banks, savings accounts, checking accounts, save your banks to files, load banks from files, and get information on pretty much anything.

Sample Run:

    1.9.3-p194 :001 > require './Banks'
     => true
    1.9.3-p194 :002 > chase = Bank.new "Chase Bank"
     => Chase Bank

    1.9.3-p194 :003 > chase.make_menu
    What would you like to do? [Enter a number]
    1) Add an account
    2) Get information about your account
    3) Print all of the accounts in the bank
    4) Remove an account from the bank
    5) Save this bank's data to a file
    : 1
    What kind of account is it?
    : checking
    Who is the account holder?
    : Taylor Lapeyre
    What is the starting balance?
    : 100
    Successfully added a new account!
     => nil
    1.9.3-p194 :004 > chase.get_account_by_holder("Taylor Lapeyre").withdraw 10
     => nil
    1.9.3-p194 :005 > chase.make_menu
    What would you like to do? [Enter a number]
    1) Add an account
    2) Get information about your account
    3) Print all of the accounts in the bank
    4) Remove an account from the bank
    5) Save this bank's data to a file
    : 2
    What is your name? (Firstname, Lastname)
    : Taylor Lapeyre
     => "[Checking] Holder: Taylor Lapeyre -- Balance: $90.0."
    1.9.3-p194 :006 > chase.make_menu
    What would you like to do? [Enter a number]
    1) Add an account
    2) Get information about your account
    3) Print all of the accounts in the bank
    4) Remove an account from the bank
    5) Save this bank's data to a file
    : 5
    Enter the name of the file you'd like to save it to
    : chase.txt
     => nil
    1.9.3-p194 :007 > exit
    ➜  banks git:(master) ✗ cat chase.txt
    Chase Bank
    1) [Checking] Holder: Taylor Lapeyre -- Balance: $90.0.