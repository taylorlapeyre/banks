from banks import *

chase = Bank("Chase Bank")

chase.add_account("Taylor Lapeyre", 0)
chase.add_account("Scrooge McDuck", 300, "savings")

chase.find_account_by_id(1).deposit(10)
str(chase.find_account_by_id(1))

chase.save_bank_info_to_file("chase")