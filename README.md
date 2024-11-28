# Personal Website: [https://gumbs.website](https://gumbs.website)

## Overview

This project showcases my personal website, hosted on AWS and designed with a serverless architecture for improved performance and scalability.

## Key Features

- **Hosting:** Statically hosted on AWS S3, leveraging Python Lambda functions (boto3) and DynamoDB for backend infrastructure.
- **Infrastructure as Code:** Created a Terraform Stack, integrating API Gateway to interact with DynamoDB.
- **Content Distribution:** Utilized AWS CloudFront CDN for low-latency content distribution.
- **DNS Management:** Configured AWS Route53 routing policies to map CloudFront distribution to a third-party DNS server.
- **Automated Testing:** Developing unit tests to ensure continued API functionality, visual consistency, and browser compatibility.
- **CI/CD Pipeline:** Deployed a CI/CD pipeline using GitHub Actions to automate deployment, invalidate edge caches, and run production test suite.
- **Responsive Design:** Site responsiveness to different browsers and screen sizes using CSS.
