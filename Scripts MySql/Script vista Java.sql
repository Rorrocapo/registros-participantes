create view tabla_registros as
select matricula_alumno.idMatricula, persona.rfc,persona.nombre,persona.apellido_paterno,
persona.apellido_materno,alumno.genero,persona.email,alumno.lugar_residencia,pais.nombre_pais,
estado.nombre_estado,ciudad.nombre_ciudad,persona.tel_fijo,persona.tel_cel,persona.tel_oficina,
formacion_academica.nivel_escolar,nombre_titulo,nombre_institucion,año_egreso,nombre_contacto_emergencia,
tel_contacto_emergencia,discapacidad,nombre_empresa,actividad_labora,sector_laboral,enterado_programa,
curso_interesado,curso_tomado,nivel,modulo,inicio,termino,usuario_registro,dia_registrado
from persona left join alumno on idPersona=alumno.persona_idPersona 
left join matricula_alumno on idAlumno=alumno_idAlumno 
left join lugar_nacimiento on idLugar_nacimiento=lugar_nacimiento 
left join pais on idPais= pais_idPais 
left join estado on idEstado=estado_idEstado 
left join ciudad on idCiudad=ciudad_idCiudad 
left join formacion_academica on idPersona=formacion_academica.persona_idPersona 
left join titulo on titulo_idTitulo=idTitulo 
left join institucion on idInstitucion=institucion_idInstitucion
left join alumno_has_empresa on idAlumno = alumno_has_empresa.alumno_idAlumno
left join empresa on idEmpresa = empresa_idEmpresa
left join estadistica on idAlumno = estadistica.alumno_idAlumno
left join historial_curso_alumno on idAlumno = historial_curso_alumno.alumno_idAlumno;