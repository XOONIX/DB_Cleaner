USE cleaner; 
show tables;
describe pago;
select * from pago;   

select distinct forma_pago from pago; /*paypal, transferencia, cheque*/

insert into pago (id_transaccion, codigo_cliente, forma_pago, fecha_pago, total)
values('ak-std-000027', 4, 'Paypal', sysdate(), 5000); /*Comando para incertar pago*/

insert into pago (id_transaccion, codigo_cliente, forma_pago, fecha_pago, total)
values('ak-std-000028', 4, 'Paypal', sysdate(), 300); /*Comando para incertar pago de nuevo */        


create table logs (
	id int auto_increment primary key,
	mensaje varchar(100),
	fecha timestamp default current_timestamp);
    
CREATE EVENT revision_juan
on schedule every 1 minute 
do 
	insert into logs(mensaje)
    values('Evento ejecutando automaticamente');


drop event revision_juan;
show variables like 'event_scheduler'; 


set global event_scheduler = on; 

   

drop event revision_juan;

select * from logs ;
/*-------------------------------------------------------*/



/*-----------Creacion del procedimiento almacenado--------------------------------------------*/
delimiter //

create procedure sp_auditoria_juan ()
begin 
	SELECT 'Ejecutado desde proceso' AS Estado;
end //
delimiter ; 

call sp_auditoria_juan(); /*Llamada del procedimiento*/

drop procedure sp_auditoria_juan;  /*Borrador por si acaso*/
/*------------------------------------------------------------------*/
/*-----------------------Creacion del job -------------------------------------------*/
create event Revision_Juan 
on schedule every 30 second
do
 insert into logs(mensaje)
    values('Evento ejecutando desde Juan');
/*------------------------------------------------------------------*/
drop event Revision_Juan ;  /*Borrador por si acaso*/

call sp_auditoria_juan();  /*Llamada del procedimiento*/
 
select * from logs;

show events; 
alter event Revision_Juan enable; /*Activacion del evento*/
/*------------------------------------------------------------------*/