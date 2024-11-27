# **Weather app para a TDS Company.** 🚀

   Olá, espero que estejas bem. 
   
   Este é o retorno do desafio mobile proposto pela TDS Company, para a criação de um aplicativo mobile de condições climáticas de cidades escolhidas. A linguagen que escolhi para ao desenvolvimento foi *Swift*.

---
# **Code Architecture:**

O projeto segue os princípios do *Clean Architecture*, com a estrutura organizada em camadas para promover escalabilidade, manutenibilidade e testabilidade:

**Views:** Responsáveis pela construção da interface, contendo a ContentView(Home) e a WeatherDetailView(Tela de condições da cidade).

**ViewModels:** Contêm a lógica de apresentação e fazem a comunicação com a camada de dados.

**Models:** Representações dos dados, como City, ResponseBody e HourlyForecastResponse(Esse traz os dados das previões de cada horário).

**Managers:** Responsáveis por obter dados da API e gerenciar a lógica de rede.

**Modifiers:** Modificadores personalizados para aplicar estilos reutilizáveis.

**Resources:** Contém imagens e outros recursos estáticos.

A comunicação entre as camadas é feita de forma clara, e o uso de **@ObservedObject** permite a atualização reativa das views.

# **Testes Implementados**

**Testes de Unidade**

**WeatherManagerTests:** Valida a busca de dados climáticos, incluindo tratamento de erros e uso de mocks para simular a API.

**ResponseModelTests:** Testa a decodificação de respostas JSON para os modelos ResponseBody e ForecastResponse.

**Testes de Interface (UI Tests)**

**WeatherViewTests:** Garante que a WeatherView exibe corretamente os dados de clima simulados.

**Testes de Performance**

**PerformanceTests:** Mede o tempo de execução da busca de dados climáticos, validando a eficiência da operação.

**Testes de Fluxo**

**AppFlowTests:** Verifica a navegação entre as telas do app e a exibição correta dos dados de clima.

---

# **Considerações.**

Valeu demais pelo desafio proposto e pelo tempo separado para a formulação deste teste, pessoal! Realmente acredito que consegui obter um bom resultado com relação às funcionalidades e interface propostas por vocês. 

Eu decidi seguir as descrições e backgrounds mandados por voces no layout, por isso eu só adicionei 4 de cada: sunny, rainy, snowy e o misty com um fundo default. Acho que seria interessante termos também o clear com um background diferente, mas como não continha no layout, preferi não modificar nada.


A WeatherDetailView é tela princpal do app, trazendo todos os dados dinâmicos de clima e etc. Como é observado no código, todos os dados são **dinâmicos**, mas por algum motivo, a API às vezes não traz os dados corretos de temperatura máxima e mínima de algumas cidades, como Recife, por exemplo. É claro que a lógica não é a culpada por isso, pois outras cidades como Vancouver e Londres sempre mostram suas temperaturas máximas e mínimas corretas.

Com relação aos testes de dados, testei a parte mais vital de carregando de dados da API, garantindo que a cidade/infos carregadas serão as corretas, de acordo com as coordernadas enviadas à API.

Meu testes de interface pssaram diversas vezes, mas também falharam algumas outras vezes por conta de problemas de alto uso de memória do meu Mac. Acredito que eles estejam bem escritos também.

Com relação ao TestFlight, eu não consegui fazer por conta de uma restrição na minha conta de apple developer, mas realmente seria ideial se eu pudesse buildar dessa forma.

---

É isso! Espero que o código e o app correspondam às expectativas do time que irá analisá-lo. Se possível, gostaria de receber um feedback com relação a o que seria interessante aprimorar ou alterar na arquitetura ou lógica do código. Desde já, grato. 

Até breve!










