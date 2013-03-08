class UseBanks {
  public static void main(String[] args) {
    Bank chase = new Bank("Chase Bank");
    chase.addAccount("checking", "Taylor Lapeyre", "0");
    chase.addAccount("savings", "Scrooge McDuck", "100");

    chase.findAccountById(1).deposit(10);
    chase.findAccountById(1).toString();

    chase.save_bank_info_to_file("chase.bank");
  }
}