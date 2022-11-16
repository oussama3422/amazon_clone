const mongoose=require('mongoose');
const {productSchema}=require('./product');
const userSchema=mongoose.Schema({
    name:{
        require:true,
        type:String,
        trim:true,
    },
    email:{
        require:true,
        type:String,
        trim:true,
        validate:{
            validator:(value)=>{
                const reject = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;  
                return value.match(reject);
            },
            message:'Please Enter a valid email Address',
        }
    },
    password:{
        required:true,
        type:String,
    },
    address:{
        type:String,
        default:'',
    },
    type:{
        type:String,
        default:'user',
    },
    cart:[
        {
            product:productSchema,
            quantity:{
                type:Number,
                required:true,
            }
        }
    ],
});


// const User=mongoose.model('user',userSchema);
// module.export=User;
module.exports = User = mongoose.model('user', userSchema);