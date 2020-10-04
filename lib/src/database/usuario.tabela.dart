
 class TabelaUsuario  {

  String nomeTabela;
  String id;
  String nome;
  String email;
  String dataNascimento;
  String cpf;
  String cep;
  String estado;
  String cidade;
  String bairro;
  String rua;
  String numero;
  String senha;

  TabelaUsuario({
    
    this.nomeTabela = "USUARIOS",
    this.nome = "nome",
    this.id = "id",
    this.email = "email",
    this.dataNascimento = "dataNascimento",
    this.cpf = "cpf",
    this.cep = "cep",
    this.estado = "estado",
    this.cidade = "cidade",
    this.bairro = "bairro",
    this.rua = "rua",
    this.numero = "numero",
    this.senha = "senha",
  });
}

