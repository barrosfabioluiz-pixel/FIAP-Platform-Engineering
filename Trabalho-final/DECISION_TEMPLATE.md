# Decisão de plataforma — Infraestrutura da Vortex como código validado

> Documento entregue à Head de Engenharia de Plataforma **Helena Marques** da Vortex Mobility antes da apresentação ao board. Simula um ADR (Architecture Decision Record) real — documento curto que registra escolhas técnicas com contexto, alternativas e consequências.
>
> **Como usar**: copie este arquivo para `DECISION.md` na raiz do seu projeto e preencha enquanto avança no Trabalho Final. Substitua todos os campos `_______` pelas suas respostas. Não deixe campos em branco.

---

## Autor e data

- **Platform Engineer**: _______ (você)
- **Stakeholder**: Helena Marques (Head de Engenharia de Plataforma, Vortex Mobility)
- **RM**: _______
- **Data**: AAAA-MM-DD
- **Link do repositório GitLab**: _______

---

## Contexto

Descreva em 3-5 linhas a demanda que Helena trouxe e o estado atual da infraestrutura.

_(exemplo: "A infraestrutura da Vortex foi criada clicando no console da AWS e não escala: ninguém consegue reproduzir ambientes e os deploys são manuais. Helena pediu uma prova de que conseguimos recriar e validar tudo do zero com um push. Partimos da demo Count — N instâncias EC2 com Nginx atrás de um ELB — e a evoluímos para um projeto modular, multi-ambiente, com pipeline.")_

_______

---

## Decisão de design do módulo

Como você estruturou o módulo a partir da demo Count?

- **Nome / caminho do módulo**: _______ (ex: `modules/web-cluster`)
- **Variável de entrada para a quantidade de nós**: _______ (ex: `node_count`)
- **Outputs expostos**: _______ (ex: `elb_dns_name`)
- **Por que essa fronteira de módulo** (3 linhas): _______

---

## Estratégia de estado (state)

- **Backend escolhido**: _______ (ex: S3 `base-config-<RM>`, key `trabalho-final/terraform.tfstate`)
- **Como os ambientes são isolados**: _______ (ex: workspaces `dev` e `prod`)
- **Bloqueio de state (locking)**: usou DynamoDB? Sim / Não — por quê: _______
- **Por que state remoto em vez de local** (2-3 linhas): _______

---

## Design do pipeline de CI/CD

Descreva as 3 etapas e o que cada uma faz:

| Etapa | O que executa | O que ela protege |
|-------|---------------|-------------------|
| 1. validar | _______ | _______ |
| 2. revisar/gate | _______ | _______ |
| 3. aplicar | _______ | _______ |

- **Ferramenta do gate de segurança**: _______ (ex: `tflint`, inspeção do `plan`)
- **Onde o pipeline roda**: _______ (Runner próprio do Módulo 02 — confirme que estava online)
- **Como as credenciais AWS chegam ao job sem ir para o Git**: _______

---

## Decisão final

Marque o que você entregou e escreva por quê.

- [ ] Módulo único reutilizado por workspace (`dev`/`prod` a partir do mesmo código)
- [ ] Diretórios separados por ambiente (cada um com seu state)
- [ ] Outra abordagem: _______

**Justificativa** (3-5 linhas): _______

---

## Alternativas consideradas e descartadas

Para cada opção que você **não** escolheu, escreva uma linha dizendo por quê.

- **State local (no repositório) — descartado**: _______
- **Sem workspaces, duplicando o código por ambiente — descartado**: _______
- **Pipeline que aplica direto sem etapa de gate — descartado**: _______

---

## Consequências

### Positivas

- _______
- _______

### Negativas / pontos de atenção

- _______
- _______

---

## O que eu precisaria do negócio para validar esta escolha

Liste 2-3 perguntas que você faria à Helena ou ao Diego **antes** de colocar isso em produção de verdade.

1. _______
2. _______
3. _______

---

## Decisões técnicas secundárias

### Diferença entre dev e prod

- Como `dev` difere de `prod`: _______ (ex: `node_count` 1 vs 3)
- Por quê: _______

### Nomeação de recursos por workspace

- Padrão de nome adotado para EC2 / ELB / Security Group: _______ (ex: `nginx-prod-002`, `elb-prod`, `sg-prod`)
- Por que carregar o workspace no nome: _______

### Tipo de load balancer

- Manteve o `aws_elb` (Classic) da demo Count ou migrou para `aws_lb` (ALB)?
- Escolha: _______
- Por quê: _______

---

## Resposta à pergunta-âncora da disciplina

> *"Quanto tempo a Vortex leva para recriar toda a sua infraestrutura do zero, de forma confiável e auditável?"*

Sua resposta, com o número real medido no seu pipeline: _______

---

## Observações adicionais

_(espaço livre — comportamentos inesperados, descobertas, dúvidas que você quer anotar)_

_______
