#!/usr/bin/env python3

import os
import psycopg2
import redis
from flask import Flask, jsonify

app = Flask(__name__)

# Database connection
def get_db_connection():
    conn = psycopg2.connect(
        host='db',
        database='appdb',
        user='user',
        password='password'
    )
    return conn

# Redis connection
redis_client = redis.Redis(host='redis', port=6379, db=0)

@app.route('/')
def home():
    return jsonify({
        'message': 'Hello from Docker Compose!',
        'service': 'web',
        'environment': os.environ.get('ENVIRONMENT', 'development')
    })

@app.route('/health')
def health():
    try:
        # Check database connection
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute('SELECT 1')
        cursor.close()
        conn.close()
        
        # Check Redis connection
        redis_client.ping()
        
        return jsonify({'status': 'healthy', 'services': ['db', 'redis']})
    except Exception as e:
        return jsonify({'status': 'unhealthy', 'error': str(e)}), 500

@app.route('/db')
def test_db():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute('SELECT version()')
        version = cursor.fetchone()[0]
        cursor.close()
        conn.close()
        
        return jsonify({'database': 'connected', 'version': version})
    except Exception as e:
        return jsonify({'database': 'error', 'message': str(e)}), 500

@app.route('/redis')
def test_redis():
    try:
        # Set and get a test value
        redis_client.set('test_key', 'Hello Redis!')
        value = redis_client.get('test_key').decode('utf-8')
        
        return jsonify({'redis': 'connected', 'test_value': value})
    except Exception as e:
        return jsonify({'redis': 'error', 'message': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80, debug=False)
