require 'date'

# A nomal Bank Account
class BankAccount
  attr_reader :balance, :holder

  def initialize(the_holder, inital_balance)
    @transaction_count = 0
    @balance = inital_balance.to_f
    @holder = the_holder
  end

  def deposit(amount)
    @transaction_count++
    @balance  = @balance + amount
  end

  def withdraw(amount)
    @transaction_count++
    @balance = @balance - amount
  end

  def to_s
    "Holder: #@holder -- Balance: $#@balance."
  end
end

# Checking Accounts differ by charging you a $5 fee every 15 transactions
class CheckingAccount < BankAccount
  FREE_TRANSACTIONS = 15
  TRANSACTION_FEE = 5.0

  def initialize(holder, inital_balance)
    super(holder, inital_balance)
  end

  def deduct_fees
    # reset the transaction count at the begining of each month
    @transaction_count = 1 if Date.today.mday == 1
    if @transaction_count > FREE_TRANSACTIONS
      @balance = @balance - TRANSACTION_FEE
    end
  end

  def withdraw(amount)
    @transaction_count++
    @balance = @balance - amount
    deduct_fees
  end

  def deposit(amount)
    @transaction_count++
    @balance  = @balance + amount
    deduct_fees
  end

  def to_s
    "[Checking] Holder: #@holder -- Balance: $#@balance."
  end
end

# A savings account adds interest to your account at the end of each year
class SavingsAccount < BankAccount
  attr_reader :interest_rate

  def initialize(holder, inital_balance)
    super(holder, inital_balance)
    @interest_rate = 0.6
  end

  def withdraw(amount)
    @transaction_count++
    @balance = @balance - amount
    add_interest if Date.today.to_s == "#{Date.today.year}-12-31"
  end

  def deposit(amount)
    @transaction_count++
    @balance  = @balance + amount
    add_interest if Date.today.to_s == "#{Date.today.year}-12-31"
  end

  def add_interest
    @balance = @balance + (@balance * @interest_rate)
  end

  def to_s
    "[Savings] Holder: #@holder -- Balance: $#@balance."
  end
end

# A Bank holds bank accounts
class Bank
  attr_reader :name
  def initialize(bank_name)
    @accounts = {}
    @name = bank_name
  end

  def manually_add_account
    puts "What kind of account is it?"; print ": "
    account_type = gets.chomp
    puts "Who is the account holder?"; print ": "
    the_holder = gets.chomp
    puts "What is the starting balance?"; print ": "
    inital_balance = gets.chomp

    self.add_account(account_type, the_holder, inital_balance)
    puts "Successfully added a new account!"
  end

  def manually_get_account_info
    puts "What is your name? (Firstname, Lastname)"; print ": "
    the_holder = gets.chomp
    self.get_account_by_holder(the_holder).to_s
  end

  def manually_remove_account
    puts "Enter the ID of the account you would like to remove"; print ": "
    id = gets.chomp.to_i
    puts "Are you sure that you want to remove #{@accounts[id].holder}'s account? [y/n]"
    @accounts.delete(id) if gets.chomp == "y"
  end

  def manually_save_bank_info
    puts "Enter the name of the file you'd like to save it to"; print ": "
    file_name = gets.chomp
    save_bank_info_to_file(file_name)
  end

  def make_menu
    puts "What would you like to do? [Enter a number]"
    puts "1) Add an account"
    puts "2) Get information about your account"
    puts "3) Print all of the accounts in the bank"
    puts "4) Remove an account from the bank"
    puts "5) Save this bank's data to a file"
    print ": "
    get_user_menu_choice
  end

  def get_user_menu_choice
    response = gets.to_i
    case response
    when 1 then manually_add_account
    when 2 then manually_get_account_info
    when 3 then self.to_s
    when 4 then manually_remove_account
    when 5 then manually_save_bank_info
    else puts "Invalid number!"; make_menu
    end
  end

  def add_account(account_type, the_holder, inital_balance)
    if account_type.downcase == "checking"
      @accounts[@accounts.size + 1] = CheckingAccount.new(the_holder, inital_balance)
    elsif account_type.downcase == "savings"
      @accounts[@accounts.size + 1] = SavingsAccount.new(the_holder, inital_balance)
    else
      puts "The account type must be either 'checking' or 'savings'"
    end
  end

  def remove_account(id)
    @accounts.delete(id)
  end

  def get_account_by_holder(holder)
    @accounts.each do |id, account|
      if account.holder.downcase == holder.downcase
        return account
      end
    end
    puts "Account not found."
  end

  def get_account_by_id(id)
    @accounts[id] or puts "Account not found."
  end

  def save_bank_info_to_file(file_name)
    file = File.new(file_name.downcase.tr(' ', '-'), "w+")
    file.puts self.to_s
    file.close
  end

  def self.load_bank_from_file(file_name)
    file = File.open(file_name, "r+")
    bank_name = file.readline
    bank = self.new(bank_name)
    regex = /\[([A-Za-z]*)\] \w*: ([A-Za-z]*\s[A-Za-z]*) -- \w*: \$(\d*\.\d*)/
    file.each do |line|
      type, holder, balance = line.match(regex).captures
      bank.add_account(type, holder, balance)
    end
    bank
  end

  def to_s
    result = @name + "\n"
    @accounts.each { |id, account| result += "#{id}) #{account.to_s}\n" }
    result
  end
end
