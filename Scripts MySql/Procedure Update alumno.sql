Delimiter //
create procedure updatealumn(
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
in $Nivel enum('Básico','Intermedio','Avanzado'),
in $Modulo enum('1','2','3','4','5'),
in $Matricula bigint)

BEGIN
/*Se crean las variables para almacenar los id de la persona alumno*/
declare idAlumno_stored bigint;
declare idPersona_stored bigint;
declare idLugar_nacimiento_stored bigint;

/*Se le asigna los id del alumno y persona basandose de la busqueda de la matricula*/
set idAlumno_stored = (select idAlumno from alumno inner join matricula_alumno on idMatricula=$Matricula where alumno_idAlumno=idAlumno);
set idPersona_stored = (select idPersona from persona,alumno where idPersona=alumno.persona_idPersona and idAlumno=idAlumno_stored);
set idLugar_nacimiento_stored = (select lugar_nacimiento from alumno where idAlumno=idAlumno_stored);

	/*Se actualizan los datos de las tablas simples*/
	update persona set rfc=$Rfc, nombre=$Nombre, apellido_paterno=$Apellido_paterno, apellido_materno=$Apellido_materno, email=$Email, tel_fijo=$Tel_fijo, tel_cel=$Tel_cel, tel_oficina=$Tel_oficina where idPersona=idPersona_stored;
    update alumno set genero=$Genero, lugar_residencia=$Lugar_residencia, nombre_contacto_emergencia=$Nombre_contacto_emergencia, tel_contacto_emergencia=$Tel_contacto_emergencia,discapacidad=$Discapacidad where idAlumno=idAlumno_stored;
    update estadistica set enterado_programa=$Enterado_programa, curso_interesado=$Curso_interesado where alumno_idAlumno=idAlumno_stored;
    update historial_curso_alumno set curso_tomado=$Curso_tomado, nivel=$Nivel, modulo=$Modulo, inicio=$Inicio, termino=$Termino where alumno_idAlumno=idAlumno_stored;
    update formacion_academica set nivel_escolar=$Nivel_escolar, año_egreso=$Año_egreso where persona_idPersona=idPersona_stored;
    
    /*Aqui empieza la actualizacion de tablas mas complejas con validacion si existe se crea nuevo registro y si no se guarda uno ya existente*/
    /*Actualiza institucion*/
    if(select count(1) from institucion where nombre_institucion=$Nombre_institucion)>0 then
		begin
        update formacion_academica set institucion_idInstitucion=(select idInstitucion from institucion where nombre_institucion=$Nombre_institucion) where persona_idPersona=idPersona_stored;
        end;
	else
		begin
        insert into institucion(nombre_institucion) value ($Nombre_institucion);
        update formacion_academica set institucion_idInstitucion=(select idInstitucion from institucion where nombre_institucion=$Nombre_institucion) where persona_idPersona=idPersona_stored;
        end;
    end if;
    
    /*Actualiza titulo*/
    if(select count(1) from titulo where nombre_titulo=$Nombre_titulo)>0 then
		begin
        update formacion_academica set titulo_idTitulo=(select idTitulo from titulo where nombre_titulo=$Nombre_titulo) where persona_idPersona=idPersona_stored;
        end;
	else
		begin
        insert into titulo(nombre_titulo) value ($Nombre_titulo);
        update formacion_academica set titulo_idTitulo=(select idTitulo from titulo where nombre_titulo=$Nombre_titulo) where persona_idPersona=idPersona_stored;
        end;
    end if;
    
    /*Actualiza empresa*/
    if(select count(1) from empresa where nombre_empresa=$Nombre_empresa)>0 then
		begin
        update alumno_has_empresa set empresa_idEmpresa=(select idEmpresa from empresa where nombre_empresa=$Nombre_empresa), actividad_labora=$Actividad_labora where alumno_idAlumno=idAlumno_stored;
        end;
	else
		begin
        insert into empresa(nombre_empresa,sector_laboral) values ($Nombre_empresa,$Sector_laboral);
		update alumno_has_empresa set empresa_idEmpresa=(select idEmpresa from empresa where nombre_empresa=$Nombre_empresa), actividad_labora=$Actividad_labora where alumno_idAlumno=idAlumno_stored;
        end;
    end if;
    
    /*Actualiza Ciudad*/
    if(select count(1) from ciudad where nombre_ciudad=$Nombre_ciudad)>0 then
		begin
        update lugar_nacimiento set ciudad_idCiudad =(select idCiudad from ciudad where nombre_ciudad=$Nombre_ciudad) where idLugar_nacimiento=idLugar_nacimiento_stored;
        end;
	else
		begin
        insert into ciudad(nombre_ciudad) value ($Nombre_ciudad);
        update lugar_nacimiento set ciudad_idCiudad =(select idCiudad from ciudad where nombre_ciudad=$Nombre_ciudad) where idLugar_nacimiento=idLugar_nacimiento_stored;
        end;
    end if;
    
    /*Actualiza Estado*/
    if(select count(1) from estado where nombre_estado=$Nombre_estado)>0 then
		begin
        update lugar_nacimiento set estado_idEstado =(select idEstado from estado where nombre_estado=$Nombre_estado) where idLugar_nacimiento=idLugar_nacimiento_stored;
        end;
	else
		begin
        insert into estado(nombre_estado) value ($Nombre_estado);
        update lugar_nacimiento set estado_idEstado =(select idEstado from estado where nombre_estado=$Nombre_estado) where idLugar_nacimiento=idLugar_nacimiento_stored;
        end;
    end if;
    
    /*Actualiza pais*/
    if(select count(1) from pais where nombre_pais=$Nombre_pais)>0 then
		begin
        update lugar_nacimiento set pais_idPais =(select idPais from pais where nombre_pais=$Nombre_pais) where idLugar_nacimiento=idLugar_nacimiento_stored;
        end;
	else
		begin
        insert into pais(nombre_pais) value ($Nombre_pais);
        update lugar_nacimiento set pais_idPais =(select idPais from pais where nombre_pais=$Nombre_pais) where idLugar_nacimiento=idLugar_nacimiento_stored;
        end;
    end if;
END//