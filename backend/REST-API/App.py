from flask import Flask,render_template,request
from flaskext.mysql import MySQL


app=Flask(__name__)
app.config['MYSQL_DATABASE_HOST']='root'
app.config['MYSQL_DATABASE_USER']='root'
app.config['MYSQL_DATABASE_PASSWORD']='root'
app.config['MYSQL_DATABASE_DB']='covid19'
mysql = MySQL(app)
con = mysql.connect()

@app.route('/')
def index():
    return render_template('index.html')
@app.route('/add_paciente' ,methods=['POST'])
def add_paciente():
    if request.method=='POST':
        cur = mysql.get_db().cursor()
        nombresCompletos=request.form['nombresCompletos']
        edad=request.form['edad']
        genero=request.form['genero']
        cedula=request.form['cedula']
        direccion=request.form['direccion']
        contactNumber=request.form['contactNumber']
        email=request.form['email']

        cur.execute('INSERT INTO pacientes(nombresCompletos,edad,genero,cedula,direccion,contactNumber,email) VALUES(%s,%s,%s,%s,%s,%s,%s)',
        (nombresCompletos,edad,genero,cedula,direccion,contactNumber,email))
        con.commit()
        
        print(nombresCompletos)
        print(edad)
        print(cedula)
        print(direccion)
        print(contactNumber)
        print(email)
        print(genero)
        return 'recibido'

@app.route('/editPaciente')
def editPaciente():
    return 'edit'
@app.route('/delete')
def deletePaciente():
    return "eliminado "
if __name__=='__main__':
    app.run(port=3000, debug=True)