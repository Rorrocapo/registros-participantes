Delimiter //
create procedure search(in word varchar(45))

begin
	select *from tabla_registros where idMatricula like word or 
    rfc like word or 
    nombre like word or 
    apellido_paterno like word or 
    apellido_materno like word or 
    genero like word or 
    email like word or 
    lugar_residencia like word or
    nombre_pais like word or 
    nombre_estado like word or 
    nombre_ciudad like word or 
    tel_fijo like word or 
    tel_cel like word or;
END //