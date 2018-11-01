create proc [dbo].[spSys_Iniciar_Banco_Caja_depos]
as
declare @id_Empresa int 
set @id_Empresa =1

delete cxc_cobro_x_caj_Caja_Movimiento where cbr_IdEmpresa=@id_Empresa 
delete ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito where mcj_IdEmpresa=@id_Empresa
delete caj_Caja_Movimiento where IdEmpresa =@id_Empresa
delete caj_Caja_Movimiento_det   where IdEmpresa =@id_Empresa
delete ba_transferencia where IdEmpresa_origen =@id_Empresa

delete ba_Conciliacion_det_IngEgr where IdEmpresa= @id_Empresa
delete ba_Conciliacion where IdEmpresa =@id_Empresa
delete ba_Conciliacion_det_no_conciliado where IdEmpresa =@id_Empresa

delete ba_cbte_ban where IdEmpresa =@id_Empresa