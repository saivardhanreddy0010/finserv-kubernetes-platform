from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({
        "service": "FinServ Customer API",
        "status": "running"
    })

@app.route("/health")
def health():
    return jsonify({
        "status": "healthy"
    })

@app.route("/customers")
def customers():
    return jsonify([
        {"id": 1, "name": "Customer One"},
        {"id": 2, "name": "Customer Two"}
    ])

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)