**This is a very minimal "Bank" library for Java.**

Within this program, you can make banks, savings accounts, checking accounts, save your banks to files, load banks from files, and get information on pretty much anything.

Sample Usage:

``` java
Bank chase = new Bank("Chase Bank");
chase.addAccount("checking", "Taylor Lapeyre", "0");
chase.addAccount("savings", "Scrooge McDuck", "100");

chase.findAccountById(1).deposit(10);
chase.findAccountById(1).toString();

chase.save_bank_info_to_file("chase.bank");
```
