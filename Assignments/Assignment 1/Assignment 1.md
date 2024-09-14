# CMPS 312 Mobile Application Development

## Assessment #1

**Deadline**: Sunday, 22, at 3:00 PM

---

### Question 1 [50%]

You are required to develop a `books_donation` application. Through this application, you will practice Dart programming language features such as mixins, extension functions, arrow functions, and built-in collection methods.

#### Tasks

1. **Project Setup**

   - Create a Dart project named `books_donation`.
   - Copy the `data` folder:
     - From your lab repository `assignments/assignment1` into the root directory of your `books_donation` project.
     - The `catalog-books.json` file contains the list of books that you will use.
2. **Book Class**

   - Create a `Book` class with the following attributes:
     - `title`: a `String` representing the book title.
     - `authors`: a `List<String>` representing the authors of the book.
     - `pageCount`: an `int` representing the number of pages.
     - `category`: a `String` representing the book category.
3. **BooksRepo Class**

   - Create the `BooksRepo` class that:

     - Reads the `catalog-books.json` file and parses it into a list of `Book` objects.
   - Implement the following methods:

     - `getBook(String name)`: Returns the `Book` object if found, otherwise throws an exception.
     - `getBooksByPageCount(int pageCount)`: Returns all books with page counts greater than or equal to the given count.
     - `getBooksByCategory(String category)`: Returns all books from the specified category.
     - `getAuthorsBookCount()`: Returns a map with author names as keys and the count of books they have authored as values.
4. **Extension Methods on `List<Book>`**

   - Create extension methods on `List<Book>` to:
     - Add a method `filterByAuthor(String author)` which returns all books written by the given author.
     - Add a method `filterByCategory(String category)` which returns all books of the specified category.
   - Use arrow functions to implement these methods concisely.
   - Use Dart's built-in collection methods such as `.map()`, `.reduce()`, `.where()`, and `.sort()` where appropriate. Ensure no traditional loops (`for`, `while`) are used in your implementations.
5. **Testing**

   - Implement the `main()` function to demonstrate the functionality of the `BooksRepo` and extensions methods.
   - Test various scenarios directly by printing the results to the console.

---

### Question 2 [50%]

You are required to implement a banking system with the following requirements. This question, will test your understanding of Object-Oriented Programming concepts such as inheritance, polymorphism, abstract classes, interfaces, and encapsulation.

#### Tasks

1. **Customer Class**

   - Create a `Customer` class with the following attributes:
     - `name`: a `String` representing the customer's name.
     - `age`: an `int` representing the customer's age.
     - `accounts`: a `List<Account>` containing the accounts owned by the customer.
   - Methods:
     - `addAccount(Account account)`: adds an account to the customer’s list of accounts.
     - `getTotalBalance()`: returns the total balance across all customer accounts.
     - `getDetails()`: returns a string containing the customer’s information.
2. **Account Class**

   - Create an `Account` class with the following attributes:
     - `accountNumber`: a `String` representing the account number.
     - `balance`: a `double` representing the balance of the account.
     - `transactions`: a `List<AccountTransaction>` representing all transactions associated with this account.
   - Methods:
     - `deposit(double amount)`: deposits money into the account, with validation for negative amounts.
     - `withdraw(double amount)`: withdraws money from the account, with validation for overdraws.
3. **AccountTransaction Class**

   - Create an `AccountTransaction` class with the following attributes:
     - `transactionType`: a `String` representing the type of transaction (either "deposit" or "withdrawal").
     - `amount`: a `double` representing the transaction amount.
4. **Mixin: TransactionLogger**

   - Create a mixin `TransactionLogger` to:
     - Add methods to log transactions for accounts where detailed transaction history is needed.
     - Apply the mixin to the `SavingsAccount` class.
   - Methods:
     - `logTransaction(String description)`: logs a transaction.
     - `printTransactionLog()`: prints all the logged transactions for the account.
5. **SavingsAccount and CurrentAccount Classes**

   - Extend `Account` to create:
     - **SavingsAccount**:
       - **Properties**:
         - `profitSharingRatio`: a `double` representing the ratio of profit-sharing between the account holder and the bank (e.g., 70% account holder, 30% bank).
         - `investmentProfit`: a `double` representing the total profit generated from investments.
       - **Methods**:
         - `applyProfit()`: A method that calculates the account holder’s share of profits based on the `profitSharingRatio` and applies it to the balance.
         - `calculateProfit(double totalProfit)`: A method to set the `investmentProfit` and calculate the account holder’s share.
     - **CurrentAccount**:
       - **Properties**:
         - `overdraftLimit`: a `double` representing the maximum amount the account can go into overdraft.
         - `overdraftFee`: a `double` representing the fee applied when the account goes into overdraft.
         - `overdraftProtection`: a `bool` flag to indicate if overdraft protection is enabled.
       - **Methods**:
         - `withdraw(double amount)`: Overridden method to handle withdrawals with overdraft protection and fee applications if necessary.
6. **Interface: Taxable**

   - Define an interface `Taxable` that provides a method `applyTax()` for accounts that might be taxable.
   - Implement the interface in `SavingsAccount` to apply a 5% tax on any investment profits (if applicable under certain tax laws).
7. **Testing**

   - Demonstrate the functionalities of all the classes and relationships by writing code in the `main()` function.
   - Ensure proper validation and scenarios such as account creation, deposit, withdrawal, profit-sharing application, and tax application are covered.

---

### Deliverables

- Fill out the `Lab1-TestingDoc-Grading-Sheet.docx` and save it in the `Assignments/Assignment1` folder of your repository.
- Your submission should include:
  - The Dart source code for the project.
  - Testing sheet that has all the outputs of the tested methods.
- Sync your repository to push your work to GitHub.

**Note**: Ensure your code adheres to best practices, is well-commented, and handles exceptions gracefully. Good luck!

---
