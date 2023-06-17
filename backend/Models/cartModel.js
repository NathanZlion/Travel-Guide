import mongoose from 'mongoose';

const cartSchema = mongoose.Schema({
  destinations: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Destination'
  }],
  hotels: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Hotel'
  }],
  restaurants: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Restaurant'
  }],
}, {
  timestamps: true
});

const Cart = mongoose.model('Cart', cartSchema);

export default Cart;
