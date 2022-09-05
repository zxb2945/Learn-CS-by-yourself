# Exam AWS Certified Solutions Architect - Associate SAA-C02

https://www.examtopics.com/exams/amazon/aws-certified-solutions-architect-associate-saa-c02/view/

### 20220731

### **Question #1** 

A company is preparing to deploy a new serverless workload. A solutions architect needs to configure permissions for invoking an AWS Lambda function. The function will be triggered by an Amazon EventBridge (Amazon CloudWatch Events) rule. Permissions should be configured using the principle of least privilege.

- A. Add an execution role to the function with lambda:InvokeFunction as the action and * as the principal.
- B. Add an execution role to the function with lambda:InvokeFunction as the action and Service:amazonaws.com as the principal.
- C. Add a resource-based policy to the function with lambda:'* as the action and Service:events.amazonaws.com as the principal.
- D. Add a resource-based policy to the function with lambda:InvokeFunction as the action and Service:events.amazonaws.com as the principal.



> **D. https://docs.aws.amazon.com/eventbridge/latest/userguide/resource-based-policies-eventbridge.html#lambda-permissions**



### **Question #2**

A business outsources its marketplace analytics management to a third-party partner. The vendor requires restricted programmatic access to the company's account's resources. All necessary policies have been established to ensure acceptable access.

Which new component provides the vendor the MOST SECURE access to the account?

- A. Stop the instance outside the application's availability window. Start up the instance again when required.
- B. Hibernate the instance outside the application's availability window. Start up the instance again when required.
- C. Use Auto Scaling to scale down the instance outside the application's availability window. Scale up the instance when required.
- D. Terminate the instance outside the application's availability window. Launch the instance by using a preconfigured Amazon Machine Image (AMI) when required.



> **Ans: B https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Hibernate.html **
>
> **1. Hibernate: To preserve contents of the instance's memory whenever the instance is unavailable. https://aws.amazon.com/blogs/aws/new-hibernate-your-ec2-instances/ **
>
> **2. Cost consideration: While the instance is in hibernation, you pay only for the EBS volumes and Elastic IP Addresses attached to it; there are no other hourly charges (just like any other stopped instance).**



### **Question #3**

A firm seeks to migrate its accounting system from an on-premises data center to an Amazon Web Services (AWS) Region. Data security and an unalterable audit log should be prioritized. All AWS activities must be subjected to compliance audits. Despite the fact that the business has enabled AWS CloudTrail, it want to guarantee that it meets these requirements.

What precautions and security procedures should a solutions architect include to protect and secure CloudTrail? (Choose two.)

A. Enable CloudTrail log file validation. 

B. Install the CloudTrail Processing Library. 

C. Enable logging of Insights events in CloudTrail. 

D. Enable custom logging from the on-premises resources. 

E. Create an AWS Config rule to monitor whether CloudTrail is configured to use



> **A and E should be answers. https://docs.aws.amazon.com/awscloudtrail/latest/userguide/data-protection.html The following security best practices also address data protection in CloudTrail: Encrypting CloudTrail log files with AWS KMS–managed keys (SSE-KMS) Amazon S3 bucket policy for CloudTrail Validating CloudTrail log file integrity Sharing CloudTrail log files between AWS accounts**



### **Question #4**

On its website, a business keeps a searchable store of things. The data is stored in a table with over ten million rows in an Amazon RDS for MySQL database. The database is stored on a 2 TB General Purpose SSD (gp2) array. Every day, the company's website receives millions of changes to this data. The organization found that certain activities were taking ten seconds or more and concluded that the bottleneck was the database storage performance. 

Which option satisfies the performance requirement?

 A. Change the storage type to Provisioned IOPS SSD (io1).

B. Change the instance to a memory-optimized instance class.

C. Change the instance to a burstable performance DB instance class. 

D. Enable Multi-AZ RDS read replicas with MySQL native asynchronous replication. 



> **Ans is A.**



### **Question #5**

A business that is currently hosting a web application on-premises is prepared to transition to AWS and launch a newer version of the application. The organization must route requests to the AWS or on-premises application based on the URL query string. The on-premises application is rendered unreachable over the internet, and a VPN connection is established between Amazon VPC and the business's data center. The company wishes to deploy this application using a load balancer (ALB).

Which of the following solutions meets these criteria?

- A. Use AWS Snowball Edge devices to process and store the images.
- B. Upload the images to Amazon Simple Queue Service (Amazon SQS) during intermittent connectivity to EC2 instances.
- C. Configure Amazon Kinesis Data Firehose to create multiple delivery streams aimed separately at the S3 buckets for storage and the EC2 instances for processing the images.
- D. Use AWS Storage Gateway pre-installed on a hardware appliance to cache the images locally for Amazon S3 to process the images when connectivity becomes available.



### **Question #6**

A company is planning to use an Amazon DynamoDB table for data storage. The company is concerned about cost optimization. The table will not be used on most mornings in the evenings, the read and write traffic will often be unpredictable When traffic spikes occur they will happen very quickly. What should a solutions architect recommend?

- A. Create a DynamoDB table in on-demand capacity mode.
- B. Create a DynamoDB table with a global secondary Index.
- C. Create a DynamoDB table with provisioned capacity and auto scaling.
- D. Create a DynamoDB table in provisioned capacity mode, and configure it as a global table.



### **Question #7**

A corporation uses an AWS application to offer content to its subscribers worldwide. Numerous Amazon EC2 instances are deployed on a private subnet behind an Application Load Balancer for the application (ALB). The chief information officer (CIO) wishes to limit access to some nations due to a recent change in copyright regulations.

Which course of action will satisfy these criteria?

- A. Modify the ALB security group to deny incoming traffic from blocked countries.
- B. Modify the security group for EC2 instances to deny incoming traffic from blocked countries.
- C. Use Amazon CloudFront to serve the application and deny access to blocked countries.
- D. Use ALB listener rules to return access denied responses to incoming traffic from blocked countries.



> **Ans is C https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/georestrictions.html**



### **Question #8**

Using seven Amazon EC2 instances, a business runs its web application on AWS. The organization needs that DNS queries provide the IP addresses of all healthy EC2 instances.

Which policy should be employed to comply with this stipulation?

- A. Simple routing policy
- B. Latency routing policy
- C. Multi-value routing policy
- D. Geolocation routing policy



> **C for correct https://aws.amazon.com/premiumsupport/knowledge-center/multivalue-versus-simple-policies/: "Use a multivalue answer routing policy to help distribute DNS responses across multiple resources. For example, use multivalue answer routing when you want to associate your routing records with a Route 53 health check."**



### **Question #9**

Each day, a corporation collects data from millions of consumers totalling around 1'. The firm delivers use records for the last 12 months to its customers. To meet with regulatory and auditing standards, all use data must be retained for at least five years.

Which storage option is the MOST CHEAPEST?

- A. Store the data in Amazon S3 Standard. Set a lifecycle rule to transition the data to S3 Glacier Deep Archive after 1 year. Set a lifecycle rule to delete the data after 5 years.
- B. Store the data in Amazon S3 One Zone-Infrequent Access (S3 One Zone-IA). Set a lifecycle rule to transition the data to S3 Glacier after 1 year. Set the lifecycle rule to delete the data after 5 years.
- C. Store the data in Amazon S3 Standard. Set a lifecycle rule to transition the data to S3 Standard-Infrequent Access (S3 Standard-IA) after 1 year. Set a lifecycle rule to delete the data after 5 years.
- D. Store the data in Amazon S3 Standard. Set a lifecycle rule to transition the data to S3 One Zone-Infrequent Access (S3 One Zone-IA) after 1 year. Set a lifecycle rule to delete the data after 5 years.



> **https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage-class-intro.html#sc-infreq-data-access**



### **Question #10**

A business uses an Amazon RDS for PostgreSQL database instance to manage a fleet of web servers. Following a normal compliance review, the corporation establishes a standard requiring all production databases to have a recovery point objective (RPO) of less than one second.

Which solution satisfies these criteria?

- A. Enable a Multi-AZ deployment for the DB instance.
- B. Enable auto scaling for the DB instance in one Availability Zone.
- C. Configure the DB instance in one Availability Zone, and create multiple read replicas in a separate Availability Zone.
- D. Configure the DB instance in one Availability Zone, and configure AWS Database Migration Service (AWS DMS) change data capture (CDC) tasks.



> **A is correct. Multi-AZ is using synchronous replication ensuring less than 1s RPO. Read replicas are assynchronous with lag up to 5 minutes in postgresql RDS**



###  20220801

### **Question #11** 

On Amazon EC2 instances, a business is developing an application that creates transitory transactional data. Access to data storage that can deliver adjustable and consistent IOPS is required by the application.

What recommendations should a solutions architect make?

- A. Provision an EC2 instance with a Throughput Optimized HDD (st1) root volume and a Cold HDD (sc1) data volume.
- B. Provision an EC2 instance with a Throughput Optimized HDD (st1) volume that will serve as the root and data volume.
- C. Provision an EC2 instance with a General Purpose SSD (gp2) root volume and Provisioned IOPS SSD (io1) data volume.
- D. Provision an EC2 instance with a General Purpose SSD (gp2) root volume. Configure the application to store its data in an Amazon S3 bucket.



> **C is my answer: Only gp3, io1, or io2 Volumes have configurable IOPS. https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volumes.html**



### **Question #12**

