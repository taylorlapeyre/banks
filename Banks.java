import java.util.*;

package Banks;

public class BankAccount {
    float balance;
    String holder;
    int transactionCount;

    public BankAccount(String holder, float balance) {
        this.transactionCount = 0;
        this.balance = balance;
        this.holder  = holder;
    }

    public static float deposit(float ammount) {
        this.transactionCount += 1;
        this.balance += ammount;
        return this.balance;
    }

    public static float withdraw(float ammount) {
        this.transactionCount += 1;
        this.balance -= ammount;
        return ammount;
    }

    public static String toString() {
        return "Holder: " + this.holder + " -- Balance: $" + this.balance + ".";
    }
}


public class CheckingAccount extends BankAccount {
    final int FREE_TRANSACTIONS = 15;
    final float TRANSACTION_FEE = 5.0;

    public CheckingAccount(holder, balance) {
        super(holder, balance);
    }

    public static void deductFees() {

    }
}