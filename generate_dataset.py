import pandas as pd 
import numpy as np
from pathlib import Path

rng = np.random.default_rng(42)

BASE_DIR = Path(__file__).resolve().parent.parent
DATA_DIR = BASE_DIR/"data"
DATA_DIR.mkdir(parents=True, exist_ok=True)


##CUSTOMERS###

customers = pd.DataFrame({
    "CustomerID": range(1,101),
    "CustomerName": [f"Customer_{i:03d}" for i in range(1,101)],
    "Region": rng.choice(["North","South","East","West"], size=100),
    "CustomerSegment": rng.choice(
        ["Consumer","corporate","Small Business"],size=100
    )
})

# print(customers)

##PRODUCTS###

products = pd.DataFrame({
    "ProductID": range(1,21),
    "ProductName": [f"Product_{i:02d}" for i in range(1,21)],
    "Category": rng.choice(
        ["Technology","Furniture","Office Supplies"], size=20
    ),
    "UnitPrice": rng.integers(100,5001,size=20),
    "UnitCost": rng.integers(50,2501,size=20)

})

products["UnitCost"] = np.minimum(
    products["UnitCost"],products["UnitPrice"] *0.8
).astype(int)

# print(products)


##ORDER##

numbers_of_orders = 500
order_dates = (
    pd.Timestamp("2025-01-01")
    + pd.to_timedelta(rng.integers(0,365,size=numbers_of_orders),unit="D")
)

orders = pd.DataFrame({
    "OrderID": range(1001,1001+ numbers_of_orders),
    "CustomerID": rng.integers(1,101,size=numbers_of_orders),
    "OrderDate": order_dates
})

product_ids =rng.integers(1,21,size=numbers_of_orders)
order_details = pd.DataFrame({
    "OrderID": orders["OrderID"],
    "ProductID": product_ids,
    "Quantity": rng.integers(1,11,size=numbers_of_orders),
    "Discount": rng.choice([0,0.05,0.10,0.15],size=numbers_of_orders)
})

order_details = order_details.merge(
    products[["ProductID","UnitPrice","UnitCost"]],
    on= "ProductID", how="left"
)


order_details["Revenue"]=(
    order_details["Quantity"] * order_details["UnitPrice"]
    * (1-order_details["Discount"])
).round(2)

order_details["Profit"] = (
    order_details["Revenue"]
    - order_details["Quantity"]* order_details["UnitCost"]
).round(2)

dataset = {
    "Customers.csv": customers,
    "products.csv": products,
    "orders.csv": orders,
    "order_details.csv": order_details
}

for filename, dataframe in dataset.items():
    dataframe.to_csv(DATA_DIR/filename,index=False)
    print(f"Created {filename}: {len(dataframe)} rows")

print("\\nDataset creation completed successfully!")





