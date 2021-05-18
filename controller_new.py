from flask_jwt_extended import jwt_required, create_access_token, get_jwt_identity
from flask import Flask, request, jsonify
from models import Indicator
from config import conn_string
from app import app, db
import services
import hashlib


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

app.run()
