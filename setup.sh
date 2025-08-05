#!/bin/bash

# Gift Hamper Store - Complete Project Setup Script
# Run this script in your repository root to create the entire folder structure

echo "🎁 Creating Gift Hamper Store Project Structure..."

# Create main directories
mkdir -p src/{app,components,lib,hooks,types,styles,utils,context,services}
mkdir -p public/{images,icons,fonts}
mkdir -p tests/{unit,integration,e2e}
mkdir -p scripts
mkdir -p docs

# Create app directory structure (Next.js 14 App Router)
mkdir -p src/app/"(shop)"/{occasions,hampers,cart,checkout,profile,track}
mkdir -p src/app/"(shop)"/hamper/"[id]"
mkdir -p src/app/"(shop)"/occasions/"[occasion]"
mkdir -p src/app/"(shop)"/category/"[category]"
mkdir -p src/app/admin/{dashboard,hampers,orders,customers,analytics,settings}
mkdir -p src/app/admin/hampers/{create,edit/"[id]"}
mkdir -p src/app/api/{auth,hampers,orders,cart,payment,users,occasions,reviews,notifications}
mkdir -p src/app/api/auth/"[...nextauth]"
mkdir -p src/app/auth/{login,register,forgot-password,verify}

# Create components structure
mkdir -p src/components/ui
mkdir -p src/components/hampers
mkdir -p src/components/cart
mkdir -p src/components/checkout
mkdir -p src/components/admin
mkdir -p src/components/layout
mkdir -p src/components/common
mkdir -p src/components/occasions

# Create lib structure
mkdir -p src/lib/{db,models,auth,payment,email,sms}
mkdir -p src/lib/validations

# Create services structure
mkdir -p src/services

# Create context structure
mkdir -p src/context

# Create utils structure
mkdir -p src/utils

# Create types structure
mkdir -p src/types

# ==================== CREATE FILES ====================

# Root configuration files
cat > package.json << 'EOF'
{
  "name": "gift-hamper-store",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "test": "jest",
    "test:watch": "jest --watch",
    "test:e2e": "playwright test",
    "db:seed": "node scripts/seed.js",
    "type-check": "tsc --noEmit"
  },
  "dependencies": {
    "next": "14.1.0",
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "mongoose": "^8.0.0",
    "next-auth": "^4.24.5",
    "bcryptjs": "^2.4.3",
    "@tanstack/react-query": "^5.17.0",
    "zustand": "^4.4.7",
    "axios": "^1.6.2",
    "razorpay": "^2.9.2",
    "cloudinary": "^1.41.0",
    "resend": "^2.0.0",
    "twilio": "^4.19.0",
    "react-hook-form": "^7.48.2",
    "zod": "^3.22.4",
    "@hookform/resolvers": "^3.3.2",
    "date-fns": "^3.0.0",
    "react-hot-toast": "^2.4.1",
    "framer-motion": "^10.16.16",
    "react-intersection-observer": "^9.5.3",
    "next-pwa": "^5.6.0",
    "sharp": "^0.33.1",
    "@radix-ui/react-dialog": "^1.0.5",
    "@radix-ui/react-dropdown-menu": "^2.0.6",
    "@radix-ui/react-select": "^2.0.0",
    "@radix-ui/react-tabs": "^1.0.4",
    "@radix-ui/react-toast": "^1.1.5",
    "tailwind-merge": "^2.2.0",
    "clsx": "^2.0.0",
    "class-variance-authority": "^0.7.0",
    "lucide-react": "^0.302.0",
    "recharts": "^2.10.3",
    "embla-carousel-react": "^8.0.0-rc17"
  },
  "devDependencies": {
    "@types/node": "^20.10.5",
    "@types/react": "^18.2.45",
    "@types/react-dom": "^18.2.18",
    "@types/bcryptjs": "^2.4.6",
    "typescript": "^5.3.3",
    "tailwindcss": "^3.4.0",
    "postcss": "^8.4.32",
    "autoprefixer": "^10.4.16",
    "eslint": "^8.56.0",
    "eslint-config-next": "14.1.0",
    "@testing-library/react": "^14.1.2",
    "@testing-library/jest-dom": "^6.1.5",
    "@playwright/test": "^1.40.1",
    "jest": "^29.7.0",
    "jest-environment-jsdom": "^29.7.0",
    "prettier": "^3.1.1"
  }
}
EOF

