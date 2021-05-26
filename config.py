from sqlalchemy import create_engine
import os

# MySQL
if os.environ['FLASK_ENV'] == "development":
    USERNAME = "bytemine"
    PASSWORD = "Cj3Qnp64eiRGfZcKNCMtchFn4HDCNuuTtsmpAgsmnPfz4sue"
    HOST = "localhost"
    PORT = "3306"
    DB = "bytemine"
else:
    USERNAME = "marcelo"
    PASSWORD = "rRNuTiO9K0jxY6vIk858"
    HOST = "ubunturaspberryquantryx.duckdns.org"
    PORT = "3360"
    DB = "BYTEMINE"

conn_string = f"mysql+pymysql://{USERNAME}:{PASSWORD}@{HOST}:{PORT}/{DB}?charset=utf8mb4"
# conn_string = "sqlite:////tmp/test.db"

mySqlConnection = create_engine(conn_string)
