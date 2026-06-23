# Documento de Visão - PetsHelp System

## 1. Identificação e Contexto do Projeto

### 1.1 Identificação do Documento

| Campo | Valor |
|-------|-------|
| Nome do Projeto | PetsHelp System |
| ONG Parceira | Associação Beneficente PetsHelp |
| Aluno(s) | Brenda Lannig Costa |
| Disciplina | Projeto Integrador Extensionista I - PIE I |

### 1.2 Descrição da ONG Parceira

**Nome e Localidade:** PetsHelp – Marília, SP - Brasil

**Missão:** Ajudar os animais de rua ou em estado de vulnerabilidade e maus tratos, intermediando coleta e distribuição de ração, medicamentos e itens de necessidade e higiene.

**Estrutura Operacional:**

| Aspecto | Situação Atual |
|---------|----------------|
| Ano de fundação | 2026 |
| Coordenadores | 1 |
| Voluntários ativos | 10 |
| Beneficiários/mês | 50 |
| Doações/mês | 150 |
| Ferramenta atual | Planilhas Excel manuais |
| Orçamento TI | R$ 5.000 |

### 1.3 Problema Identificado

**Situação Atual:**
A ONG PetsHelp gerencia todas as doações (ração, medicamentos, itens de higiene) e o controle de beneficiários (animais e protetores) utilizando planilhas Excel manuais. Atualmente, não há um repositório centralizado; cada coordenador mantém sua própria versão da planilha em seu computador pessoal. O registro de uma doação envolve anotações manuais em papel, que depois são digitadas em uma das planilhas. A rastreabilidade de um item (ex.: "quem doou o medicamento X" ou "qual animal recebeu a ração Y") é feita por busca manual, muitas vezes exigindo a verificação de múltiplos arquivos.

**Impacto do Problema:**
- **Perda de produtividade:** A equipe gasta cerca de **8 horas por semana** consolidando informações de diferentes planilhas para gerar um relatório simples de entradas e saídas de doações.
- **Risco crítico de perda de dados:** Por não haver backup automático ou versionamento centralizado, **há alto risco de perda total do histórico** em caso de falha no computador de um coordenador. Um incidente recente causou a perda do registro de 30 doações.
- **Inconsistência e retrabalho:** Com 10 voluntários utilizando versões diferentes da planilha, é comum haver **duplicidade de registros** (ex.: mesmo doador cadastrado duas vezes) ou **informações contraditórias** (ex.: saldo de ração diferente em duas planilhas).
- **Dificuldade de rastreabilidade:** A ONG não consegue responder rapidamente perguntas essenciais como: *"Qual doador contribuiu mais no último mês?"* ou *"Quantos animais foram beneficiados com medicamentos em março?"*. A busca manual por esses dados pode levar **mais de 2 horas por consulta**.
- **Falta de transparência para doadores:** Não é possível gerar automaticamente um comprovante ou relatório de impacto para enviar aos doadores, o que reduz a confiança e a possibilidade de engajamento.

**Solução Esperada:**
Desenvolver um sistema web centralizado e de baixo custo (acessível via celular ou computador) que permita o cadastro único de doadores, beneficiários e itens, além do registro em tempo real de doações e distribuições. O sistema deve gerar relatórios automáticos (entradas, saídas, saldo por tipo de item) e oferecer consultas rápidas por período, doador ou animal beneficiado, eliminando o uso de planilhas concorrentes e garantindo a integridade e rastreabilidade dos dados.

---

## 2. Requisitos do Sistema

### 2.1 Requisitos Funcionais (RF)

| ID | Ator | Descrição | Prioridade |
|----|------|-----------|------------|
| RF1 | Coordenador | Cadastrar doador com nome, CPF, e-mail, telefone e endereço. | Must Have |
| RF2 | Coordenador/Voluntário | Registrar doação recebida contendo: data, tipo de item, quantidade, descrição e vínculo com um doador. | Must Have |
| RF3 | Coordenador/Voluntário | Registrar distribuição de item para um beneficiário (animal/responsável), incluindo data, item, quantidade e observações. | Must Have |
| RF4 | Coordenador/Voluntário | Consultar estoque atual de cada item (ração, medicamentos, itens de higiene) com quantidade disponível. | Must Have |
| RF5 | Coordenador | Cadastrar beneficiário (animal) com nome, espécie, idade, condição de saúde e responsável (protetor). | Must Have |
| RF6 | Coordenador | Gerar relatório mensal de entradas (doações) vs saídas (distribuições) por categoria de item. | Must Have |
| RF7 | Sistema | Validar unicidade de CPF no cadastro de doadores (impedir duplicidade). | Must Have |
| RF8 | Coordenador/Voluntário | Autenticar-se no sistema utilizando e-mail e senha, com perfis distintos. | Must Have |
| RF9 | Coordenador | Cadastrar, editar e remover voluntários, definindo permissões de acesso. | Must Have |
| RF10 | Coordenador | Filtrar doações por período (data inicial e final) e por tipo de item. | Should Have |
| RF11 | Coordenador | Exportar relatório de doações e distribuições em formato CSV ou PDF. | Should Have |
| RF12 | Coordenador | Visualizar dashboard com indicadores principais: total de doações no mês, itens mais doados, beneficiários atendidos, desempenho por voluntário. | Should Have |
| RF13 | Coordenador/Voluntário | Buscar doador por nome ou CPF de forma rápida (autocomplete ou busca textual). | Should Have |
| RF14 | Coordenador | Gerar comprovante simples de doação (nome do doador, itens, data) para envio ao doador. | Could Have |
| RF15 | Sistema | Registrar log de todas as operações (quem cadastrou/alterou/removeu o quê e quando), permitindo ao coordenador auditar ações dos voluntários. | Could Have |
| RF16 | Coordenador | Visualizar relatório de atividades por voluntário (quantas doações/distribuições cada voluntário registrou no período). | Could Have |

