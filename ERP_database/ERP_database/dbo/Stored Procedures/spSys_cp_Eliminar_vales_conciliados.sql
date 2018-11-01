--exec [dbo].[spSys_cp_Eliminar_vales_conciliados] 1 ,22 ,124 ,0
CREATE PROCEDURE [dbo].[spSys_cp_Eliminar_vales_conciliados]
(
@IdEmpresa_conciliacion int,
@IdConciliacion decimal,
@Secuencia int,
@Borrar bit
)
as
BEGIN
BEGIN
DECLARE @IdEmpresa_mov int
DECLARE @IdTipoCbte_mov int
DECLARE @IdCbte_mov decimal
DECLARE @IdEmpresa_cbte int
DECLARE @IdTipoCbte_cbte int
DECLARE @IdCbte_cbte decimal
END
/*
set @IdEmpresa_conciliacion = 1
set @IdConciliacion = 17
set @Secuencia = 5--Si secuencia es 0 consulta todos los vales de la conciliacion ordenados por observacion
set @Borrar = 1*/

if(@Secuencia=0)
begin
SELECT        cp_conciliacion_Caja.IdEmpresa as IdEmpresa_conci, cp_conciliacion_Caja.IdConciliacion_Caja, cp_conciliacion_Caja_det_x_ValeCaja.Secuencia,
			  cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa_movcaja,cp_conciliacion_Caja_det_x_ValeCaja.IdCbteCble_movcaja, 
			  cp_conciliacion_Caja_det_x_ValeCaja.IdTipocbte_movcaja, ct_cbtecble.IdEmpresa, ct_cbtecble.IdTipoCbte,ct_cbtecble.IdCbteCble,
			  caj_Caja_Movimiento.cm_observacion
FROM            cp_conciliacion_Caja INNER JOIN
                         cp_conciliacion_Caja_det_x_ValeCaja ON cp_conciliacion_Caja.IdEmpresa = cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa AND 
                         cp_conciliacion_Caja.IdConciliacion_Caja = cp_conciliacion_Caja_det_x_ValeCaja.IdConciliacion_Caja INNER JOIN
                         caj_Caja_Movimiento ON cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa_movcaja = caj_Caja_Movimiento.IdEmpresa AND 
                         cp_conciliacion_Caja_det_x_ValeCaja.IdCbteCble_movcaja = caj_Caja_Movimiento.IdCbteCble AND 
                         cp_conciliacion_Caja_det_x_ValeCaja.IdTipocbte_movcaja = caj_Caja_Movimiento.IdTipocbte INNER JOIN
                         ct_cbtecble ON caj_Caja_Movimiento.IdEmpresa = ct_cbtecble.IdEmpresa AND caj_Caja_Movimiento.IdTipocbte = ct_cbtecble.IdTipoCbte AND 
                         caj_Caja_Movimiento.IdCbteCble = ct_cbtecble.IdCbteCble
where cp_conciliacion_Caja.IdConciliacion_Caja = @IdConciliacion 
order by caj_Caja_Movimiento.cm_observacion
end
Else
Begin
SELECT        @IdEmpresa_mov = cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa_movcaja,@IdCbte_mov = cp_conciliacion_Caja_det_x_ValeCaja.IdCbteCble_movcaja, @IdTipoCbte_mov = cp_conciliacion_Caja_det_x_ValeCaja.IdTipocbte_movcaja, 
                       @IdEmpresa_cbte =  ct_cbtecble.IdEmpresa, @IdTipoCbte_cbte = ct_cbtecble.IdTipoCbte,@IdCbte_cbte = ct_cbtecble.IdCbteCble
FROM            cp_conciliacion_Caja INNER JOIN
                         cp_conciliacion_Caja_det_x_ValeCaja ON cp_conciliacion_Caja.IdEmpresa = cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa AND 
                         cp_conciliacion_Caja.IdConciliacion_Caja = cp_conciliacion_Caja_det_x_ValeCaja.IdConciliacion_Caja INNER JOIN
                         caj_Caja_Movimiento ON cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa_movcaja = caj_Caja_Movimiento.IdEmpresa AND 
                         cp_conciliacion_Caja_det_x_ValeCaja.IdCbteCble_movcaja = caj_Caja_Movimiento.IdCbteCble AND 
                         cp_conciliacion_Caja_det_x_ValeCaja.IdTipocbte_movcaja = caj_Caja_Movimiento.IdTipocbte INNER JOIN
                         ct_cbtecble ON caj_Caja_Movimiento.IdEmpresa = ct_cbtecble.IdEmpresa AND caj_Caja_Movimiento.IdTipocbte = ct_cbtecble.IdTipoCbte AND 
                         caj_Caja_Movimiento.IdCbteCble = ct_cbtecble.IdCbteCble
where cp_conciliacion_Caja.IdConciliacion_Caja = @IdConciliacion and Secuencia = @Secuencia

IF(@Borrar = 1)
BEGIN
print 'CONCILIACION X VAJE' 
DELETE from cp_conciliacion_Caja_det_x_ValeCaja where IdEmpresa = @IdEmpresa_conciliacion and IdConciliacion_Caja = @IdConciliacion and Secuencia = @Secuencia and IdEmpresa=@IdEmpresa_conciliacion
print 'MOVIMIENTO'
DELETE from caj_Caja_Movimiento_det where IdEmpresa = @IdEmpresa_mov and IdCbteCble = @IdCbte_mov and IdTipocbte = @IdTipoCbte_mov
DELETE from caj_Caja_Movimiento where IdEmpresa = @IdEmpresa_mov and IdCbteCble = @IdCbte_mov and IdTipocbte = @IdTipoCbte_mov
print 'CBTE VALE' 
DELETE from ct_cbtecble_det where IdEmpresa = @IdEmpresa_cbte and IdCbteCble = @IdCbte_cbte and IdTipocbte = @IdTipoCbte_cbte
DELETE from ct_cbtecble where IdEmpresa = @IdEmpresa_cbte and IdCbteCble = @IdCbte_cbte and IdTipocbte = @IdTipoCbte_cbte
END
select 'CONCILIACION X VAJE' 
select * from cp_conciliacion_Caja_det_x_ValeCaja where IdEmpresa = @IdEmpresa_conciliacion and IdConciliacion_Caja = @IdConciliacion and Secuencia = @Secuencia
SELECT 'MOVIMIENTO'
select * from caj_Caja_Movimiento_det where IdEmpresa = @IdEmpresa_cbte and IdCbteCble = @IdCbte_cbte and IdTipocbte = @IdTipoCbte_cbte
select * from caj_Caja_Movimiento where IdEmpresa = @IdEmpresa_cbte and IdCbteCble = @IdCbte_cbte and IdTipocbte = @IdTipoCbte_cbte
select 'CBTE VALE' 
select * from ct_cbtecble_det where IdEmpresa = @IdEmpresa_cbte and IdCbteCble = @IdCbte_cbte and IdTipocbte = @IdTipoCbte_cbte
select * from ct_cbtecble where IdEmpresa = @IdEmpresa_cbte and IdCbteCble = @IdCbte_cbte and IdTipocbte = @IdTipoCbte_cbte
end
end