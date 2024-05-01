const mongoose = require('mongoose');

const reviewSchema = mongoose.Schema({
   user: {
     type: String,
     required: true,
     trim: true,
   },
   review: {
     type: String,
     required: true,
     trim: true,
   },
   time: {
     type: String,
     required: true,
   },
   stars: {
    type: Number,
    required: true,
  },
 });



 module.exports = reviewSchema;