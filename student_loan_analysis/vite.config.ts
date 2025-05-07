import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react-swc';
import tailwindcss from '@tailwindcss/vite';
import path from 'path';

// new tailwindcss v4

export default defineConfig({
  plugins: [
    react(),
    tailwindcss(), 
  ],
  base: '/student_loan_analysis/',
  // build: {
  //   outDir: 'docs'  // Change output directory to "docs"
  // },
  resolve: {
    alias: {
      '@': path.resolve(__dirname, 'src'),
    },
  },
});