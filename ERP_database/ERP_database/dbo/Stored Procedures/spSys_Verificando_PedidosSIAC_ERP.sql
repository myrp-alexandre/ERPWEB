create proc [dbo].[spSys_Verificando_PedidosSIAC_ERP]
as
declare @idEmpresa int
declare @idsucursal int

set @idEmpresa =1
set @idsucursal =2


select * from tbINcabPedidos 
where cp_compania=@idEmpresa
and cp_sucursal=@idsucursal
and  cast(cp_compania as varchar(1))+cast(cp_sucursal as varchar(1))+cast(cp_cliente as varchar(20))  
not in(select IdCliente from fa_cliente where IdEmpresa=@idEmpresa and IdSucursal=@idsucursal)