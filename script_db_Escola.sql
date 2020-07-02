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

