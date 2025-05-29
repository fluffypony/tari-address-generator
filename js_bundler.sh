#!/bin/bash

# Tari Generator Bundle Script
echo "Setting up Tari Generator offline bundles..."

# Create project directory structure
mkdir -p tari-bundles/src
cd tari-bundles

# Initialize npm project
echo "Initializing npm project..."
npm init -y

# Install dependencies (updated to match your imports)
echo "Installing dependencies..."
npm install @noble/curves @noble/ciphers @noble/hashes @scure/bip39 bs58 crc-32
npm install -D vite

# Create vite config for ES modules
echo "Creating vite.config.js..."
cat > vite.config.js << 'EOF'
import { defineConfig } from 'vite';

export default defineConfig({
  build: {
    lib: {
      entry: './src/main.js',
      name: 'TariGenerator',
      fileName: 'tari-generator',
      formats: ['iife']
    },
    rollupOptions: {
      output: {
        inlineDynamicImports: true
      }
    }
  }
});
EOF

# Create dependencies bundle
echo "Creating main.js..."
cat > src/main.js << 'EOF'
import { ed25519 } from '@noble/curves/ed25519';
import { blake2b } from '@noble/hashes/blake2b';
import { wordlist } from '@scure/bip39/wordlists/english';
import bs58 from 'bs58';
import { chacha20 } from '@noble/ciphers/chacha';
import CRC32 from 'crc-32';

// Use ExtendedPoint as RistrettoPoint (they're the same for ed25519)
const RistrettoPoint = ed25519.ExtendedPoint;

// Expose modules exactly as the CDN imports would
window.ed25519Module = { 
  ed25519, 
  RistrettoPoint
};

// Create mock import objects that match the CDN structure
window.blake2bModule = { blake2b };
window.wordlistModule = { wordlist };
window.bs58Module = { default: bs58 };
window.chachaModule = { chacha20 };
window.crc32Module = { default: CRC32 };

console.log('External dependencies loaded');
EOF

# Build bundle
echo "Building bundle..."
npx vite build

# Download argon2 bundle
echo "Downloading argon2 bundle..."
curl -s -o dist/argon2-bundled.min.js https://cdn.jsdelivr.net/npm/argon2-browser@1.18.0/dist/argon2-bundled.min.js

# Move the generated file to a simpler name
mv dist/tari-generator.iife.js dist/tari-generator.js

echo "✅ Build complete! Files are in the 'dist' folder:"
echo "   - argon2-bundled.min.js"
echo "   - tari-generator.js"
