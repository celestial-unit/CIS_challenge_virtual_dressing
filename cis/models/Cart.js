const mongoose = require('mongoose');

const CartSchema = new mongoose.Schema({
    userId: { type: mongoose.Schema.Types.ObjectId, ref: 'users', required: true },
    items: [
        {
            clothingId: { type: mongoose.Schema.Types.ObjectId, ref: 'Clothing', required: true },
            size: { type: String, required: true },
            quantity: { type: Number, default: 1 },
        }
    ]
});

const Cart = mongoose.model('Cart', CartSchema);
module.exports = Cart;
