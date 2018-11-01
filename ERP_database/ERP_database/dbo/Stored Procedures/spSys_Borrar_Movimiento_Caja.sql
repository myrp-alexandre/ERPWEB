CREATE PROC [dbo].[spSys_Borrar_Movimiento_Caja]
(
@i_IdEmpresa int
)
as

delete from ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito where mcj_IdEmpresa=@i_IdEmpresa
delete caj_Caja_Movimiento_det where IdEmpresa=@i_IdEmpresa 
delete from caj_Caja_Movimiento where IdEmpresa =@i_IdEmpresa