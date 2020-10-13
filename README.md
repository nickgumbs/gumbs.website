Files for https://gumbs.website

- Statically hosted in AWS S3 leveraging Python Lambda functions (boto3) and DynamoDB for backend infrastructure.
- Created an CloudFormation Stack incorporating API Gateway to interact with DynamoDB.
- Employed CloudFront CDN to distribute website with low latency.
- Used AWS Route53 routing policies to map CloudFront distribution to thrid party DNS server.

In Process:

- Creating CI/CD pipeline to test and deploy future changes.
- Develop automated unit tests to ensure continued API functionality, Visual consistency, and Web Browser compatibility.
- Make site responsive to browser and size changes (CSS).
