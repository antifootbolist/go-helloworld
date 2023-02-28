from flask import Flask

app = Flask(__name__)


@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def hello_world():
    return "Hello World from Python App\n"


if __name__ == '__main__':
    app.run(port=8080, host='0.0.0.0')
