
CREATE PROCEDURE [dbo].[spCON_saldo_cuentas_x_anio_para_cierre]
(
@IdEmpresa int,
@Anio int
)
AS
/*
SET @IdEmpresa = 1
SET @Anio = 2016
*/
 --SACO CUENTA UTILIDAD
DECLARE @IdCtaCble_utilidad varchar(20)
select @IdCtaCble_utilidad = IdCtaCble from ct_anio_fiscal_x_cuenta_utilidad where IdEmpresa = @IdEmpresa and IdanioFiscal = @Anio

 --CALCULO LA UTILIDAD
DECLARE @Valor_utilidad float 
SELECT     @Valor_utilidad =  SUM(ct_cbtecble_det.dc_Valor)
FROM            ct_cbtecble INNER JOIN
                         ct_cbtecble_det ON ct_cbtecble.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_cbtecble.IdTipoCbte = ct_cbtecble_det.IdTipoCbte AND 
                         ct_cbtecble.IdCbteCble = ct_cbtecble_det.IdCbteCble INNER JOIN
                         ct_plancta ON ct_cbtecble_det.IdEmpresa = ct_plancta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ct_plancta.IdCtaCble INNER JOIN
                         ct_grupocble ON ct_plancta.IdGrupoCble = ct_grupocble.IdGrupoCble
where ct_cbtecble.IdEmpresa = @IdEmpresa AND ct_cbtecble.cb_Anio = @Anio and ct_cbtecble_det.IdTipoCbte <> 31
and        (ct_grupocble.gc_estado_financiero = 'ER')
having SUM(ct_cbtecble_det.dc_Valor) <>0
SELECT * FROM(
SELECT        ct_plancta.IdEmpresa, ct_cbtecble_det.IdCtaCble,  SUM(ct_cbtecble_det.dc_Valor) AS dc_Valor,
ct_cbtecble_det.IdCentroCosto, ct_cbtecble_det.IdCentroCosto_sub_centro_costo, ct_cbtecble_det.IdPunto_cargo, 
                         ct_cbtecble_det.IdPunto_cargo_grupo
FROM            ct_cbtecble INNER JOIN
                         ct_cbtecble_det ON ct_cbtecble.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_cbtecble.IdTipoCbte = ct_cbtecble_det.IdTipoCbte AND 
                         ct_cbtecble.IdCbteCble = ct_cbtecble_det.IdCbteCble INNER JOIN
                         ct_plancta ON ct_cbtecble_det.IdEmpresa = ct_plancta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ct_plancta.IdCtaCble INNER JOIN
                         ct_grupocble ON ct_plancta.IdGrupoCble = ct_grupocble.IdGrupoCble
where ct_cbtecble.IdEmpresa = @IdEmpresa AND ct_cbtecble.cb_Anio = @Anio and (ct_grupocble.gc_estado_financiero = 'ER') and ct_cbtecble_det.IdTipoCbte <> 31
GROUP BY ct_plancta.IdEmpresa, ct_cbtecble_det.IdCtaCble, ct_cbtecble_det.IdCentroCosto, ct_cbtecble_det.IdCentroCosto_sub_centro_costo, ct_cbtecble_det.IdPunto_cargo, 
                         ct_cbtecble_det.IdPunto_cargo_grupo
 having round(SUM(ct_cbtecble_det.dc_Valor),2) <>0-- and round(SUM(ct_cbtecble_det.dc_Valor),2) between 25 and 26
 union
 SELECT @IdEmpresa, @IdCtaCble_utilidad, @Valor_utilidad, NULL, NULL, NULL, NULL) A
 ORDER BY IdCtaCble