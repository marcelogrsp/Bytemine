import os
import sys
sys.path.append(os.path.dirname(__file__))
from flask_jwt_extended import jwt_required, create_access_token, get_jwt_identity
import models
from config import conn_string
import services
import hashlib

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
jwt = JWTManager(app)

@app.route('/api/indicators', methods=['GET'])
@jwt_required()
def indicators():
    short_name = request.args.get('short_name',None)

    output = services.get_indicators(short_name)

    return jsonify(output), 200


@app.route('/api/indicators/metadata', methods=['GET'])
@jwt_required()
def indicators_metadata():
    short_name = request.args.get('short_name',None)

    output = services.get_indicators_metadata(short_name)

    return jsonify(output), 200


@app.route('/api/indicators/', methods=['POST'])
def create_indicators():
    indicators = request.get_json()
    created = []
    for indicator in indicators:
        indicator_model = services.create_indicator(indicator['short_name'])

    return jsonify(indicator_model), 201
@app.route('/api/indicators/validate', methods=['POST'])
@jwt_required()
def validate_indicators():
    validation_test = services.validate_indicator(request.get_json())

    if validation_test['indicator'].valid:
        return jsonify(validation_test), 200
    else:
        return jsonify(error=validation_test['data']), 400

@app.route('/api/indicators/<id>/', methods=['GET'])
@jwt_required()
def metadata():
    print(request.view_args['id'])
    print(request.query_string)
    print(request.args)

    if request.is_json:
        song_id = request.json.get('song_id')
        tiktoks = Indicator.query.filter_by(id = id).all()
    else:
        tiktoks = Indicator.query.all()

    res = jsonify(tiktoks)
    res.status_code = 200

    return res

@app.route("/api/authenticate", methods=["POST"])
def login():
    username = request.json["username"]
    password_hash = hashlib.pbkdf2_hmac('sha256', request.json["password"].encode('utf-8'), b'bytemine', 100000).hex()
    password_hash_verify = hashlib.pbkdf2_hmac('sha256', "bytemine".encode('utf-8'), b'bytemine', 100000).hex()

    if password_hash == password_hash_verify:
        access_token = create_access_token(identity=username)
        return jsonify(message="Authenticated", access_token=access_token), 200
    else:
        return jsonify(message="Incorrect Credentials"), 403

@app.errorhandler(404)
def not_found(error=None):
    message = {
        'status': 404,
        'message': 'There is no record: ' + request.url,
    }
    res = jsonify(message)
    res.status_code = 404

    return res