# TypeScript configuration
cat > tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "es5",
    "lib": ["dom", "dom.iterable", "esnext"],
    "allowJs": true,
    "skipLibCheck": true,
    "strict": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": "esnext",
    "moduleResolution": "bundler",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "incremental": true,
    "plugins": [
      {
        "name": "next"
      }
    ],
    "paths": {
      "@/*": ["./src/*"],
      "@/components/*": ["./src/components/*"],
      "@/lib/*": ["./src/lib/*"],
      "@/hooks/*": ["./src/hooks/*"],
      "@/types/*": ["./src/types/*"],
      "@/utils/*": ["./src/utils/*"],
      "@/styles/*": ["./src/styles/*"]
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
EOF

# Next.js configuration
cat > next.config.js << 'EOF'
/** @type {import('next').NextConfig} */
const withPWA = require('next-pwa')({
  dest: 'public',
  register: true,
  skipWaiting: true,
  disable: process.env.NODE_ENV === 'development'
})

const nextConfig = {
  images: {
    domains: ['res.cloudinary.com', 'images.unsplash.com'],
  },
  experimental: {
    serverActions: true,
  },
}

module.exports = withPWA(nextConfig)
EOF

# Tailwind configuration
cat > tailwind.config.ts << 'EOF'
import type { Config } from 'tailwindcss'

const config: Config = {
  content: [
    './src/pages/**/*.{js,ts,jsx,tsx,mdx}',
    './src/components/**/*.{js,ts,jsx,tsx,mdx}',
    './src/app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        primary: {
          DEFAULT: '#8B5CF6',
          dark: '#7C3AED',
        },
        secondary: '#F97316',
        accent: '#EC4899',
        gold: '#F59E0B',
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
      },
      animation: {
        'slide-up': 'slideUp 0.3s ease',
        'fade-in': 'fadeIn 0.5s ease',
      },
    },
  },
  plugins: [],
}
export default config
EOF

# PostCSS configuration
cat > postcss.config.js << 'EOF'
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
EOF

# Environment variables template
cat > .env.local.example << 'EOF'
# Database
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/gifthampers?retryWrites=true&w=majority

# NextAuth
NEXTAUTH_URL=http://localhost:3000
NEXTAUTH_SECRET=your-secret-key-here

# OAuth (optional)
GOOGLE_CLIENT_ID=
GOOGLE_CLIENT_SECRET=

# Cloudinary
CLOUDINARY_CLOUD_NAME=
CLOUDINARY_API_KEY=
CLOUDINARY_API_SECRET=

# Razorpay
RAZORPAY_KEY_ID=
RAZORPAY_KEY_SECRET=
RAZORPAY_WEBHOOK_SECRET=

# Email (Resend)
RESEND_API_KEY=

# SMS (Twilio)
TWILIO_ACCOUNT_SID=
TWILIO_AUTH_TOKEN=
TWILIO_PHONE_NUMBER=

# Analytics
NEXT_PUBLIC_GA_ID=
MIXPANEL_TOKEN=
EOF

# .gitignore
cat > .gitignore << 'EOF'
# Dependencies
/node_modules
/.pnp
.pnp.js

# Testing
/coverage
/.nyc_output

# Next.js
/.next/
/out/

# Production
/build
/dist

# Misc
.DS_Store
*.pem

# Debug
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Local env files
.env*.local
.env

# Vercel
.vercel

# TypeScript
*.tsbuildinfo
next-env.d.ts

# PWA
public/sw.js
public/workbox-*.js
public/worker-*.js
public/sw.js.map
public/workbox-*.js.map
public/worker-*.js.map

# IDE
.vscode/
.idea/
*.swp
*.swo
EOF

# Create README.md
cat > README.md << 'EOF'
# 🎁 Gift Hamper Store

A modern, mobile-first e-commerce platform for gift hampers built with Next.js 14, MongoDB, and TypeScript.

## 🚀 Features

- 📱 Mobile-first responsive design
- 🎨 Customizable gift hampers
- 📅 Delivery date selection
- 💳 Secure payment processing (Razorpay/Stripe)
- 📦 Order tracking
- 👤 User authentication
- 🎯 Occasion-based shopping
- 📊 Admin dashboard
- 📧 Email/SMS notifications
- 🔄 PWA support

## 🛠️ Tech Stack

- **Frontend:** Next.js 14, React, TypeScript, Tailwind CSS
- **Backend:** Next.js API Routes, MongoDB, Mongoose
- **Auth:** NextAuth.js
- **Payment:** Razorpay
- **Storage:** Cloudinary
- **Email:** Resend
- **SMS:** Twilio
- **Deployment:** Vercel

