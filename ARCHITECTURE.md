# Todo App Infrastructure Architecture

## High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        Azure Cloud                              │
│                                                                 │
│  ┌─────────────────┐    ┌─────────────────┐                    │
│  │   DEV Environment │    │  PROD Environment │                  │
│  │                 │    │                 │                    │
│  │ ┌─────────────┐ │    │ ┌─────────────┐ │                    │
│  │ │Resource Group│ │    │ │Resource Group│ │                    │
│  │ │todo-dev-rg  │ │    │ │todo-prod-rg │ │                    │
│  │ └─────────────┘ │    │ └─────────────┘ │                    │
│  │                 │    │                 │                    │
│  │ ┌─────────────┐ │    │ ┌─────────────┐ │                    │
│  │ │Virtual Network│ │    │ │Virtual Network│ │                  │
│  │ │10.0.0.0/16  │ │    │ │10.1.0.0/16  │ │                    │
│  │ │             │ │    │ │             │ │                    │
│  │ │ ┌─────────┐ │ │    │ │ ┌─────────┐ │ │                    │
│  │ │ │AKS Subnet│ │ │    │ │ │AKS Subnet│ │ │                    │
│  │ │ │10.0.1.0/24│ │ │    │ │ │10.1.1.0/24│ │ │                    │
│  │ │ └─────────┘ │ │    │ │ └─────────┘ │ │                    │
│  │ │             │ │    │ │             │ │                    │
│  │ │ ┌─────────┐ │ │    │ │ ┌─────────┐ │ │                    │
│  │ │ │SQL Subnet│ │ │    │ │ │SQL Subnet│ │ │                    │
│  │ │ │10.0.2.0/24│ │ │    │ │ │10.1.2.0/24│ │ │                    │
│  │ │ └─────────┘ │ │    │ │ └─────────┘ │ │                    │
│  │ └─────────────┘ │    │ └─────────────┘ │                    │
│  │                 │    │                 │                    │
│  │ ┌─────────────┐ │    │ ┌─────────────┐ │                    │
│  │ │Key Vault    │ │    │ │Key Vault    │ │                    │
│  │ │(Standard)   │ │    │ │(Premium)    │ │                    │
│  │ └─────────────┘ │    │ └─────────────┘ │                    │
│  │                 │    │                 │                    │
│  │ ┌─────────────┐ │    │ ┌─────────────┐ │                    │
│  │ │Storage Acct │ │    │ │Storage Acct │ │                    │
│  │ │(LRS)        │ │    │ │(GRS)        │ │                    │
│  │ └─────────────┘ │    │ └─────────────┘ │                    │
│  │                 │    │                 │                    │
│  │ ┌─────────────┐ │    │ ┌─────────────┐ │                    │
│  │ │SQL Server   │ │    │ │SQL Server   │ │                    │
│  │ │+ Database   │ │    │ │+ Database   │ │                    │
│  │ │(2GB)        │ │    │ │(10GB)       │ │                    │
│  │ └─────────────┘ │    │ └─────────────┘ │                    │
│  │                 │    │                 │                    │
│  │ ┌─────────────┐ │    │ ┌─────────────┐ │                    │
│  │ │AKS Cluster  │ │    │ │AKS Cluster  │ │                    │
│  │ │1-3 nodes    │ │    │ │2-10 nodes   │ │                    │
│  │ │D2s_v3       │ │    │ │D4s_v3       │ │                    │
│  │ └─────────────┘ │    │ └─────────────┘ │                    │
│  │                 │    │                 │                    │
│  │ ┌─────────────┐ │    │ ┌─────────────┐ │                    │
│  │ │Public IP    │ │    │ │Public IP    │ │                    │
│  │ └─────────────┘ │    │ └─────────────┘ │                    │
│  └─────────────────┘    └─────────────────┘                    │
└─────────────────────────────────────────────────────────────────┘
```

## Detailed Component Architecture

### Development Environment

```
┌─────────────────────────────────────────────────────────────┐
│                    DEV Environment                          │
│                                                             │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │                Resource Group                           │ │
│  │                todo-dev-rg                              │ │
│  │                                                         │ │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │ │
│  │  │Key Vault    │  │Storage Acct │  │SQL Server   │     │ │
│  │  │todo-dev-kv  │  │todo-dev-stg │  │todo-dev-sql │     │ │
│  │  │(Standard)   │  │(LRS)        │  │+ Database   │     │ │
│  │  │7-day ret.   │  │             │  │(2GB)        │     │ │
│  │  └─────────────┘  └─────────────┘  └─────────────┘     │ │
│  │                                                         │ │
│  │  ┌─────────────────────────────────────────────────────┐ │ │
│  │  │              Virtual Network                        │ │ │
│  │  │              10.0.0.0/16                           │ │ │
│  │  │                                                     │ │ │
│  │  │  ┌─────────────┐              ┌─────────────┐      │ │ │
│  │  │  │AKS Subnet   │              │SQL Subnet   │      │ │ │
│  │  │  │10.0.1.0/24  │              │10.0.2.0/24  │      │ │ │
│  │  │  │             │              │             │      │ │ │
│  │  │  │ ┌─────────┐ │              │ ┌─────────┐ │      │ │ │
│  │  │  │ │AKS      │ │              │ │SQL      │ │      │ │ │
│  │  │  │ │Cluster  │ │              │ │Server   │ │      │ │ │
│  │  │  │ │1-3 nodes│ │              │ │         │ │      │ │ │
│  │  │  │ │D2s_v3   │ │              │ │         │ │      │ │ │
│  │  │  │ └─────────┘ │              │ └─────────┘ │      │ │ │
│  │  │  └─────────────┘              └─────────────┘      │ │ │
│  │  └─────────────────────────────────────────────────────┘ │ │
│  │                                                         │ │
│  │  ┌─────────────┐  ┌─────────────┐                      │ │
│  │  │Public IP    │  │Managed     │                      │ │
│  │  │todo-dev-pip │  │Identity    │                      │ │
│  │  └─────────────┘  └─────────────┘                      │ │
│  └─────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

