from flask_jwt_extended import jwt_required, create_access_token, get_jwt_identity
from flask import Flask, request, jsonify
from flask_cors import CORS, cross_origin
from models import Indicator
from config import conn_string
from datetime import timedelta
from app import app, db

import wsgiserver
import services
import hashlib
import os

CORS(app, resources={r"/api/*": {"origins": "*"}})
app.config['CORS_HEADERS'] = 'Content-Type'

@app.route("/api/authenticate", methods=["POST"])
@cross_origin()
def login():
    print(request.remote_addr)
    username = request.json["username"]
    password_hash = hashlib.pbkdf2_hmac('sha256', request.json["password"].encode('utf-8'), b'bytemine', 100000).hex()
    password_hash_verify = hashlib.pbkdf2_hmac('sha256', "bytemine".encode('utf-8'), b'bytemine', 100000).hex()

    if password_hash == password_hash_verify:
        access_token = create_access_token(identity=username, expires_delta=timedelta(days=1))
        
        res = jsonify(message="Authenticated", access_token=access_token)
        res.status_code = 200
    else:
        res = jsonify(message="Incorrect Credentials")
        res.status_code = 403
    return res

@app.route('/api/indicators', methods=['GET', 'POST'])
@cross_origin()
@jwt_required()
def indicators():
    if request.method == 'GET':
        short_name = request.args.get('short_name', None)
        output = services.get_indicators(short_name)

        return jsonify(output), 200
    elif request.method == 'POST':
        indicators = request.get_json()
        created = []
        for indicator in indicators:
            indicator_model = services.create_indicator(indicator['short_name'])

        return jsonify(indicator_model), 201

@app.route('/api/indicators/metadata/<unique_key>/', methods=['GET'])
@cross_origin()
@jwt_required()
def indicators_metadata_unique_key(unique_key):
    output = services.get_indicators_metadata(unique_key)

    return jsonify(output), 200

@app.route('/api/indicators/metadata/', methods=['GET'])
@cross_origin()
@jwt_required()
def indicators_metadata():
    output = services.get_indicators_metadata()

    return jsonify(output), 200

@app.route('/api/indicators/validate/', methods=['POST'])
@cross_origin()
@jwt_required()
def validate_indicators():
    validation_test = services.validate_indicator(request.get_json())

    if validation_test['indicator'].valid:
        return jsonify(validation_test), 200
    else:
        return jsonify(error=validation_test['data']), 400

@app.route('/api/indicators/<id>/', methods=['GET'])
@cross_origin()
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

@app.route('/api/logics/', methods=['GET'])
@cross_origin()
@jwt_required()
def logics():
    output = services.get_logics()

    return jsonify(output), 200

@app.route('/api/logics/<id>/', methods=['GET'])
@cross_origin()
@jwt_required()
def logics_id(id):
    output = services.get_logics(id)

    return jsonify(output), 200

@app.route('/api/actions/', methods=['GET'])
@cross_origin()
@jwt_required()
def actions():
    output = services.get_actions()

    return jsonify(output), 200

@app.route('/api/actions/<id>/', methods=['GET'])
@cross_origin()
@jwt_required()
def actions_id(id):
    output = services.get_actions(id)

    return jsonify(output), 200

@app.route('/api/datas/', methods=['GET'])
@cross_origin()
@jwt_required()
def datas():
    output = services.get_datas()

    return jsonify(output), 200

@app.route('/api/datas/<id>/', methods=['GET'])
@cross_origin()
@jwt_required()
def datas_id(id):
    output = services.get_datas(id)

    return jsonify(output), 200

@app.route('/api/search/<keyword>', methods=['GET'])
@cross_origin()
@jwt_required()
def search(keyword):
    output = services.search(keyword)

    return jsonify(values = output), 200

@app.errorhandler(404)
def not_found(error=None):
    message = {
        'status': 404,
        'message': 'There is no record: ' + request.url,
    }
    res = jsonify(message)
    res.status_code = 404

    return res

if __name__ == "__main__":
    if os.environ['FLASK_ENV'] == "development":
        app.run()
    else:
        print("Starting WSGI...")
        server = wsgiserver.WSGIServer(app, host="0.0.0.0", port=5000)
        server.start()
