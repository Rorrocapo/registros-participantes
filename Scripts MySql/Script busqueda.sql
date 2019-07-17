Delimiter //
create procedure buscar(in palabra varchar(45))

begin
	select *from tabla_registros where idMatricula like palabra or 
    rfc like palabra or 
    nombre like palabra or 
    apellido_paterno like palabra or 
    apellido_materno like palabra or 
    email like palabra or 
    tel_fijo like palabra or 
    tel_cel like palabra or
    tel_oficina like palabra or
   	curso_tomado like palabra;
END //