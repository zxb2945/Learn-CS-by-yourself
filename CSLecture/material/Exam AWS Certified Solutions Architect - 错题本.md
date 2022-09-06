# Exam AWS Certified Solutions Architect - 错题本

https://www.examtopics.com/exams/amazon/aws-certified-solutions-architect-associate-saa-c02/view/

## 20220905

No81-No130

### Question #110

A solutions architect is moving the static content from a public website hosted on Amazon EC2 instances to an Amazon S3 bucket. An Amazon CloudFront distribution will be used to deliver the static assets. The security group used by the EC2 instances restricts access to a limited set of IP ranges. Access to the static content should be similarly restricted.
Which combination of steps will meet these requirements? (Choose two.)

- A. Create an origin access identity (OAI) and associate it with the distribution. Change the permissions in the bucket policy so that only the OAI can read the objects.
- B. Create an AWS WAF web ACL that includes the same IP restrictions that exist in the EC2 security group. Associate this new web ACL with the CloudFront distribution.
- C. Create a new security group that includes the same IP restrictions that exist in the current EC2 security group. Associate this new security group with the CloudFront distribution.
- D. Create a new security group that includes the same IP restrictions that exist in the current EC2 security group. Associate this new security group with the S3 bucket hosting the static content.
- E. Create a new IAM role and associate the role with the distribution. Change the permissions either on the S3 bucket or on the files within the S3 bucket so that only the newly created IAM role has read and download permissions.

> A and B is correct. https://docs.aws.amazon.com/waf/latest/developerguide/web-acl.html
>
> \- Use signed URLs or cookies - Restrict access to content in Amazon S3 buckets => A - Use AWS WAF web ACLs => B - Use geo restriction
>
> Question is "Which combination of steps". So A & B can be answer



### Question #121

A company running an on-premises application is migrating the application to AWS to increase its elasticity and availability. The current architecture uses a
Microsoft SQL Server database with heavy read activity. The company wants to explore alternate database options and migrate database engines, if needed.
Every 4 hours, the development team does a full copy of the production database to populate a test database. During this period, users experience latency.
What should a solutions architect recommend as replacement database?

- A. Use Amazon Aurora with Multi-AZ Aurora Replicas and restore from mysqldump for the test database.
- B. Use Amazon Aurora with Multi-AZ Aurora Replicas and restore snapshots from Amazon RDS for the test database.
- C. Use Amazon RDS for MySQL with a Multi-AZ deployment and read replicas, and use the standby instance for the test database.
- D. Use Amazon RDS for SQL Server with a Multi-AZ deployment and read replicas, and restore snapshots from RDS for the test database.

> B is the correct answer. Points to be noted in Q: 1. Question itself states " What should a solution architect recommend as replacement database?" 2. " users experience latency" when backup is taken from SQL Server. This means an alternate DB needs to be considered. Migrating to Aurora will eliminate this latency. For SQL Server, I/O activity is suspended briefly during backup - https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_CreateSnapshot.html 3. Elasticity, availability, replicas - everything is provided by Aurora
>
> Totally agreed with B. For all who answered D, the answer is right but the question clearly states "What should a solution architect recommend as replacement database?" Also get the hint here, AWS is trying to sell its Proprietary databases 



### Question #130

A company hosts its website on Amazon S3. The website serves petabytes of outbound traffic monthly, which accounts for most of the company's AWS costs.
What should a solutions architect do to reduce costs?

- A. Configure Amazon CloudFront with the existing website as the origin.
- B. Move the website to Amazon EC2 with Amazon Elastic Block Store (Amazon EBS) volumes for storage.
- C. Use AWS Global Accelerator and specify the existing website as the endpoint.
- D. Rearchitect the website to run on a combination of Amazon API Gateway and AWS Lambda.

> A - correct. Reason: whenever architecture is about massive data & reads (or cached rezults) -here it said output- server by the (global) customers, CloudFront helps with distribution of S3 data and less distribution costs (for reads); however CloudFront does not help for uploads (writes) to S3, if so it would be, most likely, about Transfer Accelerator for those cases. Here only A makes sense between all options.



## 20220906

No131-

### Question #131

A company runs a website on Amazon EC2 instances behind an ELB Application Load Balancer. Amazon Route 53 is used for the DNS. The company wants to set up a backup website with a message including a phone number and email address that users can reach if the primary website is down.
How should the company deploy this solution?

- A. Use Amazon S3 website hosting for the backup website and Route 53 failover routing policy.
- B. Use Amazon S3 website hosting for the backup website and Route 53 latency routing policy.
- C. Deploy the application in another AWS Region and use ELB health checks for failover routing.
- D. Deploy the application in another AWS Region and use server-side redirection on the primary website.

> Option A : S3 website hosting for the backup website and Route 53 failover routing policy.
>
> A for sure since Route53 is used



### Question #134

An application is running on Amazon EC2 instances. Sensitive information required for the application is stored in an Amazon S3 bucket. The bucket needs to be protected from internet access while only allowing services within the VPC access to the bucket.
Which combination of actions should solutions archived take to accomplish this? (Choose two.)

- A. Create a VPC endpoint for Amazon S3.
- B. Enable server access logging on the bucket.
- C. Apply a bucket policy to restrict access to the S3 endpoint.
- D. Add an S3 ACL to the bucket that has sensitive information.
- E. Restrict users using the IAM policy to use the specific bucket.

> => A, C https://docs.aws.amazon.com/AmazonS3/latest/userguide/example-bucket-policies-vpc-endpoint.html



### Question #140

A solutions architect is designing an architecture for a new application that requires low network latency and high network throughput between Amazon EC2 instances. Which component should be included in the architectural design?

- A. An Auto Scaling group with Spot Instance types.
- B. A placement group using a cluster placement strategy.
- C. A placement group using a partition placement strategy.
- D. An Auto Scaling group with On-Demand instance types.

> HPC requirement, so Cluster placement should be the choice. Hence B is the right answer.
>
> https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html#placement-groups-cluster



### Question #142

A company wants to migrate a workload to AWS. The chief information security officer requires that all data be encrypted at rest when stored in the cloud. The company wants complete control of encryption key lifecycle management.
The company must be able to immediately remove the key material and audit key usage independently of AWS CloudTrail. The chosen services should integrate with other storage services that will be used on AWS.
Which services satisfies these security requirements?

- A. AWS CloudHSM with the CloudHSM client
- B. AWS Key Management Service (AWS KMS) with AWS CloudHSM
- C. AWS Key Management Service (AWS KMS) with an external key material origin
- D. AWS Key Management Service (AWS KMS) with AWS managed customer master keys (CMKs)

> This is a difficult one. But I think option B is the right choice here. https://aws.amazon.com/blogs/security/are-kms-custom-key-stores-right-for-you/



