
-- exec spSys_Eliminar_Cobros 1,1,197,0

CREATE proc [dbo].[spSys_Eliminar_Cobros]
(
 @idEmpresa_cobro int
,@idsucursal_cobro int
,@idcobro_cobro numeric
,@i_Aplicar_Eliminacion bit
)
as
begin



/******************************************  CUIDADO ESTE QUERRY ELIMINA FISICAMENTE LOS CBROS **************/
------- solo usarlo bajo supervision de luis yanza  -------------------------
/*
declare @idEmpresa_cobro int
declare @idsucursal_cobro int
declare @idcobro_cobro numeric
declare @i_Aplicar_Eliminacion bit

set @idEmpresa_cobro =1
set @idsucursal_cobro =1
set @idcobro_cobro =62
set @i_Aplicar_Eliminacion =1


*/

declare @idempresa_caj int
declare @idTipoCbte_caj int
declare @idCbteCbte_caj numeric
declare @idempresa_conta int
declare @idTipoCbte_conta int
declare @idCbteCbte_conta int
declare  @Tiene_deposito int

declare @IdEmpresa_Banco int
declare @idTipoCbte_Banco int
declare @idCbteCbte_Banco numeric

select @idempresa_caj =mcj_IdEmpresa,@idTipoCbte_caj=mcj_IdTipocbte,@idCbteCbte_caj=mcj_IdCbteCble  from cxc_cobro_x_caj_Caja_Movimiento where cbr_IdEmpresa=@idEmpresa_cobro and cbr_IdSucursal=@idsucursal_cobro and cbr_IdCobro=@idcobro_cobro
select @idempresa_conta=ct_IdEmpresa,@idTipoCbte_conta=ct_IdTipoCbte,@idCbteCbte_conta=ct_IdCbteCble from cxc_cobro_x_ct_cbtecble where cbr_IdEmpresa=@idEmpresa_cobro and cbr_IdSucursal=@idsucursal_cobro and cbr_IdCobro=@idcobro_cobro
select @Tiene_deposito =COUNT(*) from ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito where mcj_IdEmpresa=@idempresa_caj and mcj_IdCbteCble=@idCbteCbte_caj and mcj_IdTipocbte=@idTipoCbte_caj

if (@Tiene_deposito>0)
begin
	select 'no se puede eliminar el cobro pues tiene deposito elimine primero el deposito'

	--optengo el cbte bancario q tiene este cobro
	select @IdEmpresa_Banco =mba_IdEmpresa,@idTipoCbte_Banco=mba_IdTipocbte,@idCbteCbte_Banco=mba_IdCbteCble from ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito where mcj_IdEmpresa=@idempresa_caj and mcj_IdCbteCble=@idCbteCbte_caj and mcj_IdTipocbte=@idTipoCbte_caj
	--optengo todos ingreso de caja relacionados a este deposito
	select * from ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito where mba_IdEmpresa=@IdEmpresa_Banco and mba_IdTipocbte=@idTipoCbte_Banco and mba_IdCbteCble=@idCbteCbte_Banco
	-- optengo el cbte bancario y cbte contable
	select * from ct_cbtecble_det where IdEmpresa=@IdEmpresa_Banco and IdTipoCbte=@idTipoCbte_Banco and IdCbteCble=@idCbteCbte_Banco
	select * from ct_cbtecble where IdEmpresa=@IdEmpresa_Banco and IdTipoCbte=@idTipoCbte_Banco and IdCbteCble=@idCbteCbte_Banco
	select * from ba_Cbte_Ban where IdEmpresa=@IdEmpresa_Banco and IdTipocbte=@idTipoCbte_Banco and IdCbteCble=@idCbteCbte_Banco
	--------
	--optengo los ingresos de caja q estan estos movimiento bancario
	
	--delete 
	if (@i_Aplicar_Eliminacion=1)
	begin
		delete from ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito where mba_IdEmpresa=@IdEmpresa_Banco and mba_IdTipocbte=@idTipoCbte_Banco and mba_IdCbteCble=@idCbteCbte_Banco
		delete from ba_Cbte_Ban where IdEmpresa=@IdEmpresa_Banco and IdTipocbte=@idTipoCbte_Banco and IdCbteCble=@idCbteCbte_Banco
		delete from ct_cbtecble_det where IdEmpresa=@IdEmpresa_Banco and IdTipoCbte=@idTipoCbte_Banco and IdCbteCble=@idCbteCbte_Banco
		delete from ct_cbtecble where IdEmpresa=@IdEmpresa_Banco and IdTipoCbte=@idTipoCbte_Banco and IdCbteCble=@idCbteCbte_Banco
	end
	
end 




