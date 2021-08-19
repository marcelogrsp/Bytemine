from flask_jwt_extended import JWTManager
from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from config import conn_string

app = Flask(__name__)

app.config["JWT_SECRET_KEY"] = "random_string"
app.config['SQLALCHEMY_DATABASE_URI'] = conn_string
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
app.config['JSON_SORT_KEYS'] = False

db = SQLAlchemy(app)
jwt = JWTManager(app)
