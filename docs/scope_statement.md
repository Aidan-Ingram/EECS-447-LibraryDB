# 📚 Team SQLibrary Scope Statement

## Project Scope:

### 1. Items Management:
The LMS will manage different types of library materials, including:
- **Books** (both physical and digital) with attributes such as title, author/creator, ISBN, publication year, genre, and availability status.
- **Magazines** with attributes including title, issue number, publication date, and availability status.
- Borrowing restrictions for specific items, such as rare books or recent magazine issues, will be tracked.

### 2. Client Management:
The system will maintain detailed client profiles, which will include:
- Unique Client ID, name, contact information, membership type, and account status.
- Different membership types, such as regular, student, senior citizen, etc., each with specific borrowing limits and fee structures.
- The ability to track client activity, borrowing history, and current status.

### 3. Transactions and Borrowing Rules:
The LMS will support the tracking of all borrowing and returning transactions, including timestamps, responsible clients, and item statuses.
- Borrowing limits will be defined based on client membership type, and fees for late returns will be applied according to membership.
- The system will allow clients to reserve books that are currently on loan, and notifications will be sent for upcoming due dates, overdue items, and available reserved items.

### 4. Notifications and Alerts:
- The system will implement an automated notification system that will alert clients about upcoming due dates, overdue items, and the availability of reserved books.

### 5. Reporting Capabilities:
The LMS will be capable of generating detailed reports for:
- Fine calculations, including overdue fines based on membership type.
- Borrowing trends, such as frequently borrowed items and overall library usage.
- Book availability, including current borrowing status and reserve requests.
- Client activity, showing borrow/return history and account status.

### 6. Constraints:
- Each client will have a maximum number of items they can borrow at any given time, based on their membership type.
- Special items (e.g., rare books or recent issues of magazines) will have specific borrowing restrictions, and the system will enforce these constraints.
- Late return fees will be calculated according to a tiered structure based on membership type.

## Out of Scope:
- This project will not include the development of a physical item checkout system (e.g., barcode scanners or RFID tags).
- The system will not support any direct e-commerce features, such as purchasing books or media online.
- Integration with external third-party systems for digital content (e.g., streaming services or external book databases) is not part of the scope.
