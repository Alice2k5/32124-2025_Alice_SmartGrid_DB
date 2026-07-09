# 32124-2025_Alice_SmartGrid_DB


## 📋 Course Details
* **Course Code & Name:** DPR400210 – Database Programming
* **Academic Year:** 2025-2026
* **Instructor:** Eric Maniraguha
* **Student Name:** Alice IRIMURITWE
* **Registration Number:** 32124/2025

---

## ⚡ Project Overview
* **Project Title:** Smart Energy Grid Infrastructure And Digital Billing Syste
* **Project Category:** Enterprise Database Application / Utility Infrastructure Management System

### 🔍 Project Description
This project is a robust Oracle-based database solution designed to manage modern electrical grid infrastructure and automate household utility billing. The system models power distribution sectors, tracks individual customer smart meters, logs continuous power consumption data in kilowatt-hours (kWh), and calculates precise dynamically-priced bills. By encapsulating all calculations inside PL/SQL packages and securing data access with automated DML validation triggers, the system eliminates traditional human reading errors, mitigates utility fraud, and ensures structural data integrity.

---

## 🚨 Problem Statement
### The Problem (Legacy System Flaws)
Traditional utility grid management relies heavily on manual meter reading, which introduces severe human entry errors, delayed billing cycles, and high operational costs. Furthermore, older grid infrastructures lack the transparency needed to trace localized power leaks or detect unauthorized power theft. Without a centralized automated system, calculating fluctuating energy tariffs based on high-use peak hours vs off-peak hours is highly inefficient and prone to financial losses.

### The Solution (Database Infrastructure Achievements)
This project addresses these challenges by introducing a centralized, relational database system that automatically pairs consumption metrics directly with active tariff regulations. It completely safeguards financial records by preventing unauthorized data modifications outside of scheduled administration intervals and creates an immutable security audit trail for every critical operational modification.

---

## 🛠️ Project Structure & Schema Architecture
The core system is normalized up to 3NF and implements rigorous structural integrity rules across the following modules:
1. **Core Infrastructure:** Managing grid zones, grid assets, and customer smart meters.
2. **Transaction Ledger:** Automated tracking of real-time power consumption metrics.
3. **Advanced Security Audit Trail:** System-wide trigger tracing that records authorized logs and automatically catches/blocks malicious off-hours data tampering.
