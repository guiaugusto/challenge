# Desafio Fretadão

## Instalação

Primeiramente, o sistema foi desenvolvido com o [Ruby](https://rvm.io/) na versão **2.7.0p0** e o Rails na versão **6.0.3.2**, em conjunto com o banco de dados [Postgresql](https://www.postgresql.org/download/linux/debian/) na versão **11.7**.

Para inicializar a execução do sistema, é necessário executá-lo localmente, após a instalação das versões especificadas anteriormente. Para isso, primeiramente clone o projeto e entre dentro da pasta clonada:

```bash
git clone https://github.com/guiaugusto/challenge
cd challenge
```

Após estes passos iniciais, é importante instalar todas as _gems_ utilizadas no projeto. Para isso, execute o seguinte comando:

```bash
bundle install
```

Para inicializar o sistema, simplesmente execute:

```bash
rails server
```

Após esse processo, o sistema será inicializado na porta **3000**, podendo ser localmente acessada em http://localhost:3000/
