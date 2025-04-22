
# Library Management System (LMS) - Full Setup Guide in MariaDB

**Prepared by:** Kemar Wilson  
**Team:** SQLibrary  
**Project:** 447 Part 4

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

### Book
```sql
CREATE TABLE Book (
    BookID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255),
    Author VARCHAR(255),
    Genre VARCHAR(255),
    PubYear INT,
    Availability BOOLEAN
);
```

### DigitalMedia
```sql
CREATE TABLE DigitalMedia (
    MediaID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255),
    MediaType VARCHAR(255),
    Creator VARCHAR(255),
    Availability BOOLEAN
);
```

### Magazine
```sql
CREATE TABLE Magazine (
    MagazineID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255),
    IssueNumber INT,
    PublicationDate INT,
    Status BOOLEAN
);
```

### Member
```sql
CREATE TABLE Member (
    MemberID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255),
    Contact VARCHAR(255),
    TypeID VARCHAR(5),
    AccountStatus ENUM('Active', 'Suspended', 'Closed')
);
```

### MembershipType
```sql
CREATE TABLE MembershipType (
    TypeID VARCHAR(5) PRIMARY KEY,
    TypeName VARCHAR(255),
    BorrowLimit INT,
    LateFeeRate INT
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

### Fine
```sql
CREATE TABLE Fine (
    FineID INT PRIMARY KEY AUTO_INCREMENT,
    LoanID INT,
    Amount INT,
    PaymentStatus ENUM('Paid', 'Unpaid')
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

### Librarian
```sql
CREATE TABLE Librarian (
    LibrarianID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255),
    Contact VARCHAR(255),
    Role ENUM('Admin', 'Staff')
);
```

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
