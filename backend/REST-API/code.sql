CREATE  TABLE pacientes (
  paciente_number INT  auto_increment ,
  nombresCompletos VARCHAR(150) NOT NULL ,
  genero VARCHAR(10) ,
  edad VARCHAR(3) ,
   cedula  VARCHAR(255) ,
  direccion VARCHAR(255) ,
  contactNumber VARCHAR(75) ,
  email VARCHAR(255) ,
  PRIMARY KEY (paciente_number)) ;


