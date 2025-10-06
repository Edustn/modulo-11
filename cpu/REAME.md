# 💻 CPU de 8 Bits: Arquitetura e Implementação Digital

## 🎯 Visão Geral do Projeto

Este projeto consiste no desenvolvimento e na demonstração funcional de uma **Unidade Central de Processamento (CPU) de 8 bits**, criada a partir de componentes digitais em um ambiente de simulação.

O principal objetivo é aplicar e validar conceitos de **Arquitetura de Computadores e Organização Digital**, ilustrando o fluxo de dados e o ciclo de instrução de um processador.

## ✨ Conjunto de Instruções (ISA) e Funcionalidades

A CPU foi projetada com um conjunto de instruções (ISA) focado em operações aritméticas e lógicas essenciais.

| Categoria | Operações Suportadas | Descrição |
| :--- | :--- | :--- |
| **Aritméticas** | **Soma**, **Subtração**, **Multiplicação**, **Divisão** | Implementação das quatro operações fundamentais. |
| **Unárias** | **Incremento (INC)** e **Decremento (DEC)** | Alteração do valor de um registrador em +1 ou -1. |
| **Lógicas** | **AND, OR, NOT** | *(Caso tenha implementado, adicione aqui. São comuns em CPUs.)* |
| **Controle** | *Sugestão:* **JUMP, HALT** | *Se houver controle de fluxo ou parada, inclua.* |

## 🛠️ Tecnologias e Implementação

A CPU foi construída e testada integralmente no seguinte ambiente:

* **Emulador de Hardware:** **Digital**
    * *Nota:* O emulador **Digital** foi escolhido por sua interface intuitiva e a vasta biblioteca de componentes de hardware, o que permitiu a montagem e o teste de um sistema complexo, como esta CPU de 8 bits.

## 🏗️ Arquitetura da CPU

A CPU segue uma arquitetura baseada nos principais blocos lógicos. O design foi segmentado para garantir modularidade e clareza.

* **Unidade de Lógica Aritmética (ULA):** Responsável por executar todas as operações matemáticas (Soma, Subtração, Multiplicação, Divisão) e lógicas.
* **Banco de Registradores:** Armazenamento temporário de dados e endereços (e.g., Registrador de Dados A, B, Contador de Programa - PC).
* **Unidade de Controle (UC):** O "cérebro" da CPU. Gerencia o fluxo de instruções, gerando os sinais de controle necessários para orquestrar a ULA e o Banco de Registradores em cada passo do ciclo de execução.
* **Memória (RAM/ROM):** *Se houver,* inclua a capacidade de memória e como o Contador de Programa interage com ela.

## ⚙️ Como Executar o Projeto

Para visualizar ou modificar o projeto, siga os passos abaixo:

1.  **Pré-requisito:** Baixe e instale o emulador de hardware **Digital (ou Logisim)**.
2.  **Clone o Repositório:**
    ```bash
    git clone https://github.com/Edustn/modulo-11/tree/main/cpu
    ```
3.  **Abra o Projeto:** No emulador Digital, abra o arquivo principal do circuito, `CPU.dig`.
4.  **Teste:** A paerte no play para começar a execução do programa.

## 📝 Conclusão (Para a Atividade Ponderada)

A implementação desta CPU de 8 bits alcançou os objetivos propostos ao demonstrar a viabilidade de construir um processador funcional a partir de componentes básicos. O desafio de integrar os módulos (ULA, Registradores e UC) para suportar operações complexas, como a multiplicação e a divisão, foi superado com sucesso, resultando em uma máquina robusta para fins didáticos.

## Vídeo

Abaixo temos um vídeo de demonstração do funcionamento da CPU e explicação de seus componentes.
Link do vídeo: [https://drive.google.com/drive/folders/14nOBi3_ikFJBMDZJRyNp3zDSqFakfXou?hl=pt-br](https://drive.google.com/drive/folders/14nOBi3_ikFJBMDZJRyNp3zDSqFakfXou?hl=pt-br)