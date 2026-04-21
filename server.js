require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const jwt = require('jsonwebtoken');
const path = require('path');

const app = express();

// --- 1. GLOBAL MIDDLEWARE ---
app.use((req, res, next) => {
    console.log(`${req.method} ${req.url}`);
    next();
});
app.use(express.json());
app.use(cors());

// --- 2. MONGOOSE MODELS ---
const UserSchema = new mongoose.Schema({
    name: { type: String, required: true },
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    role: { type: String, enum: ['user', 'seller'], default: 'user' }
});

const ProductSchema = new mongoose.Schema({
    id: { type: Number, unique: true }, 
    name: String,
    description: String,
    price: Number,
    image: String,
    category: String,
    rating: { type: Number, default: 5.0 },
    sellerId: { type: mongoose.Schema.Types.ObjectId, ref: 'User' }
});

const User = mongoose.model('User', UserSchema);
const Product = mongoose.model('Product', ProductSchema);

// --- 3. AUTH MIDDLEWARE ---
const auth = (req, res, next) => {
    try {
        const token = req.headers.authorization?.split(' ')[1];
        if (!token) throw new Error('No token');
        const decoded = jwt.verify(token, 'secret_key');
        req.user = decoded;
        next();
    } catch (e) {
        res.status(401).json({ status: 'error', message: 'Unauthorized' });
    }
};

// --- 4. API ROUTES (Must be before static to avoid folder conflicts) ---

app.post('/api/auth/register', async (req, res) => {
    console.log('--- REGISTRATION ATTEMPT ---');
    console.log('Body:', req.body);
    try {
        const { name, email, password, role } = req.body;
        if (!name || !email || !password) {
            return res.status(400).json({ status: 'error', message: 'All fields are required' });
        }

        const existing = await User.findOne({ email });
        if (existing) {
            return res.status(400).json({ status: 'error', message: 'Email already exists' });
        }
        
        const finalRole = (role === 'seller' || role === 'user') ? role : 'user';
        const user = new User({ name, email, password, role: finalRole });
        await user.save();
        console.log('Registration SUCCESS');
        res.json({ status: 'success', message: 'User registered' });
    } catch (err) {
        console.error('Registration ERROR:', err);
        res.status(500).json({ status: 'error', message: err.message });
    }
});

app.post('/api/auth/login', async (req, res) => {
    try {
        const { email, password } = req.body;
        const user = await User.findOne({ email, password });
        if (!user) return res.status(400).json({ status: 'error', message: 'Invalid credentials' });
        
        const token = jwt.sign({ id: user._id, role: user.role, email: user.email, name: user.name }, 'secret_key');
        res.json({ status: 'success', user: { id: user._id, name: user.name, email: user.email, role: user.role }, token });
    } catch (err) {
        res.status(500).json({ status: 'error', message: err.message });
    }
});

app.get('/api/products', async (req, res) => {
    try {
        const filter = {};
        if (req.query.search) {
            filter.$or = [
                { name: { $regex: req.query.search, $options: 'i' } },
                { description: { $regex: req.query.search, $options: 'i' } }
            ];
        }
        if (req.query.category) {
            filter.category = req.query.category;
        }
        const products = await Product.find(filter).sort({ _id: -1 });
        const mappedProducts = products.map(p => {
            const obj = p.toObject();
            obj.id = obj._id;
            return obj;
        });
        res.json({ status: 'success', data: mappedProducts });
    } catch (err) {
        res.status(500).json({ status: 'error', message: err.message });
    }
});

// Seller API routes
app.post('/api/seller/products', auth, async (req, res) => {
    try {
        if (req.user.role !== 'seller') return res.status(403).json({ status: 'error', message: 'Only sellers can add products' });
        const newProduct = new Product({ ...req.body, sellerId: req.user.id });
        await newProduct.save();
        res.json({ status: 'success', message: 'Product added', id: newProduct._id });
    } catch (err) {
        res.status(500).json({ status: 'error', message: err.message });
    }
});

app.get('/api/seller/products', auth, async (req, res) => {
    try {
        if (req.user.role !== 'seller') return res.status(403).json({ status: 'error', message: 'Only sellers can view their products' });
        const products = await Product.find({ sellerId: req.user.id }).sort({ _id: -1 });
        const mappedProducts = products.map(p => {
            const obj = p.toObject();
            obj.id = obj._id;
            return obj;
        });
        res.json({ status: 'success', data: mappedProducts });
    } catch (err) {
        res.status(500).json({ status: 'error', message: err.message });
    }
});

