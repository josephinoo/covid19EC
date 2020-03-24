from flask import Flask,render_template,request
from flaskext.mysql import MySQL


app=Flask(__name__)
app.config['MYSQL_DATABASE_HOST']='localhost'
app.config['MYSQL_DATABASE_USER']='root'
app.config['MYSQL_DATABASE_PASSWORD']='rootroot'
app.config['MYSQL_DATABASE_DB']='covid19'
mysql = MySQL()
mysql.init_app(app)
@app.route('/')
def index():
    return render_template('index.html')
@app.route('/add_paciente' ,methods=['POST'])
def add_paciente():
    if request.method=='POST':
        conn = mysql.connect()
        cursor = conn.cursor()
        nombresCompletos=request.form['nombresCompletos']
        edad=request.form['edad']
        genero=request.form['genero']
        cedula=request.form['cedula']
        direccion=request.form['direccion']
        contactNumber=request.form['contactNumber']
        email=request.form['email']
        cursor.execute('INSERT INTO covid19.pacientes(nombresCompletos,genero,edad,cedula,direccion,contactNumber,email) VALUES(%s,%s,%s,%s,%s,%s,%s)',(nombresCompletos,genero,edad,cedula,direccion,contactNumber,email))
        conn.commit()
        return 'recived'

@app.route('/editPaciente')
def editPaciente():
    return 'edit'
@app.route('/delete')
def deletePaciente():
    return "eliminado "
if __name__=='__main__':
    app.run(port=3000, debug=True)