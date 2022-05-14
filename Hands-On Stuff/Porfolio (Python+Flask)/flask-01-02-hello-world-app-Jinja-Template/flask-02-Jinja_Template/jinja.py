from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
def head():
    return render_template("index.html", var1 = 34, var2 = 45)

@app.route("/mafu")
def num_func():
    num3 = 23
    num4 = 54
    return render_template("body.html", val1 = num3, val2 = num4, sum = num3 + num4)

if __name__ == "__main__":
    app.run(debug=True)