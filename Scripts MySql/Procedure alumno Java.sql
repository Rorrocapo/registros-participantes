Delimiter //
create procedure insertalum(
in $Rfc varchar(45) ,
in $Nombre varchar(45),
in $Apellido_paterno varchar(45),
in $Apellido_materno varchar(45),
in $Email varchar(45),
in $Tel_fijo bigint,
in $Tel_cel bigint,
in $Tel_oficina bigint,
in $Identificador enum('I','A') ,
in $Genero enum('F','M') ,
in $Nombre_pais varchar(45),/*Campo Pais*/
in $Nombre_estado varchar(45),/*Campo Estado*/
in $Nombre_ciudad varchar(46),/*Campo Ciudad*/
in $Lugar_residencia varchar(46) ,
in $Nombre_contacto_emergencia varchar(45) ,
in $Tel_contacto_emergencia bigint,
in $Discapacidad varchar(45),
in $Nivel_escolar enum('Primaria','Secundaria','Preparatoria','Licenciatura','Maestria','Doctorado'),
in $Año_egreso year,
in $Nombre_institucion varchar(45),
in $Nombre_titulo varchar(45),
in $Curso_tomado varchar(45),
in $Inicio date,
in $Termino date,
in $Actividad_labora varchar(45),
in $Enterado_programa varchar(45),
in $Curso_interesado varchar(45),
in $Nombre_empresa varchar(45),
in $Sector_laboral varchar(45),
in $Matricula bigint,
in $Nivel enum('Básico','Intermedio','Avanzado'),
in $Modulo enum('1','2','3','4','5'),
in $Usuario_registro varchar(45))

begin
declare id_persona_to_foreign bigint;
declare id_alumno_to_foreign bigint;
declare id_pais_to_foreign bigint;
declare id_estado_to_foreign bigint;
declare id_ciudad_to_foreign bigint;
declare id_lugar_to_foreign bigint;
declare contador bigint;
declare codigo bigint;

/*Ingresa los datos en la tabla persona y alumno*/
 INSERT INTO
 persona( rfc,nombre,apellido_paterno,apellido_materno,email,tel_fijo,tel_cel,tel_oficina,identificador) 
		VALUES ($Rfc,$Nombre,$Apellido_paterno,$Apellido_materno,$Email,$Tel_fijo,$Tel_cel,$Tel_oficina,$Identificador);
 
set id_persona_to_foreign = last_insert_id(); /*Almacena el id de persona para las demas foraneas que la necesiten*/

/**********************************************************************************************************************/
/*Validacion si existe Pais*/
if $Nombre_pais is not null then
if (select count(1) from pais where nombre_pais=$Nombre_pais)>0 then
	begin
		set id_pais_to_foreign=(select idPais from pais where nombre_pais=$Nombre_pais);
    end;
else
	begin
		insert into pais(nombre_pais) value($Nombre_pais);
        set id_pais_to_foreign=(select idPais from pais where nombre_pais=$Nombre_pais);
    end;
end if;
end if;
/*Validacion si existe estado*/
if $Nombre_estado is not null then
if (select count(1) from estado where nombre_estado=$Nombre_estado)>0 then
	begin
		set id_estado_to_foreign=(select idEstado from estado where nombre_estado=$Nombre_estado);
    end;
else
	begin
		insert into estado(nombre_estado) value($Nombre_estado);
        set id_estado_to_foreign=(select idEstado from estado where nombre_estado=$Nombre_estado);
    end;
end if;
end if;
/*Validacion si existe ciudad*/
if $Nombre_ciudad is not null then
if (select count(1) from ciudad where nombre_ciudad=$Nombre_ciudad)>0 then
	begin
		set id_ciudad_to_foreign=(select idciudad from ciudad where nombre_ciudad=$Nombre_ciudad);
    end;
else
	begin
		insert into ciudad(nombre_ciudad) value($Nombre_ciudad);
        set id_ciudad_to_foreign=(select idCiudad from ciudad where nombre_ciudad=$Nombre_ciudad);
    end;
end if;
end if;

/*Se agrega todos los id de pais,estado y ciudad a lugar nacimiento*/
if $Nombre_pais or $Nombre_estado or $Nombre_ciudad is not null then
begin
insert into lugar_nacimiento(pais_idPais,estado_idEstado,ciudad_idCiudad) values(id_pais_to_foreign,id_estado_to_foreign,id_ciudad_to_foreign);
set id_lugar_to_foreign=last_insert_id();
end;
else
begin
if $Nombre_pais is not null and $Nombre_estado is null and $Nombre_ciudad is  null then
begin
	insert into lugar_nacimiento(pais_idPais,estado_idEstado,ciudad_idCiudad) values(id_pais_to_foreign,id_estado_to_foreign,id_ciudad_to_foreign);
	set id_lugar_to_foreign=last_insert_id();
end;
end if;

