# Java AMI

Terraform and AWS EC2 Image Builder configuration for creating a reusable
Java base AMI.

The AMI is based on Amazon Linux 2023 and includes Java 21. It does not
contain the application JAR or application-specific configuration.

## Architecture

```text
Amazon Linux 2023
        ↓
EC2 Image Builder
        ↓
Java 21 Base AMI
        ↓
java-infra
        ↓
Launch Template
        ↓
Auto Scaling Group
        ↓
EC2 instances