import firebase_admin
from firebase_admin import credentials, firestore
from flask import Flask, jsonify, request
import os
import json


app = Flask(__name__)

# Initialiser Firebase

firebase_credentials = json.loads(os.environ['GOOGLE_CREDENTIALS'])
cred = credentials.Certificate(firebase_credentials)



firebase_admin.initialize_app(cred)

db = firestore.client()

@app.route('/')
def index():
    return "Bienvenue sur l'API Bike-Go"

@app.route('/users', methods=['GET'])
def get_users():
    users_ref = db.collection('users')
    users = users_ref.stream()
    return jsonify([{user.id: user.to_dict()} for user in users])

@app.route('/users', methods=['POST'])
def add_user():
    data = request.get_json()
    db.collection('users').add(data)
    return jsonify({'message': 'User added'}), 201

@app.route('/users/<user_id>', methods=['PUT'])
def update_user(user_id):
    data = request.get_json()
    db.collection('users').document(user_id).set(data, merge=True)
    return jsonify({'message': 'User updated'}), 200

@app.route('/users/<user_id>', methods=['DELETE'])
def delete_user(user_id):
    db.collection('users').document(user_id).delete()
    return jsonify({'message': 'User deleted'}), 200
@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')

    users_ref = db.collection('users').where('email', '==', email).stream()
    for user in users_ref:
        user_data = user.to_dict()
        if user_data.get('password') == password:
            return jsonify({'success': True, 'message': 'Login successful', 'user': user_data}), 200
    return jsonify({'success': False, 'message': 'Invalid email or password'}), 401
@app.route('/users/login', methods=['POST'])
def login_user():
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')

    users = db.collection('users').where('email', '==', email).stream()
    for user in users:
        user_data = user.to_dict()
        if user_data['password'] == password:
            return jsonify({
                'success': True,
                'message': 'Login successful',
                'user_id': user.id
            }), 200

    return jsonify({'success': False, 'message': 'Invalid email or password'}), 401



if __name__ == '__main__':
   app.run(debug=True, host='0.0.0.0')
