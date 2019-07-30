Delimiter //
create procedure updatealumn(
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
in sp_Nivel enum('Básico','Intermedio','Avanzado'),
in sp_Modulo enum('1','2','3','4','5'),
in sp_Matricula bigint)

BEGIN
/*Se crean las variables para almacenar los id de la persona alumno*/
declare idAlumno_stored bigint;
declare idPersona_stored bigint;
declare idLugar_nacimiento_stored bigint;

/*Se le asigna los id del alumno y persona basandose de la busqueda de la matricula*/
set idAlumno_stored = (select idAlumno from alumno inner join matricula_alumno on idMatricula=sp_Matricula where alumno_idAlumno=idAlumno);
set idPersona_stored = (select idPersona from persona,alumno where idPersona=alumno.persona_idPersona and idAlumno=idAlumno_stored);
set idLugar_nacimiento_stored = (select lugar_nacimiento from alumno where idAlumno=idAlumno_stored);

	/*Se actualizan los datos de las tablas simples*/
	update persona set rfc=sp_Rfc, nombre=sp_Nombre, apellido_paterno=sp_Apellido_paterno, apellido_materno=sp_Apellido_materno, email=sp_Email, tel_fijo=sp_Tel_fijo, tel_cel=sp_Tel_cel, tel_oficina=sp_Tel_oficina where idPersona=idPersona_stored;
    update alumno set genero=sp_Genero, lugar_residencia=sp_Lugar_residencia, nombre_contacto_emergencia=sp_Nombre_contacto_emergencia, tel_contacto_emergencia=sp_Tel_contacto_emergencia,discapacidad=sp_Discapacidad where idAlumno=idAlumno_stored;
    update estadistica set enterado_programa=sp_Enterado_programa, curso_interesado=sp_Curso_interesado where alumno_idAlumno=idAlumno_stored;
    update historial_curso_alumno set curso_tomado=sp_Curso_tomado, nivel=sp_Nivel, modulo=sp_Modulo, inicio=sp_Inicio, termino=sp_Termino where alumno_idAlumno=idAlumno_stored;
    update formacion_academica set nivel_escolar=sp_Nivel_escolar, año_egreso=sp_Año_egreso where persona_idPersona=idPersona_stored;
    
    /*Aqui empieza la actualizacion de tablas mas complejas con validacion si existe se crea nuevo registro y si no se guarda uno ya existente*/
    /*Actualiza institucion*/
    if(select count(1) from institucion where nombre_institucion=sp_Nombre_institucion)>0 then
		begin
        update formacion_academica set institucion_idInstitucion=(select idInstitucion from institucion where nombre_institucion=sp_Nombre_institucion) where persona_idPersona=idPersona_stored;
        end;
	else
		begin
        insert into institucion(nombre_institucion) value (sp_Nombre_institucion);
        update formacion_academica set institucion_idInstitucion=(select idInstitucion from institucion where nombre_institucion=sp_Nombre_institucion) where persona_idPersona=idPersona_stored;
        end;
    end if;
    
    /*Actualiza titulo*/
    if(select count(1) from titulo where nombre_titulo=sp_Nombre_titulo)>0 then
		begin
        update formacion_academica set titulo_idTitulo=(select idTitulo from titulo where nombre_titulo=sp_Nombre_titulo) where persona_idPersona=idPersona_stored;
        end;
	else
		begin
        insert into titulo(nombre_titulo) value (sp_Nombre_titulo);
        update formacion_academica set titulo_idTitulo=(select idTitulo from titulo where nombre_titulo=sp_Nombre_titulo) where persona_idPersona=idPersona_stored;
        end;
    end if;
    
    /*Actualiza empresa*/
    if(select count(1) from empresa where nombre_empresa=sp_Nombre_empresa)>0 then
		begin
        update alumno_has_empresa set empresa_idEmpresa=(select idEmpresa from empresa where nombre_empresa=sp_Nombre_empresa), actividad_labora=sp_Actividad_labora where alumno_idAlumno=idAlumno_stored;
        end;
	else
		begin
        insert into empresa(nombre_empresa,sector_laboral) values (sp_Nombre_empresa,sp_Sector_laboral);
		update alumno_has_empresa set empresa_idEmpresa=(select idEmpresa from empresa where nombre_empresa=sp_Nombre_empresa), actividad_labora=sp_Actividad_labora where alumno_idAlumno=idAlumno_stored;
        end;
    end if;
    
    /*Actualiza Ciudad*/
    if(select count(1) from ciudad where nombre_ciudad=sp_Nombre_ciudad)>0 then
		begin
        update lugar_nacimiento set ciudad_idCiudad =(select idCiudad from ciudad where nombre_ciudad=sp_Nombre_ciudad) where idLugar_nacimiento=idLugar_nacimiento_stored;
        end;
	else
		begin
        insert into ciudad(nombre_ciudad) value (sp_Nombre_ciudad);
        update lugar_nacimiento set ciudad_idCiudad =(select idCiudad from ciudad where nombre_ciudad=sp_Nombre_ciudad) where idLugar_nacimiento=idLugar_nacimiento_stored;
        end;
    end if;
    
    /*Actualiza Estado*/
    if(select count(1) from estado where nombre_estado=sp_Nombre_estado)>0 then
		begin
        update lugar_nacimiento set estado_idEstado =(select idEstado from estado where nombre_estado=sp_Nombre_estado) where idLugar_nacimiento=idLugar_nacimiento_stored;
        end;
	else
		begin
        insert into estado(nombre_estado) value (sp_Nombre_estado);
        update lugar_nacimiento set estado_idEstado =(select idEstado from estado where nombre_estado=sp_Nombre_estado) where idLugar_nacimiento=idLugar_nacimiento_stored;
        end;
    end if;
    
    /*Actualiza pais*/
    if(select count(1) from pais where nombre_pais=sp_Nombre_pais)>0 then
		begin
        update lugar_nacimiento set pais_idPais =(select idPais from pais where nombre_pais=sp_Nombre_pais) where idLugar_nacimiento=idLugar_nacimiento_stored;
        end;
	else
		begin
        insert into pais(nombre_pais) value (sp_Nombre_pais);
        update lugar_nacimiento set pais_idPais =(select idPais from pais where nombre_pais=sp_Nombre_pais) where idLugar_nacimiento=idLugar_nacimiento_stored;
        end;
    end if;
END//