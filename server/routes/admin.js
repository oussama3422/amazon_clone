const express=require("express");
const admin=require('../middlewares/admin');
const {Product}=require('../models/product');
const adminRoute=express.Router();




// Creating an Admin Middllware
adminRoute.post('/admin/add-product',admin,async (req,res)=>{
    try{
     const {name,description,images,quantity,price,category}=req.body;
     let product=new Product({
         name,
         description,
         images,
         quantity,
         price,
         category,
     });
    product=await product.save();
    res.json(product);
    }catch(error){
    res.status(500).json({msg:error.message});
    }

});
// get all youre products
// /admin/get-products
adminRoute.get('/admin/get-products',admin,async(req,res)=>{

    try{
       const product=await Product.find({});
       res.json(product);
    }catch(err){
        res.status(500).json({error:err.message});
    }
})
// delete Product
adminRoute.post('/admin/delete-product',admin,async(req,res)=>{
    try{
        const {id}=req.body;
        const product=await Product.findByIdAndDelete(id);
    //    const product= await Product.deleteOne({ _id: id });
        res.json(product);
        console.log('deleted Successfulyl');
    }catch(err){
        res.status(500).json({error:err.message});
    }
})

module.exports=adminRoute;