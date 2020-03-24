from flask import Flask
from flaskext.mysql import MySQL

app=Flask(__name__)
mysql = MySQL()
mysql.init_app(app)

@app.route('/')
def index():
    return 'Hello World'
@app.route('/add_paciente')
def add_paciente():
    return 'Add'
@app.route('/editPaciente')
def editPaciente():
    return 'edit'
@app.route('/delete')
def deletePaciente():
    return "eliminado "
if __name__=='__main__':
    app.run(port=3000, debug=True)