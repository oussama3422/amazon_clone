// IMPORTS FROM PACKAGES
const express=require('express');
const mongoose=require('mongoose');
//IMPORTS FROM OTHER FILES
const authRouter=require('./routes/auth');

//INIT
const app=express();
const DB="mongodb+srv://ossama:ossama123@cluster0.7mvpy2c.mongodb.net/?retryWrites=true&w=majority";
//middleware
//CLIENT -> middleware -> SERVER -> CLIENT ?STOP?
app.use(express.json());
app.use(authRouter);
//connections
mongoose.connect(DB).then(()=>{
   console.log('connection successfully');
}).catch((e)=>{console.log('failure'+{e})});
// initialisation
const PORT=3000;
app.listen(PORT,'0.0.0.0',()=>{
   console.log('server has been running at port '+PORT+' ...');
})
