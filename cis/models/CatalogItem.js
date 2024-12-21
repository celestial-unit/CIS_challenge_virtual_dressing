const mongoose = require('mongoose');

const CatalogItemSchema = new mongoose.Schema({
    name: { type: String, required: true },
    description: { type: String, required: true },
    price: { type: Number, required: true },
    size: { type: [String], required: true }, // Array of available sizes
    image: { type: String, required: true }  // Path to the image
});

const CatalogItem = mongoose.model('CatalogItem', CatalogItemSchema);

module.exports = CatalogItem;
