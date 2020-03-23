const { Router }=require('express');
const router= Router();
router.get('/api/patient',(req,res)=>{
    res.json('Patient list')


});
module.exports=router;