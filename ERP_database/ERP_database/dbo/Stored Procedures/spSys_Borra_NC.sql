CREATE procedure spSys_Borra_NC
(
  @IdEmpresa int,
  @IdSucursal int,
  @IdBodega int,
  @IdNota int,
  @Borrar bit
)
as

declare @IdCobro int
declare @IdTipoCbte int
declare @IdCbteCble int

select * from fa_notaCreDeb where IdEmpresa=@IdEmpresa and IdSucursal=@IdSucursal and IdBodega=@IdBodega and IdNota=@IdNota
select @IdCobro=IdCobro_cbr from fa_notaCreDeb_x_cxc_cobro where IdEmpresa_nt=@IdEmpresa and IdSucursal_nt=@IdSucursal and IdBodega_nt=@IdBodega and IdNota_nt=@IdNota
select * from [Grafinpren].[fa_notaCreDeb_graf] where IdEmpresa=@IdEmpresa and IdSucursal=@IdSucursal and IdBodega=@IdBodega and IdNota=@IdNota
select * from cxc_cobro where IdEmpresa=@IdEmpresa and IdSucursal=@IdSucursal and IdCobro=@IdCobro
select * from cxc_cobro_det where IdEmpresa=@IdEmpresa and IdSucursal=@IdSucursal and IdCobro=@IdCobro
select * from cxc_cobro_x_EstadoCobro where IdEmpresa=@IdEmpresa and IdSucursal=@IdSucursal and IdCobro=@IdCobro
select * from fa_notaCreDeb_det where IdEmpresa=@IdEmpresa and IdSucursal=@IdSucursal and IdBodega=@IdBodega and IdNota=@IdNota
select @IdTipoCbte=ct_IdTipoCbte, @IdCbteCble=ct_IdCbteCble from fa_notaCreDeb_x_ct_cbtecble where no_IdEmpresa=@IdEmpresa and no_IdSucursal=@IdSucursal and no_IdBodega=@IdBodega and no_IdNota=@IdNota
select * from ct_cbtecble where IdEmpresa=@IdEmpresa and IdTipoCbte=@IdTipoCbte and IdCbteCble=@IdCbteCble
select * from ct_cbtecble_det where IdEmpresa=@IdEmpresa and IdTipoCbte=@IdTipoCbte and IdCbteCble=@IdCbteCble

IF(@Borrar=1)
BEGIN
	delete fa_notaCreDeb_x_ct_cbtecble where no_IdEmpresa=@IdEmpresa and no_IdNota=@IdNota
	delete fa_notaCreDeb_x_cxc_cobro where IdEmpresa_cbr=@IdEmpresa and IdNota_nt=@IdNota
	delete cxc_cobro_x_EstadoCobro where IdEmpresa=@IdEmpresa and IdCobro=@IdCobro
	delete [Grafinpren].[fa_notaCreDeb_graf] where IdEmpresa=@IdEmpresa and IdNota=@IdNota
	delete cxc_cobro_det where IdEmpresa=@IdEmpresa and IdCobro=@IdCobro
	delete cxc_cobro where IdEmpresa=@IdEmpresa and IdCobro=@IdCobro
	delete ct_cbtecble_det where IdEmpresa=@IdEmpresa and IdTipoCbte=@IdTipoCbte and IdCbteCble=@IdCbteCble
	delete ct_cbtecble where IdEmpresa=@IdEmpresa and IdTipoCbte=@IdTipoCbte and IdCbteCble=@IdCbteCble
	delete fa_notaCreDeb_det where IdEmpresa=@IdEmpresa and IdNota=@IdNota
	delete fa_notaCreDeb where IdEmpresa=@IdEmpresa and IdNota=@IdNota
end