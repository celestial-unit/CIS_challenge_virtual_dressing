const express = require('express');
const router = express.Router();
const Clothing = require('../models/Clothing');

router.get('/catalog', async (req, res) => {
    try {
        const clothingItems = await Clothing.find({});
        // Modify the image path to include the full URL, making sure no double slashes are introduced
        const clothingItemsWithFullUrl = clothingItems.map(item => {
            // Ensure the image URL starts with the correct base URL
            let imageUrl = item.image;
            if (imageUrl.startsWith('/uploads/')) {
                imageUrl = `http://localhost:5000${imageUrl}`; // Append full URL if the image path starts with '/uploads/'
            }
            item.image = imageUrl; // Assign the full image URL to the item
            return item;
        });
        res.json(clothingItemsWithFullUrl); // Send the modified list of items
    } catch (error) {
        console.error('Error fetching catalog:', error);
        res.status(500).send('Error fetching catalog.');
    }
});



module.exports = router;
