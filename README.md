# Capital Gains

Recebe uma lista de transações e retorna o valor das taxas de cada transação.

## Dependências

Possuir o ruby instalado na versão 3.2.3 ou superior

```bash
ruby -v 
# ruby 3.2.3
```

## Como rodar o projeto

Rode o comando abaixo no seu terminal, e insira os inputs para calcular a taxa:

```
ruby cli.rb
```

<img width="240" src="docs/cli.gif"/>

**Dica:** Para finalizar o processo, basta apertar Enter sem nenhuma informação.


## Como rodar os testes

Rode o comando abaixo no seu terminal:

```
ruby tests/test_capital_gains_json.rb
```

## Coisas que gostaria de melhorar :D

- Foi criado a interface "capital_gains_cli" para atender ao cli, fazendo com que a implementação não fique presa a interface do usuário (cli, web, desktop, whatever); porém, poderia ter ficado mais bonitinho e organizado.
- Poderia ter criado uma pastinha para ficar os testes
- As classes Wallet e Transactions::CalculateTax ficaram com excesso de responsabilidade
- Adicionar instruções no command line, explicando como utilizar