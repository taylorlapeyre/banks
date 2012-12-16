require './Banks'

chase = Bank.new("Chase Bank")

chase.add_account("checking", "Taylor Lapeyre", "0")
chase.add_account("savings", "Scrooge McDuck", "100")

chase.get_account_by_id(1).deposit(10)
chase.get_account_by_id(1).to_s

chase.save_bank_info_to_file("chase.bank")

puts `cat chase.bank`
