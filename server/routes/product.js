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
//create a post request route to rate the product.
productRouter.post('/api/rate-product',auth,async(req,res)=>{
 try{
    const {id,rating}=req.body;
    let product =await Product.findById(id);
    for (let i=0;i<product.ratings.length;i++)
    {
        if(product.ratings[i].userId==req.user){
            product.ratings.splice(i,1);
            break;
        }
    }
   const ratingschema={
     userId:req.user,
     rating,
   }
   product.ratings.push(ratingschema);
   product=await product.save();
   res.json(product);
    //{
    //user:'dfdfd'
     //rating:2.5
    //},
    //{userId:'aaaabbbsbs'
    //rating:4
    //}
    //
    //
 }catch(error){
    res.status(500).json({error:error.message});
 }

})


productRouter.get('/api/deal-of-day',auth,async(req,res)=>{

 try{
  var product=Product.find({});
  // A -> 10
  // B -> 30
  // C -> 50
  product.sort((a,b)=>{
    let aSum=0;
    let bSum=0;
    for(let i=0;i<a.ratings.length;i++)
    {
        aSum+=a.ratings[i].rating;
    }
    for(let i=0;i<b.ratings.length;i++)
    {
        bSum+=b.ratings[i].rating;
    }
    return aSum < bSum? 1 : -1;
  })
  res.json(product[0]);
 }catch(error){
    res.status(500).json({error:error.message});
 }

})

module.exports=productRouter;


