#importing flask class
from flask import Flask, render_template
#__name__ = special variable 
app = Flask(__name__)

@app.route('/')
def home():
    return render_template("home.html")

@app.route('/about/')
def about():
    return render_template("about.html")

if __name__=="__main__":
    #run app
    app.run(debug=True)

