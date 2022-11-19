const mongoose=require('mongoose');
const { productSchema } = require('./product');

const OrderSchema=mongoose.Schema({
         products:[
            {
                product:productSchema,
                quantity:{
                    type:Number,
                    required:true,
                }

            }
         ],
         totalPrice:{
            type:Number,
            required:true,
         },
         address:{
            type:String,
            required:true,
         },
         userId:{
            type:String,
            required:true,
         },
         orderedAt:{
            type:Number,
            required:true,
         },
         // here we add status and initiate it by 0 it mean that just order and if is 1 it mean diliver and 2 it mean arrived to client
         status:{
            type:Number,
            default:0,
         }



});



  module.exports=Order=mongoose.model('Order',OrderSchema);