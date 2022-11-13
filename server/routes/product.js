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
productRouter.get('/api/products/search/:name',auth,async(req,res)=>{
try{
    const product=await Product.find({
        name:{$regex:req.params.name,$options :"i"},
    });
    res.json(product);
}catch(err)
{
    res.status(500).json({error:err.message});
}
}
);

//create a post request route to rate the product.
productRouter.post("/api/rate-product",auth,async(req,res)=>{
try{
    const {ProductId,rating}=req.body;
    let product=await Product.findById(ProductId)
    for(let i=0;i<product.ratings.length;i++)
    {
         if(product.ratings[i].userId == req.user){
             product.ratings.splice(i,1);
             break;
         }
    }
    const ratingSchema={
        userId:req.user,
        rating,
    }
    product.ratings.push(ratingSchema);

    product=await product.save();

    res.json(product);

}catch(error){
    res.status(500).json({error:error.message});
}
})


module.exports=productRouter;


