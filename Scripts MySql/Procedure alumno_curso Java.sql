Delimiter //
create procedure insertcursoalumno(
in $Rfc varchar(45),
in $Curso_tomado varchar(45),
in $Inicio date,
in $Termino date,
in $Nivel enum('Básico','Intermedio','Avanzado'),
in $Modulo enum('1','2','3','4','5'),
in $Usuario_registro varchar(45))

begin
declare id_alumno_to_foreign bigint;

set id_alumno_to_foreign = (select idAlumno from alumno left join persona on rfc=$RFC and idPersona=persona_idPersona);

insert into historial_curso_alumno(curso_tomado,nivel,modulo,inicio,termino,alumno_idAlumno,usuario_registro,dia_registrado)
	values($Curso_tomado,$Nivel,$Modulo,$Inicio,$Termino,id_alumno_to_foreign,$Usuario_registro,current_date());

END //