from flask import Flask,render_template,request,redirect,url_for,flash,session,Response,jsonify
from flaskext.mysql import MySQL
import numpy as np
import io
import random
from firebase import firebase

firebase=firebase.FirebaseApplication("https://covid19ec-2d508.firebaseio.com/",None)
def addPacienteFireabase(nombre,genero,edad,cedula,direccion,numeroContacto,email):
    data={
        "nombre":nombre,
        "genero":genero,
        "edad":edad,
        "cedula" : cedula,
        "direccion":direccion,
        "numeroContacto":numeroContacto,
        "email":email}
    return data

app=Flask(__name__)

@app.route('/')
def login():
    return render_template('login.html')
@app.route('/ingresar',methods=['POST'])
def ingresar():
    if request.method=='POST':
        return redirect(url_for('index'))

   
@app.route('/inicio')
def index():
  

    result=firebase.get("pacientes",'')
    data=[]
    for id,valores in result.items():
        data.append((id,valores['nombre'],valores['genero'],valores['edad'],valores['cedula'],valores['direccion'],valores['numeroContacto'],valores['email']))
          
    return render_template('index.html',pacientes=data)
@app.route('/add_paciente' ,methods=['POST'])
def add_paciente():
    if request.method=='POST':
        nombresCompletos=request.form['nombresCompletos']
        edad=request.form['edad']
        genero=request.form['genero']
        cedula=request.form['cedula']
        direccion=request.form['direccion']
        contactNumber=request.form['contactNumber']
        email=request.form['email']
       
        data= addPacienteFireabase(nombresCompletos,genero,edad,cedula,direccion,contactNumber,email)
        firebase.post("pacientes",data)
        flash('Paciente Agregado')
        return redirect(url_for('index'))

@app.route('/editPaciente/<id>')
def get_paciente(id):
 
    result=firebase.get("pacientes",'')
    data=[]
    for idr,valores in result.items() :
        data.append((idr,valores['nombre'],valores['genero'],valores['edad'],valores['cedula'],valores['direccion'],valores['numeroContacto'],valores['email']))
    date =[]
    for idData in data:
        if id==idData[0]:
            date.append(idData)
            
    
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
        result=firebase.get("pacientes",'')
        data=[]
        for idr,valores in result.items() :
            data.append((idr,valores['nombre'],valores['genero'],valores['edad'],valores['cedula'],valores['direccion'],valores['numeroContacto'],valores['email']))
        date =[]
        for idData in data:
            if id==idData[0]:
                date.append(idData)
        firebase.put("/pacientes/"+date[0][0],"nombre",nombresCompletos)
        firebase.put("/pacientes/"+date[0][0],"genero",genero)
        firebase.put("/pacientes/"+date[0][0],"edad",edad)
        firebase.put("/pacientes/"+date[0][0],"cedula",cedula)
        firebase.put("/pacientes/"+date[0][0],"direccion",direccion)
        firebase.put("/pacientes/"+date[0][0],"numeroContacto",contactNumber)
        firebase.put("/pacientes/"+date[0][0],"email",email)
        flash('Paciente Cambiado')
     
        return redirect(url_for('index'))
    



@app.route('/analisis/<id>',methods=['GET'])
def analisis(id):
    resultGrafica=firebase.get("/diganostico/",'')
    print(id)
    dataGrafica=[]
    for idr,valores in resultGrafica.items():
        dataGrafica.append((valores["cedula"],valores["tos"],valores["tempertura"]))
    datosTemperatura=[]
    for clave in dataGrafica:
        if clave[0]==id:
            datosTemperatura.append(clave)
    temperaturaReportada =[]
    dateTemperatura= [list(row) for row in datosTemperatura]
    for temperatura in dateTemperatura:
        temperaturaReportada.append(int(temperatura[-1]))
    legend = 'Monitoreo'
    labels = [str(row) for row in range(len(dataGrafica))]
    values = temperaturaReportada
    result=firebase.get("pacientes",'')
    data=[]
    for idr,valores in result.items() :
        data.append((idr,valores['nombre'],valores['genero'],valores['edad'],valores['cedula'],valores['direccion'],valores['numeroContacto'],valores['email']))
    date =[]
    for idData in data:
        if id==idData[4]:
            date.append(idData)
    
    return render_template('analisis.html',paciente=id,values=values, labels=labels, legend=legend,nombre=date[0][1])

@app.route('/delete/<id>' )
def deletePaciente(id):
  
    flash('Contacto Eliminado')
    firebase.delete("/pacientes/",id)
    return redirect(url_for('index'))


if __name__=='__main__':
    app.secret_key = 'super secret key'
    app.run(host='0.0.0.0',port=3000, debug=True)