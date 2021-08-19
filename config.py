from sqlalchemy import create_engine
import os

# MySQL
if os.environ['FLASK_ENV'] == "development":
    USERNAME = "username"
    PASSWORD = "password"
    HOST = "localhost"
    PORT = "3306"
    DB = "bytemine"
else:
    USERNAME = "username"
    PASSWORD = "password"
    HOST = "localhost"
    PORT = "3306"
    DB = "BYTEMINE"

conn_string = f"mysql+pymysql://{USERNAME}:{PASSWORD}@{HOST}:{PORT}/{DB}?charset=utf8mb4"

mySqlConnection = create_engine(conn_string, pool_recycle=3600, pool_size=20, pool_timeout=300)
