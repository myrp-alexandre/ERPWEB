--exec [spSys_fa_Eliminar_NC] 1,1,4,'D',1
CREATE PROCEDURE [dbo].[spSys_fa_Eliminar_NC]
(
@IdEmpresa int,
@IdSucursal int,
@IdNota numeric,
@CreDeb varchar(1),
@Borrar bit
)
AS
BEGIN
DECLARE @IdEmpresa_ct int
DECLARE @IdCbteCble_ct numeric
DECLARE @IdTipoCbte_ct int

DECLARE @IdEmpresa_cbr int
DECLARE @IdCbteCble_cbr numeric
DECLARE @IdTipoCbte_cbr int

DECLARE @IdEmpresa_cr int
DECLARE @IdSucursal_cr int
DECLARE @IdCobro_cr numeric

select @IdEmpresa_ct = ct_IdEmpresa, @IdTipoCbte_ct = ct_IdTipoCbte, @IdCbteCble_ct = ct_IdCbteCble from fa_notaCreDeb_x_ct_cbtecble where no_IdNota = @IdNota and no_IdEmpresa = @IdEmpresa and no_IdSucursal = @IdSucursal
select @IdEmpresa_cr = IdEmpresa_cbr, @IdSucursal_cr = IdSucursal_cbr, @IdCobro_cr = IdCobro_cbr from fa_notaCreDeb_x_cxc_cobro where IdNota_nt= @IdNota and IdEmpresa_nt= @IdEmpresa and IdSucursal_nt = @IdSucursal
select @IdEmpresa_cbr = ct_IdEmpresa, @IdTipoCbte_cbr = ct_IdTipoCbte, @IdCbteCble_cbr = ct_IdCbteCble from cxc_cobro_x_ct_cbtecble where cbr_IdCobro = @IdCobro_cr and cbr_IdSucursal = @IdSucursal_cr and @IdEmpresa_cr = @IdEmpresa_cr

IF(@Borrar=0)
BEGIN
select * from fa_notaCreDeb_x_ct_cbtecble where no_IdNota = @IdNota and no_IdEmpresa = @IdEmpresa and no_IdSucursal = @IdSucursal
select * from fa_notaCreDeb_x_cxc_cobro where IdNota_nt= @IdNota and IdEmpresa_nt= @IdEmpresa and IdSucursal_nt = @IdSucursal
select * from fa_notaCreDeb_x_fa_factura_NotaDeb where IdNota_nt= @IdNota and IdEmpresa_nt= @IdEmpresa and IdSucursal_nt = @IdSucursal
select * from cxc_cobro_x_ct_cbtecble where cbr_IdCobro = @IdCobro_cr and cbr_IdSucursal = @IdSucursal_cr and @IdEmpresa_cr = @IdEmpresa_cr
select * from ct_cbtecble_det where IdEmpresa = @IdEmpresa_cbr and @IdTipoCbte_cbr = IdTipoCbte and IdCbteCble = @IdCbteCble_cbr
select * from ct_cbtecble where IdEmpresa = @IdEmpresa_cbr and @IdTipoCbte_cbr = IdTipoCbte and IdCbteCble = @IdCbteCble_cbr
select * from cxc_cobro_det cxc_cobro_x_estadocobro where IdCobro = @IdCobro_cr and IdEmpresa = @IdEmpresa_cr and IdSucursal = @IdSucursal_cr
select * from cxc_cobro_det where IdCobro = @IdCobro_cr and IdEmpresa = @IdEmpresa_cr and IdSucursal = @IdSucursal_cr
select * from cxc_cobro where IdCobro = @IdCobro_cr and IdEmpresa = @IdEmpresa_cr and IdSucursal = @IdSucursal_cr
select * from ct_cbtecble_det where IdTipoCbte = @IdTipoCbte_ct and IdEmpresa = @IdEmpresa_ct and IdCbteCble = @IdCbteCble_ct
select * from ct_cbtecble where IdTipoCbte = @IdTipoCbte_ct and IdEmpresa = @IdEmpresa_ct and IdCbteCble = @IdCbteCble_ct
select * from Grafinpren.fa_notaCreDeb_graf where IdNota = @IdNota and IdEmpresa = @IdEmpresa and IdSucursal = @IdSucursal
select * from fa_notaCreDeb_det where IdNota = @IdNota and IdEmpresa = @IdEmpresa and IdSucursal = @IdSucursal
select * from fa_notaCreDeb  where IdNota = @IdNota and IdEmpresa = @IdEmpresa and IdSucursal = @IdSucursal
END

