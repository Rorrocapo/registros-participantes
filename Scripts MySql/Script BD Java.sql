create database base_datos_ipn;
use base_datos_ipn;

create table persona(idPersona bigint primary key not null auto_increment,
rfc varchar(45) unique,
nombre varchar(45),
apellido_paterno varchar(45),
apellido_materno varchar(45),
email varchar(45),
tel_fijo bigint,
tel_cel bigint,
tel_oficina bigint,
identificador enum('I','A')not null
);

create table institucion(idInstitucion bigint primary key not null auto_increment,
nombre_institucion varchar(100)unique
);
create table titulo (idTitulo bigint primary key not null auto_increment,
nombre_titulo varchar(45)unique
);
create table formacion_academica(idFormacion_academica bigint primary key not null auto_increment,
nivel_escolar enum('Primaria','Secundaria','Preparatoria','Licenciatura','Maestria','Doctorado','Otro') ,
año_egreso year,
persona_idPersona bigint not null,
institucion_idInstitucion bigint not null,
titulo_idTitulo bigint,
foreign key (persona_idPersona) references persona(idPersona)
on update restrict on delete cascade,
foreign key (institucion_idInstitucion) references institucion(idInstitucion)
on update restrict on delete cascade,
foreign key (titulo_idTitulo) references titulo(idTitulo)
on update restrict on delete cascade
);

create table usuarios(idUsuario bigint primary key not null auto_increment,
usuario varchar(45)not null unique,
contraseña varchar(45),
tipo_usuario enum('admin','user')
);

create table pais(idPais bigint  primary key auto_increment,
nombre_pais varchar(45) unique);

create table estado(idEstado bigint  primary key auto_increment,
nombre_estado varchar(45)unique);

create table ciudad(idCiudad bigint  primary key auto_increment,
nombre_ciudad varchar(45)unique);

create table lugar_nacimiento(idLugar_nacimiento bigint not null primary key auto_increment,
pais_idPais bigint,
estado_idEstado bigint,
ciudad_idCiudad bigint,
foreign key(pais_idPais) references pais(idPais)
on delete cascade on update restrict,
foreign key(estado_idEstado) references estado(idEstado)
on delete cascade on update restrict,
foreign key(ciudad_idCiudad) references ciudad(idCiudad)
on delete cascade on update restrict
);

create table alumno(idAlumno bigint primary key not null auto_increment,
genero enum('F','M')not null,
lugar_nacimiento bigint,
lugar_residencia varchar(45),
nombre_contacto_emergencia varchar(45),
tel_contacto_emergencia bigint,
discapacidad varchar(45),
estado_alumno enum('H','I')default 'H',
persona_idPersona bigint not null,
foreign key (persona_idPersona) references persona(idPersona)
on update restrict
on delete cascade,
foreign key (lugar_nacimiento) references lugar_nacimiento(idLugar_nacimiento)
on delete cascade on update restrict
);

create table historial_curso_alumno(idHistorial bigint primary key not null auto_increment,
curso_tomado varchar(45),
nivel enum('Básico','Intermedio','Avanzado'),
modulo enum('1','2','3','4','5'),
inicio date,
termino date,
alumno_idAlumno bigint not null,
usuario_registro varchar(45),
dia_registrado date,
foreign key (alumno_idAlumno) references alumno(idAlumno)
on update restrict
on delete cascade
);

create table empresa(idEmpresa bigint primary key not null auto_increment,
nombre_empresa varchar(45),
sector_laboral varchar(45)
);

create table estadistica(idEstadistica bigint primary key auto_increment,
alumno_idAlumno bigint not null,
enterado_programa varchar(45),
curso_interesado varchar(45),
foreign key (alumno_idAlumno) references alumno(idAlumno)
on update restrict on delete cascade
);

create table alumno_has_empresa(empresa_idEmpresa bigint not null,
alumno_idAlumno bigint not null,
actividad_labora varchar(45),
foreign key (empresa_idEmpresa) references empresa(idEmpresa)
on update restrict on delete cascade,
foreign key (alumno_idAlumno) references alumno(idAlumno)
on update restrict on delete cascade
);

create table matricula_alumno(idMatricula bigint primary key not null,
alumno_idAlumno bigint not null,
foreign key (alumno_idAlumno) references alumno(idAlumno)
on update restrict
on delete cascade
);

insert into usuarios(usuario,contraseña,tipo_usuario)
	values('admin','admin','admin');