-- =============================
-- Library Management System: Physical Schema 
-- =============================

-- Table: Book
-- Stores information about books (inherits from Item)
CREATE TABLE `Book` (
  `ItemID` INT PRIMARY KEY,
  `Title` VARCHAR(255),
  `Author` VARCHAR(255),
  `Genre` VARCHAR(255),
  `PubYear` INT,
  `Availability` BOOL
);

-- Table: DigitalMedia
-- Stores digital media items like videos or ebooks
CREATE TABLE `DigitalMedia` (
  `ItemID` INT PRIMARY KEY,
  `Title` VARCHAR(255),
  `MediaType` VARCHAR(255),
  `Creator` VARCHAR(255),
  `Availability` BOOL
);

-- Table: Magazine
-- Stores magazine-specific info
CREATE TABLE `Magazine` (
  `ItemID` INT PRIMARY KEY,
  `Title` VARCHAR(255),
  `IssueNumber` INT,
  `PublicationDate` INT,
  `Status` BOOL
);

-- Table: Member
-- Library users (borrowers)
CREATE TABLE `Member` (
  `MemberID` INT PRIMARY KEY AUTO_INCREMENT,
  `Name` VARCHAR(255),
  `Contact` VARCHAR(255),
  `TypeID` CHAR,
  `AccountStatus` ENUM('Active', 'Suspended', 'Closed')
);

-- Table: MembershipType
-- Defines membership categories and rules
CREATE TABLE `MembershipType` (
  `TypeID` CHAR PRIMARY KEY,
  `TypeName` VARCHAR(255),
  `BorrowLimit` INT,
  `LateFeeRate` INT
);

-- Table: Loan
-- Tracks borrowed items
CREATE TABLE `Loan` (
  `LoanID` INT PRIMARY KEY AUTO_INCREMENT,
  `MemberID` INT,
  `ItemID` INT,
  `ItemType` VARCHAR(255),
  `LoanDate` DATE,
  `DueDate` DATE,
  `ReturnDate` DATE,
  `FineID` INT,
  `LibrarianID` INT
);

-- Table: Fine
-- Late fees associated with loans
CREATE TABLE `Fine` (
  `FineID` INT PRIMARY KEY AUTO_INCREMENT,
  `LoanID` INT,
  `Amount` INT,
  `PaymentStatus` ENUM('Paid', 'Unpaid')
);

-- Table: Reservation
-- Stores reservation requests for items
CREATE TABLE `Reservation` (
  `ReservationID` INT PRIMARY KEY AUTO_INCREMENT,
  `MemberID` INT,
  `ItemID` INT,
  `ItemType` VARCHAR(255),
  `RequestDate` DATE,
  `Status` BOOL
);

-- Table: Librarian
-- Library staff who handle transactions
CREATE TABLE `Librarian` (
  `LibrarianID` INT PRIMARY KEY AUTO_INCREMENT,
  `Name` VARCHAR(255),
  `Contact` VARCHAR(255),
  `Role` ENUM('Admin', 'Staff')
);

-- Table: Item
-- Superclass for all loanable/reservable materials
CREATE TABLE `Item` (
  `ItemID` INT PRIMARY KEY AUTO_INCREMENT,
  `Title` VARCHAR(255),
  `Availability` BOOL
);

-- =============================
-- Foreign Key Constraints
-- =============================

-- Book, DigitalMedia, Magazine inherit from Item
ALTER TABLE `Book` ADD FOREIGN KEY (`ItemID`) REFERENCES `Item` (`ItemID`);
ALTER TABLE `DigitalMedia` ADD FOREIGN KEY (`ItemID`) REFERENCES `Item` (`ItemID`);
ALTER TABLE `Magazine` ADD FOREIGN KEY (`ItemID`) REFERENCES `Item` (`ItemID`);

-- Member → MembershipType
ALTER TABLE `Member` ADD FOREIGN KEY (`TypeID`) REFERENCES `MembershipType` (`TypeID`);

-- Loan → Member, Item, Fine, Librarian
ALTER TABLE `Loan` ADD FOREIGN KEY (`MemberID`) REFERENCES `Member` (`MemberID`);
ALTER TABLE `Loan` ADD FOREIGN KEY (`ItemID`) REFERENCES `Item` (`ItemID`);
ALTER TABLE `Loan` ADD FOREIGN KEY (`FineID`) REFERENCES `Fine` (`FineID`);
ALTER TABLE `Loan` ADD FOREIGN KEY (`LibrarianID`) REFERENCES `Librarian` (`LibrarianID`);

-- Fine → Loan
ALTER TABLE `Fine` ADD FOREIGN KEY (`LoanID`) REFERENCES `Loan` (`LoanID`);

-- Reservation → Member, Item
ALTER TABLE `Reservation` ADD FOREIGN KEY (`MemberID`) REFERENCES `Member` (`MemberID`);
ALTER TABLE `Reservation` ADD FOREIGN KEY (`ItemID`) REFERENCES `Item` (`ItemID`);
