const express=require('express');
const User=require('../models/user')
const bcryptjs=require('bcryptjs');

const RouteAuth=express.Router();


RouteAuth.post("/api/singup",async(req,res)=>{
   try{
      const {name,email,password}= req.body;
      //connect data to database
      const exisitingUser=await User.findOne({email});
      if (exisitingUser){
         return res.status(400).json({msg:'User With same email already Exists!'});
      }
      //salt the hash before push it to the database
      encrypt_password=await bcryptjs.hash(password,8);
      //200
      let user=new User({
        email,
        encrypt_password,
        name,
      });
      user=await user.save();
      res.json(user); 
      //post that data in database
   
      //return that data to the user
   }catch(error){
         res.status(500).json({error:error.message});
   }
   
});

module.exports = RouteAuth;