### Production Environment

```
┌─────────────────────────────────────────────────────────────┐
│                    PROD Environment                         │
│                                                             │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │                Resource Group                           │ │
│  │                todo-prod-rg                             │ │
│  │                                                         │ │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │ │
│  │  │Key Vault    │  │Storage Acct │  │SQL Server   │     │ │
│  │  │todo-prod-kv │  │todo-prod-stg│  │todo-prod-sql│     │ │
│  │  │(Premium)    │  │(GRS)        │  │+ Database   │     │ │
│  │  │30-day ret.  │  │             │  │(10GB)       │     │ │
│  │  │Purge prot.  │  │             │  │             │     │ │
│  │  └─────────────┘  └─────────────┘  └─────────────┘     │ │
│  │                                                         │ │
│  │  ┌─────────────────────────────────────────────────────┐ │ │
│  │  │              Virtual Network                        │ │ │
│  │  │              10.1.0.0/16                           │ │ │
│  │  │                                                     │ │ │
│  │  │  ┌─────────────┐              ┌─────────────┐      │ │ │
│  │  │  │AKS Subnet   │              │SQL Subnet   │      │ │ │
│  │  │  │10.1.1.0/24  │              │10.1.2.0/24  │      │ │ │
│  │  │  │             │              │             │      │ │ │
│  │  │  │ ┌─────────┐ │              │ ┌─────────┐ │      │ │ │
│  │  │  │ │AKS      │ │              │ │SQL      │ │      │ │ │
│  │  │  │ │Cluster  │ │              │ │Server   │ │      │ │ │
│  │  │  │ │2-10 nodes│ │              │ │         │ │      │ │ │
│  │  │  │ │D4s_v3   │ │              │ │         │ │      │ │ │
│  │  │  │ │Multiple │ │              │ │         │ │      │ │ │
│  │  │  │ │Pools    │ │              │ │         │ │      │ │ │
│  │  │  │ └─────────┘ │              │ └─────────┘ │      │ │ │
│  │  │  └─────────────┘              └─────────────┘      │ │ │
│  │  └─────────────────────────────────────────────────────┘ │ │
│  │                                                         │ │
│  │  ┌─────────────┐  ┌─────────────┐                      │ │
│  │  │Public IP    │  │Managed     │                      │ │
│  │  │todo-prod-pip│  │Identity    │                      │ │
│  │  └─────────────┘  └─────────────┘                      │ │
│  └─────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

## Network Flow

```
Internet
    │
    ▼
┌─────────────┐
│  Public IP  │
└─────────────┘
    │
    ▼
┌─────────────┐
│  Load       │
│  Balancer   │
└─────────────┘
    │
    ▼
┌─────────────┐
│  AKS        │
│  Cluster    │
│  (Pods)     │
└─────────────┘
    │
    ▼
┌─────────────┐
│  SQL        │
│  Server     │
└─────────────┘
    │
    ▼
┌─────────────┐
│  Storage    │
│  Account    │
└─────────────┘
```

## Security Layers

1. **Network Security Groups (NSG)**
   - Inbound/Outbound rules
   - Port restrictions
   - Source IP filtering

2. **Key Vault Access Policies**
   - Azure AD authentication
   - Network restrictions
   - Secret rotation

3. **SQL Server Security**
   - Private endpoints
   - Firewall rules
   - Encryption at rest

4. **AKS Security**
   - RBAC enabled
   - Pod security policies
   - Network policies

5. **Storage Security**
   - Access keys in Key Vault
   - Network access rules
   - Encryption in transit

## Monitoring and Logging

- **Azure Monitor**: Infrastructure metrics
- **Log Analytics**: Centralized logging
- **Application Insights**: Application performance
- **SQL Auditing**: Database activity logs
- **Key Vault Logging**: Secret access logs
- **Storage Logging**: Access patterns

## Cost Optimization

### Development
- Smaller VM sizes (D2s_v3)
- Single region deployment
- LRS storage replication
- Minimal node count

### Production
- Auto-scaling enabled
- GRS storage replication
- Multiple node pools
- Premium Key Vault
- Larger database size
