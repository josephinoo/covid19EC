const Patient =require('./mo');
const { Router }=require('express');

const router= Router();

const faker=require('faker');
router.get('/api/patient',async(req,res)=>{
    const patients=await patients.find();
    res.json(patients);
    


});
router.get('/api/patient/create', async (req,res)=>{
    for (let i=0;i<5;i++){
        await Patient.create({
            firstName:faker.name.firstName(),
            lastName:faker.name.lastName(),
            age:faker.date(),
            dni:faker.date(),
            email:faker.date(),
            emerPhone:faker.date(),
            contcPhone:faker.date()
        });

    }

    res.json({message:'5 pacientes creados'});

});
module.exports=router;