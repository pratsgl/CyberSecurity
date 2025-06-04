# Ollama CVE Query Assistant

## Overview

This Python application combines the power of LangChain with a local Ollama LLM to translate natural language questions about CVE (Common Vulnerabilities and Exposures) into SQL queries. It then executes those queries against a MySQL database, returns the results, and presents them via CLI or web frontend.

---

## Features

* Natural Language to SQL using LangChain & Ollama
* CVE-specific SQL prompt tuning
* Executes SELECT queries securely
* CLI and Flask web interface
* Export results to CSV and JSON
* Bar chart generation of severity distribution
* Docker and Kubernetes ready
* Logging for traceability
* Prometheus metrics compatibility

---

## Step-by-Step Functionality

### Step 1: Initialize LangChain with Ollama

* `ChatOllama(model="mistral")` is used to load a local language model (e.g. Mistral) via Ollama.

### Step 2: Define Prompt for CVE SQL Translation

* A detailed `ChatPromptTemplate` tells the LLM how to convert user questions into valid SQL.
* Includes schema:

  * `cve_data(id, cve_id, description, published_date, severity, score, affected_products)`
* Incorporates logic for filtering by severity, date, score, and products.

### Step 3: Use LLMChain

* A LangChain `LLMChain` takes the user request and generates SQL using the prompt and LLM.

### Step 4: SQL Execution

* Only `SELECT` queries are allowed (validated via regex).
* Uses `mysql.connector` to connect and fetch results from the `cve_db` database.

### Step 5: Export Utilities

* `export_to_csv()` → Saves results to a CSV file
* `export_to_json()` → Saves results to JSON
* `generate_chart()` → Creates a bar chart of severity using `matplotlib`

### Step 6: CLI Mode

* Run with `python script.py cli`
* Accepts query → Generates SQL → Executes → Displays → Exports

### Step 7: Web Interface (Flask)

* Run with `python script.py`
* Access at `http://localhost:5000`
* HTML form accepts a CVE query and displays:

  * SQL
  * Table of results
  * Severity chart (bar graph)

### Step 8: Logging

* Logs every major operation (query, error, export, etc.) to stdout using `logging` module.

### Step 9: Docker & Kubernetes Support

* Dockerfile and Kubernetes deployment YAML provided
* Secrets managed via `mysql-secret.yaml`
* Helm chart available for easier cluster deployment

### Step 10: Monitoring

* Prometheus-compatible metrics integration planned
* Log scraping and metrics can be added to expose:

  * Query counts
  * Query errors
  * Response time

---

## Deployment Instructions

* Build Docker: `docker build -t cve-assistant .`
* Push: `docker push your-dockerhub-username/cve-assistant`
* Apply K8s Secrets: `kubectl apply -f mysql-secret.yaml`
* Deploy: `kubectl apply -f cve-assistant-deployment.yaml`
* Use Helm: `helm install cve-assistant ./cve-assistant-helm`

---

## Future Enhancements

* Integrate OAuth/AuthN for secure access
* Add CVSS scoring breakdown and NVD sync
* Frontend improvements (filters, pagination, search)
* Prometheus/Grafana dashboard templates
* Helm CI/CD via GitHub Actions or ArgoCD
