import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import tailwindcss from '@tailwindcss/vite';

// new tailwindcss v4

export default defineConfig({
  base: '/student_loan_analysis/',
  plugins: [
    react(),
    tailwindcss(), 
  ]
});