# ****CMPS 312 Mobile Application Development**
Lab 4 – Lab: Records and Pattern Matching**

**Lab Overview**

In this lab, students will practice using** ****Dart's records and pattern matching** features**

**Lab Objectives**

By the end of this lab, students should be able to:

* Understand and utilize Dart's records to store and manage data efficiently.
* Apply pattern matching in Dart to destructure records and simplify conditional logic.
* Used Sealed types to restrict the set of possible values for a given type, ensuring that only a finite set of values can be represented. This concept is useful for defining mutually exclusive states.

## **Dart Records and Pattern Matching**

You are developing a backend system for a bank to manage customer information and process transactions. You'll use Dart's records and pattern matching to efficiently handle customer data and transactions like deposits, withdrawals, and transfers.

### **Exercise 1: Creating Customer Records**

1. Create a new project and name it "q_bank"
2. Write a function  `(String, int, double) createCustomer()` that returns a record for customer details.

   ```
   Customer Details:
   Name: Alice Smith
   Account Number: 987654321
   Balance: 2500.0
   ```
3. In the main function create a record by calling the function and print the returned record values. using positional accessors **[`$1`, `$2`, and `$3`]**

**Expected Output**

```
Customer: Alice Smith, Account: 987654321, Balance: $2500.0
```

---

### **Exercise 2: Destructuring Records with Pattern Matching**

Use pattern matching to destructure records into individual variables.


**Destructure the Customer Record**

1. Using the** **`customer` **record from Exercise 1, **destructure** it into variables: **`name`,** **`accountNumber`, and** **`balance`**.

2. Print out the variables.

**Expected Output**

```
Name: Alice Smith
Account Number: 987654321
Balance: $2500.0
```


---

### **Exercise 3: Handling Transactions with Pattern Matching**

Apply pattern matching in switch statements to process banking transactions.

**Create a List of Transactions**

1. * Transactions:

     * `('deposit', 1500.0)`
     * `('withdrawal', 2000.0)`
     * `('withdrawal', 1000.0)`
   * Store these transactions in a list.

     ```
     void main() {
       var customer = ('Alice Smith', 987654321, 2500.0);
       var transactions = [
         ('deposit', 1500.0),
         ('withdrawal', 2000.0),
         ('withdrawal', 1000.0),
       ];
       var balance = customer.$3;

      ......

     }
     ```
2. **Process Each Transaction**
   * Loop through the list of transactions.
   * Use a** **`switch` statement with pattern matching to handle each transaction type.
   * Update the customer's balance accordingly.
   * Ensure withdrawals do not exceed the current balance; if they do, print "Insufficient funds".

**Expected Output**

```
Deposited $1500.0. New balance: $4000.0
Withdrew $2000.0. New balance: $2000.0
Withdrew $1000.0. New balance: $1000.0
Final balance: $1000.0
```

---

### **Exercise 4: Advanced Pattern Matching**

Extend pattern matching to handle additional transaction types and conditions using the **when** operator**.**

1. **Add a New Transaction Type**

   * Introduce a `('transfer', double amount, int targetAccountNumber)` transaction type.
   * When processing a transfer:
     * Deduct the amount from the current customer's balance if sufficient funds exist.
     * Print a message indicating the transfer to the target account.
2. **Modify the Switch Statement**

   * Update the switch statement to handle the new** **`transfer` transaction.
   * Include appropriate conditions to check for sufficient funds.
3. **Test the New Transaction Type**

   * Add a transfer transaction, e.g.,** **`('transfer', 500.0, 555666777)`, to the transactions list.
   * Process the transaction and print the outcome.

   ```
   void main() {
     var customer = ('Alice Smith', 987654321, 2500.0);
     var transactions = [
       ('deposit', 1500.0),
       ('withdrawal', 2000.0),
       ('withdrawal', 1000.0),
     ];
     var balance = customer.$3;

     for (var transaction in transactions) {
       switch (transaction) {
          .... write your code here....
       }
     }

     print('Final balance: \$${balance}');
   }

   ```

**Expected Output**

```
Deposited $1500.0. New balance: $4000.0
Withdrew $2000.0. New balance: $2000.0
Withdrew $1000.0. New balance: $1000.0
Final balance: $1000.0
```

---

### **Exercise 5: Using Named Fields in Records**

Learn how to create and use records with named fields for better code readability.

1. **Create a Record with Named Fields**

   * Create a customer record using named fields:
     * `name`:** **`Bob Johnson`
     * `accountNumber`:** **`1122334455`
     * `balance`:** **`6000.0`
   * Print out the customer's details using the field names.

   ```
   void main() {
     var customer = ... write your code here.....
     print('Customer: ${customer.name}, Account: ${customer.accountNumber}, Balance: \$${customer.balance}');
   }

   ```

**Expected Output**

```
Customer: Sara Lee
Account Number: 9988776655
Balance: $7500.0
Address: 123 Main St, Doha, Qatar
```

---

### **Exercise 6: Working with Nested Records**

Understand how to work with nested records and access their values.

**Create a Nested Record**

1. * Create a customer record that includes an address record:
     * Customer:
       * `name`:** **`Sara Lee`
       * `accountNumber`:** **`9988776655`
       * `balance`:** **`7500.0`
       * `address`: A record containing:
         * `street`:** **`123 Main St`
         * `city`:** **`Doha`
         * `country`:** **`Qatar`
   * Print out the customer's details, including the address. Access nested fields using dot notation.

   ```
   void main() {
   	....write your code here
   }


   ```

**Expected Output**

```
Customer: Sara Lee
Account Number: 9988776655
Balance: $7500.0
Address: 123 Main St, Doha, Qatar
```

---

### **Exercise 7: Pattern Matching with Lists of Records**

Use pattern matching to process a list of customer records.

**Instructions**

1. **Create a List of Customer Records**
   * Create a list containing multiple customer records using named fields:
     * Customer 1:
       * `name`:** **`Alice Smith`
       * `accountNumber`:** **`987654321`
       * `balance`:** **`2500.0`
     * Customer 2:
       * `name`:** **`Bob Johnson`
       * `accountNumber`:** **`1122334455`
       * `balance`:** **`6000.0`
     * Customer 3:
       * `name`:** **`Sara Lee`
       * `accountNumber`:** **`9988776655`
       * `balance`:** **`7500.0`
2. **Process the List**
   * Loop through the list and use pattern matching to destructure each customer record.
   * Print a message indicating whether each customer is a "Premium Customer" (balance >= 5000) or a "Standard Customer".
3. ```
   var customers = [
       (name: 'Alice Smith', accountNumber: 987654321, balance: 2500.0),
       (name: 'Bob Johnson', accountNumber: 1122334455, balance: 6000.0),
       (name: 'Sara Lee', accountNumber: 9988776655, balance: 7500.0),
     ];

   for (var customer in customers) {
      ..... write your code here....
     }
   ```

**Expected Output**

```
Alice Smith is a Standard Customer
Bob Johnson is a Premium Customer
Sara Lee is a Premium Customer

```
