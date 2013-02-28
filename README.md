**This is a very minimal "Bank" library for python.**

Within this program, you can make banks, savings accounts, checking accounts, save your banks to files, load banks from files, and get information on pretty much anything.

Sample Usage:

``` python
from banks import *

chase = Bank("Chase Bank")

chase.add_account("Taylor Lapeyre", 0)
chase.add_account("Scrooge McDuck", 300, "savings")

chase.find_account_by_id(1).deposit(10)
str(chase.find_account_by_id(1))

chase.save_bank_info_to_file("chase")

```
