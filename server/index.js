// IMPORTS FROM PACKAGES
const express=require('express');
const mongoose=require('mongoose');
//IMPORTS FROM OTHER FILES
const app=express();

const authRouter=require('./routes/auth');
const adminRoute=require('./routes/admin');
const productRoute=require('./routes/product');
const UserRoute = require('./routes/user');
//INIT
const DB="mongodb+srv://ossama:ossama123@cluster0.7mvpy2c.mongodb.net/?retryWrites=true&w=majority";
//middleware
//CLIENT -> middleware -> SERVER -> CLIENT ?STOP?
app.use(express.json());
app.use(authRouter);
app.use(adminRoute);
app.use(productRoute);
app.use(UserRoute);
//connections
mongoose.connect(DB).then(()=>{
   console.log('connection successfully');
}).catch((e)=>{console.log('failure'+{e})});
// initialisation
const PORT=process.env.PORT || 3000;
app.listen(PORT,()=>{
   console.log('server has been running at port '+PORT+' ...');
});
