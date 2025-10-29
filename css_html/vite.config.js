import { defineConfig } from 'vite';

export default defineConfig({
  root: 'concepts',
  publicDir: '../public',
  server: {
    port: 3000,
    host: true,
    open: true,
  },
});
