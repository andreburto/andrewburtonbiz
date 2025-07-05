# CloudFront Test

## About

Testing out using [CloudFront](https://aws.amazon.com/cloudfront/) to host a static page and using [API Gateway](https://docs.aws.amazon.com/apigateway/) with [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/CORS) for dynamic content.
Once I got over my faux outrage that API Gateway charged for custom domains, it really started to appeal.
This project is not good for anything, but some of the ideas may bleed into my [Turboman project](https://github.com/andreburto/turboman/).

## Deploy

Since this is a proof-of-concept test bed, there are some pieces missing, like the images the page uses.
However, the code will work and deploy. Use the following steps from the top project.
The following assumes your AWS credentials are setup our you have an active session.

**Step 1**

Provision resources with the Terraform configuration: `terraform apply -auto-approve`.

**Step 2**

Run the `deploy.sh` script to deploy the API Gateway: `./deploy.sh`.

## To Do

- Create a proper GHA deployment system that runs the API Gateway deploy after Terraform finishes.
- Figure out how to automate image generation without giving my ID to Sam Altman.
