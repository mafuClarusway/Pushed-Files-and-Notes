from flask import Flask

app = Flask(__name__)

@app.route("/")
def head():
    return "<h1>Hello World!</h1>"

@app.route("/second")
def second():
    return "This is my second page"

@app.route("/third/subthird")
def third():
    return "HELLO 3rd page"

@app.route("/fourth/<string:id>")
def fourth(id):
    return f'ID of this page is {id}'

if __name__ == "__main__":
    app.run(debug=True)