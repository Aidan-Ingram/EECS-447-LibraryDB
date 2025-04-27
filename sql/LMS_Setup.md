# Library Management System (LMS) - Full Setup Guide in MariaDB

**Team:** SQLibrary  
**Project:** 447 Part 5

---

## Step 1: Install and Start MariaDB (macOS with Homebrew)

```bash
brew install mariadb
brew services start mariadb
```

## Step 2: Secure MariaDB and Log In

```bash
mysql_secure_installation
mysql -u root -p
```

## Step 3: Create the LMS Database - If you wish to use DataGrip from now on, skip down to Step 7

```sql
CREATE DATABASE LMS;
USE LMS;
```

## Step 5: Create Tables

### Book

```sql
CREATE TABLE Book (
    ItemID BIGINT(20) NOT NULL (PK),
    Author VARCHAR(100) DEFAULT NULL,
    Genre VARCHAR(50) DEFAULT NULL,
    PubYear YEAR DEFAULT NULL,
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
);
```

### DigitalMedia

```sql
CREATE TABLE DigitalMedia (
    ItemID BIGINT(20) NOT NULL (PK),
    MediaType VARCHAR(50) DEFAULT NULL,
    Creator VARCHAR(100) DEFAULT NULL,
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
);
```

### Item
```sql
CREATE TABLE Item (
    ItemID BIGINT(20) NOT NULL (PK),
    Title VARCHAR(200) DEFAULT NULL,
    Availability ENUM('Available', 'Reserved') NOT NULL,
    ItemType ENUM('Book', 'Magazine', 'Digital Media') NOT NULL
);
```
### Librarian

```sql
CREATE TABLE Librarian (
    LibrarianID INT(11) AUTO_INCREMENT (PK),
    Name VARCHAR(100) DEFAULT NULL,
    Contact VARCHAR(100) DEFAULT NULL,
    Role ENUM('Admin', 'Staff') DEFAULT NULL
);
```
### Loan

```sql
CREATE TABLE Loan (
    LoanID INT PRIMARY KEY AUTO_INCREMENT,
    MemberID INT,
    ItemID INT,
    ItemType VARCHAR(255),
    LoanDate DATE,
    DueDate DATE,
    ReturnDate DATE,
    FineID INT,
    LibrarianID INT
);
```
### Magazine

```sql
CREATE TABLE Magazine (
    ItemID BIGINT(20) NOT NULL (PK),
    IssueNumber INT(11) DEFAULT NULL,
    PublicationDate YEAR DEFAULT NULL,
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
);
);
```

### Member

```sql
CREATE TABLE Member (
    MemberID VARCHAR(36) NOT NULL (PK),
    Name VARCHAR(100) DEFAULT NULL,
    Contact VARCHAR(100) DEFAULT NULL,
    TypeID CHAR(1) NOT NULL,
    AccountStatus ENUM('Active', 'Suspended', 'Closed') DEFAULT NULL,
    FOREIGN KEY (TypeID) REFERENCES MembershipType(TypeID)
);
```

### MembershipType

```sql
CREATE TABLE MembershipType (
    TypeID CHAR(1) NOT NULL (PK),
    TypeName VARCHAR(20) DEFAULT NULL,
    BorrowLimit INT(11) DEFAULT NULL,
    LateFeeRate INT(11) DEFAULT NULL
);
```

### Fine

```sql
CREATE TABLE Fine (
    FineID BIGINT(20) NOT NULL (PK),
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentStatus ENUM('Paid', 'Unpaid') DEFAULT NULL,
    MemberID VARCHAR(36) NOT NULL,
    MemberType CHAR(1) NOT NULL,
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
    FOREIGN KEY (MemberType) REFERENCES MembershipType(TypeID)
);
```

### Reservation

```sql
CREATE TABLE Reservation (
    ReservationID INT PRIMARY KEY AUTO_INCREMENT,
    MemberID INT,
    ItemID INT,
    ItemType VARCHAR(255),
    RequestDate DATE,
    Status BOOLEAN
);
```

## Optional step

## Step 5: Create Admin User for Remote Access

```sql
CREATE USER 'lms_admin'@'%' IDENTIFIED BY 'Teamsqllibrary';
GRANT ALL PRIVILEGES ON *.* TO 'lms_admin'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```

## Step 6: Expose MariaDB to Teammates via Ngrok

```bash
ngrok tcp 3306
```

Ngrok output:

```
Forwarding tcp://6.tcp.ngrok.io:12368 -> localhost:3306
```

Teammate Connection:

- Host: 6.tcp.ngrok.io
- Port: 12368
- Username: lms_admin
- Password: Teamsqllibrary
- Database: LMS

## Step 7: Connect to MariaDB Using DataGrip

1. Open **DataGrip**.
2. Click **+** → **Data Source** → **MariaDB**.
3. In the connection window:
   - **Host**: Use `localhost` if running locally, or `6.tcp.ngrok.io` if using Ngrok.
   - **Port**: `3306` locally, or Ngrok forwarded port (e.g., `12368`).
   - **User**: `lms_admin`, or root locally
   - **Password**: `Teamsqllibrary`, or whatever you set your MariaDB root pwd to.
4. Test the connection and click **OK**.

## Step 8: Import Data into Tables (From CSV Files)

1. Right-click the table (e.g., `Item`) → **Import Data from File**.
2. Select the corresponding `.csv` file from the `Data/` folder.
3. Confirm column mappings.
4. Click **Import**.

### CSV Files to Import:
| Table | CSV File |
|:---|:---|
| MembershipType | MembershipType.csv |
| Member | Member.csv |
| Item | Item.csv |
| Book | Book.csv |
| DigitalMedia | DigitalMedia.csv |
| Magazine | Magazine.csv |
| Librarian | Librarian.csv |
| Loan | Loan.csv |
| Fine | Fine.csv |
| Reservation | Reservation.csv |

## Step 9: Manipulate Data

Once you are using the LMS databse and it has been successfully brought into DataGrip, AND you've filled it with data, you can use the SQL console to enter commands, and run them. You should get output tables in the result windows. 
