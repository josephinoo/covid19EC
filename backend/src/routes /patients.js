
const { Router }=require('express');

const router= Router();
const Patient =require('../models/Patient');

const faker=require('faker');
router.get('/api/patient',async(req,res)=>{
    const patients=await  patients.find();
    res.json('fff');
    


});
router.get('/api/patient/create', async (req,res)=>{
    for (let i=0;i<5;i++){
        await Patient.create({
            firstName:faker.name.firstName(),
            lastName:faker.name.lastName(),
            age:faker.name.firstName(),
            dni:faker.name.firstName(),
            email:faker.name.firstName(),
            emerPhone:faker.name.firstName(),
            contcPhone:faker.name.firstName(),
        });

    };

    res.json({message:'5 pacientes creados'});

});
module.exports=router;