if $Nombre_estado is not null and $Nombre_pais is  null and $Nombre_ciudad is  null then
begin
	insert into lugar_nacimiento(pais_idPais,estado_idEstado,ciudad_idCiudad) values(id_pais_to_foreign,id_estado_to_foreign,id_ciudad_to_foreign);
	set id_lugar_to_foreign=last_insert_id();
end;
end if;

if $Nombre_ciudad is not null and $Nombre_estado is null and $Nombre_pais is null then
begin
	insert into lugar_nacimiento(pais_idPais,estado_idEstado,ciudad_idCiudad) values(id_pais_to_foreign,id_estado_to_foreign,id_ciudad_to_foreign);
	set id_lugar_to_foreign=last_insert_id();
end;
end if;
end;
end if;
/**********************************************************************************************************************/

INSERT INTO  alumno(genero,lugar_nacimiento,lugar_residencia,nombre_contacto_emergencia,tel_contacto_emergencia,discapacidad,persona_idPersona)
		 Values ($Genero,id_lugar_to_foreign,$Lugar_residencia,$Nombre_contacto_emergencia,$Tel_contacto_emergencia,$Discapacidad,id_persona_to_foreign);
         
set id_alumno_to_foreign = last_insert_id(); /*Almacena el id de persona para las demas foraneas que la necesiten*/
/*Termina de ingresar los datos de la tabla y alumno*/

insert into estadistica(alumno_idAlumno,enterado_programa,curso_interesado)
	values (id_alumno_to_foreign,$Enterado_programa,$Curso_interesado);

insert into historial_curso_alumno(curso_tomado,nivel,modulo,inicio,termino,alumno_idAlumno,usuario_registro,dia_registrado)
	values($Curso_tomado,$Nivel,$Modulo,$Inicio,$Termino,id_alumno_to_foreign,$Usuario_registro,current_date());

/**********************************************************************************************************************/ 
set contador = (select count(*)+1 from matricula_alumno where idMatricula like concat('%',$Matricula,'%'));
if(contador<10)then
	set codigo = concat($Matricula,'000',contador);
elseif(contador<100)then
	set codigo = concat($Matricula,'00',contador);
elseif(contador<1000)then
	set codigo = concat($Matricula,'0',contador);
elseif(contador<10000)then
	set codigo = concat($Matricula,contador);
end if;

insert into matricula_alumno(idMatricula,alumno_idAlumno)
	values(codigo,id_alumno_to_foreign);

/*Validacion si existe la institucion solo inserta en la tabla formacion academica el instituto ya existente*/
if $Nombre_institucion is not null then
if (select count(1) from institucion where nombre_institucion=$Nombre_Institucion)>0 then
begin
	insert into formacion_academica(persona_idPersona,nivel_escolar,año_egreso,institucion_idInstitucion)
		values (id_persona_to_foreign,$Nivel_escolar,$Año_egreso,(select idInstitucion from institucion where nombre_institucion=$Nombre_institucion));
end;
else
begin
	insert into institucion(nombre_institucion) value ($Nombre_institucion);
	insert into formacion_academica(persona_idPersona,nivel_escolar,año_egreso,institucion_idInstitucion)
		values (id_persona_to_foreign,$Nivel_escolar,$Año_egreso,(select idInstitucion from institucion where nombre_institucion=$Nombre_institucion));
end;
end if;
end if;

if $Nombre_titulo is not null then /*Si el alumno aun no tiene titulo esto valida si se ingresa o no un titulo en la tabla*/
	if (select count(1) from titulo where nombre_titulo=$Nombre_titulo)>0 then 
	begin
		update formacion_academica
			set titulo_idTitulo= (select idTitulo from titulo where nombre_titulo = $Nombre_titulo) where persona_idPersona=id_persona_to_foreign;
	end;
	else
    begin
		insert into titulo(nombre_titulo) value ($Nombre_titulo);
		update formacion_academica
			set titulo_idTitulo= (select idTitulo from titulo where nombre_titulo = $Nombre_titulo) where persona_idPersona=id_persona_to_foreign;
	end;
	end if;
end if;

if $Nombre_Empresa is not null then
	if(select count(1) from empresa where nombre_empresa=$Nombre_empresa) then
    begin
		insert into alumno_has_empresa(actividad_labora,empresa_idEmpresa,alumno_idAlumno)
			values ($Actividad_labora,(select idEmpresa from empresa where nombre_empresa=$Nombre_empresa),id_alumno_to_foreign);
    end;
    else
    begin
		insert into empresa(nombre_empresa,sector_laboral)
			values($Nombre_empresa,$Sector_laboral);
		insert into alumno_has_empresa(actividad_labora,empresa_idEmpresa,alumno_idAlumno)
			values ($Actividad_labora,(select idEmpresa from empresa where nombre_empresa=$Nombre_empresa),id_alumno_to_foreign);
    end;
    end if;
end if;
/**********************************************************************************************************************/
END //