Delimiter //
create procedure sp_insertalumncurso(
in sp_Rfc varchar(45),
in sp_Curso_tomado varchar(45),
in sp_Inicio date,
in sp_Termino date,
in sp_Nivel enum('Básico','Intermedio','Avanzado'),
in sp_Modulo enum('1','2','3','4','5'),
in sp_Usuario_registro varchar(45))

begin
declare id_alumno_to_foreign bigint;

set id_alumno_to_foreign = (select idAlumno from alumno left join persona on rfc=sp_RFC and idPersona=persona_idPersona);

insert into historial_curso_alumno(curso_tomado,nivel,modulo,inicio,termino,alumno_idAlumno,usuario_registro,dia_registrado)
	values(sp_Curso_tomado,sp_Nivel,sp_Modulo,sp_Inicio,sp_Termino,id_alumno_to_foreign,sp_Usuario_registro,current_date());

END //