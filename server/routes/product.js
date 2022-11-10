const { json } = require('express');
const express=require('express');
const auth=require('../middlewares/auth');
const Product=require('../models/product');
const productRouter=express.Router();

// /api/product?category=Essentials
productRouter.get('/api/products',auth,async(req,res)=>{

try{
  console.log(req.query.category);
  const products=await Product.find({category:req.query.category});
  res.json(products);

}catch(err)
{
    res.status(500).json({error:err.message});
}
});
// create a get request to search products and get them
//api/products/search/i
productRouter.get('/api/products/search/:paramsName',auth,async(req,res)=>{
try{
    const product=await Product.find({
        name:{$regex:req.params.paramsName,$options :"i"},
    });
    res.json(product);
}catch(err)
{
    res.status(500).json({error:err.message});
}
}
);


module.exports=productRouter;


