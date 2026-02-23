# Personal Website: [https://gumbs.me](https://gumbs.me)

## Overview

This project showcases my personal website, hosted on AWS and designed with a serverless architecture for improved performance and scalability.

## Local Development

### Prerequisites

- Node.js and npm (LTS recommended)

### Install

```bash
npm install
```

### Run Locally

```bash
npm run webpack:start
```

This starts the dev server at `http://localhost:8080` and serves static content from `public/`.

### Build

```bash
npm run webpack:build
```

Build output is written to `dist/`.

### Test

```bash
# Run Cypress in interactive mode (expects the dev server running)
npm run cypress:open

# Run Cypress headless (expects the dev server running)
npm run cypress:run

# Run Playwright tests (defaults to https://gumbs.me)
npm run playwright:run
```

If you want Playwright to run against a local build, update `baseURL` in `playwright.config.js` or set it via CLI.

## Key Features

- **Hosting:** Statically hosted on AWS S3, leveraging Python Lambda functions (boto3) and DynamoDB for backend infrastructure.
- **Infrastructure as Code:** Created a Terraform Stack, integrating API Gateway to interact with DynamoDB.
- **Content Distribution:** Utilized AWS CloudFront CDN for low-latency content distribution.
- **DNS Management:** Configured AWS Route53 routing policies to map CloudFront distribution to a third-party DNS server.
- **Automated Testing:** Developing unit tests to ensure continued API functionality, visual consistency, and browser compatibility.
- **CI/CD Pipeline:** Deployed a CI/CD pipeline using GitHub Actions to automate deployment, invalidate edge caches, and run production test suite.
- **Responsive Design:** Site responsiveness to different browsers and screen sizes using CSS.
- **Access Management:** Implement OIDC for secure access control within the CI pipeline.





