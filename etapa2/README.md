# Etapa 2 – Diagrama de Classes Inicial

Nesta etapa foi elaborado o **diagrama de classes UML** representando os principais elementos do sistema de monitoramento agrícola com drones.

---

## 📌 Diagrama de Classes

![Diagrama de Classes](./diagrama_classes.png)

---

## 📌 Classes Principais

- **Usuario** → representa administradores e operadores (atributos: nome, login, senha, perfil).  
- **AreaAgricola** → define tamanho, localização e tipo de cultivo.  
- **Drone** → identifica cada drone, seu status, sensores disponíveis e nível de bateria.  
- **Missao** → armazena informações sobre o agendamento e execução dos voos.  
- **DadosColetados** → dados de sensores e imagens obtidos durante a missão.  
- **Relatorio** → consolida os resultados das missões para análise.

---

## 📌 Relacionamentos

- Um **Usuário** pode criar várias missões.  
- Uma **Área Agrícola** pode estar vinculada a várias missões.  
- Um **Drone** pode executar várias missões, mas apenas uma por vez.  
- Uma **Missão** gera vários **DadosColetados** e ao menos um **Relatório**.
