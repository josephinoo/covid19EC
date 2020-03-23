const {Schema,model}=require('mongoose');
const patientShema=new Schema({

    firstName:String,
    lastName:String,
    age:String,
    dni:String,
    email:String,
    emerPhone:String,
    contcPhone:String


});
model('Pacientes',patientShema);