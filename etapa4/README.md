# Etapa 4 – Integração de Modelos (Classes + Banco de Dados)

Esta etapa mostra a integração entre o **modelo de classes UML** e o **modelo relacional no SQLite**.

---

## 📌 Estrutura do Banco (SQLite)

O script completo está no arquivo [`projeto_drones.sql`](./projeto_drones.sql).

Ele cria as seguintes tabelas:

- **usuarios**
- **areas**
- **drones**
- **missoes**
- **dados**
- **relatorios**

Além disso, foram adicionadas restrições de integridade, como:
- **CHECK** em atributos (ex.: status, perfil, bateria).  
- **Chaves estrangeiras** respeitando os relacionamentos UML.  
- **Índice único** para evitar missões sobrepostas no mesmo drone e horário.  

---

## 📸 Evidências (Prints)

- **Estrutura do Banco**  
  ![Database Structure](./print_tabelas.jpg)

- **Usuários cadastrados**  
  ![Usuários](./print_usuarios.jpg)

- **Drones cadastrados**  
  ![Drones](./print_drones.jpg)

- **Missões registradas**  
  ![Missões](./print_missoes.jpg)


---

## 📌 Mapeamento Classes → Tabelas

| Classe UML        | Tabela BD   | Atributos principais                                   | Relacionamentos (FK) |
|-------------------|-------------|--------------------------------------------------------|----------------------|
| **Usuario**       | `usuarios`  | id, nome, login, senha, perfil                         | `missoes.criada_por`, `missoes.executada_por` |
| **AreaAgricola**  | `areas`     | id, tamanho, localizacao, tipo_cultivo                 | `missoes.area_id` |
| **Drone**         | `drones`    | id, status, bateria                                    | `missoes.drone_id` |
| **Missao**        | `missoes`   | id, data_hora, status, sensores_usados                 | FK → `areas`, `drones`, `usuarios` |
| **DadosColetados**| `dados`     | id, imagens, temperatura, umidade, pragas              | FK → `missoes.id` |
| **Relatorio**     | `relatorios`| id, data_geracao                                       | FK → `missoes.id`, `areas.id` |

---

✍️ **Conclusão:**  
Com este mapeamento e a execução do script no SQLite, comprovamos que o **modelo de classes UML** foi corretamente integrado ao **modelo relacional**, garantindo a consistência entre o projeto conceitual e a implementação prática.
