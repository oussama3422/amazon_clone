// IMPORTS FROM PACKAGES
const express=require('express');
const mongoose=require('mongoose');
//IMPORTS FROM OTHER FILES
const app=express();

const authRouter=require('./routes/auth');
const adminRoute=require('./routes/admin');
//INIT
const DB="mongodb+srv://ossama:ossama123@cluster0.7mvpy2c.mongodb.net/?retryWrites=true&w=majority";
//middleware
//CLIENT -> middleware -> SERVER -> CLIENT ?STOP?
app.use(express.json());
app.use(authRouter);
app.use(adminRoute);
//connections
mongoose.connect(DB).then(()=>{
   console.log('connection successfully');
}).catch((e)=>{console.log('failure'+{e})});
// initialisation
const PORT=3000;
app.listen(PORT,'0.0.0.0',()=>{
   console.log('server has been running at port '+PORT+' ...');
});
