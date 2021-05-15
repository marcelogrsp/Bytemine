from flask_jwt_extended import JWTManager
from flask import Flask, jsonify, request
from flask_cors import CORS, cross_origin
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
from config import conn_string

app = Flask(__name__)
app.config["JWT_SECRET_KEY"] = "fe7e8955db51c0ff78550419434128cb"
app.config["JWT_ACCESS_TOKEN_EXPIRES "] = 28800
app.config['SQLALCHEMY_DATABASE_URI'] = conn_string
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
app.config['JSON_SORT_KEYS'] = False

db = SQLAlchemy(app)
ma = Marshmallow(app)
jwt = JWTManager(app)

CORS(app)
