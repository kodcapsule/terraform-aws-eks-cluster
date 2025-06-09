# AWS EKS Terraform Module - Production-Ready Kubernetes Cluster Infrastructure as Code

This repository contains Terraform infrastructure as code (IaC) to deploy a production-ready Amazon Elastic Kubernetes Service (EKS) cluster on AWS.

## Architecture Overview

The Terraform configuration creates:

- **VPC with Multi-AZ Setup**: Custom VPC with public and private subnets across 2 availability zones
- **EKS Cluster**: Fully managed Kubernetes control plane with CloudWatch logging
- **Managed Node Group**: Auto-scaling worker nodes in private subnets
- **Networking**: Internet Gateway, NAT Gateways, and route tables for secure connectivity
- **Security**: Security groups with least-privilege access
- **IAM**: Service roles with required permissions for EKS cluster and worker nodes

## Prerequisites

Before you begin, ensure you have:

1. **AWS CLI** installed and configured with appropriate credentials
   ```bash
      aws configure
   ```

2. **Terraform** installed (version >= 1.0)
   - Download from [terraform.io](https://www.terraform.io/downloads.html)

3. **kubectl** installed for cluster management
   - Download from [kubernetes.io](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

4. **AWS IAM Permissions** - Your AWS credentials need permissions for:
   - EKS cluster creation and management
   - EC2 instance and VPC management
   - IAM role creation and policy attachment
   - CloudWatch logs management

## Quick Start

### 1. Clone and Initialize

```bash
# Clone the repository (or download the files)
git clone <your-repo-url>
cd aws-eks-terraform

# Initialize Terraform
terraform init
```

### 2. Configure Variables (Optional)

Create a `terraform.tfvars` file to customize your deployment:

```hcl
# terraform.tfvars
cluster_name         = "my-production-cluster"
aws_region          = "us-east-1"
cluster_version     = "1.28"
node_instance_types = ["t3.large"]
node_desired_size   = 3
node_max_size       = 6
node_min_size       = 2
```

### 3. Deploy the Infrastructure

```bash
# Review the planned changes
terraform plan

# Apply the configuration
terraform apply
```

The deployment typically takes 10-15 minutes to complete.

### 4. Configure kubectl

Once the cluster is created, configure kubectl to connect:

```bash
aws eks update-kubeconfig --region <your-region> --name <your-cluster-name>

# Verify connection
kubectl get nodes
```

## Configuration Variables

| Variable | Description | Default | Type |
|----------|-------------|---------|------|
| `aws_region` | AWS region for deployment | `us-west-2` | string |
| `cluster_name` | Name of the EKS cluster | `my-eks-cluster` | string |
| `cluster_version` | Kubernetes version | `1.28` | string |
| `node_instance_types` | EC2 instance types for nodes | `["t3.medium"]` | list(string) |
| `node_desired_size` | Desired number of worker nodes | `2` | number |
| `node_max_size` | Maximum number of worker nodes | `4` | number |
| `node_min_size` | Minimum number of worker nodes | `1` | number |

## Outputs

After successful deployment, Terraform provides these outputs:

- `cluster_id`: EKS cluster identifier
- `cluster_arn`: EKS cluster ARN
- `cluster_endpoint`: Kubernetes API endpoint
- `cluster_security_group_id`: Security group ID for the cluster
- `kubectl_config`: Configuration details for kubectl setup

## Post-Deployment Setup

### Install Essential Add-ons

1. **AWS Load Balancer Controller** (for ingress):
   ```bash
   helm repo add eks https://aws.github.io/eks-charts
   helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
     -n kube-system \
     --set clusterName=<your-cluster-name>
   ```

2. **Cluster Autoscaler**:
   ```bash
   kubectl apply -f https://raw.githubusercontent.com/kubernetes/autoscaler/master/cluster-autoscaler/cloudprovider/aws/examples/cluster-autoscaler-autodiscover.yaml
   ```

3. **Metrics Server** (if not already installed):
   ```bash
   kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
   ```

### Verify Deployment

```bash
# Check cluster status
kubectl get nodes

# View cluster info
kubectl cluster-info

# Check system pods
kubectl get pods -n kube-system
```

## Security Considerations

This configuration implements several security best practices:

- **Private Worker Nodes**: All worker nodes are deployed in private subnets
- **Network Isolation**: Proper security group rules limit access
- **IAM Least Privilege**: Minimal required permissions for cluster and nodes
- **Encrypted Communication**: All traffic between components is encrypted
- **CloudWatch Logging**: Comprehensive audit logging enabled

## Cost Optimization

To optimize costs:

1. **Right-size instances**: Choose appropriate instance types for your workload
2. **Use Spot Instances**: Consider spot instances for non-critical workloads
3. **Enable Cluster Autoscaler**: Automatically scale nodes based on demand
4. **Monitor usage**: Use AWS Cost Explorer to track EKS costs

## Troubleshooting

### Common Issues

1. **Authentication Error**:
   ```bash
   # Re-configure kubectl
   aws eks update-kubeconfig --region <region> --name <cluster-name>
   ```

2. **Nodes Not Joining**:
   - Check IAM roles and policies
   - Verify security group rules
   - Check subnet routing

3. **Terraform Apply Fails**:
   - Ensure AWS credentials are configured
   - Check IAM permissions
   - Verify resource limits in AWS account

### Useful Commands

```bash
# View Terraform state
terraform show

# Get specific output
terraform output cluster_endpoint

# Destroy infrastructure (caution!)
terraform destroy
```

## Maintenance

### Upgrading Kubernetes Version

1. Update the `cluster_version` variable
2. Apply changes: `terraform apply`
3. Update node groups following AWS documentation

### Scaling Nodes

Modify the scaling variables in `terraform.tfvars` and apply:
```bash
terraform apply
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For issues and questions:
- Check the [troubleshooting section](#troubleshooting)
- Review [AWS EKS documentation](https://docs.aws.amazon.com/eks/)
- Open an issue in this repository

## Additional Resources

- [AWS EKS Best Practices Guide](https://aws.github.io/aws-eks-best-practices/)
- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [AWS EKS Workshop](https://www.eksworkshop.com/)