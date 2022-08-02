# Exam AWS Certified Solutions Architect - Associate SAA-C02

https://www.examtopics.com/exams/amazon/aws-certified-solutions-architect-associate-saa-c02/view/

### **Question #1** 20220801

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



### **Question #11** 20220802

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



**Question #21**

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


### Question #31 20220802
Currently, a company's legacy application relies on an unencrypted Amazon RDS MySQL database with a single instance. All current and new data in this database must be encrypted to comply with new compliance standards.

How is this to be achieved?

A. Create an Amazon S3 bucket with server-side encryption enabled. Move all the data to Amazon S3. Delete the RDS instance.
B. Enable RDS Multi-AZ mode with encryption at rest enabled. Perform a failover to the standby instance to delete the original instance.
C. Take a Snapshot of the RDS instance. Create an encrypted copy of the snapshot. Restore the RDS instance from the encrypted snapshot.
D. Create an RDS read replica with encryption at rest enabled. Promote the read replica to master and switch the application over to the new master. Delete the old RDS instance.

C for sure.
You can only enable encryption for an Amazon RDS DB instance when you create it, not after the DB instance is created.
However, because you can encrypt a copy of an unencrypted snapshot, you can effectively add encryption to an unencrypted DB instance. That is, you can create a snapshot of your DB instance, and then create an encrypted copy of that snapshot. You can then restore a DB instance from the encrypted snapshot, and thus you have an encrypted copy of your original DB instance.
https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Overview.Encryption.html

### Question #32
A marketing firm uses an Amazon S3 bucket to store CSV data for statistical research. Permission is required for an application running on an Amazon EC2 instance to properly handle the CSV data stored in the S3 bucket.

Which step will provide the MOST SECURE access to the S3 bucket for the EC2 instance?

A. Attach a resource-based policy to the S3 bucket.
B. Create an IAM user for the application with specific permissions to the S3 bucket.
C. Associate an IAM role with least privilege permissions to the EC2 instance profile.
D. Store AWS credentials directly on the EC2 instance for applications on the instance to use for API calls.

It should be IAM Role

### Question #33
On a cluster of Amazon Linux EC2 instances, a business runs an application. The organization is required to store all application log files for seven years for compliance purposes.
The log files will be evaluated by a reporting program, which will need concurrent access to all files.

Which storage system best satisfies these criteria in terms of cost-effectiveness?

A. Amazon Elastic Block Store (Amazon EBS)
B. Amazon Elastic File System (Amazon EFS)
C. Amazon EC2 instance store
D. Amazon S3