IF(@Borrar=1)
BEGIN
delete from fa_notaCreDeb_x_ct_cbtecble where no_IdNota = @IdNota and no_IdEmpresa = @IdEmpresa and no_IdSucursal = @IdSucursal
delete from fa_notaCreDeb_x_cxc_cobro where IdNota_nt= @IdNota and IdEmpresa_nt= @IdEmpresa and IdSucursal_nt = @IdSucursal
delete from fa_notaCreDeb_x_fa_factura_NotaDeb where IdNota_nt= @IdNota and IdEmpresa_nt= @IdEmpresa and IdSucursal_nt = @IdSucursal
delete from cxc_cobro_x_ct_cbtecble where cbr_IdCobro = @IdCobro_cr and cbr_IdSucursal = @IdSucursal_cr and @IdEmpresa_cr = @IdEmpresa_cr
delete from ct_cbtecble_det where IdEmpresa = @IdEmpresa_cbr and @IdTipoCbte_cbr = IdTipoCbte and IdCbteCble = @IdCbteCble_cbr
delete from ct_cbtecble where IdEmpresa = @IdEmpresa_cbr and @IdTipoCbte_cbr = IdTipoCbte and IdCbteCble = @IdCbteCble_cbr
delete from cxc_cobro_x_estadocobro where IdCobro = @IdCobro_cr and IdEmpresa = @IdEmpresa_cr and IdSucursal = @IdSucursal_cr
delete from cxc_cobro_det where IdCobro = @IdCobro_cr and IdEmpresa = @IdEmpresa_cr and IdSucursal = @IdSucursal_cr
delete from cxc_cobro where IdCobro = @IdCobro_cr and IdEmpresa = @IdEmpresa_cr and IdSucursal = @IdSucursal_cr
delete from ct_cbtecble_det where IdTipoCbte = @IdTipoCbte_ct and IdEmpresa = @IdEmpresa_ct and IdCbteCble = @IdCbteCble_ct
delete from ct_cbtecble where IdTipoCbte = @IdTipoCbte_ct and IdEmpresa = @IdEmpresa_ct and IdCbteCble = @IdCbteCble_ct
delete from Grafinpren.fa_notaCreDeb_graf where IdNota = @IdNota and IdEmpresa = @IdEmpresa and IdSucursal = @IdSucursal
delete from fa_notaCreDeb_det where IdNota = @IdNota and IdEmpresa = @IdEmpresa and IdSucursal = @IdSucursal
delete from fa_notaCreDeb  where IdNota = @IdNota and IdEmpresa = @IdEmpresa and IdSucursal = @IdSucursal

select * from fa_notaCreDeb_x_ct_cbtecble where no_IdNota = @IdNota and no_IdEmpresa = @IdEmpresa and no_IdSucursal = @IdSucursal
select * from fa_notaCreDeb_x_cxc_cobro where IdNota_nt= @IdNota and IdEmpresa_nt= @IdEmpresa and IdSucursal_nt = @IdSucursal
select * from fa_notaCreDeb_x_fa_factura_NotaDeb where IdNota_nt= @IdNota and IdEmpresa_nt= @IdEmpresa and IdSucursal_nt = @IdSucursal
select * from cxc_cobro_x_ct_cbtecble where cbr_IdCobro = @IdCobro_cr and cbr_IdSucursal = @IdSucursal_cr and @IdEmpresa_cr = @IdEmpresa_cr
select * from ct_cbtecble_det where IdEmpresa = @IdEmpresa_cbr and @IdTipoCbte_cbr = IdTipoCbte and IdCbteCble = @IdCbteCble_cbr
select * from ct_cbtecble where IdEmpresa = @IdEmpresa_cbr and @IdTipoCbte_cbr = IdTipoCbte and IdCbteCble = @IdCbteCble_cbr
select * from cxc_cobro_det cxc_cobro_x_estadocobro where IdCobro = @IdCobro_cr and IdEmpresa = @IdEmpresa_cr and IdSucursal = @IdSucursal_cr
select * from cxc_cobro_det where IdCobro = @IdCobro_cr and IdEmpresa = @IdEmpresa_cr and IdSucursal = @IdSucursal_cr
select * from cxc_cobro where IdCobro = @IdCobro_cr and IdEmpresa = @IdEmpresa_cr and IdSucursal = @IdSucursal_cr
select * from ct_cbtecble_det where IdTipoCbte = @IdTipoCbte_ct and IdEmpresa = @IdEmpresa_ct and IdCbteCble = @IdCbteCble_ct
select * from ct_cbtecble where IdTipoCbte = @IdTipoCbte_ct and IdEmpresa = @IdEmpresa_ct and IdCbteCble = @IdCbteCble_ct
select * from Grafinpren.fa_notaCreDeb_graf where IdNota = @IdNota and IdEmpresa = @IdEmpresa and IdSucursal = @IdSucursal
select * from fa_notaCreDeb_det where IdNota = @IdNota and IdEmpresa = @IdEmpresa and IdSucursal = @IdSucursal
select * from fa_notaCreDeb  where IdNota = @IdNota and IdEmpresa = @IdEmpresa and IdSucursal = @IdSucursal
END
END