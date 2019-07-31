Delimiter //
create procedure insertalumno(
in sp_Rfc varchar(45) ,
in sp_Nombre varchar(45),
in sp_Apellido_paterno varchar(45),
in sp_Apellido_materno varchar(45),
in sp_Email varchar(45),
in sp_Tel_fijo bigint,
in sp_Tel_cel bigint,
in sp_Tel_oficina bigint,
in sp_Identificador enum('I','A') ,
in sp_Genero enum('F','M') ,
in sp_Nombre_pais varchar(45),/*Campo Pais*/
in sp_Nombre_estado varchar(45),/*Campo Estado*/
in sp_Nombre_ciudad varchar(46),/*Campo Ciudad*/
in sp_Lugar_residencia varchar(46) ,
in sp_Nombre_contacto_emergencia varchar(45) ,
in sp_Tel_contacto_emergencia bigint,
in sp_Discapacidad varchar(45),
in sp_Nivel_escolar enum('Primaria','Secundaria','Preparatoria','Licenciatura','Maestria','Doctorado'),
in sp_Año_egreso year,
in sp_Nombre_institucion varchar(45),
in sp_Nombre_titulo varchar(45),
in sp_Curso_tomado varchar(45),
in sp_Inicio date,
in sp_Termino date,
in sp_Actividad_labora varchar(45),
in sp_Enterado_programa varchar(45),
in sp_Curso_interesado varchar(45),
in sp_Nombre_empresa varchar(45),
in sp_Sector_laboral varchar(45),
in sp_Matricula bigint,
in sp_Nivel enum('Básico','Intermedio','Avanzado'),
in sp_Modulo enum('1','2','3','4','5'),
in sp_Usuario_registro varchar(45))

begin
declare id_persona_to_foreign bigint;
declare id_alumno_to_foreign bigint;
declare id_pais_to_foreign bigint;
declare id_estado_to_foreign bigint;
declare id_ciudad_to_foreign bigint;
declare id_lugar_to_foreign bigint;
declare idGenerado bigint;
declare codigo bigint;

/*Ingresa los datos en la tabla persona y alumno*/
 INSERT INTO
 persona( rfc,nombre,apellido_paterno,apellido_materno,email,tel_fijo,tel_cel,tel_oficina,identificador) 
		VALUES (sp_Rfc,sp_Nombre,sp_Apellido_paterno,sp_Apellido_materno,sp_Email,sp_Tel_fijo,sp_Tel_cel,sp_Tel_oficina,sp_Identificador);
 
set id_persona_to_foreign = last_insert_id(); /*Almacena el id de persona para las demas foraneas que la necesiten*/

/**********************************************************************************************************************/
/*Validacion si existe Pais*/
if sp_Nombre_pais is not null then
if (select count(1) from pais where nombre_pais=sp_Nombre_pais)>0 then
	begin
		set id_pais_to_foreign=(select idPais from pais where nombre_pais=sp_Nombre_pais);
    end;
else
	begin
		insert into pais(nombre_pais) value(sp_Nombre_pais);
        set id_pais_to_foreign=(select idPais from pais where nombre_pais=sp_Nombre_pais);
    end;
end if;
end if;
/*Validacion si existe estado*/
if sp_Nombre_estado is not null then
if (select count(1) from estado where nombre_estado=sp_Nombre_estado)>0 then
	begin
		set id_estado_to_foreign=(select idEstado from estado where nombre_estado=sp_Nombre_estado);
    end;
else
	begin
		insert into estado(nombre_estado) value(sp_Nombre_estado);
        set id_estado_to_foreign=(select idEstado from estado where nombre_estado=sp_Nombre_estado);
    end;
end if;
end if;
/*Validacion si existe ciudad*/
if sp_Nombre_ciudad is not null then
if (select count(1) from ciudad where nombre_ciudad=sp_Nombre_ciudad)>0 then
	begin
		set id_ciudad_to_foreign=(select idciudad from ciudad where nombre_ciudad=sp_Nombre_ciudad);
    end;
else
	begin
		insert into ciudad(nombre_ciudad) value(sp_Nombre_ciudad);
        set id_ciudad_to_foreign=(select idCiudad from ciudad where nombre_ciudad=sp_Nombre_ciudad);
    end;
end if;
end if;

/*Se agrega todos los id de pais,estado y ciudad a lugar nacimiento*/
if sp_Nombre_pais or sp_Nombre_estado or sp_Nombre_ciudad is not null then
begin
insert into lugar_nacimiento(pais_idPais,estado_idEstado,ciudad_idCiudad) values(id_pais_to_foreign,id_estado_to_foreign,id_ciudad_to_foreign);
set id_lugar_to_foreign=last_insert_id();
end;
else
begin
if sp_Nombre_pais is not null and sp_Nombre_estado is null and sp_Nombre_ciudad is  null then
begin
	insert into lugar_nacimiento(pais_idPais,estado_idEstado,ciudad_idCiudad) values(id_pais_to_foreign,id_estado_to_foreign,id_ciudad_to_foreign);
	set id_lugar_to_foreign=last_insert_id();
end;
end if;