Correct Answer: D
Using the AWS Simple Cost Calculator (Jan 2022), the cost of storage for 1TB a month is $81.92. However, 1TB in S3 Standard is $23.44.
Since S3 does, in fact, support concurrency (https://aws.amazon.com/blogs/big-data/optimizing-amazon-s3-for-high-concurrency-in-distributed-workloads/), for cost-effectiveness and concurrency selecting S3 (Answer D) is the better answer.
Here's another link that might be helpful. https://aws.amazon.com/about-aws/whats-new/2018/07/amazon-s3-announces-increased-request-rate-performance/

### Question #34
On a fleet of Amazon EC2 instances, a business provides a training site. The business predicts that when its new course, which includes hundreds of training videos on the web, is available in one week, it will be tremendously popular.

What should a solutions architect do to ensure that the predicted server load is kept to a minimum?

A. Store the videos in Amazon ElastiCache for Redis. Update the web servers to serve the videos using the ElastiCache API.
B. Store the videos in Amazon Elastic File System (Amazon EFS). Create a user data script for the web servers to mount the EFS volume.
C. Store the videos in an Amazon S3 bucket. Create an Amazon CloudFront distribution with an origin access identity (OAI) of that S3 bucket. Restrict Amazon S3 access to the OAI.
D. Store the videos in an Amazon S3 bucket. Create an AWS Storage Gateway file gateway to access the S3 bucket. Create a user data script for the web servers to mount the file gateway.

answer is C
keyword: Load is kept is a minimum (using cloudfront)
A. We would have to store the videos on an RDS, not sure if that would be suitable.....
B. How does this help minimize the anticipated server load?
C. Sounds about right, the best option probably.
D. We're not running anything on premise.

### Question #35
A business chooses to transition from on-premises to the AWS Cloud its three-tier web application. The new database must be able to scale storage capacity dynamically and conduct table joins.

Which AWS service satisfies these criteria?

A. Amazon Aurora
B. Amazon RDS for SqlServer
C. Amazon DynamoDB Streams
D. Amazon DynamoDB on-demand

A...Table joins indicate Relational DB or SQL... so DynamoDB ruled out coz NoSQL.. so Aurora is completely server less and scalable in storage.


### Question #36
On a fleet of Amazon EC2 instances, a business runs a production application. The program takes data from an Amazon SQS queue and concurrently processes the messages. The message volume is variable, and traffic is often interrupted. This program should handle messages continuously and without interruption.

Which option best fits these criteria in terms of cost-effectiveness?

A. Use Spot Instances exclusively to handle the maximum capacity required.
B. Use Reserved Instances exclusively to handle the maximum capacity required.
C. Use Reserved Instances for the baseline capacity and use Spot Instances to handle additional capacity.
D. Use Reserved Instances for the baseline capacity and use On-Demand Instances to handle additional capacity.

I was going with D but now realise that SQS requires consumers to manually delete the message from queue post processing.
Fact that instance(spot) got abruptly terminated means no deletion from queue,hence no loss of message.
Going back to C.

### Question #37
A startup has developed an application that gathers data from Internet of Things (IoT) sensors installed on autos. Through Amazon Kinesis Data Firehose, the data is transmitted to and stored in Amazon S3. Each year, data generates billions of S3 objects. Each morning, the business retrains a set of machine learning (ML) models using data from the preceding 30 days.
Four times a year, the corporation analyzes and trains other machine learning models using data from the preceding 12 months. The data must be accessible with a minimum of delay for a period of up to one year. Data must be preserved for archive reasons after one year.

Which storage system best satisfies these criteria in terms of cost-effectiveness?

A. Use the S3 Intelligent-Tiering storage class. Create an S3 Lifecycle policy to transition objects to S3 Glacier Deep Archive after 1 year.
B. Use the S3 Intelligent-Tiering storage class. Configure S3 Intelligent-Tiering to automativally move objects to S3 Glacier Deep Archive after 1 year.
C. Use the S3 Standard-Infrequent Access (S3 Standard-IA) storage class. Create an S3 Lifecycle policy to transition objects to S3 Glacier Deep Archive after 1 year.
D. Use the S3 Standard storage class. Create an S3 Lifecycle policy to transition objects to S3 Standard-Infrequent Access (S3 Standard-IA) after 30 days, and then to S3 Glacier Deep Archive after 1 year.

D because:
- First 30 days- data access every morning ( predictable and frequently) – S3 standard
- After 30 days, accessed 4 times a year – S3 infrequently access
- Data preserved- S3 Gllacier Deep Archive
Not B because S3 Intelligent-Tiering is suitable when access patterns change - https://aws.amazon.com/s3/storage-classes/intelligent-tiering/

### Question #38
A business requires data storage on Amazon S3. A compliance requirement stipulates that when objects are modified, their original state must be retained. Additionally, data older than five years should be kept for auditing purposes.

What SHOULD A SOLUTIONS ARCHITECT RECOMMEND AS THE MOST EFFORTABLE?

A. Enable object-level versioning and S3 Object Lock in governance mode
B. Enable object-level versioning and S3 Object Lock in compliance mode
C. Enable object-level versioning. Enable a lifecycle policy to move data older than 5 years to S3 Glacier Deep Archive
D. Enable object-level versioning. Enable a lifecycle policy to move data older than 5 years to S3 Standard-Infrequent Access (S3 Standard-IA)

This question appeared in the exam with a tweak. I passed the exam yesterday. Thanks examtopics and those who contributed! Question had two choices. I don't remember the exact wordings but, it also ask to delete objects after five years.
With Governance Mode it is possible to delete the object with special permissions
I chose A & C

### Question #39
Multiple Amazon EC2 instances are used to host an application. The program reads messages from an Amazon SQS queue, writes them to an Amazon RDS database, and then removes them from the queue. The RDS table sometimes contains duplicate entries. There are no duplicate messages in the SQS queue.

How can a solutions architect guarantee that messages are handled just once?

A. Use the CreateQueue API call to create a new queue.
B. Use the AddPermission API call to add appropriate permissions.
C. Use the ReceiveMessage API call to set an appropriate wait time.
D. Use the ChangeMessageVisibility API call to increase the visibility timeout.


D -
The visibility timeout begins when Amazon SQS returns a message. During this time, the consumer processes and deletes the message. However, if the consumer fails before deleting the message and your system doesn't call the DeleteMessage action for that message before the visibility timeout expires, the message becomes visible to other consumers and the message is received again. If a message must be received only once, your consumer should delete it within the duration of the visibility timeout.

https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-visibility-timeout.html

### Question #40
A corporation just announced the worldwide launch of their retail website. The website is hosted on numerous Amazon EC2 instances, which are routed via an Elastic Load Balancer. The instances are distributed across several Availability Zones in an Auto Scaling group.
The firm want to give its clients with customized material depending on the device from which they view the website.

Which steps should a solutions architect perform in combination to satisfy these requirements? (Select two.)

A. Configure Amazon CloudFront to cache multiple versions of the content.
B. Configure a host header in a Network Load Balancer to forward traffic to different instances.
C. Configure a Lambda@Edge function to send specific objects to users based on the User-Agent header.
D. Configure AWS Global Accelerator. Forward requests to a Network Load Balancer (NLB). Configure the NLB to set up host-based routing to different EC2 instances.
E. Configure AWS Global Accelerator. Forward requests to a Network Load Balancer (NLB). Configure the NLB to set up path-based routing to different EC2 instances.

A and C.
- B is wrong - NLBs do not understand HTTP (Layer 7 / Application layer) headers, this is what ALBs do. Moreover, a host header is information of the DESTINATION server, not the SOURCE client\
- D and E are wrong - Global Accelerator helps to SPEED UP requests. Doesn't help with CONTENT CUSTOMIZATION

I know D and E are wrong because only ALB can do any path or host based routing. B also is wrong cos HTTP headers cannot be sent by a NLB. NLB operates on layer 3, HTTP is a Layer 7 protocol, hence only an ALB too. By order of elimination, A and C are the answers.