app.delete('/api/seller/products/:id', auth, async (req, res) => {
    try {
        if (req.user.role !== 'seller') return res.status(403).json({ status: 'error', message: 'Unauthorized' });
        await Product.findOneAndDelete({ _id: req.params.id, sellerId: req.user.id });
        res.json({ status: 'success', message: 'Product deleted' });
    } catch (err) {
        res.status(500).json({ status: 'error', message: err.message });
    }
});

app.post('/api/user/become-seller', auth, async (req, res) => {
    try {
        const user = await User.findById(req.user.id);
        if (!user) return res.status(404).json({ status: 'error', message: 'User not found' });
        user.role = 'seller';
        await user.save();
        const token = jwt.sign({ id: user._id, role: user.role, email: user.email, name: user.name }, 'secret_key');
        res.json({ status: 'success', user: { id: user._id, name: user.name, email: user.email, role: user.role }, token });
    } catch (err) {
        res.status(500).json({ status: 'error', message: err.message });
    }
});

// --- 5. STATIC FILES & MULTI-PAGE ROUTING ---

// Serve static assets (js, css, images)
app.use(express.static(__dirname));

// Primary routes
app.get('/', (req, res) => res.sendFile(path.join(__dirname, 'index.html')));
app.get('/dashboard', (req, res) => res.sendFile(path.join(__dirname, 'dashboard.html')));
app.get('/seller-dashboard', (req, res) => res.sendFile(path.join(__dirname, 'seller-dashboard.html')));

// Fallback for everything else (SPA-like)
app.get(/.*/, (req, res) => {
    // If it starts with /api but reached here, it's a 404 API
    if (req.url.startsWith('/api')) {
        return res.status(404).json({ status: 'error', message: 'API endpoint not found' });
    }
    // Otherwise serve index.html
    res.sendFile(path.join(__dirname, 'index.html'));
});

// --- 6. DB SETUP & SERVER START ---

const DUMMY_PRODUCTS = [
    { name: "Rubber Hex Dumbbells", description: "Anti-roll hex design, durable rubber coating.", category: "Equipment", price: 4999.00, rating: 4.8, image: "https://images.unsplash.com/photo-1638536532686-d610adfc8e5c?auto=format&fit=crop&w=900&q=80" },
    { name: "Olympic Barbell 20kg", description: "Knurled Olympic barbell with smooth sleeve rotation.", category: "Equipment", price: 15999.00, rating: 4.7, image: "https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?auto=format&fit=crop&w=900&q=80" },
    { name: "Bumper Weight Plates 100kg", description: "Durable bumper plates for deadlifts and cross training.", category: "Equipment", price: 42999.00, rating: 4.8, image: "https://images.unsplash.com/photo-1517836357463-d25dfeac3438?auto=format&fit=crop&w=900&q=80" },
    { name: "Whey Protein Isolate", description: "Fast-absorbing whey isolate for lean muscle recovery.", category: "Supplements", price: 4599.00, rating: 4.8, image: "https://images.unsplash.com/photo-1579722820308-d74e571900a9?auto=format&fit=crop&w=900&q=80" },
    { name: "Pro Gym Gloves", description: "Breathable palm-padded gloves for grip.", category: "Accessories", price: 999.00, rating: 4.5, image: "https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&w=900&q=80" }
];

const startServer = async () => {
    try {
        console.log('Connecting to MongoDB...');
        mongoose.set('bufferCommands', false);
        await mongoose.connect(process.env.MONGO_URI, {
            tlsAllowInvalidCertificates: true, 
            serverSelectionTimeoutMS: 5000,
        });
        console.log('MongoDB Connected Successfully');
        
        // Seed
        const count = await Product.countDocuments();
        if(count === 0) {
            await Product.insertMany(DUMMY_PRODUCTS);
            console.log("Seed complete.");
        }

        app.listen(5000, () => {
            console.log('Unified Server Running on http://localhost:5000');
        });
    } catch (err) {
        console.error('CRITICAL: Database connection failed:', err.message);
        setTimeout(startServer, 10000);
    }
};

startServer();
