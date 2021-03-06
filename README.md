# Desafio Fretadão

## Instalação

Para a inicialização da aplicação é importante ter instalado o [docker](https://docs.docker.com/engine/install/debian/) e o [docker-compose](https://docs.docker.com/compose/install/) no seu sistema.

Posteriormente, inclua as configurações necessárias no arquivo ```env```, inserindo seu bitly token para permitir o encurtamento de url. Para saber como conseguir um token no bitly, acesse [aqui](https://support.bitly.com/hc/en-us/articles/230647907-How-do-I-generate-an-OAuth-access-token-for-the-Bitly-API-).

Configurado todo o processo, para inicializar a aplicação, execute:

```
sudo docker-compose up
```

Após esse processo, ao instalar todos as gems necessárias e subir os containers do banco de da aplicação, ela será inicializada na porta **3000**, podendo ser localmente acessada em http://localhost:3000/

## Testes

Para executar os testes, entre dentro do container e execute:

```
rails test
```

## Solução

Optei por utilizar o framework Ruby on Rails para o desenvolvimento do sistema com algumas gems que poderiam me auxiliar a atingir as metas propostas, não fazendo uso do desenvolvimento de uma api em Rails em conjunto com um front end desacoplado. As gems adicionais utilizadas para o desenvolvimento do sistema foram:

* pg - banco de dados Postgresql em conjunto com a _gem_ pg_search aprimorar a eficiencia no filtro dos perfis a partir das informações inseridas pelo usuário.
* pg_search - gem para obter vantagens na pesquisa de buscas por ocorrências em alguma String, utilizando o método search_by_term, ele consegue fazer uma query com uma performance superior de um texto filtrando de forma generalizada, sem necessitar da especificação do atributo relacionado.
* bitly - API para encurtamento de urls. Não houve uma justificativa de utilização além de ter sido citada nas instruções do desafio e de eu já ter utilizado o sistema web deles.

### Tecnicas utilizadas

Não são muitas mas tentei me atentar em alguns pontos que poderiam ser interessantes.

1. Aplicar boas práticas no desenvolvimento do sistema

* Como não tinha muita experiência em relação a boas práticas mais específicas para desenvolvimento rails, tentei me guiar um pouco a partir [deste handbook](https://github.com/infinum/rails-handbook/blob/master/Development%20practices/__Other%20important%20guidelines.md) no desenvolvimento do desafio. Os pontos principais foram a ideia principal de respeitar a arquitetura MVC para que a View não interaja diretamente com a Model, apenas sob a supervisão da controller que gerencia esses processos, além da não utilização de variáveis instanciadas dentro da _partials_, apenas passadas como parâmetros através do _locals_.

2. Reaproveitar código o máximo possível

* provavelmente não cheguei a aplicar no sistema como um todo, só que tentei me preocupar em relação a repetição de código, se havia necessidade ou não de instanciar um objeto mais de uma vez, entre outros pontos. Em relação a realizar várias instancias de um objeto que talvez não havia necessidade eu posso referenciar a criação do _client_ para a utilização da API do Bitly para o encurtamento das URLs. Para não criar um _client_ toda vez em que eu registro um novo usuário, eu procurei implementar o padrão Singleton para manter apenas uma instância do _client_ para ser reutilizada toda vez em que o usuário registre um novo perfil.
* outro ponto foi uma utilização de _partials_ para utilização em várias páginas do sistema, generalizando tanto a _partial_ ```_search``` quanto a partial ```_form```, passando todos as variáveis locais diretamente para as _partials_, aplicando uma das boas práticas citadas no ponto 1 das técnicas utilizadas.

### Limitações

O sistema em si não possui muitas funcionalidades, porém tem alguns pontos importantes de se levantar a respeito sobre suas limitações:

* A busca foi limitada a somente alguns campos do perfil: nome, username do github, organização e localização. Realizando a pesquisa de algum desses campos o sistema deve retornar os perfis relacionados.

* Não tem uma aplicação direta de JavaScript no sistema, deixando ele bem cru com HTML e CSS.

* Está faltando o desenvolvimento de alguns testes e a aplicação de algum sistema que consiga medir a cobertura de código da aplicação como um todo.

### Pontos de Melhoria

O sistema no geral precisa de algumas melhorias, tanto na parte do front end na disposição dos componentes quanto no backend em relação a melhora do código em si, tratamento mais adequado de excessões e testes mais elaborados, procurando cobrir tanto os "caminhos felizes" quanto também os "caminhos tristes". Logo, para orientar melhor em alguns pontos de melhoria que poderiam ser aplicados, é importante:

1. Muito código CSS poderia ser generalizado para ser melhor reutilizado, não havendo a necessidade de uma duplicação frequente no código, principalmente na questão de redimensionamento dos componentes.

2. Provavelmente deve haver melhores maneiras de conseguir filtrar efetivamente as informações dos perfis na página do github, podendo haver uma melhora nesse quesito também.

3. Tanto a validação dos campos da model de profile quanto o desenvolvimento do método de query poderiam ser mais robustos. No projeto, procurei fazer de uma maneira mais simples (principalmente na validação em regex das urls) para que conseguisse demandar mais tempo para outros pontos.

4. Desenvolvimento de testes mais robusto, procurando cobrir tanto os caminhos felizes quanto os caminhos tristes. Além disso, tentei colocar a gem **simplecov** para medir a cobertura dos testes que eu cheguei a desenvolver mas não consegui configurar corretamente, e acabei deixando de lado para dar foco na finalização do desafio.

5. Alguns commits não foram muito claros no que foi feito, principalmente no início do desenvolvimento, onde ficou um pouco confuso o que cada commit fazia e/ou se ele fazia apenas o especificado.

6. Uso mesclado de tags html e métodos rails para um tipo de objeto, como para as imagens, por exemplo. Padronizar um tipo só ficaria mais agradável na leitura.