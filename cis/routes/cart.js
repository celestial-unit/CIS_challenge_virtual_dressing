const express = require('express');
const router = express.Router();
//const Cart = require('../models/Cart');
const Clothing = require('../models/Clothing');

// Add item to cart
router.post('/add', async (req, res) => {
    try {
        const { userId, clothingId, size } = req.body;

        if (!userId || !clothingId || !size) {
            return res.status(400).send('Missing required fields.');
        }

        let cart = await Cart.findOne({ userId });

        if (!cart) {
            cart = new Cart({ userId, items: [] });
        }

        // Check if the item already exists in the cart
        const existingItem = cart.items.find(
            item => item.clothingId.toString() === clothingId && item.size === size
        );

        if (existingItem) {
            existingItem.quantity += 1; // Increment quantity if item exists
        } else {
            cart.items.push({ clothingId, size });
        }

        await cart.save();
        res.status(200).send('Item added to cart.');
    } catch (error) {
        console.error('Error adding to cart:', error);
        res.status(500).send('Error adding to cart.');
    }
});

// Get cart items
router.get('/:userId', async (req, res) => {
    try {
        const { userId } = req.params;
        const cart = await Cart.findOne({ userId }).populate('items.clothingId');
        if (!cart) {
            return res.status(404).send('Cart not found.');
        }
        res.status(200).json(cart);
    } catch (error) {
        console.error('Error fetching cart:', error);
        res.status(500).send('Error fetching cart.');
    }
});

module.exports = router;
