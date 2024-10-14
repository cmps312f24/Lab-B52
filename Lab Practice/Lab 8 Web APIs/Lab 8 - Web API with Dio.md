# CMPS 312 Mobile App Development  
## Lab 8 – Web API with Dio

### PART A: Implement the Dio Network Layer

1. **Create the BankingRepository Class**:  
   - Implement a `BankingRepository` class in Flutter that uses Dio to communicate with the Banking Web API.
   - Use the following structure:
   ```dart
   class BankingRepository {
     final Dio _dio = Dio();
     final String _baseUrl = 'https://api1.codedbyyou.com/api';
   }

### PART B: CRUD Operations

#### 1. Create Operations

- **Method Name: `createTransfer`**  
  - Create a new transfer using the API endpoint `POST /api/transfers/:cid`.
  - Send fields such as `fromAccountNo`, `amount`, `beneficiaryName`, and `beneficiaryAccountNo`.

- **Method Name: `addBeneficiary`**  
  - Add a new beneficiary using `PUT /api/beneficiaries/:cid`.

#### 2. Read Operations

- **Method Name: `getCustomers`**  
  - Retrieve all customers using `GET /api/customers`.

- **Method Name: `getCustomerAccounts`**  
  - Retrieve accounts associated with a customer ID using `GET /api/accounts/:cid`.

- **Method Name: `getTransfers`**  
  - Fetch all transfers for a customer using `GET /api/transfers/:cid`.

- **Method Name: `getBeneficiaries`**  
  - Retrieve beneficiaries for a customer using `GET /api/beneficiaries/:cid`.

#### 3. Delete Operations

- **Method Name: `deleteTransfer`**  
  - Delete a transfer using `DELETE /api/transfers/:cid/:transferId`.

- **Method Name: `deleteBeneficiary`**  
  - Delete a beneficiary using `DELETE /api/beneficiaries/:cid/:accountNo`.