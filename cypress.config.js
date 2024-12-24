const { defineConfig } = require('cypress');

module.exports = defineConfig({
  retries: 2,
  e2e: {
    baseUrl: 'http://localhost:8080/'
  }
});
