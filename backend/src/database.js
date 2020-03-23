const mongoose =require('mongoose');
async  function conect(){
        await mongoose.connect('mongodb://localhost/codvid',{
            useNewUrlParser:true



        });

        console.log('Database:Conectada');


};
module.exports={conect };