Prior to implementing a new workload, a solutions architect must examine and update the company's current IAM rules. The following policy was written by the solutions architect:
![img](https://www.examtopics.com/assets/media/exam-media/04121/0021300001.png)

What is the policy's net effect?

- A. Users will be allowed all actions except s3:PutObject if multi-factor authentication (MFA) is enabled.
- B. Users will be allowed all actions except s3:PutObject if multi-factor authentication (MFA) is not enabled.
- C. Users will be denied all actions except s3:PutObject if multi-factor authentication (MFA) is enabled.
- D. Users will be denied all actions except s3:PutObject if multi-factor authentication (MFA) is not enabled.



> **D. Users will be denied all actions except s3:PutObject if multi-factor authentication (MFA) is not enabled.**



### **Question #13**

To allow neat-real-time processing, a web application must persist order data to Amazon S3. A solutions architect must design a scalable and fault-tolerant architecture.

Which solutions satisfy these criteria? (Select two.)

- A. Write the order event to an Amazon DynamoDB table. Use DynamoDB Streams to trigger an AWS Lambda function that parses the payload and writes the data to Amazon S3.
- B. Write the order event to an Amazon Simple Queue Service (Amazon SQS) queue. Use the queue to trigger an AWSLambda function that parsers the payload and writes the data to Amazon S3.
- C. Write the order event to an Amazon Simple Notification Service (Amazon SNS) topic. Use the SNS topic to trigger an AWS Lambda function that parses the payload and writes the data to Amazon S3.
- D. Write the order event to an Amazon Simple Queue Service (Amazon SQS) queue. Use an Amazon EventBridge (Amazon CloudWatch Events) rule to trigger an AWS Lambda function that parses the payload and writes the data to Amazon S3.
- E. Write the order event to an Amazon Simple Notification Service (Amazon SNS) topic. Use an Amazon EventBridge (Amazon CloudWatch Events) rule to trigger an AWS Lambda function that parses the payload andwrites the data to Amazon S3.



> **I think using EventBridge is just adding the additional overhead, so we can skip D and E. And, I choose C over B because I think SNS is more scalable & fault tolerent. So, I will finally go for A and C.**
>
> =>SNS: Data is not persisted(lost if not delivered)



### **Question #14**

A business in the us-east-1 region offers a picture hosting service. Users from many countries may upload and browse images using the program. Some photographs get a high volume of views over months, while others receive a low volume of views for less than a week. The program supports picture uploads of up to 20 MB in size. The service determines which photographs to show to each user based on the photo information.

Which option delivers the most cost-effective access to the suitable users?

- A. Store the photos in Amazon DynamoDB. Turn on DynamoDB Accelerator (DAX) to cache frequently viewed items.
- B. Store the photos in the Amazon S3 Intelligent-Tiering storage class. Store the photo metadata and its S3 location in DynamoDB.
- C. Store the photos in the Amazon S3 Standard storage class. Set up an S3 Lifecycle policy to move photos older than 30 days to the S3 Standard-Infrequent Access (S3 Standard-IA) storage class. Use the object tags to keep track of metadata.
- D. Store the photos in the Amazon S3 Glacier storage class. Set up an S3 Lifecycle policy to move photos older than 30 days to the S3 Glacier Deep Archive storage class. Store the photo metadata and its S3 location in Amazon Elasticsearch Service (Amazon ES).



> **I agree with B, But can someone explain me why it is not A ?**
>
> **DynamoDB can only store objects smaller than 4kb in size.**



### **Question #15**

A business is creating a website that will store static photos in an Amazon S3 bucket. The company's goal is to reduce both latency and cost for all future requests.

How should a solutions architect propose a service configuration?

- A. Deploy a NAT server in front of Amazon S3.
- B. Deploy Amazon CloudFront in front of Amazon S3.
- C. Deploy a Network Load Balancer in front of Amazon S3.
- D. Configure Auto Scaling to automatically adjust the capacity of the website.



> **A. What does a NAT server have to do with S3? B. Sounds about right. C. What? D. What? x2**
>
> **CloudFront used distribute web contain and improve performance**
>
> **Cloudfront + S3 = Static Website**



**Question #16**

For the database layer of its ecommerce website, a firm uses Amazon DynamoDB with provided throughput. During flash sales, clients may encounter periods of delay when the database is unable to manage the volume of transactions. As a result, the business loses transactions. The database operates normally during regular times.

Which approach resolves the company's performance issue?

- A. Switch DynamoDB to on-demand mode during flash sales.
- B. Implement DynamoDB Accelerator for fast in memory performance.
- C. Use Amazon Kinesis to queue transactions for processing to DynamoDB.
- D. Use Amazon Simple Queue Service (Amazon SQS) to queue transactions to DynamoDB.



> **Sure this link deals with a flash sale and Dynamodb, but you stopped reading right there... In the link, DAX helps to mitigate the effect of high READ traffic. You’re doing a flash sale on a product, people will view that product’s page a lot, so you put it in a cache (DAX), sure makes sense. But this questions specifically asked for another problem - they are LOSING TRANSACTIONS. Think about it, how does a cache help you with transaction loss? They lose transaction because the database itself didn’t have the capacity to handle all those demands. A is the right answer**



### **Question #17**

A significant media corporation uses AWS to host a web application. The corporation intends to begin caching secret media files in order to provide dependable access to them to consumers worldwide. Amazon S3 buckets are used to store the material. The organization must supply material rapidly, regardless of the origin of the requests.

Which solution will satisfy these criteria?

- A. Use AWS DataSync to connect the S3 buckets to the web application.
- B. Deploy AWS Global Accelerator to connect the S3 buckets to the web application.
- C. Deploy Amazon CloudFront to connect the S3 buckets to CloudFront edge servers.
- D. Use Amazon Simple Queue Service (Amazon SQS) to connect the S3 buckets to the web application.



> **First, try to remove the obvious: 1. SQS is out of question. 2. You might be tempted to check DataSync, however you aren't doing migrations over here do you? Now here's the meat, most of you would select caching as CF, however check the requirement for material source to be: a. Rapidly served b. Should be available globally. c. Regardless of the origin of the request. (Meaning no playing around with HTTP headers) d. The content is most likely for VOD services, although Cloudfront do support for VOD, rapidly distributing is far fetched idea, as it requires network based service to with low latency and high throughput. Hence B**



### **Question #18**

In the AWS Cloud, a web application is deployed. It is a two-tier design comprised of a web and database layer. Cross-site scripting (XSS) attacks are possible on the web server.

What is the best course of action for a solutions architect to take to address the vulnerability?

- A. Create a Classic Load Balancer. Put the web layer behind the load balancer and enable AWS WAF.
- B. Create a Network Load Balancer. Put the web layer behind the load balancer and enable AWS WAF.
- C. Create an Application Load Balancer. Put the web layer behind the load balancer and enable AWS WAF.
- D. Create an Application Load Balancer. Put the web layer behind the load balancer and use AWS Shield Standard.



> **AWS WAF+ALB (C) is correct. AWS Web Application Firewall works at Layer 7 of the OSI. It protects against 'common exploits'/ 'vulnerabilities' like XSS(cross site scripting) and SQL injection. It applies to App GW, Cloudfront and ALB (no CLB,NLB). ------------------ Shield comes in 2 flavours. AWS Shield Standard protects against L3/L4 attacks. (free service) AWS Shield Advanced protects at L3/L4 +L7. It is priced at a premium and gives 24/7 access to dedicated DDoS Response team. It helps protect against DDoS(Distributed Denial of Service) attacks. It can be applied on EC2 ,Cloudfront, Global Accelerator, Route 53,ELB. It also gives price protection(protection against higher fees during usage spikes due to DDoS).**



### **Question #19**

On its website, a business keeps a searchable store of things. The data is stored in a table with over ten million rows in an Amazon RDS for MySQL database. The database is stored on a 2 TB General Purpose SSD (gp2) array. Every day, the company's website receives millions of changes to this data. The organization found that certain activities were taking ten seconds or more and concluded that the bottleneck was the database storage performance.

Which option satisfies the performance requirement?

- A. Change the storage type to Provisioned IOPS SSD (io1).
- B. Change the instance to a memory-optimized instance class.
- C. Change the instance to a burstable performance DB instance class.
- D. Enable Multi-AZ RDS read replicas with MySQL native asynchronous replication.



> **A. This is a case for I/O intensive operation: Getting the best performance from Amazon RDS Provisioned IOPS SSD storage If your workload is I/O constrained, using Provisioned IOPS SSD storage can increase the number of I/O requests that the system can process concurrently. Increased concurrency allows for decreased latency because I/O requests spend less time in a queue. Decreased latency allows for faster database commits, which improves response time and allows for higher database throughput. https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html**



### **Question #20**

A business is prepared to use Amazon S3 to store sensitive data. Data must be encrypted at rest for compliance purposes. Auditing of encryption key use is required. Each year, keys must be rotated.

Which solution satisfies these parameters and is the MOST OPTIMAL in terms of operational efficiency?

- A. Server-side encryption with customer-provided keys (SSE-C)
- B. Server-side encryption with Amazon S3 managed keys (SSE-S3)
- C. Server-side encryption with AWS KMS (SSE-KMS) customer master keys (CMKs) with manual rotation
- D. Server-side encryption with AWS KMS (SSE-KMS) customer master keys (CMKs) with automatic rotation



> **Ans. D - https://docs.aws.amazon.com/kms/latest/developerguide/rotate-keys.htm**



### **Question #21**

Management need a summary of AWS billed items broken down by user as part of their budget planning process. Budgets for departments will be created using the data. A solutions architect must ascertain the most effective method of obtaining this report data.

Which solution satisfies these criteria?

- A. Run a query with Amazon Athena to generate the report.
- B. Create a report in Cost Explorer and download the report.
- C. Access the bill details from the billing dashboard and download the bill.
- D. Modify a cost budget in AWS Budgets to alert with Amazon Simple Email Service (Amazon SES).



> **B is ok - https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/ce-reports.html**



### **Question #22**

A solutions architect must create a system for archiving client case files. The files are critical corporate assets. The file count will increase over time.
Multiple application servers running on Amazon EC2 instances must be able to access the files concurrently. There must be built-in redundancy in the solution.

Which solution satisfies these criteria?

- A. Amazon Elastic File System (Amazon EFS)
- B. Amazon Elastic Block Store (Amazon EBS)
- C. Amazon S3 Glacier Deep Archive
- D. AWS Backup



> **concurrently => EFS**



### **Question #23**

A business must give secure access to secret and sensitive data to its workers. The firm want to guarantee that only authorized individuals have access to the data. The data must be safely downloaded to the workers' devices.
The files are kept on a Windows file server on-premises. However, as remote traffic increases, the file server's capacity is being depleted.

Which solution will satisfy these criteria?

- A. Migrate the file server to an Amazon EC2 instance in a public subnet. Configure the security group to limit inbound traffic to the employees' IP addresses.
- B. Migrate the files to an Amazon FSx for Windows File Server file system. Integrate the Amazon FSx file system with the on-premises Active Directory. Configure AWS Client VPN.
- C. Migrate the files to Amazon S3, and create a private VPC endpoint. Create a signed URL to allow download.
- D. Migrate the files to Amazon S3, and create a public VPC endpoint. Allow employees to sign on with AWS Single Sign-On.



> **Answer should be (B), since the Windows file server is on-premise and we need something to replicate the data to the cloud, the only option we have is AWS FSx for Windows File Server. Also, since the information is confidential and sensitive, we also want to make sure that the appropriate users have access to it in a secure manner. https://docs.aws.amazon.com/fsx/latest/WindowsGuide/what-is.html**



### **Question #24**

A legal company must communicate with the public. Hundreds of files must be publicly accessible. Anyone is banned from modifying or deleting the files before to a specified future date.

Which solution satisfies these criteria the SAFEST way possible?

- A. Upload all flies to an Amazon S3 bucket that is configured for static website hosting. Grant read-only IAM permissions to any AWS principals that access the S3 bucket until the designated date.
- B. Create a new Amazon S3 bucket with S3 Versioning enabled. Use S3 Object Lock with a retention period in accordance with the designated date. Configure the S3 bucket for static website hosting. Set an S3 bucket policy to allow read-only access to the objects.
- C. Create a new Amazon S3 bucket with S3 Versioning enabled. Configure an event trigger to run an AWS Lambda function in case of object modification or deletion. Configure the Lambda function to replace the objects with the original versions from a private S3 bucket.
- D. Upload all files to an Amazon S3 bucket that is configured for static website hosting. Select the folder that contains the files. Use S3 Object Lock with a retention period in accordance with the designated date. Grant read-only IAM permissions to any AWS principals that access the S3 bucket.



> **Found this on the AWS FAQs, correct answer should be B If you’re more interested in “Who can access this S3 bucket?” then S3 bucket policies will likely suit you better. You can easily answer this by looking up a bucket and examining the bucket policy.**
>
> **https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lock.html > Object Lock works only in versioned buckets**



### **Question #25**

A corporation connects its on-premises servers to AWS through a 10 Gbps AWS Direct Connect connection. The connection's workloads are crucial. The organization needs a catastrophe recovery approach that is as resilient as possible while minimizing the existing connection bandwidth.

What recommendations should a solutions architect make?

- A. Set up a new Direct Connect connection in another AWS Region.
- B. Set up a new AWS managed VPN connection in another AWS Region.
- C. Set up two new Direct Connect connections: one in the current AWS Region and one in another Region.
- D. Set up two new AWS managed VPN connections: one in the current AWS Region and one in another Region.



> **A. The company already has a DX connection in the current Region, so just needs another one in another Region for DR.**
>
> **Diagram here: https://d1.awsstatic.com/AWS%20Direct%20Connect/Redundancy-Highest.cc18117d65de87b62bf4b8e10db7f980e3ac13fd.png**



### **Question #26**

A business has two virtual private clouds (VPCs) labeled Management and Production. The Management VPC connects to a single device in the data center using VPNs via a customer gateway. The Production VPC is connected to AWS through two AWS Direct Connect connections via a virtual private gateway. Both the Management and Production VPCs communicate with one another through a single VPC peering connection.

What should a solutions architect do to minimize the architecture's single point of failure?

- A. Add a set of VPNs between the Management and Production VPCs.
- B. Add a second virtual private gateway and attach it to the Management VPC.
- C. Add a second set of VPNs to the Management VPC from a second customer gateway device.
- D. Add a second VPC peering connection between the Management VPC and the Production VPC.



> **I think its C. **
>
> **A is out - Regarding the VPC Peering "There is no single point of failure for communication or a bandwidth bottleneck". So there is no need to create a redundancy mechanism when you already have a VPC Peering in place. https://docs.aws.amazon.com/vpc/latest/peering/what-is-vpc-peering.html **
>
> **B is out - "You can attach one virtual private gateway to a VPC at a time." https://docs.aws.amazon.com/vpn/latest/s2svpn/vpn-limits.html**
>
> D is out - You can only have one VPC Peering per VPC pair. "A VPC peering connection is a one to one relationship between two VPCs." VPChttps://docs.aws.amazon.com/vpc/latest/peering/vpc-peering-basics.html 
>
> C is correct. "To protect against a loss of connectivity in case your customer gateway device becomes unavailable, you can set up a second Site-to-Site VPN connection to your VPC and virtual private gateway by using a second customer gateway device." https://docs.aws.amazon.com/vpn/latest/s2svpn/vpn-redundant-connection.html



### Question #27

AWS hosts a company's near-real-time streaming application. While the data is being ingested, a job is being performed on it that takes 30 minutes to finish. Due to the massive volume of incoming data, the workload regularly faces significant latency. To optimize performance, a solutions architect must build a scalable and serverless system.

Which actions should the solutions architect do in combination? (Select two.)

- A. Use Amazon Kinesis Data Firehose to ingest the data.
- B. Use AWS Lambda with AWS Step Functions to process the data.
- C. Use AWS Database Migration Service (AWS DMS) to ingest the data.
- D. Use Amazon EC2 instances in an Auto Scaling group to process the data.
- E. Use AWS Fargate with Amazon Elastic Container Service (Amazon ECS) to process the data.



### Question #28

Amazon Elastic Block Store (Amazon EBS) volumes are used by a media organization to store video material. A certain video file has gained popularity, and a significant number of individuals from all over the globe are now viewing it. As a consequence, costs have increased.

Which step will result in a cost reduction without jeopardizing user accessibility?

- A. Change the EBS volume to Provisioned IOPS (PIOPS).
- B. Store the video in an Amazon S3 bucket and create an Amazon CloudFront distribution.
- C. Split the video into multiple, smaller segments so users are routed to the requested video segments only.
- D. Clear an Amazon S3 bucket in each Region and upload the videos so users are routed to the nearest S3 bucket.



> **Store video in S3 and use Cloudfront for distribution. So option B is correct.**



### Question #29

Amazon S3 buckets are used by an image hosting firm to store its objects. The firm wishes to prevent unintentional public disclosure of the items contained in the S3 buckets. All S3 items in the AWS account as a whole must remain private.

Which solution will satisfy these criteria?

- A. Use Amazon GuardDuty to monitor S3 bucket policies. Create an automatic remediation action rule that uses an AWS Lambda function to remediate any change that makes the objects public.
- B. Use AWS Trusted Advisor to find publicly accessible S3 buckets. Configure email notifications in Trusted Advisor when a change is detected. Manually change the S3 bucket policy if it allows public access.
- C. Use AWS Resource Access Manager to find publicly accessible S3 buckets. Use Amazon Simple Notification Service (Amazon SNS) to invoke an AWS Lambda function when a change is detected. Deploy a Lambda function that programmatically remediates the change.
- D. Use the S3 Block Public Access feature on the account level. Use AWS Organizations to create a service control policy (SCP) that prevents IAM users from changing the setting. Apply the SCP to the account.



> **Answer is D ladies and gentlemen. While guard duty helps to monitor s3 for potential threats its a reactive action. We should always be proactive and not reactive in our solutions so D, block public access to avoid any possibility of the info becoming publicly accessible**
>
> **https://aws.amazon.com/blogs/aws/amazon-s3-block-public-access-another-layer-of-protection-for-your-accounts-and-buckets/**





### Question #30

A company's website stores transactional data on an Amazon RDS MySQL Multi-AZ DB instance. Other internal systems query this database instance to get data for batch processing. When internal systems request data from the RDS DB instance, the RDS DB instance drastically slows down. This has an effect on the website's read and write performance, resulting in poor response times for users.

Which approach will result in an increase in website performance?

- A. Use an RDS PostgreSQL DB instance instead of a MySQL database.
- B. Use Amazon ElastiCache to cache the query responses for the website.
- C. Add an additional Availability Zone to the current RDS MySQL Multi-AZ DB instance.
- D. Add a read replica to the RDS DB instance and configure the internal systems to query the read replica.



> **D is correct option. Here the internal system fetch the data that mean it is performing only SELECT statement, Read replicas are used for SELECT (=read) only kind of statements (not INSERT, UPDATE, DELETE)**
>
> **A read replica will continuously sync from the master. So your results will probably lag 0 - 3s (depending on the load) behind the master. A cache takes the query result at a specific point in time and stores it for a certain amount of time. The longer your queries are being cached, the more lag you'll have; but your master database will experience less load. It's a trade-off you'll need to choose wisely depending on your application.**
>
> **Option B is wrong as ElastiCache would only help for caching data from same queries.**



### 20220802 

### Question #31 

Currently, a company's legacy application relies on an unencrypted Amazon RDS MySQL database with a single instance. All current and new data in this database must be encrypted to comply with new compliance standards.

How is this to be achieved?

A. Create an Amazon S3 bucket with server-side encryption enabled. Move all the data to Amazon S3. Delete the RDS instance.
B. Enable RDS Multi-AZ mode with encryption at rest enabled. Perform a failover to the standby instance to delete the original instance.
C. Take a Snapshot of the RDS instance. Create an encrypted copy of the snapshot. Restore the RDS instance from the encrypted snapshot.
D. Create an RDS read replica with encryption at rest enabled. Promote the read replica to master and switch the application over to the new master. Delete the old RDS instance.



> C for sure.
> You can only enable encryption for an Amazon RDS DB instance when you create it, not after the DB instance is created.
> However, because you can encrypt a copy of an unencrypted snapshot, you can effectively add encryption to an unencrypted DB instance. That is, you can create a snapshot of your DB instance, and then create an encrypted copy of that snapshot. You can then restore a DB instance from the encrypted snapshot, and thus you have an encrypted copy of your original DB instance.
> https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Overview.Encryption.html



### Question #32
A marketing firm uses an Amazon S3 bucket to store CSV data for statistical research. Permission is required for an application running on an Amazon EC2 instance to properly handle the CSV data stored in the S3 bucket.

Which step will provide the MOST SECURE access to the S3 bucket for the EC2 instance?

A. Attach a resource-based policy to the S3 bucket.
B. Create an IAM user for the application with specific permissions to the S3 bucket.
C. Associate an IAM role with least privilege permissions to the EC2 instance profile.
D. Store AWS credentials directly on the EC2 instance for applications on the instance to use for API calls.

> It should be IAM Role
>



### Question #33

On a cluster of Amazon Linux EC2 instances, a business runs an application. The organization is required to store all application log files for seven years for compliance purposes.
The log files will be evaluated by a reporting program, which will need concurrent access to all files.

Which storage system best satisfies these criteria in terms of cost-effectiveness?

A. Amazon Elastic Block Store (Amazon EBS)
B. Amazon Elastic File System (Amazon EFS)
C. Amazon EC2 instance store
D. Amazon S3



> Correct Answer: D
> Using the AWS Simple Cost Calculator (Jan 2022), the cost of storage for 1TB a month is $81.92. However, 1TB in S3 Standard is $23.44.
> Since S3 does, in fact, support concurrency (https://aws.amazon.com/blogs/big-data/optimizing-amazon-s3-for-high-concurrency-in-distributed-workloads/), for cost-effectiveness and concurrency selecting S3 (Answer D) is the better answer.
> Here's another link that might be helpful. https://aws.amazon.com/about-aws/whats-new/2018/07/amazon-s3-announces-increased-request-rate-performance/



### Question #34
On a fleet of Amazon EC2 instances, a business provides a training site. The business predicts that when its new course, which includes hundreds of training videos on the web, is available in one week, it will be tremendously popular.

What should a solutions architect do to ensure that the predicted server load is kept to a minimum?

A. Store the videos in Amazon ElastiCache for Redis. Update the web servers to serve the videos using the ElastiCache API.
B. Store the videos in Amazon Elastic File System (Amazon EFS). Create a user data script for the web servers to mount the EFS volume.
C. Store the videos in an Amazon S3 bucket. Create an Amazon CloudFront distribution with an origin access identity (OAI) of that S3 bucket. Restrict Amazon S3 access to the OAI.
D. Store the videos in an Amazon S3 bucket. Create an AWS Storage Gateway file gateway to access the S3 bucket. Create a user data script for the web servers to mount the file gateway.



> answer is C
> keyword: Load is kept is a minimum (using cloudfront)
> A. We would have to store the videos on an RDS, not sure if that would be suitable.....
> B. How does this help minimize the anticipated server load?
> C. Sounds about right, the best option probably.
> D. We're not running anything on premise.



### Question #35
A business chooses to transition from on-premises to the AWS Cloud its three-tier web application. The new database must be able to scale storage capacity dynamically and conduct table joins.

Which AWS service satisfies these criteria?

A. Amazon Aurora
B. Amazon RDS for SqlServer
C. Amazon DynamoDB Streams
D. Amazon DynamoDB on-demand



> A...Table joins indicate Relational DB or SQL... so DynamoDB ruled out coz NoSQL.. so Aurora is completely server less and scalable in storage.




### Question #36
On a fleet of Amazon EC2 instances, a business runs a production application. The program takes data from an Amazon SQS queue and concurrently processes the messages. The message volume is variable, and traffic is often interrupted. This program should handle messages continuously and without interruption.

Which option best fits these criteria in terms of cost-effectiveness?

A. Use Spot Instances exclusively to handle the maximum capacity required.
B. Use Reserved Instances exclusively to handle the maximum capacity required.
C. Use Reserved Instances for the baseline capacity and use Spot Instances to handle additional capacity.
D. Use Reserved Instances for the baseline capacity and use On-Demand Instances to handle additional capacity.



> I was going with D but now realise that SQS requires consumers to manually delete the message from queue post processing.
> Fact that instance(spot) got abruptly terminated means no deletion from queue,hence no loss of message.
> Going back to C.



### Question #37
A startup has developed an application that gathers data from Internet of Things (IoT) sensors installed on autos. Through Amazon Kinesis Data Firehose, the data is transmitted to and stored in Amazon S3. Each year, data generates billions of S3 objects. Each morning, the business retrains a set of machine learning (ML) models using data from the preceding 30 days.
Four times a year, the corporation analyzes and trains other machine learning models using data from the preceding 12 months. The data must be accessible with a minimum of delay for a period of up to one year. Data must be preserved for archive reasons after one year.

Which storage system best satisfies these criteria in terms of cost-effectiveness?

A. Use the S3 Intelligent-Tiering storage class. Create an S3 Lifecycle policy to transition objects to S3 Glacier Deep Archive after 1 year.
B. Use the S3 Intelligent-Tiering storage class. Configure S3 Intelligent-Tiering to automativally move objects to S3 Glacier Deep Archive after 1 year.
C. Use the S3 Standard-Infrequent Access (S3 Standard-IA) storage class. Create an S3 Lifecycle policy to transition objects to S3 Glacier Deep Archive after 1 year.
D. Use the S3 Standard storage class. Create an S3 Lifecycle policy to transition objects to S3 Standard-Infrequent Access (S3 Standard-IA) after 30 days, and then to S3 Glacier Deep Archive after 1 year.



> D because:
>
> - First 30 days- data access every morning ( predictable and frequently) – S3 standard
> - After 30 days, accessed 4 times a year – S3 infrequently access
> - Data preserved- S3 Gllacier Deep Archive
>   Not B because S3 Intelligent-Tiering is suitable when access patterns change - https://aws.amazon.com/s3/storage-classes/intelligent-tiering/



### Question #38
A business requires data storage on Amazon S3. A compliance requirement stipulates that when objects are modified, their original state must be retained. Additionally, data older than five years should be kept for auditing purposes.

What SHOULD A SOLUTIONS ARCHITECT RECOMMEND AS THE MOST EFFORTABLE?

A. Enable object-level versioning and S3 Object Lock in governance mode
B. Enable object-level versioning and S3 Object Lock in compliance mode
C. Enable object-level versioning. Enable a lifecycle policy to move data older than 5 years to S3 Glacier Deep Archive
D. Enable object-level versioning. Enable a lifecycle policy to move data older than 5 years to S3 Standard-Infrequent Access (S3 Standard-IA)



> This question appeared in the exam with a tweak. I passed the exam yesterday. Thanks examtopics and those who contributed! Question had two choices. I don't remember the exact wordings but, it also ask to delete objects after five years.
> With Governance Mode it is possible to delete the object with special permissions
> I chose A & C



### Question #39
Multiple Amazon EC2 instances are used to host an application. The program reads messages from an Amazon SQS queue, writes them to an Amazon RDS database, and then removes them from the queue. The RDS table sometimes contains duplicate entries. There are no duplicate messages in the SQS queue.

How can a solutions architect guarantee that messages are handled just once?

A. Use the CreateQueue API call to create a new queue.
B. Use the AddPermission API call to add appropriate permissions.
C. Use the ReceiveMessage API call to set an appropriate wait time.
D. Use the ChangeMessageVisibility API call to increase the visibility timeout.



> D -
> The visibility timeout begins when Amazon SQS returns a message. During this time, the consumer processes and deletes the message. However, if the consumer fails before deleting the message and your system doesn't call the DeleteMessage action for that message before the visibility timeout expires, the message becomes visible to other consumers and the message is received again. If a message must be received only once, your consumer should delete it within the duration of the visibility timeout.
>
> https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-visibility-timeout.html



### Question #40
A corporation just announced the worldwide launch of their retail website. The website is hosted on numerous Amazon EC2 instances, which are routed via an Elastic Load Balancer. The instances are distributed across several Availability Zones in an Auto Scaling group.
The firm want to give its clients with customized material depending on the device from which they view the website.

Which steps should a solutions architect perform in combination to satisfy these requirements? (Select two.)

A. Configure Amazon CloudFront to cache multiple versions of the content.
B. Configure a host header in a Network Load Balancer to forward traffic to different instances.
C. Configure a Lambda@Edge function to send specific objects to users based on the User-Agent header.
D. Configure AWS Global Accelerator. Forward requests to a Network Load Balancer (NLB). Configure the NLB to set up host-based routing to different EC2 instances.
E. Configure AWS Global Accelerator. Forward requests to a Network Load Balancer (NLB). Configure the NLB to set up path-based routing to different EC2 instances.



> A and C.
> - B is wrong - NLBs do not understand HTTP (Layer 7 / Application layer) headers, this is what ALBs do. Moreover, a host header is information of the DESTINATION server, not the SOURCE client\
> - D and E are wrong - Global Accelerator helps to SPEED UP requests. Doesn't help with CONTENT CUSTOMIZATION
>
> I know D and E are wrong because only ALB can do any path or host based routing. B also is wrong cos HTTP headers cannot be sent by a NLB. NLB operates on layer 3, HTTP is a Layer 7 protocol, hence only an ALB too. By order of elimination, A and C are the answers.
>



### 20220803

### Question #41

To facilitate experimentation and agility, a business enables developers to link current IAM policies to existing IAM roles. The security operations team, on the other hand, is worried that the developers may attach the current administrator policy, allowing them to bypass any other security rules.

What approach should a solutions architect use in dealing with this issue?

- A. Create an Amazon SNS topic to send an alert every time a developer creates a new policy.
- B. Use service control policies to disable IAM activity across all account in the organizational unit.
- C. Prevent the developers from attaching any policies and assign all IAM duties to the security operations team.
- D. Set an IAM permissions boundary on the developer IAM role that explicitly denies attaching the administrator policy.



> Permission boundaries are for this use case. Be aware that you can assign boundaries only to users and roles, not groups



### Question #42

A newly formed company developed a three-tiered web application. The front end is comprised entirely of static information. Microservices form the application layer. User data is kept in the form of JSON documents that must be accessible with a minimum of delay. The firm anticipates minimal regular traffic in the first year, with monthly traffic spikes. The startup team's operational overhead expenditures must be kept to a minimum.

What should a solutions architect suggest as a means of achieving this?

- A. Use Amazon S3 static website hosting to store and serve the front end. Use AWS Elastic Beanstalk for the application layer. Use Amazon DynamoDB to store user data.
- B. Use Amazon S3 static website hosting to store and serve the front end. Use Amazon Elastic KubernetesService (Amazon EKS) for the application layer. Use Amazon DynamoDB to store user data.
- C. Use Amazon S3 static website hosting to store and serve the front end. Use Amazon API Gateway and AWS Lambda functions for the application layer. Use Amazon DynamoDB to store user data.
- D. Use Amazon S3 static website hosting to store and serve the front end. Use Amazon API Gateway and AWS Lambda functions for the application layer. Use Amazon RDS with read replicas to store user data.



> Answer is C. Microservice does not always means "container". It can be realized by several methods one of which is API gateway + Lambda.
>
> https://docs.aws.amazon.com/lambda/latest/dg/services-apigateway-blueprint.html



### Question #43

Amazon Elastic Container Service (Amazon ECS) container instances are used to install an ecommerce website's web application behind an Application Load Balancer (ALB). The website slows down and availability is decreased during moments of heavy usage. A solutions architect utilizes Amazon CloudWatch alarms to be notified when an availability problem occurs, allowing them to scale out resources. The management of the business want a system that automatically reacts to such circumstances.

Which solution satisfies these criteria?

- A. Set up AWS Auto Scaling to scale out the ECS service when there are timeouts on the ALB. Set up AWS Auto Scaling to scale out the ECS cluster when the CPU or memory reservation is too high.
- B. Set up AWS Auto Scaling to scale out the ECS service when the ALB CPU utilization is too high. Setup AWS Auto Scaling to scale out the ECS cluster when the CPU or memory reservation is too high.
- C. Set up AWS Auto Scaling to scale out the ECS service when the service's CPU utilization is too high. Set up AWS Auto Scaling to scale out the ECS cluster when the CPU or memory reservation is too high.
- D. Set up AWS Auto Scaling to scale out the ECS service when the ALB target group CPU utilization is too high. Set up AWS Auto Scaling to scale out the ECS cluster when the CPU or memory reservation is too high.



> https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-configure-auto-scaling.html To configure target tracking scaling policies for your service For Scaling policy type, choose Target tracking. For Policy name, enter a descriptive name for your policy. For ECS service metric, choose the metric to track. The following metrics are available: ECSServiceAverageCPUUtilization—Average CPU utilization of the service. ECSServiceAverageMemoryUtilization—Average memory utilization of the service. ALBRequestCountPerTarget—Number of requests completed per target in an Application Load Balancer target group.



### Question #44

A business uses Site-to-Site VPN connections to provide safe access to AWS Cloud services from on-premises. Users are experiencing slower VPN connectivity as a result of increased traffic through the VPN connections to the Amazon EC2 instances.

Which approach will result in an increase in VPN throughput?

- A. Implement multiple customer gateways for the same network to scale the throughput.
- B. Use a transit gateway with equal cost multipath routing and add additional VPN tunnels.
- C. Configure a virtual private gateway with equal cost multipath routing and multiple channels.
- D. Increase the number of tunnels in the VPN configuration to scale the throughput beyond the default limit.



> Answer is B. https://aws.amazon.com/blogs/networking-and-content-delivery/scaling-vpn-throughput-using-aws-transit-gateway/ With AWS Transit Gateway, you can simplify the connectivity between multiple VPCs and also connect to any VPC attached to AWS Transit Gateway with a single VPN connection. AWS Transit Gateway also enables you to scale the IPsec VPN throughput with equal cost multi-path (ECMP) routing support over multiple VPN tunnels. A single VPN tunnel still has a maximum throughput of 1.25 Gbps. If you establish multiple VPN tunnels to an ECMP-enabled transit gateway, it can scale beyond the default limit of 1.25 Gbps.



### Question #45

On Amazon EC2 Linux instances, a business hosts a website. Several of the examples are malfunctioning. The troubleshooting indicates that the unsuccessful instances lack swap space. The operations team's lead need a monitoring solution for this.

What recommendations should a solutions architect make?

- A. Configure an Amazon CloudWatch SwapUsage metric dimension. Monitor the SwapUsage dimension in the EC2 metrics in CloudWatch.
- B. Use EC2 metadata to collect information, then publish it to Amazon CloudWatch custom metrics. Monitor SwapUsage metrics in CloudWatch.
- C. Install an Amazon CloudWatch agent on the instances. Run an appropriate script on a set schedule. Monitor SwapUtilization metrics in CloudWatch.
- D. Enable detailed monitoring in the EC2 console. Create an Amazon CloudWatch SwapUtilization custom metric. Monitor SwapUtilization metrics in CloudWatch.



> c is correct. https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/mon-scripts.html
>
> As per the latest docs this is deprecated. This is now handled via cloudwatch itself without the need to addition mon-scripts https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/metrics-collected-by-CloudWatch-agent.html



### Question #46

AWS is used by a business to perform an online transaction processing (OLTP) burden. This workload is deployed in a Multi-AZ environment using an unencrypted Amazon RDS database instance. This instance's database is backed up daily.

What should a solutions architect do going forward to guarantee that the database and snapshots are constantly encrypted?

- A. Encrypt a copy of the latest DB snapshot. Replace existing DB instance by restoring the encrypted snapshot.
- B. Create a new encrypted Amazon Elastic Block Store (Amazon EBS) volume and copy the snapshots to it. Enable encryption on the DB instance.
- C. Copy the snapshots and enable encryption using AWS Key Management Service (AWS KMS). Restore encrypted snapshot to an existing DB instance.
- D. Copy the snapshots to an Amazon S3 bucket that is encrypted using server-side encryption with AWS Key Management Service (AWS KMS) managed keys (SSE-KMS).



> You can't restore from a DB snapshot to an existing DB instance; a new DB instance is created when you restore. https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_RestoreFromSnapshot.html#USER_RestoreFromSnapshot.CON So answer A is right



### Question #47

A business operates an application that collects data from its consumers through various Amazon EC2 instances. After processing, the data is uploaded to Amazon S3 for long-term storage. A study of the application reveals that the EC2 instances were inactive for extended periods of time. A solutions architect must provide a system that maximizes usage while minimizing expenditures.

Which solution satisfies these criteria?

- A. Use Amazon EC2 in an Auto Scaling group with On-Demand instances.
- B. Build the application to use Amazon Lightsail with On-Demand Instances.
- C. Create an Amazon CloudWatch cron job to automatically stop the EC2 instances when there is no activity.
- D. Redesign the application to use an event-driven design with Amazon Simple Queue Service (Amazon SQS) and AWS Lambda.



> Answer is D. Lamda and SQS are cheapest. With AWS Lambda, you pay only for what you use. You are charged based on the number of requests for your functions and the duration, the time it takes for your code to execute. For SQS, First 1 Million Requests/Month Free Free
>
> "a business operates" I think that's indicates that you can't redesign the application, in that case the answer is A.



### Question #48

A business wishes to migrate from many independent Amazon Web Services accounts to a consolidated, multi-account design. The organization intends to generate a large number of new AWS accounts for its business divisions. The organization must use a single corporate directory service to authenticate access to these AWS accounts.

Which steps should a solutions architect advocate in order to satisfy these requirements? (Select two.)

- A. Create a new organization in AWS Organizations with all features turned on. Create the new AWS accounts in the organization.
- B. Set up an Amazon Cognito identity pool. Configure AWS Single Sign-On to accept Amazon Cognito authentication.
- C. Configure a service control policy (SCP) to manage the AWS accounts. Add AWS Single Sign-On to AWS Directory Service.
- D. Create a new organization in AWS Organizations. Configure the organization's authentication mechanism to use AWS Directory Service directly.
- E. Set up AWS Single Sign-On (AWS SSO) in the organization. Configure AWS SSO, and integrate it with the company's corporate directory service.



> D does not "generate a large number of new AWS accounts for its business divisions". Correct answers should be A and E.
>
> https://docs.aws.amazon.com/singlesignon/latest/userguide/what-is.html



### Question #49

A solutions architect is developing a daily data processing task that will take up to two hours to finish. If the task is stopped, it must be restarted from scratch.

What is the MOST cost-effective way for the solutions architect to solve this issue?

- A. Create a script that runs locally on an Amazon EC2 Reserved Instance that is triggered by a cron job.
- B. Create an AWS Lambda function triggered by an Amazon EventBridge (Amazon CloudWatch Events) scheduled event.
- C. Use an Amazon Elastic Container Service (Amazon ECS) Fargate task triggered by an Amazon EventBridge (Amazon CloudWatch Events) scheduled event.
- D. Use an Amazon Elastic Container Service (Amazon ECS) task running on Amazon EC2 triggered by an Amazon EventBridge (Amazon CloudWatch Events) scheduled event.



> Answer is C A is wrong; "EC2 Reserved Instance" not cost effective compared to serverless 
>
> B is wrong; Lambda runs for 15 minutes max
>
>  D is wrong; "running on Amazon EC2" not cost effective



### Question #50

A business intends to use AWS to host a survey website. The firm anticipated a high volume of traffic. As a consequence of this traffic, the database is updated asynchronously. The organization want to avoid dropping writes to the database housed on AWS.

How should the business's application be written to handle these database requests?

- A. Configure the application to publish to an Amazon Simple Notification Service (Amazon SNS) topic. Subscribe the database to the SNS topic.
- B. Configure the application to subscribe to an Amazon Simple Notification Service (Amazon SNS) topic. Publish the database updates to the SNS topic.
- C. Use Amazon Simple Queue Service (Amazon SQS) FIFO queues to queue the database connection until the database has resources to write the data.
- D. Use Amazon Simple Queue Service (Amazon SQS) FIFO queues for capturing the writes and draining the queue as each write is made to the database.



> Only one consumer (DB), so SNS no need .. as it makes sense only for multiple consumers. So A and B Out... Between C and D, C asks for queuing DB Connections ..which can be done but thats not regular...so D which drains (empties via msg processing within Visibility time out and deleting msgs from SQS).



### 20220810

### Question #51

On a huge fleet of Amazon EC2 instances, a business runs an application. The program reads and writes items to a DynamoDB database hosted by Amazon. The DynamoDB database increases in size regularly, yet the application requires just data from the previous 30 days. The organization need a solution that is both cost effective and time efficient to implement.

Which solution satisfies these criteria?

- A. Use an AWS CloudFormation template to deploy the complete solution. Redeploy the CloudFormation stack every 30 days, and delete the original stack.
- B. Use an EC2 instance that runs a monitoring application from AWS Marketplace. Configure the monitoring application to use Amazon DynamoDB Streams to store the timestamp when a new item is created in the table. Use a script that runs on the EC2 instance to delete items that have a timestamp that is older than 30 days.
- C. Configure Amazon DynamoDB Streams to invoke an AWS Lambda function when a new item is created in the table. Configure the Lambda function to delete items in the table that are older than 30 days.
- D. Extend the application to add an attribute that has a value of the current timestamp plus 30 days to each new item that is created in the table. Configure DynamoDB to use the attribute as the TTL attribute.



> D is correct. Amazon DynamoDB Time to Live (TTL) allows you to define a per-item timestamp to determine when an item is no longer needed. Shortly after the date and time of the specified timestamp, DynamoDB deletes the item from your table without consuming any write throughput. TTL is provided at no extra cost as a means to reduce stored data volumes by retaining only the items that remain current for your workload’s needs. TTL is useful if you store items that lose relevance after a specific time. The following are example TTL use cases: Remove user or sensor data after one year of inactivity in an application. Archive expired items to an Amazon S3 data lake via Amazon DynamoDB Streams and AWS Lambda. Retain sensitive data for a certain amount of time according to contractual or regulatory obligations. https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/TTL.html



### Question #52

Previously, a corporation moved their data warehousing solution to AWS. Additionally, the firm has an AWS Direct Connect connection. Through the use of a visualization tool, users in the corporate office may query the data warehouse. Each query answered by the data warehouse is on average 50 MB in size, whereas each webpage supplied by the visualization tool is around 500 KB in size. The data warehouse does not cache the result sets it returns.

Which approach results in the LOWEST OUTGOING DATA TRANSFER COSTS FOR THE COMPANY?

- A. Host the visualization tool on premises and query the data warehouse directly over the internet.
- B. Host the visualization tool in the same AWS Region as the data warehouse. Access it over the internet.
- C. Host the visualization tool on premises and query the data warehouse directly over a Direct Connect connection at a location in the same AWS Region.
- D. Host the visualization tool in the same AWS Region as the data warehouse and access it over a DirectConnect connection at a location in the same Region.

> https://aws.amazon.com/getting-started/hands-on/connect-data-center-to-aws/services-costs/: "Data transfer pricing over Direct Connect is lower than data transfer pricing over the internet" A and B are out I would take D over C as transfer from AWS to on-premises would cost more than transfer from AWS to AWS



### 20220831

### Question #53

A company is running an ecommerce application on Amazon EC2. The application consists of a stateless web tier that requires a minimum of 10 instances, and a peak of 250 instances to support the application's usage. The application requires 50 instances 80% of the time.
Which solution should be used to minimize costs?

- A. Purchase Reserved Instances to cover 250 instances.
- B. Purchase Reserved Instances to cover 80 instances. Use Spot Instances to cover the remaining instances.
- C. Purchase On-Demand Instances to cover 40 instances. Use Spot Instances to cover the remaining instances.
- D. Purchase Reserved Instances to cover 50 instances. Use On-Demand and Spot Instances to cover the remaining instances.

> Agree with D. Reserved instances for the 50 that are up most of the time, Spot fleet (mix of on-demand and spot) for the others



### Question #54

A company has deployed an API in a VPC behind an internet-facing Application Load Balancer (ALB). An application that consumes the API as a client is deployed in a second account in private subnets behind a NAT gateway. When requests to the client application increase, the NAT gateway costs are higher than expected. A solutions architect has configured the ALB to be internal.
Which combination of architectural changes will reduce the NAT gateway costs? (Choose two.)

- A. Configure a VPC peering connection between the two VPCs. Access the API using the private address.
- B. Configure an AWS Direct Connect connection between the two VPCs. Access the API using the private address.
- C. Configure a ClassicLink connection for the API into the client VPC. Access the API using the ClassicLink address.
- D. Configure a PrivateLink connection for the API into the client VPC. Access the API using the PrivateLink address.
- E. Configure an AWS Resource Access Manager connection between the two accounts. Access the API using the private address.

> A & D is correct. With RAM you cannot share the API Gateway, have look here: https://docs.aws.amazon.com/ram/latest/userguide/shareable.html With privatelink you can add the LB, thats the reason why LB is in the description and the API GW after the LB, another account and can than be used from the application.



### Question #55

A solutions architect is tasked with transferring 750 TB of data from an on-premises network-attached file system located at a branch office Amazon S3 Glacier.
The migration must not saturate the on-premises 1 Mbps internet connection.
Which solution will meet these requirements?

- A. Create an AWS site-to-site VPN tunnel to an Amazon S3 bucket and transfer the files directly. Transfer the files directly by using the AWS CLI.
- B. Order 10 AWS Snowball Edge Storage Optimized devices, and select an S3 Glacier vault as the destination.
- C. Mount the network-attached file system to an S3 bucket, and copy the files directly. Create a lifecycle policy to transition the S3 objects to Amazon S3 Glacier.
- D. Order 10 AWS Snowball Edge Storage Optimized devices, and select an Amazon S3 bucket as the destination. Create a lifecycle policy to transition the S3 objects to Amazon S3 Glacier.



> Answer should be "D". To upload existing data to Amazon S3 Glacier (S3 Glacier), you might consider using one of the AWS Snowball device types to import data into Amazon S3, and then move it to the S3 Glacier storage class for archival using lifecycle rules. When you transition Amazon S3 objects to the S3 Glacier storage class, Amazon S3 internally uses S3 Glacier for durable storage at lower cost. Although the objects are stored in S3 Glacier, they remain Amazon S3 objects that you manage in Amazon S3, and you cannot access them directly through S3 Glacier. https://docs.aws.amazon.com/amazonglacier/latest/dev/uploading-an-archive.html



### Question #56

A company has a two-tier application architecture that runs in public and private subnets. Amazon EC2 instances running the web application are in the public subnet and a database runs on the private subnet. The web application instances and the database are running in a single Availability Zone (AZ).
Which combination of steps should a solutions architect take to provide high availability for this architecture? (Choose two.)

- A. Create new public and private subnets in the same AZ for high availability.
- B. Create an Amazon EC2 Auto Scaling group and Application Load Balancer spanning multiple AZs.
- C. Add the existing web application instances to an Auto Scaling group behind an Application Load Balancer.
- D. Create new public and private subnets in a new AZ. Create a database using Amazon EC2 in one AZ.
- E. Create new public and private subnets in the same VPC, each in a new AZ. Migrate the database to an Amazon RDS multi-AZ deployment.

> B & E to me...



### Question #57

A solutions architect is implementing a document review application using an Amazon S3 bucket for storage. The solution must prevent an accidental deletion of the documents and ensure that all versions of the documents are available. Users must be able to download, modify, and upload documents.
Which combination of actions should be taken to meet these requirements? (Choose two.)

- A. Enable a read-only bucket ACL.
- B. Enable versioning on the bucket.
- C. Attach an IAM policy to the bucket.
- D. Enable MFA Delete on the bucket.
- E. Encrypt the bucket using AWS KMS.

> B & D are correct.



### Question #58

An application hosted on AWS is experiencing performance problems, and the application vendor wants to perform an analysis of the log file to troubleshoot further. The log file is stored on Amazon S3 and is 10 GB in size. The application owner will make the log file available to the vendor for a limited time.
What is the MOST secure way to do this?

- A. Enable public read on the S3 object and provide the link to the vendor.
- B. Upload the file to Amazon WorkDocs and share the public link with the vendor.
- C. Generate a presigned URL and have the vendor download the log file before it expires.
- D. Create an IAM user for the vendor to provide access to the S3 bucket and the application. Enforce multi-factor authentication.

> C is the correct. A and B providing public link which security concerns. option D is not suitable because here in question it is a vendor user accessing a log file, here user use to access the application which is hosted in AWS he is not the one who has access permission to AWS console management so creating IAM is not feasible.



### Question #59

A solutions architect is designing a two-tier web application. The application consists of a public-facing web tier hosted on Amazon EC2 in public subnets. The database tier consists of Microsoft SQL Server running on Amazon EC2 in a private subnet. Security is a high priority for the company.
How should security groups be configured in this situation? (Choose two.)

- A. Configure the security group for the web tier to allow inbound traffic on port 443 from 0.0.0.0/0.
- B. Configure the security group for the web tier to allow outbound traffic on port 443 from 0.0.0.0/0.
- C. Configure the security group for the database tier to allow inbound traffic on port 1433 from the security group for the web tier.
- D. Configure the security group for the database tier to allow outbound traffic on ports 443 and 1433 to the security group for the web tier.
- E. Configure the security group for the database tier to allow inbound traffic on ports 443 and 1433 from the security group for the web tier.



> No Brainer here. 443 inbound from internet (0.0.0.0/0) for the Web Tier (A) 1433 inbound to the database tier from the Web Tier (Security Group) (C) Answer = A & C
>
> correct! SG is stateful, when we allow an inbound it gets outbound as well. So there is no outbound rule that must be specified in SG.



### Question #60

A company allows its developers to attach existing IAM policies to existing IAM roles to enable faster experimentation and agility. However, the security operations team is concerned that the developers could attach the existing administrator policy, which would allow the developers to circumvent any other security policies.
How should a solutions architect address this issue?

- A. Create an Amazon SNS topic to send an alert every time a developer creates a new policy.
- B. Use service control policies to disable IAM activity across all accounts in the organizational unit.
- C. Prevent the developers from attaching any policies and assign all IAM duties to the security operations team.
- D. Set an IAM permissions boundary on the developer IAM role that explicitly denies attaching the administrator policy.

> Answer should be D
>
> Permission boundaries are for this use case. Be aware that you can assign boundaries only to users and roles, not groups



### Question #61

A company has a multi-tier application that runs six front-end web servers in an Amazon EC2 Auto Scaling group in a single Availability Zone behind an
Application Load Balancer (ALB). A solutions architect needs to modify the infrastructure to be highly available without modifying the application.
Which architecture should the solutions architect choose that provides high availability?

- A. Create an Auto Scaling group that uses three instances across each of two Regions.
- B. Modify the Auto Scaling group to use three instances across each of two Availability Zones.
- C. Create an Auto Scaling template that can be used to quickly create more instances in another Region.
- D. Change the ALB in front of the Amazon EC2 instances in a round-robin configuration to balance traffic to the web tier.

> Should be B as An Auto Scaling group can contain Amazon EC2 instances from multiple Availability Zones within the same Region. However, an Auto Scaling group can't contain instances from multiple Regions. Source: https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-add-availability-zone.html



### Question #62

A company runs an application on a group of Amazon Linux EC2 instances. For compliance reasons, the company must retain all application log files for 7 years.
The log files will be analyzed by a reporting tool that must access all files concurrently.
Which storage solution meets these requirements MOST cost-effectively?

- A. Amazon Elastic Block Store (Amazon EBS)
- B. Amazon Elastic File System (Amazon EFS)
- C. Amazon EC2 instance store
- D. Amazon S3

> concurrent access- EFS. Cost effectiveness- S3. Since S3 does not support concurrent access. I will go with EFS.



### Question #63

A media streaming company collects real-time data and stores it in a disk-optimized database system. The company is not getting the expected throughput and wants an in-memory database storage solution that performs faster and provides high availability using data replication.
Which database should a solutions architect recommend?

- A. Amazon RDS for MySQL
- B. Amazon RDS for PostgreSQL.
- C. Amazon ElastiCache for Redis
- D. Amazon ElastiCache for Memcached



> Answer is C. Redis lets you create multiple replicas of a Redis primary. This allows you to scale database reads and to have highly available clusters. Memcached does not. https://aws.amazon.com/elasticache/redis-vs-memcached/



### Question #64

A company hosts its product information webpages on AWS. The existing solution uses multiple Amazon C2 instances behind an Application Load Balancer in an
Auto Scaling group. The website also uses a custom DNS name and communicates with HTTPS only using a dedicated SSL certificate. The company is planning a new product launch and wants to be sure that users from around the world have the best possible experience on the new website.
What should a solutions architect do to meet these requirements?

- A. Redesign the application to use Amazon CloudFront.
- B. Redesign the application to use AWS Elastic Beanstalk.
- C. Redesign the application to use a Network Load Balancer.
- D. Redesign the application to use Amazon S3 static website hosting.



> ans is A



### Question #65

A solutions architect is designing the cloud architecture for a new application being deployed on AWS. The process should run in parallel while adding and removing application nodes as needed based on the number of jobs to be processed. The processor application is stateless. The solutions architect must ensure that the application is loosely coupled and the job items are durably stored.
Which design should the solutions architect use?

- A. Create an Amazon SNS topic to send the jobs that need to be processed. Create an Amazon Machine Image (AMI) that consists of the processor application. Create a launch configuration that uses the AMI. Create an Auto Scaling group using the launch configuration. Set the scaling policy for the Auto Scaling group to add and remove nodes based on CPU usage.
- B. Create an Amazon SQS queue to hold the jobs that need to be processed. Create an Amazon Machine Image (AMI) that consists of the processor application. Create a launch configuration that uses the AMI. Create an Auto Scaling group using the launch configuration. Set the scaling policy for the Auto Scaling group to add and remove nodes based on network usage.
- C. Create an Amazon SQS queue to hold the jobs that need to be processed. Create an Amazon Machine Image (AMI) that consists of the processor application. Create a launch template that uses the AMI. Create an Auto Scaling group using the launch template. Set the scaling policy for the Auto Scaling group to add and remove nodes based on the number of items in the SQS queue.
- D. Create an Amazon SNS topic to send the jobs that need to be processed. Create an Amazon Machine Image (AMI) that consists of the processor application. Create a launch template that uses the AMI. Create an Auto Scaling group using the launch template. Set the scaling policy for the Auto Scaling group to add and remove nodes based on the number of messages published to the SNS topic.



> C is correct. You want to scale this application based on # of messages in SQS.
>
> loosely connected indicates SQS 'tasks' indicates ECS cluster (further 'state is not maintained' indicated ECS) SNS will publish a job received to multiple subscribers,we dont want same job to go to multiple instances for processing So A and D are out



### Question #66

A marketing company is storing CSV files in an Amazon S3 bucket for statistical analysis. An application on an Amazon EC2 instance needs permission to efficiently process the CSV data stored in the S3 bucket.
Which action will MOST securely grant the EC2 instance access to the S3 bucket?

- A. Attach a resource-based policy to the S3 bucket.
- B. Create an IAM user for the application with specific permissions to the S3 bucket.
- C. Associate an IAM role with least privilege permissions to the EC2 instance profile.
- D. Store AWS credentials directly on the EC2 instance for applications on the instance to use for API calls.



> It should be IAM Role



### Question #67

A company has on-premises servers that run a relational database. The database serves high-read traffic for users in different locations. The company wants to migrate the database to AWS with the least amount of effort. The database solution must support high availability and must not affect the company's current traffic flow.
Which solution meets these requirements?

- A. Use a database in Amazon RDS with Multi-AZ and at least one read replica.
- B. Use a database in Amazon RDS with Multi-AZ and at least one standby replica.
- C. Use databases that are hosted on multiple Amazon EC2 instances in different AWS Regions.
- D. Use databases that are hosted on Amazon EC2 instances behind an Application Load Balancer in different Availability Zones.



### Question #68

A company's application is running on Amazon EC2 instances within an Auto Scaling group behind an Elastic Load Balancer. Based on the application's history, the company anticipates a spike in traffic during a holiday each year. A solutions architect must design a strategy to ensure that the Auto Scaling group proactively increases capacity to minimize any performance impact on application users.
Which solution will meet these requirements?

- A. Create an Amazon CloudWatch alarm to scale up the EC2 instances when CPU utilization exceeds 90%.
- B. Create a recurring scheduled action to scale up the Auto Scaling group before the expected period of peak demand.
- C. Increase the minimum and maximum number of EC2 instances in the Auto Scaling group during the peak demand period.
- D. Configure an Amazon Simple Notification Service (Amazon SNS) notification to send alerts when there are autoscaling:EC2_INSTANCE_LAUNCH events.



> Answer B: https://docs.aws.amazon.com/autoscaling/ec2/userguide/schedule_time.html



### Question #69

A company hosts an application on multiple Amazon EC2 instances. The application processes messages from an Amazon SQS queue, writes for an Amazon

RDS table, and deletes -
the message from the queue. Occasional duplicate records are found in the RDS table. The SQS queue does not contain any duplicate messages.
What should a solutions architect do to ensure messages are being processed once only?

- A. Use the CreateQueue API call to create a new queue.
- B. Use the AddPermission API call to add appropriate permissions.
- C. Use the ReceiveMessage API call to set an appropriate wait time.
- D. Use the ChangeMessageVisibility API call to increase the visibility timeout.



> Answer is D. Increasing visibility time out will allow more time for the message to be processed and deleted before it has a chance to become visible again to other subscribers to the SQS queue



### Question #70

![img](https://www.examtopics.com/assets/media/exam-media/04240/0006000001.jpg)
What is the effect of this policy?

- A. Users can terminate an EC2 instance in any AWS Region except us-east-1.
- B. Users can terminate an EC2 instance with the IP address 10.100.100.1 in the us-east-1 Region.
- C. Users can terminate an EC2 instance in the us-east-1 Region when the user's source IP is 10.100.100.254.
- D. Users cannot terminate an EC2 instance in the us-east-1 Region when the user's source IP is 10.100.100.254.



> ANSWER IS C. let me break it down for you. 1. deny policy always overrides allow policy according to AWS 2. first statement says allow ec2 termination action coming from a IP address range (condiiton is the IP range) 3. second statement, deny all action on ec2 (now the condition is StringNotEquals, which means negated matching according to AWS), which implies deny all actions on ec2 so far as the request is not coming from us-east-1, that is allow actions only from us-east-1 (negate matching). 3. this would help you eliminate option A and D. now you are left with B and C 4. now remember deny rule takes effect before allow rule. 5. now users can terminate instances in us-east-1 as far as the IP range 10....whatever the range is.
>
> To add to your detailed explanation, B and C both would have been correct if same IP was used, since 10.100.100.1 is mentioned which is a reserved IP and unavailable in the CIDR block so this option becomes invalid, Hence correct answer is C.



### Question #71

A solutions architect is optimizing a website for an upcoming musical event. Videos of the performances will be streamed in real time and then will be available on demand. The event is expected to attract a global online audience.
Which service will improve the performance of both the real-time and on-demand steaming?

- A. Amazon CloudFront
- B. AWS Global Accelerator
- C. Amazon Route S3
- D. Amazon S3 Transfer Acceleration



> Answer: A You can use CloudFront to deliver video on demand (VOD) or live streaming video using any HTTP origin. One way you can set up video workflows in the cloud is by using CloudFront together with AWS Media Services. https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/on-demand-streaming-video.html



### Question #72

A company has a three-tier image-sharing application. It uses an Amazon EC2 instance for the front-end layer, another for the backend tier, and a third for the
MySQL database. A solutions architect has been tasked with designing a solution that is highly available, and requires the least amount of changes to the application
Which solution meets these requirements?

- A. Use Amazon S3 to host the front-end layer and AWS Lambda functions for the backend layer. Move the database to an Amazon DynamoDB table and use Amazon S3 to store and serve users' images.
- B. Use load-balanced Multi-AZ AWS Elastic Beanstalk environments for the front-end and backend layers. Move the database to an Amazon RDS instance with multiple read replicas to store and serve users' images.
- C. Use Amazon S3 to host the front-end layer and a fleet of Amazon EC2 instances in an Auto Scaling group for the backend layer. Move the database to a memory optimized instance type to store and serve users' images.
- D. Use load-balanced Multi-AZ AWS Elastic Beanstalk environments for the front-end and backend layers. Move the database to an Amazon RDS instance with a Multi-AZ deployment. Use Amazon S3 to store and serve users' images.



> I think the answer is D because B doesn’t mention RDS multiAZ. D provides for greater availability



### Question #73

A solutions architect is designing a system to analyze the performance of financial markets while the markets are closed. The system will run a series of compute- intensive jobs for 4 hours every night. The time to complete the compute jobs is expected to remain constant, and jobs cannot be interrupted once started. Once completed, the system is expected to run for a minimum of 1 year.
Which type of Amazon EC2 instances should be used to reduce the cost of the system?

- A. Spot Instances
- B. On-Demand Instances
- C. Standard Reserved Instances
- D. Scheduled Reserved Instances

> Answer D.



### Question #74

A company built a food ordering application that captures user data and stores it for future analysis. The application's static front end is deployed on an Amazon
EC2 instance. The front-end application sends the requests to the backend application running on separate EC2 instance. The backend application then stores the data in Amazon RDS.
What should a solutions architect do to decouple the architecture and make it scalable?

- A. Use Amazon S3 to serve the front-end application, which sends requests to Amazon EC2 to execute the backend application. The backend application will process and store the data in Amazon RDS.
- B. Use Amazon S3 to serve the front-end application and write requests to an Amazon Simple Notification Service (Amazon SNS) topic. Subscribe Amazon EC2 instances to the HTTP/HTTPS endpoint of the topic, and process and store the data in Amazon RDS.
- C. Use an EC2 instance to serve the front end and write requests to an Amazon SQS queue. Place the backend instance in an Auto Scaling group, and scale based on the queue depth to process and store the data in Amazon RDS.
- D. Use Amazon S3 to serve the static front-end application and send requests to Amazon API Gateway, which writes the requests to an Amazon SQS queue. Place the backend instances in an Auto Scaling group, and scale based on the queue depth to process and store the data in Amazon RDS.

> Static front end, so you want to use S3 for that so automatically rule out C. Key word here is "decouple", any time you see that look for SQS. Answer here is D.



### Question #75

A solutions architect needs to design a managed storage solution for a company's application that includes high-performance machine learning functionality. This application runs on AWS Fargate and the connected storage needs to have concurrent access to files and deliver high performance.
Which storage option should the solutions architect recommend?

- A. Create an Amazon S3 bucket for the application and establish an IAM role for Fargate to communicate with Amazon S3.
- B. Create an Amazon FSx for Lustre file share and establish an IAM role that allows Fargate to communicate with FSx for Lustre.
- C. Create an Amazon Elastic File System (Amazon EFS) file share and establish an IAM role that allows Fargate to communicate with Amazon Elastic File System (Amazon EFS).
- D. Create an Amazon Elastic Block Store (Amazon EBS) volume for the application and establish an IAM role that allows Fargate to communicate with Amazon Elastic Block Store (Amazon EBS).

> answer is C



### Question #76

A bicycle sharing company is developing a multi-tier architecture to track the location of its bicycles during peak operating hours. The company wants to use these data points in its existing analytics platform. A solutions architect must determine the most viable multi-tier option to support this architecture. The data points must be accessible from the REST API.
Which action meets these requirements for storing and retrieving location data?

- A. Use Amazon Athena with Amazon S3.
- B. Use Amazon API Gateway with AWS Lambda.
- C. Use Amazon QuickSight with Amazon Redshift.
- D. Use Amazon API Gateway with Amazon Kinesis Data Analytics.



> The answer is D! Not A - Athena provides REST API to run queries and does not expose data points as asked in the question, read this link properly - https://aws.amazon.com/about-aws/whats-new/2017/05/amazon-athena-adds-api-cli-aws-sdk-support-and-audit-logging-with-aws-cloudtrail/ Not B because you cannot ingest and store data points using lambda. Not C because Quicksight is an analytics service, needs data as input D is the correct answer because - 1. it can ingest data and not only store the data points but can expose them as REST API, here is a tutorial - https://docs.aws.amazon.com/apigateway/latest/developerguide/integrating-api-with-aws-services-kinesis.html



### Question #77

A solutions architect is designing a web application that will run on Amazon EC2 instances behind an Application Load Balancer (ALB). The company strictly requires that the application be resilient against malicious internet activity and attacks, and protect against new common vulnerabilities and exposures.
What should the solutions architect recommend?

- A. Leverage Amazon CloudFront with the ALB endpoint as the origin.
- B. Deploy an appropriate managed rule for AWS WAF and associate it with the ALB.
- C. Subscribe to AWS Shield Advanced and ensure common vulnerabilities and exposures are blocked.
- D. Configure network ACLs and security groups to allow only ports 80 and 443 to access the EC2 instances.

> AWS WAF is included with AWS Shield Advanced at no extra cost. Check the link: https://docs.aws.amazon.com/waf/latest/developerguide/ddos-overview.html Hence answer is C



### Question #78

A company has an application that calls AWS Lambda functions. A code review shows that database credentials are stored in a Lambda function's source code, which violates the company's security policy. The credentials must be securely stored and must be automatically rotated on an ongoing basis to meet security policy requirements.
What should a solutions architect recommend to meet these requirements in the MOST secure manner?

- A. Store the password in AWS CloudHSM. Associate the Lambda function with a role that can use the key ID to retrieve the password from CloudHSM. Use CloudHSM to automatically rotate the password.
- B. Store the password in AWS Secrets Manager. Associate the Lambda function with a role that can use the secret ID to retrieve the password from Secrets Manager. Use Secrets Manager to automatically rotate the password.
- C. Store the password in AWS Key Management Service (AWS KMS). Associate the Lambda function with a role that can use the key ID to retrieve the password from AWS KMS. Use AWS KMS to automatically rotate the uploaded password.
- D. Move the database password to an environment variable that is associated with the Lambda function. Retrieve the password from the environment variable by invoking the function. Create a deployment script to automatically rotate the password.



> B.AWS Secrets Manager Secrets Manager: It was designed specifically for confidential information (like database credentials, API keys) that needs to be encrypted, so the creation of a secret entry has encryption enabled by default. It also gives additional functionality like rotation of keys. 
>
> KMS is a service that manages encryption keys('Customer Master keys',not Data keys). A 'data key' is used to encrypt the actual data data. CMK is basically used to protect the data key which is used for encrypting data. To decrypt the data,one calls the KMS service and uses the CMK to decrypt the 'data key'.Once we have the decrypted(plaintext) data key, we use the same to decrypt the actual data. When thinking KMS/CMK--- -think about Cx managed/Aws Managed Keys as options -think encryption at rest -think encrypting master key, not data key ======================= HSM is alternative to KMS for encrypting same CMK. AWS provisions the encryption hardware ,not the software.



### Question #79

A company is managing health records on-premises. The company must keep these records indefinitely, disable any modifications to the records once they are stored, and granularly audit access at all levels. The chief technology officer (CTO) is concerned because there are already millions of records not being used by any application, and the current infrastructure is running out of space. The CTO has requested a solutions architect design a solution to move existing data and support future records.
Which services can the solutions architect recommend to meet these requirements?

- A. Use AWS DataSync to move existing data to AWS. Use Amazon S3 to store existing and new data. Enable Amazon S3 object lock and enable AWS CloudTrail with data events.
- B. Use AWS Storage Gateway to move existing data to AWS. Use Amazon S3 to store existing and new data. Enable Amazon S3 object lock and enable AWS CloudTrail with management events.
- C. Use AWS DataSync to move existing data to AWS. Use Amazon S3 to store existing and new data. Enable Amazon S3 object lock and enable AWS CloudTrail with management events.
- D. Use AWS Storage Gateway to move existing data to AWS. Use Amazon Elastic Block Store (Amazon EBS) to store existing and new data. Enable Amazon S3 object lock and enable Amazon S3 server access logging.

> I think it's A. "Use AWS DataSync to migrate existing data to Amazon S3, and then use the File Gateway configuration of AWS Storage Gateway to retain access to the migrated data and for ongoing updates from your on-premises file-based applications." Need a solution to move existing data and support future records -> so, AWS DataSync should be used for migration. Need granular audit access at all levels -> so, Data Events should be used in CloudTrail, Management Events is enabled by default.



### Question #80

A company wants to use Amazon S3 for the secondary copy of its on-premises dataset. The company would rarely need to access this copy. The storage solution's cost should be minimal.
Which storage solution meets these requirements?

- A. S3 Standard
- B. S3 Intelligent-Tiering
- C. S3 Standard-Infrequent Access (S3 Standard-IA)
- D. S3 One Zone-Infrequent Access (S3 One Zone-IA)

> My vote is for D. S3 One Zone-Infrequent Access (S3 One Zone-IA) Least costs. There is no mention of resilience so no need for S3 Standard IA



### 20220905

### Question #81

A company's operations team has an existing Amazon S3 bucket configured to notify an Amazon SQS queue when new objects are created within the bucket. The development team also wants to receive events when new objects are created. The existing operations team workflow must remain intact.
Which solution would satisfy these requirements?

- A. Create another SQS queue. Update the S3 events in the bucket to also update the new queue when a new object is created.
- B. Create a new SQS queue that only allows Amazon S3 to access the queue. Update Amazon S3 to update this queue when a new object is created.
- C. Create an Amazon SNS topic and SQS queue for the bucket updates. Update the bucket to send events to the new topic. Updates both queues to poll Amazon SNS.
- D. Create an Amazon SNS topic and SQS queue for the bucket updates. Update the bucket to send events to the new topic. Add subscriptions for both queues in the topic.

> Another scenario for Fan-out. SNS driving two SQS queues and hence correct answer is option D.
>
> https://aws.amazon.com/getting-started/hands-on/send-fanout-event-notifications/



### Question #82

An application runs on Amazon EC2 instances in private subnets. The application needs to access an Amazon DynamoDB table. What is the MOST secure way to access the table while ensuring that the traffic does not leave the AWS network?

- A. Use a VPC endpoint for DynamoDB.
- B. Use a NAT gateway in a public subnet.
- C. Use a NAT instance in a private subnet.
- D. Use the internet gateway attached to the VPC.

> A for sure. https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/vpc-endpoints-dynamodb.html
>



### Question #83

A company built an application that lets users check in to places they visit, rank the places, and add reviews about their experiences. The application is successful with a rapid increase in the number of users every month.
The chief technology officer fears the database supporting the current Infrastructure may not handle the new load the following month because the single Amazon
RDS for MySQL instance has triggered alarms related to resource exhaustion due to read requests.
What can a solutions architect recommend to prevent service Interruptions at the database layer with minimal changes to code?

- A. Create RDS read replicas and redirect read-only traffic to the read replica endpoints. Enable a Multi-AZ deployment.
- B. Create an Amazon EMR cluster and migrate the data to a Hadoop Distributed File System (HDFS) with a replication factor of 3.
- C. Create an Amazon ElastiCache cluster and redirect all read-only traffic to the cluster. Set up the cluster to be deployed in three Availability Zones.
- D. Create an Amazon DynamoDB table to replace the RDS instance and redirect all read-only traffic to the DynamoDB table. Enable DynamoDB Accelerator to offload traffic from the main table.

> I agree, answer is A. This is a typical use case for read replicas



### Question #84

A company is looking for a solution that can store video archives in AWS from old news footage. The company needs to minimize costs and will rarely need to restore these files. When the files are needed, they must be available in a maximum of five minutes.
What is the MOST cost-effective solution?

- A. Store the video archives in Amazon S3 Glacier and use Expedited retrievals.
- B. Store the video archives in Amazon S3 Glacier and use Standard retrievals.
- C. Store the video archives in Amazon S3 Standard-Infrequent Access (S3 Standard-IA).
- D. Store the video archives in Amazon S3 One Zone-Infrequent Access (S3 One Zone-IA).

> Expedited – Expedited retrievals allow you to quickly access your data that's stored in the S3 Glacier Flexible Retrieval storage class or the S3 Intelligent-Tiering Archive Access tier when occasional urgent requests for a subset of archives are required. For all but the largest archives (more than 250 MB), data accessed by using Expedited retrievals is typically made available within 1–5 minutes. https://docs.aws.amazon.com/amazonglacier/latest/dev/downloading-an-archive-two-steps.html
>



### Question #85

A company has created a VPC with multiple private subnets in multiple Availability Zones (AZs) and one public subnet in one of the AZs. The public subnet is used to launch a NAT gateway. There are instances in the private subnets that use a NAT gateway to connect to the internet. In case of an AZ failure, the company wants to ensure that the instances are not all experiencing internet connectivity issues and that there is a backup plan ready.
Which solution should a solutions architect recommend that is MOST highly available?

- A. Create a new public subnet with a NAT gateway in the same AZ. Distribute the traffic between the two NAT gateways.
- B. Create an Amazon EC2 NAT instance in a new public subnet. Distribute the traffic between the NAT gateway and the NAT instance.
- C. Create public subnets in each AZ and launch a NAT gateway in each subnet. Configure the traffic from the private subnets in each AZ to the respective NAT gateway.
- D. Create an Amazon EC2 NAT instance in the same public subnet. Replace the NAT gateway with the NAT instance and associate the instance with an Auto Scaling group with an appropriate scaling policy.

> Selected Answer: **C**
>
> AWS no longer recommends using NAT Instances. For every NAT question I go for NAT GW. In order to have NAT public>private you need public IP and NAT GW.



### Question #86

A healthcare company stores highly sensitive patient records. Compliance requires that multiple copies be stored in different locations. Each record must be stored for 7 years. The company has a service level agreement (SLA) to provide records to government agencies immediately for the first 30 days and then within
4 hours of a request thereafter.
What should a solutions architect recommend?

- A. Use Amazon S3 with cross-Region replication enabled. After 30 days, transition the data to Amazon S3 Glacier using lifecycle policy.
- B. Use Amazon S3 with cross-origin resource sharing (CORS) enabled. After 30 days, transition the data to Amazon S3 Glacier using a lifecycle policy.
- C. Use Amazon S3 with cross-Region replication enabled. After 30 days, transition the data to Amazon S3 Glacier Deep Achieve using a lifecycle policy.
- D. Use Amazon S3 with cross-origin resource sharing (CORS) enabled. After 30 days, transition the data to Amazon S3 Glacier Deep Archive using a lifecycle policy.

> A or C - recommended by Amazon: Use Deep archive when data is accessed at most twice a year with latencies of 12 to 48 hours. The question demands data within 4 hours. Correct answer is A



### Question #87

A company recently deployed a new auditing system to centralize information about operating system versions, patching, and installed software for Amazon EC2 instances. A solutions architect must ensure all instances provisioned through EC2 Auto Scaling groups successfully send reports to the auditing system as soon as they are launched and terminated.
Which solution achieves these goals MOST efficiently?

- A. Use a scheduled AWS Lambda function and run a script remotely on all EC2 instances to send data to the audit system.
- B. Use EC2 Auto Scaling lifecycle hooks to run a custom script to send data to the audit system when instances are launched and terminated.
- C. Use an EC2 Auto Scaling launch configuration to run a custom script through user data to send data to the audit system when instances are launched and terminated.
- D. Run a custom script on the instance operating system to send data to the audit system. Configure the script to be executed by the EC2 Auto Scaling group when the instance starts and is terminated.

> I agree B -> https://docs.aws.amazon.com/autoscaling/ec2/userguide/lifecycle-hooks.html
>



### Question #88

A company recently implemented hybrid cloud connectivity using AWS Direct Connect and is migrating data to Amazon S3. The company is looking for a fully managed solution that will automate and accelerate the replication of data between the on-premises storage systems and AWS storage services.
Which solution should a solutions architect recommend to keep the data private?

- A. Deploy an AWS DataSync agent for the on-premises environment. Configure a sync job to replicate the data and connect it with an AWS service endpoint.
- B. Deploy an AWS DataSync agent for the on-premises environment. Schedule a batch job to replicate point-in-time snapshots to AWS.
- C. Deploy an AWS Storage Gateway volume gateway for the on-premises environment. Configure it to store data locally, and asynchronously back up point-in- time snapshots to AWS.
- D. Deploy an AWS Storage Gateway file gateway for the on-premises environment. Configure it to store data locally, and asynchronously back up point-in-time snapshots to AWS.

> Ans is A: You can use AWS DataSync with your Direct Connect link to access public service endpoints or private VPC endpoints. When using VPC endpoints, data transferred between the DataSync agent and AWS services does not traverse the public internet or need public IP addresses, increasing the security of data as it is copied over the network.
>
> For initial migration & accelerated transfer Datasync is right solution. Storage Gateway is used once initial data is transferred and you want to sync incremental data.



### Question #89

A company has 150 TB of archived image data stored on-premises that needs to be moved to the AWS Cloud within the next month. The company's current network connection allows up to 100 Mbps uploads for this purpose during the night only.
What is the MOST cost-effective mechanism to move this data and meet the migration deadline?

- A. Use AWS Snowmobile to ship the data to AWS.
- B. Order multiple AWS Snowball devices to ship the data to AWS.
- C. Enable Amazon S3 Transfer Acceleration and securely upload the data.
- D. Create an Amazon S3 VPC endpoint and establish a VPN to upload the data.

> Couple of snowball devices (80 TB) should able to move 150 TB easily. So answer should be B.



### Question #90

A public-facing web application queries a database hosted on an Amazon EC2 instance in a private subnet. A large number of queries involve multiple table joins, and the application performance has been degrading due to an increase in complex queries. The application team will be performing updates to improve performance.
What should a solutions architect recommend to the application team? (Choose two.)

- A. Cache query data in Amazon SQS
- B. Create a read replica to offload queries
- C. Migrate the database to Amazon Athena
- D. Implement Amazon DynamoDB Accelerator to cache data.
- E. Migrate the database to Amazon RDS

> A is obviously wrong since SQS doesn't cache data C is wrong as Athena is used to query data in S3 D is wrong as the question mentions table joins implying relational database; Dynamo is non-relational B and E are the answers
>



### Question #91

A company is seeing access requests by some suspicious IP addresses. The security team discovers the requests are from different IP addresses under the same CIDR range.
What should a solutions architect recommend to the team?

- A. Add a rule in the inbound table of the security to deny the traffic from that CIDR range.
- B. Add a rule in the outbound table of the security group to deny the traffic from that CIDR range.
- C. Add a deny rule in the inbound table of the network ACL with a lower number than other rules.
- D. Add a deny rule in the outbound table of the network ACL with a lower rule number than other rules.

> Security group only allow rules, NACL one mentioned explicit deny
>
> you cannot deny traffic in a security group
>
> Ans is C



### Question #92

A company recently expanded globally and wants to make its application accessible to users in those geographic locations. The application is deployed on
Amazon EC2 instances behind an Application Load Balancer in an Auto Scaling group. The company needs the ability to shift traffic from resources in one region to another.
What should a solutions architect recommend?

- A. Configure an Amazon Route 53 latency routing policy.
- B. Configure an Amazon Route 53 geolocation routing policy.
- C. Configure an Amazon Route 53 geoproximity routing policy.
- D. Configure an Amazon Route 53 multivalue answer routing policy.

> Selected Answer: **C**
>
> https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-policy.html reason: Geoproximity routing policy – Use when you want to route traffic based on the location of your resources and, optionally, shift traffic from resources in one location to resources in another.



### Question #93

A company wants to replicate its data to AWS to recover in the event of a disaster. Today, a system administrator has scripts that copy data to a NFS share.
Individual backup files need to be accessed with low latency by application administrators to deal with errors in processing.
What should a solutions architect recommend to meet these requirements?

- A. Modify the script to copy data to an Amazon S3 bucket instead of the on-premises NFS share.
- B. Modify the script to copy data to an Amazon S3 Glacier Archive instead of the on-premises NFS share.
- C. Modify the script to copy data to an Amazon Elastic File System (Amazon EFS) volume instead of the on-premises NFS share.
- D. Modify the script to copy data to an AWS Storage Gateway for File Gateway virtual appliance instead of the on-premises NFS share.

> Ans: D The file gateway employs a local read/write cache to provide a low-latency access to data for file share clients in the same local area network (LAN) as the file gateway. Good read - https://d0.awsstatic.com/whitepapers/aws-storage-gateway-file-gateway-for-hybrid-architectures.pdf

> If you want to expand your datacenter to aws use the Storage Gateway service (file gateway). At this point you copy the files to S3, but access them via NFS or SMB. Instead you will use EFS when you have an EC2 (you are already inside a vpc)



### Question #94

An application requires a development environment (DEV) and production environment (PROD) for several years. The DEV instances will run for 10 hours each day during normal business hours, while the PROD instances will run 24 hours each day. A solutions architect needs to determine a compute instance purchase strategy to minimize costs.
Which solution is the MOST cost-effective?

- A. DEV with Spot Instances and PROD with On-Demand Instances
- B. DEV with On-Demand Instances and PROD with Spot Instances
- C. DEV with Scheduled Reserved Instances and PROD with Reserved Instances
- D. DEV with On-Demand Instances and PROD with Scheduled Reserved Instances

> My vote is C. DEV with Scheduled Reserved Instances and PROD with Reserved Instance. But for Prod it says just 'Reserved' instances instead of Standard Reserved.



### Question #95

A company runs multiple Amazon EC2 Linux instances in a VPC across two Availability Zones. The instances host applications that use a hierarchical directory structure. The applications need to read and write rapidly and concurrently to shared storage.
What should a solutions architect do to meet these requirements?

- A. Create an Amazon Elastic File System (Amazon EFS) file system. Mount the EFS file system from each EC2 instance.
- B. Create an Amazon S3 bucket. Allow access from all the EC2 instances in the VPC.
- C. Create a file system on a Provisioned IOPS SSD (io2) Amazon Elastic Block Store (Amazon EBS) volume. Attach the EBS volume to all the EC2 instances.
- D. Create file systems on Amazon Elastic Block Store (Amazon EBS) volumes that are attached to each EC2 instance. Synchronize the EBS volumes across the different EC2 instances.



### Question #96

A solutions architect observes that a nightly batch processing job is automatically scaled up for 1 hour before the desired Amazon EC2 capacity is reached. The peak capacity is the same every night and the batch jobs always start at 1 AM. The solutions architect needs to find a cost-effective solution that will allow for the desired EC2 capacity to be reached quickly and allow the Auto Scaling group to scale down after the batch jobs are complete.
What should the solutions architect do to meet these requirements?

- A. Increase the minimum capacity for the Auto Scaling group.
- B. Increase the maximum capacity for the Auto Scaling group.
- C. Configure scheduled scaling to scale up to the desired compute level.
- D. Change the scaling policy to add more EC2 instances during each scaling operation.

> I agree its C



### Question #97

A Solutions Architect must design a web application that will be hosted on AWS, allowing users to purchase access to premium, shared content that is stored in an
S3 bucket. Upon payment, content will be available for download for 14 days before the user is denied access.
Which of the following would be the LEAST complicated implementation?

- A. Use an Amazon CloudFront distribution with an origin access identity (OAI). Configure the distribution with an Amazon S3 origin to provide access to the file through signed URLs. Design a Lambda function to remove data that is older than 14 days.
- B. Use an S3 bucket and provide direct access to the file. Design the application to track purchases in a DynamoDB table. Configure a Lambda function to remove data that is older than 14 days based on a query to Amazon DynamoDB.
- C. Use an Amazon CloudFront distribution with an OAI. Configure the distribution with an Amazon S3 origin to provide access to the file through signed URLs. Design the application to set an expiration of 14 days for the URL.
- D. Use an Amazon CloudFront distribution with an OAI. Configure the distribution with an Amazon S3 origin to provide access to the file through signed URLs. Design the application to set an expiration of 60 minutes for the URL and recreate the URL as necessary.

> There is no need to remove the data. Just expire the pre-signed url. So answer should be between C and D. However the max expiry time for pre-signed url is 7 days. So option D is the right answer
>
> It seems the restriction on max expiry time is only valid for normal S3 pre-signed URLs. For Cloudfront signed URLs there is no restriction. So changing answer to C.



### Question #98

A solutions architect is designing a mission-critical web application. It will consist of Amazon EC2 instances behind an Application Load Balancer and a relational database. The database should be highly available and fault tolerant.
Which database implementations will meet these requirements? (Choose two.)

- A. Amazon Redshift
- B. Amazon DynamoDB
- C. Amazon RDS for MySQL
- D. MySQL-compatible Amazon Aurora Multi-AZ
- E. Amazon RDS for SQL Server Standard Edition Multi-AZ

> D and E. Explanation: A - Redshift is a cloud data warehouse not a sql database B - it does not say that global tables is active and it is a NoSQL database C - It is not multi az



### Question #99

A company's web application is running on Amazon EC2 instances behind an Application Load Balancer. The company recently changed its policy, which now requires the application to be accessed from one specific country only.
Which configuration will meet this requirement?

- A. Configure the security group for the EC2 instances.
- B. Configure the security group on the Application Load Balancer.
- C. Configure AWS WAF on the Application Load Balancer in a VPC.
- D. Configure the network ACL for the subnet that contains the EC2 instances.

> I agree it is C, see https://aws.amazon.com/es/blogs/security/how-to-use-aws-waf-to-filter-incoming-traffic-from-embargoed-countries/



### Question #100

A solutions architect has created two IAM policies: Policy1 and Policy2. Both policies are attached to an IAM group.
![img](https://www.examtopics.com/assets/media/exam-media/04240/0007600001.png)
A cloud engineer is added as an IAM user to the IAM group. Which action will the cloud engineer be able to perform?

- A. Deleting IAM users
- B. Deleting directories
- C. Deleting Amazon EC2 instances
- D. Deleting logs from Amazon CloudWatch Logs

> As per the permission on Policy 1, the Cloud Engineer has full permission for EC2 instances. rest he will have limited permission. iam - Get & List kms - List ec2 - All ds - All (Directory Service) logs - Get & Describe resource - all



### Question #101

A company has an Amazon EC2 instance running on a private subnet that needs to access a public website to download patches and updates. The company does not want external websites to see the EC2 instance IP address or initiate connections to it.
How can a solutions architect achieve this objective?

- A. Create a site-to-site VPN connection between the private subnet and the network in which the public site is deployed.
- B. Create a NAT gateway in a public subnet. Route outbound traffic from the private subnet through the NAT gateway.
- C. Create a network ACL for the private subnet where the EC2 instance deployed only allows access from the IP address range of the public website.
- D. Create a security group that only allows connections from the IP address range of the public website. Attach the security group to the EC2 instance.

> Typical requirement for Nat Gateway. So answer is B.



### Question #102

A company must migrate 20 TB of data from a data center to the AWS Cloud within 30 days. The company's network bandwidth is limited to 15 Mbps and cannot exceed 70% utilization. What should a solutions architect do to meet these requirements?

- A. Use AWS Snowball.
- B. Use AWS DataSync.
- C. Use a secure VPN connection.
- D. Use Amazon S3 Transfer Acceleration.

> With 15 Mbps connection at 70% utilization it will take months to transfer 20 TB data. So using Snowball is the best option. Hence answer is A.



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
