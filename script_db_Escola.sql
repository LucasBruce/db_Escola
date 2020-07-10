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

/*inserindo dados para teste*/

insert into tbl_coordenacao(nome_coordenacao, turno)
  values
  ('fundamental I', 'tarde'),
  ('fundamental II', 'manhã');

insert into tbl_tipo_logradouro(tipo_logradouro)
  values
  ('aeroporto'),
  ('alameda'),
  ('área'),
  ('avenida'),
  ('campo'),
  ('rua');

insert into tbl_tipo_telefone(tipo_telefone)
  values
  ('residêncial'),
  ('comercial'),
  ('celular');

insert into tbl_professor(nome_professor, sobrenome_professor, status_professor, id_coordenacao)
  values
  ('Marco', 'Antonio', 1, 2),
  ('Renato', 'Basílio', 0, 2),
  ('Anna', 'Maria', 1, 1);
 
insert into tbl_disciplina(nome_disciplina, descricao, carga_horaria, id_coordenacao)
  values
  ('Matemática', 'Fomentar o raciocínio lógico dos alunos.', '1400h', 2),
  ('História', 'Levar conhecimento sobre a história do mundo.', '1000h', 2),
  ('Português', 'Ensinar os príncipios da língua', '1200h', 1);

insert into tbl_serie(id_coordenacao, ano_serie, quantidade_turma)
  values
  (2, '6º ano', 1),
  (2, '7º ano', 2),
  (1, '5º ano', 0);
 
insert into tbl_disciplina_professor(id_professor, id_disciplina)
  values
  (1, 2),
  (2, 1),
  (3, 3);

insert into tbl_turma(id_serie, classificacao, semestre, data_inicio, data_final, numero_aluno)
  values
  (1, 'a', 'primeiro semestre', '2007-02-15', '2007-11-25', 15),
  (2, 'a', 'primeiro semestre', '2008-02-15', '2008-11-25', 18),
  (2, 'b', 'primeiro semestre', '2008-02-15', '2008-11-25', 20);

insert into tbl_aluno(id_serie, nome_aluno, sobrenome_aluno, sexo,
id_turma, cpf, status_aluno, nome_mae, nome_pai, whatsapp, email)
  values
  (1, 'Alison', 'Fernandes', 'M', 1, '120-188-921-70', 1, 'Maria', 'Antonio', '4563-0679', 'alison_10@yahoo.com'),
  (1, 'yuri', 'Furtado', 'M', 1, '867-123-203-43', 1, 'Angela', 'Steve', '9786-1234',  'yuri_goku@outlook.com'),
  (2, 'Gertrude', 'Otohime', 'F', 2, '576-234-567-60', 1, 'Marina', 'Emerson', '3456-3214', 'gertrude_asd@hotmail.com'),
  (2, 'Gerominia', 'Katsura', 'F', 3, '345-256-098-30', 1, 'Jane', 'Oliveira', '3234-6576', 'gerominia_asdf@gmail.com');
 
insert into tbl_historico(data_inicial, data_final, ra)
  values
  ('2007-02-15', '2010-11-25', 1),
  ('2007-02-15', '2010-11-25', 2),
  ('2008-02-15', '2011-11-25', 3),
  ('2008-02-15', '2011-11-25', 4);
 
insert into tbl_disciplina_historico(id_historico, id_disciplina, nota, freguencia)
  values
  (1, 1, '7.5', 9),
  (2, 3, '5.5', 13),
  (3, 2, '7.0', 12),
  (4, 3, '4.5', 8);

insert into tbl_disciplina_aluno(id_disciplina, ra)
  values
  (1, 1),
  (3, 2),
  (2, 3),
  (3, 4);
  
insert into tbl_disciplina_serie(id_serie, id_disciplina)
  values
  (1, 2),
  (2, 1),
  (3, 3);

insert into tbl_endereco_aluno(ra, id_tipo_logradouro, complemento, nome_rua, cep)
  values
  (1, 2, 'casa', 'Alam. Pereragildo Peragoji', '12374-879'),
  (2, 6, 'apartamento', 'Rua Arnesto argão', '31232-564'),
  (3, 5, 'casa', 'campo Jordão de arapema', '65745-324'),
  (4, 3, 'apartamento', 'Área 51 da silva', '72983-349');
  
insert into tbl_historico_serie(id_historico, id_serie)
  values
  (1, 1),
  (2, 1),
  (3, 2),
  (4, 2);
  
insert into tbl_telefone_aluno(ra, id_tipo_telefone, telefone)
  values
  (1, 3, '4563-0679'),
  (2, 3, '9786-1234'),
  (3, 3, '3456-3214'),
  (4, 3, '3456-3214');
  
/*Consultas testes*/

/*Consulta que traz o nome, telefone, tipo do telefone, nome da rua e tipo do logradouro do aluno*/
select a.nome_aluno, ta.telefone, tt.tipo_telefone, e.nome_rua, tl.tipo_logradouro from tbl_aluno a
inner join tbl_telefone_aluno ta
on a.ra = ta.ra
inner join tbl_tipo_telefone tt
on tt.id_tipo_telefone = ta. id_tipo_telefone
inner join tbl_endereco_aluno e
on a.ra = e.ra
inner join tbl_tipo_logradouro tl
on tl.id_tipo_logradouro = e.id_tipo_logradouro;

