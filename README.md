# Atividade 1 - IaC com Terraform

## Estrutura

```
.
├── backend.tf          # provider aws + backend s3 + bucket de state
├── main.tf              # instancia os modulos (vpc, ...)
├── variables.tf          # declaracao das variaveis (sem default; valores vem do tfvars)
├── dev.tfvars            # valores das variaveis para o ambiente dev
└── modules/
    ├── vpc/               # vpc, subnets, internet gateway, route table
    ├── ec2/               # instancia EC2 generica (security group + user_data opcional)
    └── web/                # usa o modulo ec2 e injeta o user_data que instala o servidor web
```

## Por que existe um `.tfvars` por ambiente

As variaveis em `variables.tf` não têm `default` de propósito — os valores reais ficam em um arquivo `.tfvars` por ambiente (ex: `dev.tfvars`). Isso porque o projeto usa **Terraform Workspaces** para isolar o state de cada ambiente (dev, homolog, prod, etc.) dentro do mesmo backend S3.

Cada workspace usa seu próprio `.tfvars` correspondente, então trocar de ambiente é só trocar de workspace **e** apontar para o `.tfvars` daquele ambiente — sem editar código, sem duplicar módulos.

## Como rodar

```bash
# inicializa o backend e os providers
terraform init

# cria (ou reaproveita) o workspace do ambiente
terraform workspace new dev   # ou: terraform workspace select dev

# planeja usando o tfvars do ambiente correspondente ao workspace
terraform plan -var-file="dev.tfvars"

# aplica
terraform apply -var-file="dev.tfvars"
```

Para um novo ambiente (ex: `prod`), o padrão é:

```bash
terraform workspace new prod
```

e criar um `prod.tfvars` com os valores daquele ambiente, mantendo o mesmo `.tf` para todos.
