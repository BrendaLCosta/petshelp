# Diagrama de Casos de Uso - PetsHelp System



## Diagrama Entidade-Relacionamento (MER)

![Diagrama MER do PetsHelp](mer-petshelp.png)

*Figura 1: Diagrama Entidade-Relacionamento do sistema PetsHelp com 5 entidades principais.*

---

## Descri��o Geral

O diagrama de casos de uso representa as intera��es entre os atores (Coordenador e Volunt�rios) e as funcionalidades do sistema PetsHelp. O sistema possui dois perfis de usu�rio com n�veis de permiss�o distintos.

## Atores

| Ator | Descri��o |
|------|-----------|
| **Coordenador** | Respons�vel m�ximo pela ONG. Possui acesso total a todas as funcionalidades do sistema, incluindo cadastros, relat�rios e gest�o de volunt�rios. |
| **Volunt�rio** | Membro da equipe operacional (10 volunt�rios). Pode registrar doa��es e distribui��es, consultar estoque e buscar informa��es, mas n�o pode cadastrar ou excluir dados mestres. |
| **Sistema** | Ator n�o humano respons�vel por valida��es autom�ticas (CPF �nico, autentica��o, logs). |

## Casos de Uso por M�dulo

### M�dulo de Autentica��o
| ID | Caso de Uso | Atores | Descri��o |
|----|-------------|--------|-----------|
| UC01 | Autenticar usu�rio | Coordenador, Volunt�rio | Realizar login com e-mail e senha. Sistema valida credenciais e redireciona conforme perfil. |

### M�dulo de Cadastros (Coordenador)
| ID | Caso de Uso | Atores | Descri��o |
|----|-------------|--------|-----------|
| UC02 | Cadastrar doador | Coordenador | Inserir dados do doador: nome, CPF, e-mail, telefone, endere�o. |
| UC03 | Editar doador | Coordenador | Atualizar informa��es de um doador existente. |
| UC04 | Remover doador | Coordenador | Excluir (ou inativar) um doador do sistema. |
| UC05 | Cadastrar benefici�rio | Coordenador | Inserir dados do animal: nome, esp�cie, idade, condi��o de sa�de, respons�vel. |
| UC06 | Editar benefici�rio | Coordenador | Atualizar informa��es de um animal cadastrado. |
| UC07 | Remover benefici�rio | Coordenador | Excluir (ou inativar) um benefici�rio do sistema. |
| UC08 | Cadastrar item | Coordenador | Inserir novo item (ra��o, medicamento, higiene) com nome, categoria e unidade. |
| UC09 | Editar item | Coordenador | Atualizar informa��es de um item existente. |
| UC10 | Gerenciar volunt�rios | Coordenador | Cadastrar, editar ou remover volunt�rios, definindo permiss�es de acesso. |

### M�dulo de Registros (Coordenador e Volunt�rio)
| ID | Caso de Uso | Atores | Descri��o |
|----|-------------|--------|-----------|
| UC11 | Registrar doa��o | Coordenador, Volunt�rio | Registrar entrada de doa��o: data, item, quantidade, doador, descri��o. |
| UC12 | Registrar distribui��o | Coordenador, Volunt�rio | Registrar sa�da de item para benefici�rio: data, item, quantidade, benefici�rio, observa��es. |
| UC13 | Consultar estoque | Coordenador, Volunt�rio | Visualizar quantidade dispon�vel de cada item com alerta de estoque baixo. |

### M�dulo de Consultas e Relat�rios (Coordenador)
| ID | Caso de Uso | Atores | Descri��o |
|----|-------------|--------|-----------|
| UC14 | Buscar doador | Coordenador, Volunt�rio | Pesquisar doador por nome ou CPF com autocomplete. |
| UC15 | Filtrar doa��es | Coordenador | Filtrar doa��es por per�odo, item ou doador. |
| UC16 | Gerar relat�rio mensal | Coordenador | Gerar relat�rio consolidado de entradas vs sa�das por categoria. |
| UC17 | Exportar dados | Coordenador | Exportar relat�rios em formato CSV ou PDF. |
| UC18 | Visualizar dashboard | Coordenador | Visualizar indicadores: total de doa��es, itens mais doados, benefici�rios atendidos. |
| UC19 | Relat�rio por volunt�rio | Coordenador | Visualizar produtividade de cada volunt�rio (quantas a��es registrou). |

### M�dulo de Auditoria (Coordenador)
| ID | Caso de Uso | Atores | Descri��o |
|----|-------------|--------|-----------|
| UC20 | Gerar comprovante | Coordenador | Emitir comprovante de doa��o para enviar ao doador. |
| UC21 | Visualizar logs | Coordenador | Consultar hist�rico de opera��es realizadas no sistema (auditoria). |

### Valida��es Autom�ticas (Sistema)
| ID | Caso de Uso | Atores | Descri��o |
|----|-------------|--------|-----------|
| UC22 | Validar CPF �nico | Sistema | Impedir cadastro de doador com CPF j� existente no sistema. |
| UC23 | Validar e-mail �nico | Sistema | Impedir cadastro de doador ou usu�rio com e-mail duplicado. |
| UC24 | Registrar log autom�tico | Sistema | Registrar todas as a��es dos usu�rios para auditoria. |
| UC25 | Backup autom�tico | Sistema | Realizar backup di�rio do banco de dados. |
| UC26 | Expirar sess�o | Sistema | Encerrar sess�o ap�s 15 minutos de inatividade. |

## Diagrama Visual

![Diagrama de Casos de Uso - PetsHelp](./diagrama-casos-uso.png)

