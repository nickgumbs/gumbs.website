const { defineConfig } = require('cypress');

module.exports = defineConfig({
  retries: 2,
  reporter: 'mochawesome',
  reporterOptions: {
    reportDir: 'reports/cypress',
    overwrite: true,
    html: false,
    json: true
  },
  e2e: {
    baseUrl: 'http://localhost:8080/'
  }
});
