require('dotenv').config(); // Load environment variables
const express = require('express');
const path = require('path');
const collection = require('./config');
const bcrypt = require('bcrypt');
const session = require('express-session');
const multer = require('multer');
const fs = require('fs');
const catalogRouter = require('./routes/catalog');
const cartRouter = require('./routes/cart');
const cors = require('cors');

const app = express();

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(express.static('public'));
app.use(cors());

// View engine
app.set('view engine', 'ejs');

app.use(cors());

// Session middleware
app.use(
  session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: true,
  })
);

// Photo upload endpoint
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const uploadDir = './uploads/';
    if (!fs.existsSync(uploadDir)) {
      fs.mkdirSync(uploadDir);
    }
    cb(null, uploadDir);
  },
  filename: (req, file, cb) => cb(null, Date.now() + path.extname(file.originalname)),
});

const upload = multer({ storage });
// Photo upload route
app.post('/upload-photo', upload.single('photo'), async (req, res) => {
  try {
    if (!req.session.userId) {
      return res.status(401).json({ message: 'You must be logged in to upload a photo.' });
    }

    const user = await collection.findById(req.session.userId); // Find user by session ID
    if (!user) {
      return res.status(404).json({ message: 'User not found.' });
    }

    user.photo = `/uploads/${req.file.filename}`; // Save the photo path to the database
    await user.save();

    res.status(200).json({ message: 'Photo uploaded successfully!' });
  } catch (error) {
    res.status(500).json({ message: 'Error uploading photo.' });
  }
});

app.use('/api', catalogRouter);
app.use(express.static('public'));

// Routes
app.get('/', (req, res) => res.render('login'));
app.get('/signup', (req, res) => res.render('signup'));
app.get('/catalog', (req, res) => res.render('catalog'));
app.use('/cart', cartRouter);

app.get('/home', async (req, res) => {
  try {
    if (!req.session.userId) {
      return res.redirect('/'); // Redirect to login if not authenticated
    }

    // Fetch user details
    const user = await collection.findById(req.session.userId);
    if (!user) {
      return res.status(404).send('User not found.');
    }

    res.render('home', { username: user.name, photo: user.photo });
  } catch (error) {
    console.error('Error fetching home page:', error);
    res.status(500).json({ message: 'An error occurred. Please try again later.' });
  }
});

// Signup
app.post('/signup', async (req, res) => {
  try {
    const { username, email, password, confirmPassword, gender } = req.body;

    console.log('User Input:', { username, email, password, confirmPassword, gender });

    // Validate input
    if (!username || !email || !password || !confirmPassword) {
      return res.status(400).json({ message: 'All fields are required.' });
    }

    if (password !== confirmPassword) {
      return res.status(400).json({ message: 'Passwords do not match.' });
    }

    // Check if email is already used
    const existingEmail = await collection.findOne({ email });
    if (existingEmail) {
      return res.status(400).json({ message: 'Email is already in use.' });
    }

    // Check if username is already taken
    const existingUser = await collection.findOne({ name: username });
    if (existingUser) {
      return res.status(400).json({ message: 'Username is already taken.' });
    }

    // Hash the password
    const saltRounds = 10;
    const hashedPassword = await bcrypt.hash(password, saltRounds);

    // Insert new user
    await collection.create({
      name: username,
      email,
      password: hashedPassword,
      gender,
    });

    res.status(200).json({ message: 'User registered successfully.' });
  } catch (error) {
    console.error('Error during signup:', error);
    res.status(500).json({ message: 'An error occurred. Please try again later.' });
  }
});

// File upload configuration

// Login
app.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body; // use 'email' instead of 'useremail'
    const user = await collection.findOne({ email }); // find the user by email

    if (!user) {
      console.log('User not found:', email); // Debug log
      return res.status(401).json({ message: 'Invalid username or password.' });
    }

    const passwordMatch = await bcrypt.compare(password, user.password);
    console.log('Password match:', passwordMatch); // Debug log

    if (!passwordMatch) {
      return res.status(401).json({ message: 'Invalid username or password.' });
    }

    req.session.userId = user._id; // Store user ID in session
    res.status(200).json({ message: 'Login successful' });  // Send a success response
  } catch (error) {
    console.error('Error during login:', error);
    res.status(500).send('An error occurred. Please try again later.');
  }
});


// Start server
const port = 5000;
app.listen(port, () => console.log(`Server listening on port ${port}`));
