-- Drop child tables first (Reservation depends on Member too!)
DROP TABLE IF EXISTS `Reservation`;
DROP TABLE IF EXISTS `Loan`;
DROP TABLE IF EXISTS `Fine`;
DROP TABLE IF EXISTS `Member`;

-- Then drop MembershipType (parent)
DROP TABLE IF EXISTS `MembershipType`;

-- Then drop others related to Item
DROP TABLE IF EXISTS `Book`;
DROP TABLE IF EXISTS `Magazine`;
DROP TABLE IF EXISTS `DigitalMedia`;
DROP TABLE IF EXISTS `Item`;

-- Then Librarian
DROP TABLE IF EXISTS `Librarian`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `MembershipType` (
                                  `TypeID` char(1) NOT NULL,
                                  `TypeName` varchar(20) DEFAULT NULL,
                                  `BorrowLimit` int(11) DEFAULT NULL,
                                  `LateFeeRate` int(11) DEFAULT NULL,
                                  PRIMARY KEY (`TypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MembershipType`
--

LOCK TABLES `MembershipType` WRITE;
/*!40000 ALTER TABLE `MembershipType` DISABLE KEYS */;
/*!40000 ALTER TABLE `MembershipType` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `Member`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Member` (
                          `MemberID` varchar(36) NOT NULL,
                          `Name` varchar(100) DEFAULT NULL,
                          `Contact` varchar(100) DEFAULT NULL,
                          `TypeID` char(1) NOT NULL,
                          `AccountStatus` enum('Active','Suspended','Closed') DEFAULT NULL,
                          PRIMARY KEY (`MemberID`),
                          KEY `TypeID` (`TypeID`),
                          CONSTRAINT `member_ibfk_1` FOREIGN KEY (`TypeID`) REFERENCES `MembershipType` (`TypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Member`
--

LOCK TABLES `Member` WRITE;
/*!40000 ALTER TABLE `Member` DISABLE KEYS */;
/*!40000 ALTER TABLE `Member` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `Item`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Item` (
                        `ItemID` bigint(20) NOT NULL,
                        `Title` varchar(200) DEFAULT NULL,
                        `Availability` ENUM('Available', 'Reserved') DEFAULT NULL,
                        `ItemType` enum('Book', 'Magazine', 'DigitalMedia') NOT NULL,
                        PRIMARY KEY (`ItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Item`
--

LOCK TABLES `Item` WRITE;
/*!40000 ALTER TABLE `Item` DISABLE KEYS */;
/*!40000 ALTER TABLE `Item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for `Book`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Book` (
                        `ItemID` bigint(20) NOT NULL,
                        `Author` varchar(100) DEFAULT NULL,
                        `Genre` varchar(50) DEFAULT NULL,
                        `PubYear` year DEFAULT NULL,
                        PRIMARY KEY (`ItemID`),
                        CONSTRAINT `book_ibfk_1` FOREIGN KEY (`ItemID`) REFERENCES `Item` (`ItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Book`
--

LOCK TABLES `Book` WRITE;
/*!40000 ALTER TABLE `Book` DISABLE KEYS */;
/*!40000 ALTER TABLE `Book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DigitalMedia`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `DigitalMedia` (
                                `ItemID` bigint(20) NOT NULL,
                                `MediaType` varchar(50) DEFAULT NULL,
                                `Creator` varchar(100) DEFAULT NULL,
                                PRIMARY KEY (`ItemID`),
                                CONSTRAINT `digitalmedia_ibfk_1` FOREIGN KEY (`ItemID`) REFERENCES `Item` (`ItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DigitalMedia`
--

LOCK TABLES `DigitalMedia` WRITE;
/*!40000 ALTER TABLE `DigitalMedia` DISABLE KEYS */;
/*!40000 ALTER TABLE `DigitalMedia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Librarian`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Librarian` (
                             `LibrarianID` int(11),
                             `Name` varchar(100) DEFAULT NULL,
                             `Contact` varchar(100) DEFAULT NULL,
                             `Role` enum('Admin','Staff') DEFAULT NULL,
                             PRIMARY KEY (`LibrarianID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Librarian`
--

LOCK TABLES `Librarian` WRITE;
/*!40000 ALTER TABLE `Librarian` DISABLE KEYS */;
/*!40000 ALTER TABLE `Librarian` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Fine`
--

-- Create Fine table (no FK to Loan anymore)
CREATE TABLE `Fine` (
                        `FineID` bigint(20) NOT NULL,
                        `Amount` DECIMAL(10, 2) NOT NULL,
                        `PaymentStatus` enum('Paid','Unpaid') DEFAULT NULL,
                        `MemberID` varchar(36) NOT NULL,
                        `MemberType` char(1) NOT NULL,
                        PRIMARY KEY (`FineID`),
                        KEY `MemberID` (`MemberID`),
                        KEY `MemberType` (`MemberType`),
                        CONSTRAINT `fine_ibfk_member` FOREIGN KEY (`MemberID`) REFERENCES `Member` (`MemberID`),
                        CONSTRAINT `fine_ibfk_membertype` FOREIGN KEY (`MemberType`) REFERENCES `MembershipType` (`TypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Create Loan table (Loan links to Fine optionally)
CREATE TABLE `Loan` (
                        `LoanID` bigint(20) NOT NULL,
                        `MemberID` varchar(36) NOT NULL,
                        `ItemID` bigint(20) NOT NULL,
                        `LoanDate` date DEFAULT NULL,
                        `DueDate` date DEFAULT NULL,
                        `ReturnDate` date DEFAULT NULL,
                        `FineID` bigint(20) DEFAULT NULL,
                        `LibrarianID` int(11) DEFAULT NULL,
                        `LateReturn` enum('Yes', 'No') NOT NULL,
                        PRIMARY KEY (`LoanID`),
                        KEY `MemberID` (`MemberID`),
                        KEY `ItemID` (`ItemID`),
                        KEY `FineID` (`FineID`),
                        KEY `LibrarianID` (`LibrarianID`),
                        CONSTRAINT `loan_ibfk_member` FOREIGN KEY (`MemberID`) REFERENCES `Member` (`MemberID`),
                        CONSTRAINT `loan_ibfk_item` FOREIGN KEY (`ItemID`) REFERENCES `Item` (`ItemID`),
                        CONSTRAINT `loan_ibfk_fine` FOREIGN KEY (`FineID`) REFERENCES `Fine` (`FineID`),
                        CONSTRAINT `loan_ibfk_librarian` FOREIGN KEY (`LibrarianID`) REFERENCES `Librarian` (`LibrarianID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Table structure for table `Magazine`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Magazine` (
                            `ItemID` bigint(20) NOT NULL,
                            `IssueNumber` int(11) DEFAULT NULL,
                            `PublicationDate` year DEFAULT NULL,
                            PRIMARY KEY (`ItemID`),
                            CONSTRAINT `magazine_ibfk_1` FOREIGN KEY (`ItemID`) REFERENCES `Item` (`ItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Magazine`
--

LOCK TABLES `Magazine` WRITE;
/*!40000 ALTER TABLE `Magazine` DISABLE KEYS */;
/*!40000 ALTER TABLE `Magazine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reservation`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reservation` (
                               `ReservationID` bigint(20) NOT NULL,
                               `MemberID` varchar(36) NOT NULL,
                               `ItemID` bigint(20) NOT NULL,
                               `RequestDate` date DEFAULT NULL,
                               PRIMARY KEY (`ReservationID`),
                               KEY `MemberID` (`MemberID`),
                               KEY `ItemID` (`ItemID`),
                               CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`MemberID`) REFERENCES `Member` (`MemberID`),
                               CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`ItemID`) REFERENCES `Item` (`ItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reservation`
--

LOCK TABLES `Reservation` WRITE;
/*!40000 ALTER TABLE `Reservation` DISABLE KEYS */;
/*!40000 ALTER TABLE `Reservation` ENABLE KEYS */;
UNLOCK TABLES;
