const mongoose = require('mongoose');
const Clothing = require('./models/Clothing');

mongoose.connect('mongodb://127.0.0.1:27017/ecommerce', {
    useNewUrlParser: true,
    useUnifiedTopology: true,
}).then(() => console.log('DB connected!'))
  .catch(error => console.error('Database connection error:', error));

async function seedClothing() {
    const clothingItems = [
        {
            name: "Casual White T-Shirt",
            description: "A simple and comfortable white T-shirt.",
            price: 20,
            image: "/uploads/white_tshirt.jpg",
            size: ["S", "M", "L", "XL"],
            category: "Men",
        },
        {
            name: "Black Leather Jacket",
            description: "A stylish black leather jacket for every occasion.",
            price: 120,
            image: "/uploads/black_leather_jacket.jpg",
            size: ["M", "L"],
            category: "Men",
        },
        {
            name: "Blue Jeans",
            description: "Classic blue jeans with a modern fit.",
            price: 50,
            image: "/uploads/blue_jeans.jpg",
            size: ["S", "M", "L"],
            category: "Unisex",
        },
        {
            name: "Red Evening Dress",
            description: "An elegant red dress for formal occasions.",
            price: 90,
            image: "/uploads/red_evening_dress.jpg",
            size: ["S", "M", "L"],
            category: "Women",
        },
        {
            name: "Beige Trench Coat",
            description: "A timeless beige trench coat for all seasons.",
            price: 150,
            image: "/uploads/beige_trench_coat.jpg",
            size: ["M", "L", "XL"],
            category: "Unisex",
        },
    ];

    await Clothing.insertMany(clothingItems);
    console.log("Clothing items seeded!");
    mongoose.connection.close();
}

seedClothing();
