import pandas as pd
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent
DATA_DIR = BASE_DIR/"data"

customers = pd.read_csv(DATA_DIR/"customers.csv")
products = pd.read_csv(DATA_DIR/"products.csv")
orders = pd.read_csv(DATA_DIR/"orders.csv")
details = pd.read_csv(DATA_DIR/"order_details.csv")

print("======DATA QUALITY REPORTS======")

print("\\n1. Duplicate primary IDs")
print("Customer:",customers["CustomerID"].duplicated().sum())
print("Products:",products["ProductID"].duplicated().sum())
print("Orders:",orders["OrderID"].duplicated().sum())

print("\\n2. Missing Values")
for name, df in {
    "Customers": customers,
    "Products": products,
    "Orders": orders,
    "Order details": details
}.items():
    print(f"{name}: {df.isnull().sum()}")



print("\\n3.Relationship checks")
print("Order with unknow customers:",
      (~orders["CustomerID"].isin(customers["CustomerID"])).sum())

print("Details with unknow orders:",
      (~details["OrderID"].isin(orders["OrderID"])).sum())

print("Order with unknow products:",
      (~details["ProductID"].isin(products["ProductID"])).sum())


print("\\n. Numeric checks")
print("Invalid quantities:",(details["Quantity"]<= 0).sum())
print("Negative prices:",(details["UnitPrice"]< 0).sum())
print("Negative Costs:",(details["UnitCost"]< 0).sum())
print("Invalid discount:",
      ((details["Discount"] < 0) | (details["Discount"]>1)).sum())

expected_revenue = (
    details["Quantity"] * details["UnitPrice"]
    *(1-details["Discount"])
).round(2)

expected_profit = (
    expected_revenue - details["Quantity"] * details["UnitCost"]
).round(2)

print("Revenue mismatches:",
      (~(details["Revenue"].round(2) ==  expected_revenue)).sum())
print("Profit mismatches:",
      (~(details["Profit"].round(2) ==  expected_profit)).sum())

print("\\n ==== REPORT COMPLETE =====")