select * from fa_notaCreDeb_x_cxc_cobro where IdEmpresa_cbr =@idEmpresa_cobro and IdSucursal_cbr=@idsucursal_cobro and IdCobro_cbr=@idcobro_cobro
select * from cxc_cobro_x_caj_Caja_Movimiento where cbr_IdEmpresa=@idEmpresa_cobro and cbr_IdSucursal=@idsucursal_cobro and cbr_IdCobro=@idcobro_cobro
select * from cxc_cobro_x_ct_cbtecble where cbr_IdEmpresa=@idEmpresa_cobro and cbr_IdSucursal=@idsucursal_cobro and cbr_IdCobro=@idcobro_cobro
select * from cxc_cobro_det_x_ct_cbtecble_det where IdEmpresa_cb =@idEmpresa_cobro and IdSucursal_cb =@idsucursal_cobro and IdCobro_cb =@idcobro_cobro

select 'cxc_cobro  , cxc_cobro_det cxc_cobro_x_estadocobro'
select * from cxc_cobro where IdEmpresa=@idEmpresa_cobro and IdSucursal=@idsucursal_cobro and IdCobro=@idcobro_cobro
select * from cxc_cobro_det  where IdEmpresa=@idEmpresa_cobro and IdSucursal=@idsucursal_cobro and IdCobro=@idcobro_cobro
select * from cxc_cobro_x_EstadoCobro where IdEmpresa=@idEmpresa_cobro and IdSucursal=@idsucursal_cobro and IdCobro=@idcobro_cobro

select 'caj_Caja_Movimiento  caj_Caja_Movimiento_det '
select * from caj_Caja_Movimiento where IdEmpresa=@idempresa_caj and IdTipocbte=@idTipoCbte_caj and IdCbteCble=@idCbteCbte_caj
select * from caj_Caja_Movimiento_det where IdEmpresa=@idempresa_caj and IdTipocbte=@idTipoCbte_caj and IdCbteCble=@idCbteCbte_caj


select 'ct_cbtecble ct_cbtecble_det '
select * from ct_cbtecble_det where IdEmpresa=@idempresa_conta and IdTipoCbte=@idTipoCbte_conta and IdCbteCble=@idCbteCbte_conta
select * from ct_cbtecble where IdEmpresa=@idempresa_conta and IdTipoCbte=@idTipoCbte_conta and IdCbteCble=@idCbteCbte_conta

select 'ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito '
select * from ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito where mcj_IdEmpresa=@idempresa_caj and mcj_IdCbteCble=@idCbteCbte_caj and mcj_IdTipocbte=@idTipoCbte_caj


--return 

if (@i_Aplicar_Eliminacion =1)
begin

select 'eliminando fa_notaCreDeb_x_cxc_cobro '
delete from  fa_notaCreDeb_x_cxc_cobro where IdEmpresa_cbr =@idEmpresa_cobro and IdSucursal_cbr=@idsucursal_cobro and IdCobro_cbr=@idcobro_cobro


select 'eliminando cxc_cobro_x_caj_Caja_Movimiento    cxc_cobro_x_ct_cbtecble '
delete from cxc_cobro_x_caj_Caja_Movimiento where cbr_IdEmpresa=@idEmpresa_cobro and cbr_IdSucursal=@idsucursal_cobro and cbr_IdCobro=@idcobro_cobro
delete from cxc_cobro_det_x_ct_cbtecble_det where IdEmpresa_cb =@idEmpresa_cobro and IdSucursal_cb =@idsucursal_cobro and IdCobro_cb =@idcobro_cobro
delete from cxc_cobro_x_ct_cbtecble where cbr_IdEmpresa=@idEmpresa_cobro and cbr_IdSucursal=@idsucursal_cobro and cbr_IdCobro=@idcobro_cobro


select 'eliminando cxc_cobro  , cxc_cobro_det cxc_cobro_x_estadocobro'
delete from cxc_cobro_x_EstadoCobro where IdEmpresa=@idEmpresa_cobro and IdSucursal=@idsucursal_cobro and IdCobro=@idcobro_cobro
delete from cxc_cobro_det  where IdEmpresa=@idEmpresa_cobro and IdSucursal=@idsucursal_cobro and IdCobro=@idcobro_cobro
delete from cxc_cobro where IdEmpresa=@idEmpresa_cobro and IdSucursal=@idsucursal_cobro and IdCobro=@idcobro_cobro

select 'caj_Caja_Movimiento  caj_Caja_Movimiento_det '
delete from caj_Caja_Movimiento_det where IdEmpresa=@idempresa_caj and IdTipocbte=@idTipoCbte_caj and IdCbteCble=@idCbteCbte_caj
delete from caj_Caja_Movimiento where IdEmpresa=@idempresa_caj and IdTipocbte=@idTipoCbte_caj and IdCbteCble=@idCbteCbte_caj

select 'ct_cbtecble ct_cbtecble_det '
delete from ct_cbtecble_det where IdEmpresa=@idempresa_conta and IdTipoCbte=@idTipoCbte_conta and IdCbteCble=@idCbteCbte_conta
delete from ct_cbtecble where IdEmpresa=@idempresa_conta and IdTipoCbte=@idTipoCbte_conta and IdCbteCble=@idCbteCbte_conta
end -- end if

end