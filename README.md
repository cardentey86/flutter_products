# 🛒 Product Approval Manager (Technical Test)

A technical test developed in **Flutter** to create a product approval and management application. This project demonstrates skills in API consumption, local database integration, list management (pagination, infinite scroll), and architectural patterns.

## ✨ Key Features

This application implements a complete workflow for managing product approval, focusing on separation of concerns and data persistence.

| Feature | Description |
| :--- | :--- |
| **API Consumption** | Initial loading of products from an external mock API (e.g., JSONPlaceholder or MockAPI). |
| **Local Persistence** | Uses **SQLite** or **IsarDB** to ensure product states (approved/rejected) are saved locally. |
| **Architecture** | Implements the **Adapter Pattern** for API communication to keep network logic separate from business logic. |
| **UI/UX** | Dedicated screens for pending and reviewed items, featuring clean design and efficient list handling. |

---

## 🛠️ Functional Requirements

### 1. Main Screens

#### **Pending Products (Products to Review)**

* Displays an initial list of **10 products** fetched from the external API.
* Each product item must include a **checkbox** mechanism to mark it as either **Approved** or **Rejected**.

#### **Reviewed Products**

* A list consolidating all products that have been reviewed (Approved or Rejected).
* Features **Infinite Scroll** and **Pagination** (7 products per page) for efficient loading.
* Each product must be presented in a dedicated **Card** with a clean design.

##### Management Actions (within Reviewed Products):
* Ability to **Delete** a product from the local list.
* Ability to view full product **Details** via a **Dialog/Modal** pop-up.

### 2. Local Storage

* **Database Implementation:** Utilize a local database, specifically **SQLite** or **IsarDB**.
* **Data Stored:** Persist product data and their respective **review status** (Approved / Rejected).

### 3. API Consumption

* **Design Pattern:** The communication layer with the external API must be implemented using the **Adapter Pattern**. This ensures the data fetching logic is decoupled and easily interchangeable.

---

## ⚙️ Technology Stack

* **Framework:** Flutter
* **Language:** Dart
* **Database:** SQLite / IsarDB
* **Mock API:** JSONPlaceholder or MockAPI
* **Pattern:** Adapter Pattern
