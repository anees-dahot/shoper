const mongoose = require('mongoose');

const userSchema = mongoose.Schema({
   name: {
      type: String,
      required: true,
      trim: true
   },
   email: {
      type: String,
      required: true,
      trim: true,
      validate: {
         validator: (val) => {
            const re =
               /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
            return val.match(re)
         },
         message: 'Enter a valid email address'
      },
   },
      password: {
         type: String,
         required: true,
         validate: {
            validator: (val) => {
               return val.length > 6;
            },
            message: 'Enter a long password'
         },
      },
      address: {
         type: String,
         default: ''
      },
      type: {
         type: String,
         default: 'user'
      },
      wishlist: [{
         type: mongoose.Schema.Types.ObjectId,
         ref: 'Products',
         default: []
      }]
  
})

const User = mongoose.model('User', userSchema);

module.exports = User;
