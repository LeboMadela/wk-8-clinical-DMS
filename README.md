# wk-8-clinical-DMS
# Title: 🧪 Clinical Trial Management Database

## 📘 Project Description

This project is a complete relational **Clinical Trial Management System** database designed using MySQL. It is developed for a Clinical Research Organization to manage and track clinical trial operations, including investigators, study sites, enrolled subjects, subject visits, and recorded vitals.

The database features:

- **Relational structure** with meaningful real-world data
- Proper use of SQL constraints (`PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `NOT NULL`)
- Relationship types:
  - One-to-Many (e.g., sites to subjects)
  - Many-to-Many (e.g., sites and investigators)
  - One-to-One (e.g., visit and its vitals)
- **Principal Investigator restriction** per site
- **Sample data** for all tables with realistic entries

## ⚙️ How to Set Up / Run the Project

To use this project:

1. **Install MySQL** on your local machine if not already installed.
2. Clone or download the repository.
3. Open MySQL Workbench, phpMyAdmin, or your preferred SQL client.
4. Import the SQL file by running the following command:

```sql
SOURCE path_to_your_repo/clinical_db_schema.sql;
