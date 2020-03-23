const app= require('./app');
const { conect}=require('./database');
async function main () {
    //Conexion de bases de datos
   await conect();

   await app.listen(4000);
    console.log('server on port :4000 Conectado ');
};
main();