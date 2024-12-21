const mongoose = require('mongoose');

// Connect to MongoDB
mongoose.connect('mongodb://127.0.0.1:27017/ecommerce', {
  useNewUrlParser: true,
  useUnifiedTopology: true
}).then(() => console.log('DB connected!'))
  .catch(error => console.error('Database connection error:', error));

// Create Schema
const Loginschema = new mongoose.Schema({
  name: { type: String, required: true },
  email: {
    type: String,
    required: true,
    unique: true, // Ensure emails are unique
  },
  password: { type: String, required: true },
  gender: { type: String, required: false },
  photo: { type: String, required: false } 
});


// Create Model
const collection = mongoose.model('users', Loginschema);

module.exports = collection;
