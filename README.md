# **Weather app para a TDS Company.** 🚀

   Olá, espero que estejas bem. 
   
   Este é o retorno do desafio mobile proposto pela TDS Company, para a criação de um aplicativo mobile de condições climáticas de cidades escolhidas. A linguagen que escolhi para ao desenvolvimento foi *Swift*.

---
# **Code Architecture:**

O projeto segue os princípios do *Clean Architecture*, com a estrutura organizada em camadas para promover escalabilidade, manutenibilidade e testabilidade:

**Views:** Responsáveis pela construção da interface, utilizando SwiftUI para renderização declarativa.

**ViewModels:** Contêm a lógica de apresentação e fazem a comunicação com a camada de dados.

**Models:** Representações dos dados, como City e WeatherData.

**Managers:** Responsáveis por obter dados da API e gerenciar a lógica de rede.

**Modifiers:** Modificadores personalizados do SwiftUI para aplicar estilos reutilizáveis.

**Resources:** Contém imagens e outros recursos estáticos.

A comunicação entre as camadas é feita de forma clara, e o uso de **@ObservedObject** permite a atualização reativa das views.
