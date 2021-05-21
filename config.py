from sqlalchemy import create_engine
import os

# MySQL
if os.environ['FLASK_ENV'] == "development":
    USERNAME = "marcelo"
    PASSWORD = "rRNuTiO9K0jxY6vIk858"
    HOST = "localhost"
    PORT = "3306"
    DB = "BYTEMINE"
else:
    USERNAME = "marcelo"
    PASSWORD = "rRNuTiO9K0jxY6vIk858"
    HOST = "ubunturaspberryquantryx.duckdns.org"
    PORT = "3360"
    DB = "BYTEMINE"

conn_string = f"mysql+pymysql://{USERNAME}:{PASSWORD}@{HOST}:{PORT}/{DB}?charset=utf8mb4"
# conn_string = "sqlite:////tmp/test.db"

mySqlConnection = create_engine(conn_string)
