/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.7.2-MariaDB, for osx10.20 (arm64)
--
-- Host: localhost    Database: LMS
-- ------------------------------------------------------
-- Server version	11.7.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `Book`
--

DROP TABLE IF EXISTS `Book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Book` (
  `ItemID` int(11) NOT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `Author` varchar(255) DEFAULT NULL,
  `Genre` varchar(255) DEFAULT NULL,
  `PubYear` int(11) DEFAULT NULL,
  `Availability` tinyint(1) DEFAULT NULL,
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

DROP TABLE IF EXISTS `DigitalMedia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `DigitalMedia` (
  `ItemID` int(11) NOT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `MediaType` varchar(255) DEFAULT NULL,
  `Creator` varchar(255) DEFAULT NULL,
  `Availability` tinyint(1) DEFAULT NULL,
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
-- Table structure for table `Fine`
--

DROP TABLE IF EXISTS `Fine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fine` (
  `FineID` int(11) NOT NULL AUTO_INCREMENT,
  `LoanID` int(11) DEFAULT NULL,
  `Amount` int(11) DEFAULT NULL,
  `PaymentStatus` enum('Paid','Unpaid') DEFAULT NULL,
  PRIMARY KEY (`FineID`),
  KEY `LoanID` (`LoanID`),
  CONSTRAINT `fine_ibfk_1` FOREIGN KEY (`LoanID`) REFERENCES `Loan` (`LoanID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fine`
--

LOCK TABLES `Fine` WRITE;
/*!40000 ALTER TABLE `Fine` DISABLE KEYS */;
/*!40000 ALTER TABLE `Fine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Item`
--

DROP TABLE IF EXISTS `Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Item` (
  `ItemID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) DEFAULT NULL,
  `Availability` tinyint(1) DEFAULT NULL,
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
-- Table structure for table `Librarian`
--

DROP TABLE IF EXISTS `Librarian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Librarian` (
  `LibrarianID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `Contact` varchar(255) DEFAULT NULL,
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
-- Table structure for table `Loan`
--

DROP TABLE IF EXISTS `Loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Loan` (
  `LoanID` int(11) NOT NULL AUTO_INCREMENT,
  `MemberID` int(11) DEFAULT NULL,
  `ItemID` int(11) DEFAULT NULL,
  `ItemType` varchar(255) DEFAULT NULL,
  `LoanDate` date DEFAULT NULL,
  `DueDate` date DEFAULT NULL,
  `ReturnDate` date DEFAULT NULL,
  `FineID` int(11) DEFAULT NULL,
  `LibrarianID` int(11) DEFAULT NULL,
  PRIMARY KEY (`LoanID`),
  KEY `MemberID` (`MemberID`),
  KEY `ItemID` (`ItemID`),
  KEY `FineID` (`FineID`),
  KEY `LibrarianID` (`LibrarianID`),
  CONSTRAINT `loan_ibfk_1` FOREIGN KEY (`MemberID`) REFERENCES `Member` (`MemberID`),
  CONSTRAINT `loan_ibfk_2` FOREIGN KEY (`ItemID`) REFERENCES `Item` (`ItemID`),
  CONSTRAINT `loan_ibfk_3` FOREIGN KEY (`FineID`) REFERENCES `Fine` (`FineID`),
  CONSTRAINT `loan_ibfk_4` FOREIGN KEY (`LibrarianID`) REFERENCES `Librarian` (`LibrarianID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Loan`
--

LOCK TABLES `Loan` WRITE;
/*!40000 ALTER TABLE `Loan` DISABLE KEYS */;
/*!40000 ALTER TABLE `Loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Magazine`
--

DROP TABLE IF EXISTS `Magazine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Magazine` (
  `ItemID` int(11) NOT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `IssueNumber` int(11) DEFAULT NULL,
  `PublicationDate` int(11) DEFAULT NULL,
  `Status` tinyint(1) DEFAULT NULL,
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
-- Table structure for table `Member`
--

DROP TABLE IF EXISTS `Member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Member` (
  `MemberID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `Contact` varchar(255) DEFAULT NULL,
  `TypeID` char(1) DEFAULT NULL,
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
-- Table structure for table `MembershipType`
--

DROP TABLE IF EXISTS `MembershipType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `MembershipType` (
  `TypeID` char(1) NOT NULL,
  `TypeName` varchar(255) DEFAULT NULL,
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
-- Table structure for table `Reservation`
--

DROP TABLE IF EXISTS `Reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reservation` (
  `ReservationID` int(11) NOT NULL AUTO_INCREMENT,
  `MemberID` int(11) DEFAULT NULL,
  `ItemID` int(11) DEFAULT NULL,
  `ItemType` varchar(255) DEFAULT NULL,
  `RequestDate` date DEFAULT NULL,
  `Status` tinyint(1) DEFAULT NULL,
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-04-22 18:02:35
