const express=require('express');
const User=require('../models/user')
const bcryptjs=require('bcryptjs');
const jwt=require('jsonwebtoken');
const auth=require('../middlewares/auth');

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
      const encrypt_password=await bcryptjs.hash(password,8);
      //200
      let user=new User({
        email,
        password:encrypt_password,
        name,
      });
      user=await user.save();
      res.json(user); 
      //post that data in database
   
      //return that data to the user
   }catch(e){
         res.status(500).json({error:e.message});
   }
   
});
RouteAuth.post("/api/singin",async(req,res)=>{

   try{
      const {email,password}=req.body;
      const user=await User.findOne({email});
      if(!user){
         return res.status(400).json({msg:"User with this email does not exists"});
      }
      const isMatch=await bcryptjs.compare(password,user.password);
      if(!isMatch){
         return res.status(400).json({msg:"Incorrect Password"});
      }
      const token=jwt.sign({id:user._id},"passwordKey");
      res.json({token,...user._doc});
   }catch(e){
      res.status(500).json({error:e.message})
   }
})
RouteAuth.post('/tokenIsValid',async(req,res)=>{
   try{
   const token=req.header('x-token-auth');
   if(!token) return res.json(false);
   const verified=jwt.verify(token,'passwordKey');
   if(!verified) return res.json(false);
   const user=await User.findById(verified.id);
   if(!user) return res.json(false)
   res.json(true)
   }catch(err){
      res.status(500).json({error:err.message});

   }
})
// get user data
RouteAuth.get('/',auth,async(req,res)=>{
   const user=await User.findById(req.user);
   res.json({...user._doc,token:req.token});
})
module.exports = RouteAuth;