## 📦 Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/gift-hamper-store.git
cd gift-hamper-store
```

2. Install dependencies:
```bash
npm install
```

3. Set up environment variables:
```bash
cp .env.local.example .env.local
# Edit .env.local with your credentials
```

4. Run the development server:
```bash
npm run dev
```

5. Open [http://localhost:3000](http://localhost:3000)

## 🗄️ Database Setup

1. Create a MongoDB Atlas account
2. Create a new cluster
3. Add connection string to `.env.local`
4. Run seed script:
```bash
npm run db:seed
```

## 📁 Project Structure

```
src/
├── app/           # Next.js app directory
├── components/    # React components
├── lib/          # Utilities and database
├── hooks/        # Custom React hooks
├── types/        # TypeScript types
├── context/      # React context
└── services/     # API services
```

## 🚀 Deployment

1. Push to GitHub
2. Connect to Vercel
3. Add environment variables
4. Deploy

## 📝 License

MIT
EOF

# Create main layout file
cat > src/app/layout.tsx << 'EOF'
import type { Metadata } from 'next'
import { Inter } from 'next/font/google'
import './globals.css'
import { Providers } from '@/components/providers'

const inter = Inter({ subsets: ['latin'] })

export const metadata: Metadata = {
  title: 'GiftBox - Premium Gift Hampers',
  description: 'Perfect gifts for every occasion. Curated hampers delivered with love.',
  manifest: '/manifest.json',
  themeColor: '#8B5CF6',
  viewport: 'width=device-width, initial-scale=1, maximum-scale=1',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body className={inter.className}>
        <Providers>{children}</Providers>
      </body>
    </html>
  )
}
EOF

# Create global styles
cat > src/app/globals.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  :root {
    --primary: 139 92 246;
    --primary-dark: 124 58 237;
    --secondary: 249 115 22;
    --accent: 236 72 153;
    --gold: 245 158 11;
  }
}

@layer components {
  .btn-primary {
    @apply bg-primary text-white font-semibold py-3 px-6 rounded-xl transition-all hover:bg-primary-dark active:scale-95;
  }
  
  .card {
    @apply bg-white rounded-2xl shadow-lg overflow-hidden;
  }
}

* {
  -webkit-tap-highlight-color: transparent;
}
EOF

# Create MongoDB connection
cat > src/lib/db/mongoose.ts << 'EOF'
import mongoose from 'mongoose'

const MONGODB_URI = process.env.MONGODB_URI!

if (!MONGODB_URI) {
  throw new Error('Please define the MONGODB_URI environment variable')
}

let cached = global.mongoose

if (!cached) {
  cached = global.mongoose = { conn: null, promise: null }
}

async function connectDB() {
  if (cached.conn) {
    return cached.conn
  }

  if (!cached.promise) {
    const opts = {
      bufferCommands: false,
    }

    cached.promise = mongoose.connect(MONGODB_URI, opts).then((mongoose) => {
      return mongoose
    })
  }

  try {
    cached.conn = await cached.promise
  } catch (e) {
    cached.promise = null
    throw e
  }

  return cached.conn
}

export default connectDB
EOF

# Create Hamper model
cat > src/lib/models/Hamper.ts << 'EOF'
import mongoose from 'mongoose'

const hamperSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true
  },
  slug: {
    type: String,
    required: true,
    unique: true,
    lowercase: true
  },
  description: {
    type: String,
    required: true
  },
  occasions: [{
    type: String,
    enum: ['birthday', 'anniversary', 'wedding', 'baby', 'corporate', 'festival', 'graduation', 'sympathy']
  }],
  category: {
    type: String,
    enum: ['luxury', 'chocolate', 'spa', 'gourmet', 'personalized', 'flowers', 'wine'],
    required: true
  },
  basePrice: {
    type: Number,
    required: true
  },
  sizes: [{
    name: String,
    price: Number,
    dimensions: String
  }],
  items: [{
    name: String,
    quantity: Number,
    description: String
  }],
  customizations: {
    wrapColors: [String],
    cardTemplates: [mongoose.Schema.Types.ObjectId],
    addOns: [mongoose.Schema.Types.ObjectId]
  },
  images: [{
    url: String,
    alt: String,
    isPrimary: Boolean
  }],
  tags: [String],
  ratings: {
    average: { type: Number, default: 0 },
    count: { type: Number, default: 0 }
  },
  stock: {
    type: Number,
    default: 0
  },
  deliveryTime: {
    type: String,
    default: '2-3 days'
  },
  isPersonalizable: {
    type: Boolean,
    default: true
  },
  isFeatured: {
    type: Boolean,
    default: false
  },
  status: {
    type: String,
    enum: ['active', 'inactive', 'draft'],
    default: 'active'
  }
}, {
  timestamps: true
})

hamperSchema.index({ name: 'text', description: 'text' })
hamperSchema.index({ slug: 1 })
hamperSchema.index({ occasions: 1 })
hamperSchema.index({ category: 1 })
hamperSchema.index({ status: 1 })

export default mongoose.models.Hamper || mongoose.model('Hamper', hamperSchema)
EOF

# Create User model
cat > src/lib/models/User.ts << 'EOF'
import mongoose from 'mongoose'
import bcrypt from 'bcryptjs'

const userSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true
  },
  email: {
    type: String,
    required: true,
    unique: true,
    lowercase: true
  },
  phone: {
    type: String,
    required: true
  },
  password: {
    type: String,
    required: true
  },
  addresses: [{
    type: { type: String, enum: ['home', 'work'], default: 'home' },
    name: String,
    phone: String,
    line1: String,
    line2: String,
    city: String,
    state: String,
    pincode: String,
    isDefault: Boolean
  }],
  savedRecipients: [{
    name: String,
    phone: String,
    address: Object,
    occasions: [{
      type: String,
      date: Date
    }]
  }],
  wishlist: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Hamper'
  }],
  giftReminders: [{
    recipientName: String,
    occasion: String,
    date: Date,
    reminderDays: Number
  }],
  corporateAccount: {
    companyName: String,
    gstNumber: String,
    creditLimit: Number
  },
  loyaltyPoints: {
    type: Number,
    default: 0
  },
  role: {
    type: String,
    enum: ['customer', 'admin'],
    default: 'customer'
  }
}, {
  timestamps: true
})

userSchema.pre('save', async function(next) {
  if (!this.isModified('password')) return next()
  this.password = await bcrypt.hash(this.password, 12)
  next()
})

userSchema.methods.comparePassword = async function(candidatePassword: string) {
  return await bcrypt.compare(candidatePassword, this.password)
}

export default mongoose.models.User || mongoose.model('User', userSchema)
EOF

# Create homepage
cat > src/app/page.tsx << 'EOF'
'use client'

import { useState } from 'react'
import Link from 'next/link'
import { Search, ShoppingCart, Gift, Calendar, Heart } from 'lucide-react'

export default function HomePage() {
  const [searchQuery, setSearchQuery] = useState('')

  const occasions = [
    { id: 'birthday', name: 'Birthday', icon: '🎂', color: 'bg-pink-100' },
    { id: 'anniversary', name: 'Anniversary', icon: '💑', color: 'bg-red-100' },
    { id: 'wedding', name: 'Wedding', icon: '💐', color: 'bg-purple-100' },
    { id: 'baby', name: 'New Baby', icon: '👶', color: 'bg-blue-100' },
    { id: 'corporate', name: 'Corporate', icon: '💼', color: 'bg-gray-100' },
    { id: 'festival', name: 'Festival', icon: '🪔', color: 'bg-yellow-100' },
  ]

  const featuredHampers = [
    {
      id: 1,
      name: 'Birthday Celebration Box',
      price: 2499,
      image: '🎉',
      rating: 4.8,
      reviews: 234
    },
    {
      id: 2,
      name: 'Chocolate Paradise',
      price: 1899,
      image: '🍫',
      rating: 4.9,
      reviews: 189
    },
    {
      id: 3,
      name: 'Spa & Wellness Kit',
      price: 3299,
      image: '🧖‍♀️',
      rating: 4.7,
      reviews: 156
    },
    {
      id: 4,
      name: 'Gourmet Food Basket',
      price: 3499,
      image: '🧺',
      rating: 4.6,
      reviews: 145
    }
  ]

  return (
    <div className="min-h-screen bg-gradient-to-b from-purple-50 to-white">
      {/* Header */}
      <header className="sticky top-0 z-50 bg-white shadow-sm">
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between">
            <Link href="/" className="text-2xl font-bold bg-gradient-to-r from-primary to-accent bg-clip-text text-transparent">
              🎁 GiftBox
            </Link>
            <div className="flex items-center gap-4">
              <button className="p-2">
                <Heart className="w-6 h-6" />
              </button>
              <Link href="/cart" className="relative p-2">
                <ShoppingCart className="w-6 h-6" />
                <span className="absolute -top-1 -right-1 bg-accent text-white text-xs rounded-full w-5 h-5 flex items-center justify-center">
                  0
                </span>
              </Link>
            </div>
          </div>
        </div>
      </header>

      {/* Hero Section */}
      <section className="container mx-auto px-4 py-8">
        <div className="text-center mb-8">
          <h1 className="text-4xl font-bold mb-4 bg-gradient-to-r from-primary to-accent bg-clip-text text-transparent">
            Perfect Gifts for Every Occasion
          </h1>
          <p className="text-gray-600">Curated hampers delivered with love 💝</p>
        </div>

        {/* Search Bar */}
        <div className="max-w-2xl mx-auto mb-8">
          <div className="relative">
            <input
              type="text"
              placeholder="Search for hampers, occasions..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="w-full px-6 py-4 pr-12 rounded-full border-2 border-gray-200 focus:border-primary focus:outline-none"
            />
            <Search className="absolute right-4 top-1/2 -translate-y-1/2 text-gray-400 w-6 h-6" />
          </div>
        </div>
      </section>

      {/* Occasions Grid */}
      <section className="container mx-auto px-4 py-8">
        <h2 className="text-2xl font-bold mb-6">Shop by Occasion</h2>
        <div className="grid grid-cols-3 md:grid-cols-6 gap-4">
          {occasions.map((occasion) => (
            <Link
              key={occasion.id}
              href={`/occasions/${occasion.id}`}
              className={`${occasion.color} rounded-2xl p-4 text-center hover:shadow-lg transition-shadow`}
            >
              <div className="text-4xl mb-2">{occasion.icon}</div>
              <p className="text-sm font-medium">{occasion.name}</p>
            </Link>
          ))}
        </div>
      </section>

      {/* Featured Hampers */}
      <section className="container mx-auto px-4 py-8">
        <h2 className="text-2xl font-bold mb-6">Popular Hampers</h2>
        <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
          {featuredHampers.map((hamper) => (
            <Link
              key={hamper.id}
              href={`/hamper/${hamper.id}`}
              className="bg-white rounded-2xl shadow-lg overflow-hidden hover:shadow-xl transition-shadow"
            >
              <div className="aspect-square bg-gradient-to-br from-purple-100 to-pink-100 flex items-center justify-center text-6xl">
                {hamper.image}
              </div>
              <div className="p-4">
                <h3 className="font-semibold mb-1">{hamper.name}</h3>
                <div className="flex items-center gap-1 mb-2">
                  <span className="text-gold">⭐</span>
                  <span className="text-sm">{hamper.rating}</span>
                  <span className="text-sm text-gray-500">({hamper.reviews})</span>
                </div>
                <p className="text-xl font-bold text-primary">₹{hamper.price}</p>
              </div>
            </Link>
          ))}
        </div>
      </section>

      {/* Bottom Navigation */}
      <nav className="fixed bottom-0 left-0 right-0 bg-white border-t md:hidden">
        <div className="grid grid-cols-4 py-2">
          <Link href="/" className="flex flex-col items-center py-2 text-primary">
            <Gift className="w-6 h-6" />
            <span className="text-xs mt-1">Home</span>
          </Link>
          <Link href="/occasions" className="flex flex-col items-center py-2 text-gray-600">
            <Calendar className="w-6 h-6" />
            <span className="text-xs mt-1">Occasions</span>
          </Link>
          <Link href="/cart" className="flex flex-col items-center py-2 text-gray-600">
            <ShoppingCart className="w-6 h-6" />
            <span className="text-xs mt-1">Cart</span>
          </Link>
          <Link href="/profile" className="flex flex-col items-center py-2 text-gray-600">
            <Heart className="w-6 h-6" />
            <span className="text-xs mt-1">Profile</span>
          </Link>
        </div>
      </nav>
    </div>
  )
}
EOF

# Create package scripts
cat > scripts/seed.js << 'EOF'
// Database seeding script
const mongoose = require('mongoose')
require('dotenv').config({ path: '.env.local' })

async function seed() {
  try {
    await mongoose.connect(process.env.MONGODB_URI)
    console.log('Connected to MongoDB')
    
    // Add seeding logic here
    console.log('Database seeded successfully')
    
    process.exit(0)
  } catch (error) {
    console.error('Seeding failed:', error)
    process.exit(1)
  }
}

seed()
EOF

echo "✅ Project structure created successfully!"
echo ""
echo "📝 Next steps:"
echo "1. Navigate to your repository: cd your-repo-name"
echo "2. Run this script: bash setup.sh"
echo "3. Install dependencies: npm install"
echo "4. Set up your .env.local file"
echo "5. Run the development server: npm run dev"
echo ""
echo "🎉 Your Gift Hamper Store project is ready!"
