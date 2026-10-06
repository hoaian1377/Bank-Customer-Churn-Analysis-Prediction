import pandas as pd
from sqlalchemy import create_engine
import os
from dotenv import load_dotenv
load_dotenv()


DB_USERNAME=os.getenv("DB_USERNAME")
DB_PASSWORD=os.getenv("DB_PASSWORD")
DB_HOST=os.getenv("DB_HOST")
DB_PORT=os.getenv("DB_PORT")
DB_DATABASE=os.getenv("DB_DATABASE")
def connect_sql():
    engine = create_engine(f"postgresql+psycopg2://{DB_USERNAME}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_DATABASE}")
    df = pd.read_csv(r"C:\duan\da\Bank's Customer Churn\data\raw\Churn_Modelling.csv")
    df.to_sql('customerchurn',con=engine, if_exists='replace', index=False)
    return df

if __name__ == "__main__":
    connect_sql()
    print("connect success")