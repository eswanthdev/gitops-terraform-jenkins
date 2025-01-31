# gitops-terraform-jenkins

## Overview1

This repository will demonstrate an example GitOps workflow with Terraform and Jenkins.

The configuration in this repository was run using `Terraform v0.11.13`.

Video can be found here:

https://youtu.be/qFjGqPw1NUY

## Requirements

* Terraform installed on Jenkins
* Correct plugins installed on Jenkins
* GitHub access token
* AWS credentials
* S3 bucket

## Setup Bucket

You will need to create a bucket and reference the bucket name in the following section of `main.tf`:

```
terraform {
  backend "s3" {
    bucket = "terraform-bucket-alex"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
```

## Plugins Required

* [Workspace Cleanup Plugin](https://wiki.jenkins.io/display/JENKINS/Workspace+Cleanup+Plugin)
* [Credentials Binding Plugin](https://wiki.jenkins.io/display/JENKINS/Credentials+Binding+Plugin)
* [AnsiColor Plugin](https://wiki.jenkins.io/display/JENKINS/AnsiColor+Plugin)
* [GitHub Plugin](https://wiki.jenkins.io/display/JENKINS/GitHub+Plugin)
* [Pipeline Plugin](https://wiki.jenkins.io/display/JENKINS/Pipeline+Plugin)
* [CloudBees AWS Credentials Plugin](https://wiki.jenkins.io/display/JENKINS/CloudBees+AWS+Credentials+Plugin)

## Questions?

Open an issue.
