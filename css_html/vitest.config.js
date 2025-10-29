import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    environment: 'jsdom',
    globals: true,
    include: ['**/*.test.js'], // Only include .test.js files for Vitest
    exclude: ['node_modules/**', 'dist/**', '**/*.spec.js'], // Exclude Playwright .spec.js files
  },
});
