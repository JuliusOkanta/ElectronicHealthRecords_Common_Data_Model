# 🧬 Multicentric COVID-19 Dataset Standardization with OMOP CDM

## 📖 Overview

This project focuses on integrating and standardizing multicentric observational healthcare data using the **OMOP Common Data Model (CDM)**. Data sources come from multiple hospitals and span several domains: diagnoses, medications, lab results, vital signs, and patient demographics.

By using an ETL (Extract, Transform, Load) pipeline, the project harmonizes raw datasets into a unified, research-ready OMOP CDM format.

---

## 🗃️ Dataset Domains

Each participating hospital provided data in the following categories:

- **Diagnósticos** – Diagnosis records  
- **Farmacos** – Drug prescriptions  
- **Laboratorio** – Lab test results  
- **Paciente** – Demographic and mortality data  
- **Signos Vitales** – Vital sign measurements  

> ⚠️ All datasets were originally in **Catalan/Spanish**, requiring translation for mapping to OMOP CDM standards.

---

## 🔁 ETL Workflow

### 1. Data Profiling  
- Tool: **WhiteRabbit**  
- Output: `Scan_Report`  
- Goal: Analyze source tables and data distributions.

### 2. Mapping Specification  
- Tool: **Rabbit-In-A-Hat**  
- Purpose: Define mappings between source data and OMOP CDM tables/fields.  
- Output: Visual and tabular mapping specification.

### 3. Data Transformation & Loading  
- Platform: **MySQL Workbench**  
- Scripts:
  - [`OMOP_CDM_SCHEMA.sql`](OMOP_CDM_SCHEMA.sql) – Creates OMOP CDM schema.
  - [`Consolidated_Dataset_Script.sql`](Consolidated_Dataset_Script.sql) – Transforms and loads the data into OMOP tables.
