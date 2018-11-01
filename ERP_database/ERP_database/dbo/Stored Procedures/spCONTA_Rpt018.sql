--exec [spCONTA_Rpt018] '01/08/2016','31/08/2016',1,12,12,1
CREATE PROCEDURE [dbo].[spCONTA_Rpt018]
(
@Fecha_ini datetime, 
@Fecha_fin datetime, 
@IdEmpresa int, 
@IdPunto_cargo_grupo_ini int, 
@IdPunto_cargo_grupo_fin int, 
@Mostrar_detalle bit
)
AS
BEGIN
/*
set @Fecha_ini = '01/08/2016'
set @Fecha_fin = '31/08/2016'
set @IdEmpresa = 1
set @IdPunto_cargo_grupo_ini = 12
set @IdPunto_cargo_grupo_fin = 12
set @Mostrar_detalle = 1
*/
SELECT ISNULL(ROW_NUMBER() OVER (ORDER BY (A.IdEmpresa)),0) as IdRow, A.* 
FROM (
SELECT       ct_plancta.IdEmpresa, ct_plancta.IdCtaCble, ct_plancta.pc_Cuenta,'' as Observacion, sum(ct_cbtecble_det.dc_Valor) Valor, ct_cbtecble_det.IdPunto_cargo_grupo, ct_punto_cargo_grupo.nom_punto_cargo_grupo,
			null Comprobante,null IdCbteCble
FROM            ct_cbtecble INNER JOIN
                         ct_cbtecble_det ON ct_cbtecble.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_cbtecble.IdTipoCbte = ct_cbtecble_det.IdTipoCbte AND 
                         ct_cbtecble.IdCbteCble = ct_cbtecble_det.IdCbteCble INNER JOIN
                         ct_punto_cargo_grupo ON ct_cbtecble_det.IdEmpresa = ct_punto_cargo_grupo.IdEmpresa AND 
                         ct_cbtecble_det.IdPunto_cargo_grupo = ct_punto_cargo_grupo.IdPunto_cargo_grupo INNER JOIN
                         ct_plancta ON ct_cbtecble_det.IdEmpresa = ct_plancta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ct_plancta.IdCtaCble
where ct_cbtecble.IdEmpresa = @IdEmpresa and ct_cbtecble.cb_Fecha between @Fecha_ini and @Fecha_fin and ct_cbtecble_det.IdPunto_cargo_grupo between @IdPunto_cargo_grupo_ini and @IdPunto_cargo_grupo_fin
AND @Mostrar_detalle = 0
group by ct_plancta.IdEmpresa,ct_plancta.IdCtaCble, ct_plancta.pc_Cuenta, ct_cbtecble_det.IdPunto_cargo_grupo, ct_punto_cargo_grupo.nom_punto_cargo_grupo
union
SELECT        ct_plancta.IdEmpresa, ct_plancta.IdCtaCble, ct_plancta.pc_Cuenta, ct_cbtecble.cb_Observacion, ct_cbtecble_det.dc_Valor AS Valor, 
                         ct_cbtecble_det.IdPunto_cargo_grupo, ct_punto_cargo_grupo.nom_punto_cargo_grupo, ct_cbtecble_tipo.tc_TipoCbte, ct_cbtecble.IdCbteCble
FROM            ct_cbtecble INNER JOIN
                         ct_cbtecble_det ON ct_cbtecble.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_cbtecble.IdTipoCbte = ct_cbtecble_det.IdTipoCbte AND 
                         ct_cbtecble.IdCbteCble = ct_cbtecble_det.IdCbteCble INNER JOIN
                         ct_punto_cargo_grupo ON ct_cbtecble_det.IdEmpresa = ct_punto_cargo_grupo.IdEmpresa AND 
                         ct_cbtecble_det.IdPunto_cargo_grupo = ct_punto_cargo_grupo.IdPunto_cargo_grupo INNER JOIN
                         ct_plancta ON ct_cbtecble_det.IdEmpresa = ct_plancta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ct_plancta.IdCtaCble INNER JOIN
                         ct_cbtecble_tipo ON ct_cbtecble.IdEmpresa = ct_cbtecble_tipo.IdEmpresa AND ct_cbtecble.IdTipoCbte = ct_cbtecble_tipo.IdTipoCbte
where ct_cbtecble.IdEmpresa = @IdEmpresa and ct_cbtecble.cb_Fecha between @Fecha_ini and @Fecha_fin and ct_cbtecble_det.IdPunto_cargo_grupo between @IdPunto_cargo_grupo_ini and @IdPunto_cargo_grupo_fin
AND @Mostrar_detalle = 1) A
END