### 2.2 Requisitos Não Funcionais (RNF)

| ID | Categoria | Descrição e Critério Mensurável |
|----|-----------|----------------------------------|
| RNF1 | Usabilidade | Interface em português brasileiro; voluntário novo registra doação em menos de **1 minuto**. |
| RNF2 | Performance | Consultas e registros respondem em menos de **2 segundos** em conexão 4G. |
| RNF3 | Performance | Estoque consultado em menos de **1 segundo** (até 1.000 registros históricos). |
| RNF4 | Disponibilidade | Sistema disponível **99% do tempo** em horário comercial (8h-18h, segunda a sábado). |
| RNF5 | Segurança | Senhas armazenadas com **hash bcrypt**; sessão expira após **15 minutos** de inatividade. |
| RNF6 | Compatibilidade | Funciona em **Chrome, Firefox e Safari** (últimas 2 versões), desktop e mobile. |
| RNF7 | Confiabilidade | Backup automático **diário**, mantendo últimas 7 versões; recuperação em até **2 horas**. |
| RNF8 | Portabilidade | Funciona em hospedagem compartilhada **PHP 8+ e MySQL 5.7+** (sem software proprietário). |

### 2.3 Priorização MoSCoW

| Categoria | Requisitos |
|-----------|------------|
| **Must Have** (9 itens) | RF1, RF2, RF3, RF4, RF5, RF6, RF7, RF8, RF9 |
| **Should Have** (4 itens) | RF10, RF11, RF12, RF13 |
| **Could Have** (3 itens) | RF14, RF15, RF16 |
| **Won't Have** | App mobile nativo, integração com pagamento, chat, mapa, IA |

---

## 3. Modelo Entidade-Relacionamento (MER)

### Entidades do Sistema

| Entidade | Descrição | Principais Atributos |
|----------|-----------|----------------------|
| **Usuario** | Coordenador e voluntários | id_usuario, nome, email, senha_hash, perfil, ativo |
| **Doador** | Pessoas que doam itens | id_doador, nome, cpf, email, telefone, endereco |
| **Beneficiario** | Animais atendidos pela ONG | id_beneficiario, nome, especie, idade, condicao_saude, responsavel |
| **Categoria_Item** | Classificação dos itens | id_categoria, nome, descricao |
| **Item** | Produtos doados (ração, medicamento, etc.) | id_item, nome, descricao, id_categoria, unidade_medida |
| **Estoque** | Quantidade disponível de cada item | id_estoque, id_item, quantidade, quantidade_minima |
| **Doacao** | Registro de doações recebidas | id_doacao, id_doador, id_item, quantidade, data_doacao, status |
| **Distribuicao** | Registro de distribuições para beneficiários | id_distribuicao, id_beneficiario, id_item, quantidade, data_distribuicao |
| **Log_Auditoria** | Histórico de ações dos usuários | id_log, id_usuario, acao, tabela_afetada, dados_anteriores, dados_novos |

### Relacionamentos Principais

- Usuario (1) --- (N) Doacao (um usuário registra muitas doações)
- Usuario (1) --- (N) Distribuicao (um usuário registra muitas distribuições)
- Doador (1) --- (N) Doacao (um doador faz muitas doações)
- Beneficiario (1) --- (N) Distribuicao (um beneficiário recebe muitas distribuições)
- Item (1) --- (N) Doacao (um item aparece em muitas doações)
- Item (1) --- (N) Distribuicao (um item aparece em muitas distribuições)
- Item (1) --- (1) Estoque (um item tem um registro de estoque)
- Categoria_Item (1) --- (N) Item (uma categoria contém muitos itens)

---

## 4. Validação e Riscos

### 4.1 Checklist de Coerência

| Verificação | Status |
|-------------|--------|
| Cada RF tem um caso de uso correspondente? | ✅ OK |
| Cada caso de uso tem ao menos uma tela nos wireframes? | ✅ OK |
| A stack tecnológica atende os RNFs? | ✅ OK |
| O MVP é viável com a arquitetura escolhida? | ✅ OK |
| Os atributos do MER aparecem nos formulários? | ✅ OK |

### 4.2 Validação com o Stakeholder

**Data:** 22/06/2026 | **Stakeholder:** Representante da ONG PetsHelp

**Pergunta-chave:** *"Se tivéssemos apenas 2 meses e 1 desenvolvedor, qual funcionalidade é inegociável?"*

**Resposta:** *"O registro de doações e a consulta de estoque são inegociáveis. O cadastro de beneficiários também é essencial."*

**Alterações resultantes:**
- RF6 (Relatório mensal) mantido como Must Have, com escopo reduzido
- RF5 (Cadastrar beneficiário) confirmado como Must Have
- Sugestão: adicionar campo "validade" em medicamentos (futuro)

### 4.3 Riscos Identificados

| Risco | Mitigação |
|-------|-----------|
| Técnico - Stack nova para o aluno | Reservar 2 semanas iniciais para aprendizado |
| Escopo - MVP grande para 1 semestre | Revisar MoSCoW periodicamente |
| Hospedagem - Limitações de plano gratuito | Usar hospedagem paga de baixo custo |
| Dados - Sem backup automatizado | Configurar dump diário do banco |

---

## 5. Anexos

- Diagrama de Casos de Uso: `diagrama-casos-uso.png`
- Wireframes: pasta `/docs/wireframes/`
- Script SQL: `/database/schema.sql`
- Arquivo .env.example: raiz do projeto
- README.md: raiz do projeto