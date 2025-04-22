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

## Step 3: Create the LMS Database

```sql
CREATE DATABASE LMS;
USE LMS;
```

## Step 4: Create Tables

### MembershipType

```sql
CREATE TABLE MembershipType (
    TypeID CHAR(2) PRIMARY KEY,
    TypeName VARCHAR(100),
    BorrowLimit INT CHECK (BorrowLimit >= 0),
    LateFeeRate INT CHECK (LateFeeRate >= 0)
);
```

### Member

```sql
CREATE TABLE Member (
    MemberID INT PRIMARY KEY,
    Name VARCHAR(100),
    Contact VARCHAR(100),
    TypeID CHAR(2),
    AccountStatus ENUM('Active', 'Suspended', 'Closed'),
    FOREIGN KEY (TypeID) REFERENCES MembershipType(TypeID)
);
```

### Item

```sql
CREATE TABLE Item (
    ItemID INT PRIMARY KEY,
    Title VARCHAR(255),
    Availability BOOLEAN
);
```

### Book

```sql
CREATE TABLE Book (
    ItemID INT PRIMARY KEY,
    Title VARCHAR(255),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    PubYear INT CHECK (PubYear >= 1450),
    Availability BOOLEAN,
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
);
```

### DigitalMedia

```sql
CREATE TABLE DigitalMedia (
    ItemID INT PRIMARY KEY,
    Title VARCHAR(255),
    MediaType VARCHAR(100),
    Creator VARCHAR(100),
    Availability BOOLEAN,
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
);
```

### Magazine

```sql
CREATE TABLE Magazine (
    ItemID INT PRIMARY KEY,
    Title VARCHAR(255),
    IssueNumber INT,
    PublicationDate INT CHECK (PublicationDate >= 1660),
    Status BOOLEAN,
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
);
```

### Librarian

```sql
CREATE TABLE Librarian (
    LibrarianID INT PRIMARY KEY,
    Name VARCHAR(100),
    Contact VARCHAR(100),
    Role ENUM('Admin', 'Staff')
);
```

### Fine

```sql
CREATE TABLE Fine (
    FineID INT PRIMARY KEY,
    LoanID INT,
    Amount INT CHECK (Amount >= 0),
    PaymentStatus ENUM('Paid', 'Unpaid')
);
```

### Loan

```sql
CREATE TABLE Loan (
    LoanID INT PRIMARY KEY,
    MemberID INT,
    ItemID INT,
    ItemType VARCHAR(50),
    LoanDate DATE,
    DueDate DATE,
    ReturnDate DATE,
    FineID INT,
    LibrarianID INT,
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID),
    FOREIGN KEY (FineID) REFERENCES Fine(FineID),
    FOREIGN KEY (LibrarianID) REFERENCES Librarian(LibrarianID)
);
```

### Reservation

```sql
CREATE TABLE Reservation (
    ReservationID INT PRIMARY KEY,
    MemberID INT,
    ItemID INT,
    ItemType VARCHAR(50),
    RequestDate DATE,
    Status BOOLEAN,
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
);
```

## Step 5: Create Admin User for Remote Access

```sql
CREATE USER 'lms_admin'@'%' IDENTIFIED BY 'Teamsqllibrary';
GRANT ALL PRIVILEGES ON *.* TO 'lms_admin'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```

## Optional

## Step 6: Expose MariaDB to Teammates via Ngrok

```bash
ngrok tcp 3306
```

Ngrok output:

```
Forwarding tcp://6.tcp.ngrok.io:12368 → localhost:3306
```

Teammate Connection:

- Host: 6.tcp.ngrok.io
- Port: 12368
- Username: lms_admin
- Password: Teamsqllibrary
- Database: LMS
