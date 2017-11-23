create database pratica5;
create table dados_multimidia (
Codigo int auto_increment not null primary key,
Nome varchar(30), 
Tipo varchar (20),
Dados longblob
);

show variables like "secure_file_priv";

insert into dados_multimidia (Nome, Tipo, Dados) values ( 'PAISAGEM', 'jpg', load_file("C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\flores-3.jpg"));
insert into dados_multimidia (Nome, Tipo, Dados) values ( 'BOLA', 'jpg', load_file("C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\voley.jpg"));

select * from dados_multimidia;

select Dados into outfile 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\gio.jpeg' 
from dados_multimidia 
where Codigo = 4;