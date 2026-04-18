# FitZone E-Commerce Store (Static Demo)

FitZone is now a **100% frontend static demo** project that runs directly in the browser with no server setup.

## Run Instantly
1. Open the `fitzone-store` folder.
2. Double-click `index.html`.
3. The app runs directly in your browser (no XAMPP, Apache, PHP, or MySQL).

## How Data Works
- Products are loaded from in-file JavaScript mock data (`js/script.js`).
- Cart is stored in `localStorage` (`fitzone_cart`).
- Users (register/login simulation) are stored in `localStorage` (`fitzone_users`, `fitzone_user`).
- Demo orders and payment metadata are stored in `localStorage` (`fitzone_orders`).

## Payment Demo
- Razorpay test popup is enabled via CDN (`checkout.razorpay.com`).
- Checkout remains demo-only:
  - Local order creation
  - Local verification/persistence
  - Redirect to success page
- If Razorpay CDN is unavailable, checkout falls back to simulated success mode.

## Features Included
- Product listing with category and search filter
- Add to cart and quantity controls
- Cart total calculations in INR
- Register/login demo flow
- Checkout demo flow with Razorpay test popup
- Mobile responsive dark UI (unchanged)

## Deploy as Static Site
You can deploy this folder directly to:
- Netlify (drag-and-drop the `fitzone-store` folder)
- Vercel (import as static project)
- GitHub Pages (push and enable Pages)
