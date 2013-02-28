from datetime import date

class BankAccount(object):

    def __init__(self, holder, balance):
        self.transaction_count = 0
        self.balance = balance
        self.holder  = holder

    def deposit(self, ammount):
        self.transaction_count += 1
        self.balance += ammount
        return(self.balance)

    def withdraw(self, ammount):
        self.transaction_count += 1
        self.balance -= ammount
        return(ammount)

    def __str__(self):
        return("Holder: {holder} -- ${balance}".format(holder=self.holder, balance=self.balance))


class CheckingAccount(BankAccount):
    FREE_TRANSACTIONS = 15
    TRANSACTION_FEE   = 5.0

    def deposit(self, ammount):
        self.transaction_count += 1
        self.balance += ammount
        self.deduct_fees()
        return(self.balance)

    def withdraw(self, ammount):
        self.transaction_count += 1
        self.balance -= ammount
        self.deduct_fees()
        return(ammount)

    def deduct_fees(self):
        if date.today().day == 1:
            self.transaction_count = 1
        if self.transaction_count > FREE_TRANSACTIONS:
            self.balance -= TRANSACTION_FEE
            self.transaction_count = 1

    def __str__(self):
        return("[Checking] Holder: {holder} -- ${balance}".format(holder=self.holder, balance=self.balance))


class SavingsAccount(BankAccount):

    def __init__(self, holder, balance):
        super(holder, balance)
        self.interest_rate  = 0.6
        self.interest_added = False

    def withdraw(self, ammount):
        self.balance -= ammount
        if date.today().day == date(date.today().year, 12, 31):
            self.add_interest()
        return(ammount)

    def deposit(self, ammount):
        self.balance += ammount
        if date.today().day == date(date.today().year, 12, 31):
            self.add_interest()
        return(self.balance)

    def add_interest(self):
        self.balance += self.balance * self.interest_rate

    def __str__(self):
        return("[Savings] Holder: {holder} -- ${balance}".format(holder=self.holder, balance=self.balance))


class Bank(object):

    def __init__(self, name):
        self. accounts = {}
        self.name = name

    def add_account(self, holder, balance, account_type="checking"):
        if account_type == "checking":
            self.accounts[len(self.accounts) + 1] = CheckingAccount(holder, balance)
        elif account_type == "savings":
            self.accounts[len(self.accounts) + 1] = SavingsAccount(holder, balance)
        else:
            raise ValueError("must be either 'checking', 'savings', or blank")

    def remove_account(self, account_id):
        del self.accounts[account_id]

    def find_account_by_id(self, account_id):
        if account_id in self.accounts:
            return self.accounts[account_id]
        else:
            raise KeyError("Account not found")

    def find_account_by_holder(self, holder):
        for account_id in self.accounts:
            if self.accounts[account_id].holder == holder:
                return self.accounts[account_id]
        raise KeyError("Account not found")

    def save_bank_info_to_file(self, file_name):
        with open("{name}.bank".format(name=file_name), 'w+') as f:
            f.write(str(self))

    def __str__(self):
        result = self.name + "\n"
        for account_id in self.accounts:
            result += "{id}) {account} \n".format(id=account_id, account=str(self.accounts[account_id]))
        return result