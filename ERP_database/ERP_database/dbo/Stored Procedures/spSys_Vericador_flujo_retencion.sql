CREATE proc [dbo].[spSys_Vericador_flujo_retencion]
(
 @i_idempresa int
,@i_idRetencion numeric
)
as
/*
declare @i_idempresa int
declare @i_idRetencion numeric

set @i_idRetencion =1
set @i_idempresa =1
*/
select 'cabecera reten' 
select * from cp_retencion  where IdEmpresa=@i_idempresa and IdRetencion=@i_idRetencion

select 'det reten' 
select * from cp_retencion_det where IdEmpresa=@i_idempresa and IdRetencion=@i_idRetencion

select 'relacion contable' 
select * from cp_retencion_x_ct_cbtecble  where rt_IdEmpresa=@i_idempresa and rt_IdRetencion=@i_idRetencion


select 'diario x ret cab' 
SELECT     cp_retencion_x_ct_cbtecble.Observacion, ct_cbtecble.*, ct_cbtecble_tipo.tc_TipoCbte
FROM         cp_retencion_x_ct_cbtecble INNER JOIN
                      ct_cbtecble ON cp_retencion_x_ct_cbtecble.ct_IdEmpresa = ct_cbtecble.IdEmpresa AND cp_retencion_x_ct_cbtecble.ct_IdTipoCbte = ct_cbtecble.IdTipoCbte AND 
                      cp_retencion_x_ct_cbtecble.ct_IdCbteCble = ct_cbtecble.IdCbteCble INNER JOIN
                      ct_cbtecble_tipo ON ct_cbtecble.IdTipoCbte = ct_cbtecble_tipo.IdTipoCbte
WHERE     (cp_retencion_x_ct_cbtecble.rt_IdEmpresa = @i_idempresa) 
AND (cp_retencion_x_ct_cbtecble.rt_IdRetencion = @i_idRetencion)


select 'diario x ret det' 
SELECT     ct_cbtecble_det.*, ct_plancta.pc_Cuenta
FROM         cp_retencion_x_ct_cbtecble INNER JOIN
                      ct_cbtecble_det ON cp_retencion_x_ct_cbtecble.ct_IdEmpresa = ct_cbtecble_det.IdEmpresa AND 
                      cp_retencion_x_ct_cbtecble.ct_IdTipoCbte = ct_cbtecble_det.IdTipoCbte AND cp_retencion_x_ct_cbtecble.ct_IdCbteCble = ct_cbtecble_det.IdCbteCble INNER JOIN
                      ct_plancta ON ct_cbtecble_det.IdEmpresa = ct_plancta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ct_plancta.IdCtaCble
WHERE     (cp_retencion_x_ct_cbtecble.rt_IdEmpresa = @i_idempresa)
 AND (cp_retencion_x_ct_cbtecble.rt_IdRetencion = @i_idRetencion)
 
 
 select 'diario x Anu ret cab' 
 SELECT     ct_cbtecble.*, ct_cbtecble_tipo.tc_TipoCbte
FROM         ct_cbtecble_tipo INNER JOIN
                      ct_cbtecble ON ct_cbtecble_tipo.IdTipoCbte = ct_cbtecble.IdTipoCbte INNER JOIN
                      cp_retencion ON ct_cbtecble.IdEmpresa = cp_retencion.ct_IdEmpresa_Anu AND ct_cbtecble.IdTipoCbte = cp_retencion.ct_IdTipoCbte_Anu AND 
                      ct_cbtecble.IdCbteCble = cp_retencion.ct_IdCbteCble_Anu
WHERE     (cp_retencion.IdEmpresa = @i_idempresa) AND (cp_retencion.IdRetencion = @i_idRetencion)

 select 'diario x Anu ret det' 
 SELECT     ct_cbtecble_det.IdEmpresa, ct_cbtecble_det.IdTipoCbte, ct_cbtecble_det.IdCbteCble, ct_cbtecble_det.secuencia, ct_cbtecble_det.IdCtaCble, 
                      ct_cbtecble_det.IdCentroCosto, ct_cbtecble_det.IdCentroCosto_sub_centro_costo, ct_cbtecble_det.dc_Valor, ct_cbtecble_det.dc_Observacion, 
                      0 dc_Numconciliacion, 'N' dc_EstaConciliado, ct_plancta.pc_Cuenta
FROM         ct_cbtecble_det INNER JOIN
                      ct_plancta ON ct_cbtecble_det.IdEmpresa = ct_plancta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ct_plancta.IdCtaCble INNER JOIN
                      cp_retencion ON ct_cbtecble_det.IdEmpresa = cp_retencion.ct_IdEmpresa_Anu AND ct_cbtecble_det.IdTipoCbte = cp_retencion.ct_IdTipoCbte_Anu AND 
                      ct_cbtecble_det.IdCbteCble = cp_retencion.ct_IdCbteCble_Anu
WHERE     (cp_retencion.IdEmpresa = @i_idempresa) 
AND (cp_retencion.IdRetencion = @i_idRetencion)