if sp_Nombre_estado is not null and sp_Nombre_pais is  null and sp_Nombre_ciudad is  null then
begin
	insert into lugar_nacimiento(pais_idPais,estado_idEstado,ciudad_idCiudad) values(id_pais_to_foreign,id_estado_to_foreign,id_ciudad_to_foreign);
	set id_lugar_to_foreign=last_insert_id();
end;
end if;

if sp_Nombre_ciudad is not null and sp_Nombre_estado is null and sp_Nombre_pais is null then
begin
	insert into lugar_nacimiento(pais_idPais,estado_idEstado,ciudad_idCiudad) values(id_pais_to_foreign,id_estado_to_foreign,id_ciudad_to_foreign);
	set id_lugar_to_foreign=last_insert_id();
end;
end if;
end;
end if;
/**********************************************************************************************************************/

INSERT INTO  alumno(genero,lugar_nacimiento,lugar_residencia,nombre_contacto_emergencia,tel_contacto_emergencia,discapacidad,persona_idPersona)
		 Values (sp_Genero,id_lugar_to_foreign,sp_Lugar_residencia,sp_Nombre_contacto_emergencia,sp_Tel_contacto_emergencia,sp_Discapacidad,id_persona_to_foreign);
         
set id_alumno_to_foreign = last_insert_id(); /*Almacena el id de persona para las demas foraneas que la necesiten*/
/*Termina de ingresar los datos de la tabla y alumno*/

insert into estadistica(alumno_idAlumno,enterado_programa,curso_interesado)
	values (id_alumno_to_foreign,sp_Enterado_programa,sp_Curso_interesado);

insert into historial_curso_alumno(curso_tomado,nivel,modulo,inicio,termino,alumno_idAlumno,usuario_registro,dia_registrado)
	values(sp_Curso_tomado,sp_Nivel,sp_Modulo,sp_Inicio,sp_Termino,id_alumno_to_foreign,sp_Usuario_registro,current_date());

/**********************************************************************************************************************/ 
set idGenerado = (select count(*)+1 from matricula_alumno where idMatricula like concat('%',sp_Matricula,'%'));

if(idGenerado<10)then
	set codigo = concat(sp_Matricula,'000',idGenerado);
elseif(idGenerado<100)then
	set codigo = concat(sp_Matricula,'00',idGenerado);
elseif(idGenerado<1000)then
	set codigo = concat(sp_Matricula,'0',idGenerado);
elseif(idGenerado<10000)then
	set codigo = concat(sp_Matricula,idGenerado);
end if;

insert into matricula_alumno(idMatricula,alumno_idAlumno)
	values(codigo,id_alumno_to_foreign);

/*Validacion si existe la institucion solo inserta en la tabla formacion academica el instituto ya existente*/
if sp_Nombre_institucion is not null then
if (select count(1) from institucion where nombre_institucion=sp_Nombre_Institucion)>0 then
begin
	insert into formacion_academica(persona_idPersona,nivel_escolar,año_egreso,institucion_idInstitucion)
		values (id_persona_to_foreign,sp_Nivel_escolar,sp_Año_egreso,(select idInstitucion from institucion where nombre_institucion=sp_Nombre_institucion));
end;
else
begin
	insert into institucion(nombre_institucion) value (sp_Nombre_institucion);
	insert into formacion_academica(persona_idPersona,nivel_escolar,año_egreso,institucion_idInstitucion)
		values (id_persona_to_foreign,sp_Nivel_escolar,sp_Año_egreso,(select idInstitucion from institucion where nombre_institucion=sp_Nombre_institucion));
end;
end if;
end if;

if sp_Nombre_titulo is not null then /*Si el alumno aun no tiene titulo esto valida si se ingresa o no un titulo en la tabla*/
	if (select count(1) from titulo where nombre_titulo=sp_Nombre_titulo)>0 then 
	begin
		update formacion_academica
			set titulo_idTitulo= (select idTitulo from titulo where nombre_titulo = sp_Nombre_titulo) where persona_idPersona=id_persona_to_foreign;
	end;
	else
    begin
		insert into titulo(nombre_titulo) value (sp_Nombre_titulo);
		update formacion_academica
			set titulo_idTitulo= (select idTitulo from titulo where nombre_titulo = sp_Nombre_titulo) where persona_idPersona=id_persona_to_foreign;
	end;
	end if;
end if;

if sp_Nombre_Empresa is not null then
	if(select count(1) from empresa where nombre_empresa=sp_Nombre_empresa) then
    begin
		insert into alumno_has_empresa(actividad_labora,empresa_idEmpresa,alumno_idAlumno)
			values (sp_Actividad_labora,(select idEmpresa from empresa where nombre_empresa=sp_Nombre_empresa),id_alumno_to_foreign);
    end;
    else
    begin
		insert into empresa(nombre_empresa,sector_laboral)
			values(sp_Nombre_empresa,sp_Sector_laboral);
		insert into alumno_has_empresa(actividad_labora,empresa_idEmpresa,alumno_idAlumno)
			values (sp_Actividad_labora,(select idEmpresa from empresa where nombre_empresa=sp_Nombre_empresa),id_alumno_to_foreign);
    end;
    end if;
end if;
/**********************************************************************************************************************/
END //