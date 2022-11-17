const express=require("express");
const auth = require("../middlewares/auth");
const UserRoute=express.Router();
const {Product}=require('../models/product');
const User = require("../models/user");


UserRoute.post('/api/add-to-cart',auth,async(req,res)=>{
    try{
       const {id}=req.body;
       const product=await Product.findById(id);
       let user=await User.findById(req.user);

       if(user.cart.length==0)
       {
        user.cart.push({product,quantity:1});
       }else{
        let isPorductFound=false;
        for(let i=0;i<user.cart.length;i++)
        {
            if(user.cart[i].product._id.equals(product._id))
            {
                isPorductFound=true;
            }
        }
        if(isPorductFound){
            var product_find=user.cart.find((product_param)=>
            product_param.product._id.equals(product._id)
            );  
            product_find.quantity+=1;
        }else{
            user.cart.push({product,quantity:1});
        }
       }
       user=await user.save();
       res.json(user);
    }catch(err){
        res.status(500).json({error:err.message});
    }
})
UserRoute.delete('/api/remove-from-cart/:id',auth,async(req,res)=>{
    try{
    //    const id=req.params.id;
       const {id}=req.params;
       const product=await Product.findById(id);
       let user=await User.findById(req.user);
        for(let i=0;i<user.cart.length;i++)
        {
            if(user.cart[i].product._id.equals(product._id))
            {
                if (user.cart[i].quantity==1){
                    user.cart.splice(i,1);
                }else{
                    user.cart[i].quantity-=1;
                }
            }
        }
       user=await user.save();
       res.json(user);
    }catch(err){
        res.status(500).json({error:err.message});
    }
})




module.exports=UserRoute;
