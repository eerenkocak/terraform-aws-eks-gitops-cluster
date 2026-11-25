# Production AWS EKS Cluster & Automated ArgoCD GitOps Platform (Terraform)

[English Documentation](#english-version) | [Turkce Dokumantasyon](#turkce-versiyon)

---

## <a name="english-version"></a>English Version

This repository provisions a production-grade **Amazon Elastic Kubernetes Service (EKS)** cluster on **AWS (`eu-north-1`)** using **Terraform**, integrated with **OIDC / IRSA** pod-level IAM security, isolated Multi-AZ private worker nodes, FinOps cost guardrails, and an automated **ArgoCD GitOps** controller deployed via the Terraform Helm provider.

### Key Architectural & Kubernetes Practices

* **Isolated Multi-AZ EKS VPC (`vpc.tf`):** Provisions a dedicated `10.30.0.0/16` network topology with Kubernetes-tagged public load-balancer subnets (`kubernetes.io/role/elb`) and private worker subnets (`kubernetes.io/role/internal-elb`).
* **Private Managed Worker Nodes (`eks.tf`):** Deploys Kubernetes `1.30` worker nodes exclusively inside private subnets (`t3.medium`, FinOps-constrained scaling `min=1, max=2`) with keyless **Amazon ECR** image pull permissions (`AmazonEC2ContainerRegistryReadOnly`).
* **OIDC & IRSA Pod Security (`eks.tf`, `iam.tf`):** Configures an IAM OpenID Connect (OIDC) provider to enable **IAM Roles for Service Accounts (IRSA)**, eliminating static AWS credentials inside Kubernetes pods.
* **Automated GitOps Controller (`gitops.tf`):** Bootstraps **ArgoCD** via the Terraform `helm_release` provider into a dedicated `argocd` namespace immediately upon cluster readiness, enabling declarative continuous delivery.
* **FinOps Variable Guardrails (`variables.tf`):** Enforces Terraform `validation` blocks to prevent oversized EC2 node provisioning.

### Project Structure

```text
terraform-aws-eks-gitops-cluster/
|-- providers.tf     # AWS, Kubernetes, Helm & TLS provider configurations
|-- variables.tf     # Cluster parameters & FinOps node validation guardrails
|-- vpc.tf           # Multi-AZ VPC with Kubernetes ELB & internal routing tags
|-- iam.tf           # Least-privilege Control Plane & Worker Node IAM roles
|-- eks.tf           # EKS 1.30 Control Plane, Private Node Group & OIDC Provider
|-- gitops.tf        # Automated ArgoCD Helm release in isolated namespace
|-- outputs.tf       # Cluster endpoint, OIDC ARN & kubectl config command
|-- .gitignore       # Terraform state & cache exclusion rules
`-- README.md
```

---

## <a name="turkce-versiyon"></a>Turkce Versiyon

Bu depo, **AWS (`eu-north-1`)** uzerinde **Terraform** kullanilarak produksiyon standartlarinda bir **Amazon EKS (Kubernetes 1.30)** kumesini, **OIDC / IRSA** pod seviyesi guvenlik mimarisini, izole Multi-AZ private isci dugumlerini (Worker Nodes) ve Terraform Helm saglayicisi uzerinden otomatik kurulan **ArgoCD GitOps** motorunu ayaga kaldirir.

### One Cikan Kubernetes ve Bulut Pratikleri

* **Izole Multi-AZ EKS Ag Topolojisi (`vpc.tf`):** Kubernetes Load Balancer etiketlerine (`kubernetes.io/role/elb` ve `internal-elb`) sahip Public ve Private alt aglardan olusan ozel `10.30.0.0/16` VPC yapisi sunar.
* **Private Isci Dugumler (`eks.tf`):** Kubernetes isci dugumlerini dis dunyaya kapali Private alt aglarda calistirir ve AWS ECR'den sifresiz imaj cekebilmeleri icin en az yetkili IAM politikasini baglar.
* **OIDC ve IRSA Pod Guvenligi (`eks.tf`, `iam.tf`):** Podlarin AWS servislerine sabit sifreler kullanmadan guvenli erisebilmesi icin OIDC saglayicisini otomatik yapilandirir.
* **Otomatik ArgoCD GitOps Kurulumu (`gitops.tf`):** Kume hazir oldugu saniye Terraform `helm_release` uzerinden `argocd` namespace'i icine ArgoCD kurulumunu gerceklestirir.
* **FinOps Maliyet Korumalari (`variables.tf`):** `validation` bloklari ve dugum olcekleme sinirlariyla kontrolsuz bulut faturalarini onler.
