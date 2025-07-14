# OrangeHRM and Salesforce Automation with Robot Framework

This project demonstrates end-to-end UI and API test automation using **Robot Framework** for:
- **OrangeHRM** (UI tests)
- **API Automation** (Use https://reqres.in/)
- **Salesforce Trailhead Playground** (UI tests only)

---

## Prerequisites

- Python **3.11+**
- Google Chrome (v125+) or Firefox (latest)
- Compatible WebDriver (e.g., ChromeDriver)
- Postman (for optional API test validation)

---

## Create and Activate Virtual Environment

```bash
python -m venv robot_env
source robot_env/bin/activate    # On macOS/Linux
robot_env\Scripts\activate       # On Windows
```

---

## Installation

1. **Clone the repository**:

```bash
git clone https://github.com/yourusername/orangehrm-salesforce-automation.git
cd orangehrm-salesforce-automation
```

2. **Install dependencies**:

```bash
pip install -r requirements.txt
```

---

## Test Execution

### OrangeHRM UI Tests

```bash
robot -d results tests/orangehrm/ui/orangehrm.robot
```

### API Tests

```bash
robot -d results tests/orangehrm/api/req_res_tests.robot
```

 *Alternatively*, you can import `Assignment.postman_collection.json` into Postman and run the API collection there.

---

### Salesforce UI Tests

```bash
robot -d results/salesforce tests/salesforce/salesforce_test.robot
```

---

##  Reports

After each execution, find generated reports in the `reports/` or `results/` directory:

- `report.html` – Test summary
- `log.html` – Detailed execution log
- `output.xml` – Robot result XML file
- Screenshots – Captured at key pass/fail steps

---

##  Tools & Libraries Used

| Tool/Library         | Version      |
|----------------------|--------------|
| Python               | 3.12.7       |
| Robot Framework      | 7.3.1        |
| SeleniumLibrary      | 6.7.1        |
| RequestsLibrary      | 0.9.7        |
| Google Chrome        | 125+         |
| ChromeDriver         | 135+         |
| Postman              | v11.x        |

---

##  Project Structure

```
orangehrm-salesforce-automation/
│
├── tests/
│   ├── orangehrm/
│   │   ├── ui/
│   │   │   └── orangehrm_tests.robot
│   │   └── api/
│   │       └── req_res_tests.robot
│   └── salesforce/
│       └── salesforce_test.robot
│
├── resources/
│   ├── orangehrm/
│   └── salesforce/
│
├── variables/
├── results/
├── requirements.txt
└── README.md
```

---
