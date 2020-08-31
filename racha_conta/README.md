# racha_conta

App para dividir a conta do restaurante.

## Getting Started

A ideia da aplicação é trazer uma forma simples de dividir igualmente o valor de uma conta de restaurante entre um grupo de pessoas.

O APP consiste em três campos de texto, que pedem informações ao usuário:
- O valor total da conta.
- O valor, em percentual, da comissão dada ao garçom pelo atendimento.
- A quantidade de pessoas dispostas a dividir o valor da conta.

Todos os campos são obrigatórios. Caso um campo esteja em branco na hora de calcular, o APP irá identificar essa ausência e alertar para o usuário em forma de mensagem na tela.

Caso os dados estejam todos preenchidos, é feito o cálculo e é mostrado na tela:
- O valor da comissão calculado.
- O valor a ser pago por pessoa.
- O valor total da conta somado com a comissão do garçom.

O cálculo do valor da comissão é feito da seguinte forma:
-> O valor que consta na nota * (valor percentual da comissão) / 100 = valor calculado da comissão

O cálculo do valor por pessoa é feito da seguinte forma:
-> (O valor calculado da comissão + O valor que consta na nota) / Número de pessoas pagantes

Esse APP tem por prioridade ser avaliado como atividade proposta na disciplina de Laboratório de Desenvolvimento Mobile e foi produzido por Ramon Santos - 3º período de Engenharia de Computação - Noite.

O vídeo de demonstração do APP deve ser acessado pelo link:
https://www.youtube.com/watch?v=RXbvcekxjgs
