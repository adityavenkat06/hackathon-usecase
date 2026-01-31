# Design Tasks for Hackathon Requirements

This document outlines the work needed to satisfy the requirements in `readme.md` for the DevOps Hackathon Challenge on GCP only. It does not implement anything; it is a task plan only.

## 1) Service Inventory and Decisions
- Confirm which two microservices will be deployed:
  - Option A: Node.js Patient Service + Appointment Service (`patient-service/`, `application-service/`)
  - Option B: Java `order-service/`
- Decide if all three will be supported or only one track at a time.
- Standardize port conventions (assume `8080`) and health endpoint (`/health`).

## 2) Containerization (Docker)
- Create `Dockerfile` for Node.js services.
- Create `Dockerfile` for Java `order-service`.
- Add `.dockerignore` files.
- Define image names and tags (commit SHA).
- Validate local builds run and expose health endpoint.

## 3) Kubernetes Manifests / Helm
- Create namespace for microservices.
- Add Deployment and Service for each microservice.
- Add readiness/liveness probes on `/health` and port `8080`.
- Add Ingress definition with path routing:
  - `/patient`, `/appointment` (or `/a`, `/b` for demo)
- Configure resource requests/limits.
- Add ConfigMaps/Secrets where needed.

## 4) Secrets Management (GCP)
- Use Secret Manager for application secrets.
- Define how secrets are injected into pods (env vars or mounted files).
- Optional: CSI driver approach for secret mounts.

## 5) Infrastructure as Code (Terraform - GCP)
- Create project layout supporting environments:
  - `terraform/modules/{network,cluster,registry}`
  - `terraform/envs/{dev,staging,prod}`
- Define network:
  - VPC with public/private subnets across 2 zones.
  - Private Google Access on private subnet.
  - Cloud Router + Cloud NAT for private egress (GCP).
- Define cluster:
  - GKE cluster configuration.
  - Node pools and sizing.
  - Workload Identity.
- Define container registry:
  - GCP Artifact Registry.
- Remote state storage:
  - GCS bucket.
- State locking:
  - GCS backend locking.
- Environment separation:
  - Terraform workspaces or per-env backend prefixes.

## 6) CI/CD Pipelines (GitHub Actions)
- Workflow A (Terraform):
  - `terraform fmt` and `validate` on PRs.
  - `terraform plan` on PRs.
  - `terraform apply` on merge to main.
- Workflow B (Build):
  - Build Docker images.
  - Push to Artifact Registry with commit SHA tags.
- Workflow C (Deploy):
  - Update manifests with new image tags.
  - Deploy to GKE/AKS.
  - Verify rollout status.

## 7) Authentication and Permissions (GCP)
- GitHub OIDC → Workload Identity Federation (no JSON keys).
- Create least-privilege service accounts.
- Store required values as GitHub secrets.

## 8) Monitoring and Logging (GCP)
- Enable Cloud Monitoring/Logging.
- Capture cluster logs and application logs.
- Define basic alerting:
  - Pod restart loops
  - High CPU/memory
  - 5xx ingress errors

## 9) Documentation and Runbook
- Update `readme-gcp.md` with GCP-specific steps.
- Provide quickstart commands:
  - Terraform init/plan/apply
  - Cluster credentials fetch
  - `kubectl apply` and rollout checks
- Document ingress endpoint verification.

## 10) Validation Checklist
- Docker images build locally.
- Terraform plan/apply succeeds in dev.
- Cluster reachable via kubectl.
- Services reachable via ingress.
- Logs visible in monitoring tools.
