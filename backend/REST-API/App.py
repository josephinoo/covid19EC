from flask import Flask,render_template,request,redirect,url_for,flash
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
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute('SELECT*FROM pacientes')
    data=cursor.fetchall()
    conn.commit()
    return render_template('index.html',pacientes=data)
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
        flash('Paciente Agregado')
        return redirect(url_for('index'))
@app.route('/editPaciente/<id>')
def get_paciente(id):
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM pacientes WHERE pacienteNumber=%s",(id))
    date=cursor.fetchall()
    print(date)
    conn.commit()
    return render_template('editPacientes.html',paciente=date[0])
@app.route('/update/<id>',methods=['POST'])
def update_paciente(id):
    if request.method=='POST':
        nombresCompletos=request.form['nombresCompletos']
        edad=request.form['edad']
        genero=request.form['genero']
        cedula=request.form['cedula']
        direccion=request.form['direccion']
        contactNumber=request.form['contactNumber']
        email=request.form['email']
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute('''
        UPDATE pacientes
        SET nombresCompletos=%s,
            genero=%s,
            edad=%s,
            cedula=%s,
            direccion=%s,
            contactNumber=%s,
            email=%s
        WHERE pacienteNumber=%s
        ''',(nombresCompletos,genero,edad,cedula,direccion,contactNumber,email,id))
        conn.commit()
        flash('Paciente Cambiado')
        return redirect(url_for('index'))
    





@app.route('/delete/<id>' )
def deletePaciente(id):
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM pacientes WHERE pacienteNumber=%s",(id))
    conn.commit()
    flash('Contacto Eliminado')
    return redirect(url_for('index'))
if __name__=='__main__':
    app.secret_key = 'super secret key'
    app.run(port=3000, debug=True)