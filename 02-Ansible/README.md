# 02 — Ansible: configuração de servidores como código

> **Mês 2 do arco Vortex Mobility.**
> No mês 1, você (Platform Engineer recém-contratado na **Vortex Mobility**, a startup de micromobilidade que escala de 3 para 30 cidades) entregou a infraestrutura como código com Terraform. **Helena Marques**, Head de Engenharia de Plataforma, volta com a próxima dor:
>
> > *— "Agora precisamos automatizar nossos deploys com um GitLab Runner próprio. Mas configurar servidor na mão, um por um — instalar pacote, registrar runner, ajustar systemd — não escala e ninguém lembra a sequência. Use Ansible para deixar isso repetível: eu quero subir um runner novo rodando um playbook, não seguindo um documento de 30 passos."*

Este módulo é o **segundo passo** da jornada da Vortex de sair do "tudo na mão no console" para "tudo como código versionado". O Terraform (módulo 01) provisiona a máquina; o **Ansible** entra logo depois para **configurar** essa máquina de forma declarativa e repetível — transformar uma EC2 nua num GitLab Runner pronto para rodar pipelines.

## O laboratório deste módulo

| # | Laboratório | O que você faz | Tempo estimado |
|---|-------------|----------------|----------------|
| **02.1** | **[Provisionando um GitLab Runner com Ansible](01-provisionando-gitlab-runner/README.md)** | Provisiona uma EC2 com Terraform, depois usa um playbook Ansible para instalar e registrar um GitLab Runner dedicado ao projeto da Vortex. | 60-90 min |

> [!TIP]
> Este módulo prepara o terreno para o **módulo 03 (CI/CD)**: o runner que você registra aqui é exatamente quem vai executar os pipelines de `terraform plan`/`apply` automatizados lá na frente.

## Por que Ansible (e não mais um shell script)

| Aspecto | Resposta curta |
|---------|----------------|
| **Problema de negócio** | A Vortex vai subir vários runners ao longo do tempo. Configurar cada um manualmente é lento, propenso a erro e impossível de auditar. |
| **Onde Ansible brilha** | Descrever o **estado desejado** do servidor (pacotes, serviços, arquivos) e aplicar de forma idempotente — rodar de novo não quebra nada. |
| **Onde Ansible sofre** | Provisionar a infraestrutura em si (criar a VPC, a EC2). Isso continua sendo trabalho do Terraform. |
| **Quando acontece na vida real** | Toda vez que você separa "criar a máquina" (Terraform) de "configurar a máquina" (Ansible) — o padrão clássico de IaC + config management. |

## Pré-requisitos

Antes de começar o lab deste módulo:

- [ ] **Módulo 01 (Terraform) concluído** — você já sabe rodar `terraform init/plan/apply` e entende state remoto no S3
- [ ] Bucket de state remoto existe no S3 (`base-config-<SEU-RM>`, criado no [setup inicial](../00-create-codespaces/README.md))
- [ ] Credenciais AWS do Academy atualizadas no Codespaces — valide com `aws sts get-caller-identity`
- [ ] Uma conta no [GitLab](https://gitlab.com/) (gratuita)

## Custo do módulo

O lab cria **uma EC2 `t2.micro`** que fica ligada enquanto o runner roda:

- **EC2 `t2.micro`**: ~$0,0116/h (~$0,28/dia se esquecida ligada)
- **S3** (state remoto): centavos/mês

> [!CAUTION]
> A EC2 do runner é infraestrutura **paga e ligada**. Ao terminar o lab, rode `terraform destroy -auto-approve` na pasta `terraform-gitlab-runner/`. O comando completo está no fim do [Lab 02.1](01-provisionando-gitlab-runner/README.md#conclusão). Esquecer ligada por uma semana consome ~$2 do orçamento do Learner Lab — pouco, mas evitável.

## Próximo módulo

Após concluir o lab deste módulo, prossiga para:

**[03 — CI/CD com GitLab](../03-CICD/README.md)** — com o runner registrado, todo push na master da Vortex vai disparar `plan` e `apply` automáticos, com um gate de segurança que barra configuração insegura antes de chegar na nuvem.
