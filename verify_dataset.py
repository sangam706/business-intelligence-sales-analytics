import pandas as pd 
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent
DATA_DIR = BASE_DIR/"data"

expected_rows = {
    "customers.csv":100,
    "products.csv": 20,
    "orders.csv": 500,
    "order_details.csv": 500
}

all_passed = True

for filename, expected in expected_rows.items():
    filepath = DATA_DIR/filename
    print(f"\\nChecking: {filename}")

    if not filepath.exists():
        print("FAILED: File not found")
        all_passed = False
        continue

    try:
        df = pd.read_csv(filepath)
        print("Actual rows:",len(df))
        print("Columns:",list(df.columns))

        if len(df)==expected:
            print("PASS : Row count is correct")
        else:
            print(f"FAILED : Expected {expected} rows")
            all_passed = False
    except Exception as error:
        print("FAILED:",error)
        all_passed = False

print("\\nFinal result:")
if all_passed:
    print("SUCCESS: ALL Datasets verified!")
else:
    print("Some checks failed. Review the message above.")




