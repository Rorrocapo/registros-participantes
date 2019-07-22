Delimiter //
create procedure eliminar(in UserU varchar(45),
in Tipo enum('normal','admin'))

begin

if Tipo='admin' then
begin
	if((select count(tipo_usuario)from usuarios where tipo_usuario=Tipo)>1)then
    begin
		delete from usuarios where usuario=UserU;
    end;
    end if;
end;
else 
begin
	delete from usuarios where usuario=UserU;
end;
end if;
END //