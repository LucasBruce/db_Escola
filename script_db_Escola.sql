create table if not exists tbl_coordenacao(
  id_coordenacao smallint primary key auto_increment,
  nome_coordenacao char(10) not null,
  turno char(10) not null
);

create table if not exists tbl_tipo_logradouro(
  id_tipo_logradouro smallint primary key auto_increment,
  tipo_logradouro char(15) not null
);

create table if not exists tbl_tipo_telefone(
  id_tipo_telefone smallint primary key auto_increment,
  tipo_telefone char(10)
);
	
create table if not exists tbl_professor(
  id_professor smallint primary key auto_increment,
  nome_professor char(20) not null,
  sobrenome_professor char(20) not null,
  status_professor tinyint not null,
  id_coordenacao smallint not null,
  constraint fk_id_coordenacao_tbl_professor foreign key (id_coordenacao)
    references tbl_coordenacao (id_coordenacao)
);

create table if not exists tbl_disciplina(
  id_disciplina smallint primary key auto_increment,
  nome_disciplina char(20) not null,
  descricao varchar(100) null,
  carga_horaria smallint not null,
  id_coordenacao smallint not null,
  constraint fk_id_coordenacao_tbl_disciplina foreign key (id_coordenacao)
    references tbl_coordenacao(id_coordenacao)
);

create table if not exists tbl_disciplina_professor(
  id_professor smallint not null,
  id_disciplina smallint not null,
  primary key(id_professor, id_disciplina),
  constraint fk_id_professor_tbl_disciplina_professor foreign key(id_professor)
    references tbl_professor(id_professor),
  constraint fk_id_disciplina_tbl_disciplina_professor foreign key(id_disciplina)
    references tbl_disciplina(id_disciplina)
);

create table if not exists tbl_serie(
  id_serie smallint primary key auto_increment,
  id_coordenacao smallint not null,
  ano_serie char(10) not null,
  quantidade_turma smallint not null,
  id_serie_depende smallint not null,
  constraint fk_id_coordenacao_tbl_serie foreign key(id_coordenacao)
    references tbl_coordenacao(id_coordenacao),
  constraint fk_id_serie_depende_tbl_serie foreign key(id_serie_depende)
    references tbl_serie(id_serie)
);

create table if not exists tbl_disciplina_serie(
  id_serie smallint not null,
  id_disciplina smallint not null,
  primary key(id_serie, id_disciplina),
  constraint fk_id_serie_tbl_disciplina_serie foreign key(id_serie)
    references tbl_serie(id_serie),
  constraint fk_id_disciplina_tbl_disciplina_serie foreign key(id_disciplina)
    references tbl_disciplina(id_disciplina)
);

create table if not exists tbl_turma(
  id_turma smallint primary key auto_increment,
  id_serie smallint not null,
  classificacao char(1) not null,
  semestre char(20) not null,
  data_inicio date not null,
  data_final date not null,
  numero_aluno smallint not null,
  constraint fk_id_serie_tbl_turma foreign key(id_serie)
    references tbl_serie(id_serie)
);

create table if not exists tbl_aluno(
  ra smallint primary key auto_increment,
  id_serie smallint not null,
  nome_aluno varchar(30) not null,
  sobrenome_aluno varchar(50) not null,
  sexo char(1) not null,
  id_turma smallint not null,
  cpf char(14) not null,
  status_aluno tinyint not null,
  nome_mae varchar(20) not null,
  nome_pai varchar(20) null,
  whatsapp varchar(11) null,
  email varchar(40) not null,
  constraint fk_id_turma_tbl_aluno foreign key(id_turma)
    references tbl_turma(id_turma),
  constraint fk_id_serie_tbl_aluno foreign key(id_serie)
    references tbl_serie(id_serie)
);

create table if not exists tbl_endereco_aluno(
  id_endereco_aluno smallint primary key auto_increment,
  ra smallint not null,
  id_tipo_logradouro smallint not null,
  complemento varchar(20) not null,
  nome_rua varchar(50) not null,
  cep char(9) not null,
  constraint fk_ra_tbl_endereco_aluno foreign key(ra)
    references tbl_aluno(ra),
  constraint fk_id_tipo_logradouro_tbl_endereco_aluno foreign key(id_tipo_logradouro)
    references tbl_tipo_logradouro(id_tipo_logradouro)
);

create table if not exists tbl_telefone_aluno(
  id_telefone_aluno smallint primary key auto_increment,
  ra smallint not null,
  id_tipo_telefone smallint not null,
  telefone varchar(9),
  constraint fk_ra_tbl_telefone_aluno foreign key(ra)
    references tbl_aluno(ra),
  constraint fk_id_tipo_telefone_tbl_telefone_aluno foreign key(id_tipo_telefone)
    references tbl_tipo_telefone(id_tipo_telefone)
);

create table if not exists tbl_disciplina_aluno(
  id_disciplina smallint not null,
  ra smallint not null,
  primary key (id_disciplina, ra),
  constraint fk_id_disciplina_tbl_disciplina_aluno foreign key(id_disciplina)
    references tbl_disciplina(id_disciplina),
  constraint fk_ra_tbl_disciplina_aluno foreign key(ra) 
    references tbl_aluno(ra)
);

create table if not exists tbl_historico(
  id_historico smallint primary key auto_increment,
  data_inicial date not null,
  data_final date not null,
  ra smallint not null,
  constraint fk_ra_tbl_historico foreign key(ra)
    references tbl_aluno(ra)
);

create table if not exists tbl_disciplina_historico(
  id_historico smallint not null,
  id_disciplina smallint not null,
  nota float not null,
  freguencia smallint not null,
  primary key(id_historico, id_disciplina),
  constraint fk_id_historico_tbl_disciplina_historico foreign key(id_historico)
   references tbl_historico(id_historico),
  constraint fk_id_disciplina_tbl_disciplina_historico foreign key(id_disciplina)
   references tbl_disciplina(id_disciplina)
);

create table if not exists tbl_historico_serie(
  id_historico smallint not null,
  id_serie smallint not null,
  primary key (id_historico, id_serie),
  constraint fk_id_historico_tbl_historico_serie foreign key(id_historico)
    references tbl_historico(id_historico),
  constraint fk_id_serie_tbl_historico_serie foreign key(id_serie)
    references tbl_serie(id_serie)
);