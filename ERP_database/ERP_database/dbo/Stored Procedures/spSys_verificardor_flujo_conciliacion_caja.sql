CREATE proc [dbo].[spSys_verificardor_flujo_conciliacion_caja]
(
 @i_idempresa int
,@i_idConciliacion_Caja numeric

)
as
/*
declare @i_idempresa int
declare @i_idConciliacion_Caja numeric


set @i_idempresa =1
set @i_idConciliacion_Caja =2
*/ 

select '*** conciliacion de caja***'
select * from cp_conciliacion_Caja
where IdEmpresa=@i_idempresa
and IdConciliacion_Caja=@i_idConciliacion_Caja

/*
select '*** oreden giro***'
SELECT     cp_orden_giro.*
FROM         cp_conciliacion_Caja INNER JOIN
                      cp_orden_giro ON cp_conciliacion_Caja.IdEmpresa_OGiro = cp_orden_giro.IdEmpresa AND 
                      cp_conciliacion_Caja.IdCbteCble_Ogiro = cp_orden_giro.IdCbteCble_Ogiro AND cp_conciliacion_Caja.IdTipoCbte_Ogiro = cp_orden_giro.IdTipoCbte_Ogiro
where     cp_conciliacion_Caja.IdEmpresa=@i_idempresa
and     cp_conciliacion_Caja.IdConciliacion_Caja=@i_idConciliacion_Caja   

*/
  select '*** cbte contable cabecera***'         

  /*
SELECT     ct_cbtecble.*
FROM         cp_conciliacion_Caja INNER JOIN
                      cp_orden_giro ON cp_conciliacion_Caja.IdEmpresa_OGiro = cp_orden_giro.IdEmpresa AND 
                      cp_conciliacion_Caja.IdCbteCble_Ogiro = cp_orden_giro.IdCbteCble_Ogiro AND cp_conciliacion_Caja.IdTipoCbte_Ogiro = cp_orden_giro.IdTipoCbte_Ogiro INNER JOIN
                      ct_cbtecble ON cp_orden_giro.IdEmpresa = ct_cbtecble.IdEmpresa AND cp_orden_giro.IdTipoCbte_Ogiro = ct_cbtecble.IdTipoCbte AND 
                      cp_orden_giro.IdCbteCble_Ogiro = ct_cbtecble.IdCbteCble
WHERE     (cp_conciliacion_Caja.IdEmpresa = @i_idempresa) AND (cp_conciliacion_Caja.IdConciliacion_Caja = @i_idConciliacion_Caja)


select '***cbte contable detalle***'         
SELECT     ct_cbtecble_det.*, ct_plancta.IdCtaCble , ct_plancta.pc_Cuenta
FROM         cp_conciliacion_Caja INNER JOIN
                      cp_orden_giro ON cp_conciliacion_Caja.IdEmpresa_OGiro = cp_orden_giro.IdEmpresa AND 
                      cp_conciliacion_Caja.IdCbteCble_Ogiro = cp_orden_giro.IdCbteCble_Ogiro AND cp_conciliacion_Caja.IdTipoCbte_Ogiro = cp_orden_giro.IdTipoCbte_Ogiro INNER JOIN
                      ct_cbtecble_det ON cp_orden_giro.IdEmpresa = ct_cbtecble_det.IdEmpresa AND cp_orden_giro.IdTipoCbte_Ogiro = ct_cbtecble_det.IdTipoCbte AND 
                      cp_orden_giro.IdCbteCble_Ogiro = ct_cbtecble_det.IdCbteCble INNER JOIN
                      ct_plancta ON ct_cbtecble_det.IdEmpresa = ct_plancta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ct_plancta.IdCtaCble
WHERE     (cp_conciliacion_Caja.IdEmpresa = @i_idempresa) AND (cp_conciliacion_Caja.IdConciliacion_Caja = @i_idConciliacion_Caja)
*/
select '***cabecera retencion***'
/*  
SELECT     cp_retencion.*
FROM         cp_conciliacion_Caja INNER JOIN
                      cp_orden_giro ON cp_conciliacion_Caja.IdEmpresa_OGiro = cp_orden_giro.IdEmpresa AND 
                      cp_conciliacion_Caja.IdCbteCble_Ogiro = cp_orden_giro.IdCbteCble_Ogiro AND cp_conciliacion_Caja.IdTipoCbte_Ogiro = cp_orden_giro.IdTipoCbte_Ogiro INNER JOIN
                      cp_retencion ON cp_orden_giro.IdEmpresa = cp_retencion.IdEmpresa AND cp_orden_giro.IdCbteCble_Ogiro = cp_retencion.IdCbteCble_Ogiro AND 
                      cp_orden_giro.IdTipoCbte_Ogiro = cp_retencion.IdTipoCbte_Ogiro
WHERE     (cp_conciliacion_Caja.IdEmpresa = @i_idempresa) AND (cp_conciliacion_Caja.IdConciliacion_Caja = @i_idConciliacion_Caja)

select '***detalle retencion***'  
SELECT     cp_retencion_det.*
FROM         cp_conciliacion_Caja INNER JOIN
                      cp_orden_giro ON cp_conciliacion_Caja.IdEmpresa_OGiro = cp_orden_giro.IdEmpresa AND 
                      cp_conciliacion_Caja.IdCbteCble_Ogiro = cp_orden_giro.IdCbteCble_Ogiro AND cp_conciliacion_Caja.IdTipoCbte_Ogiro = cp_orden_giro.IdTipoCbte_Ogiro INNER JOIN
                      cp_retencion ON cp_orden_giro.IdEmpresa = cp_retencion.IdEmpresa AND cp_orden_giro.IdCbteCble_Ogiro = cp_retencion.IdCbteCble_Ogiro AND 
                      cp_orden_giro.IdTipoCbte_Ogiro = cp_retencion.IdTipoCbte_Ogiro INNER JOIN
                      cp_retencion_det ON cp_retencion.IdEmpresa = cp_retencion_det.IdEmpresa AND cp_retencion.IdCbteCble_Ogiro = cp_retencion_det.IdCbteCble_Ogiro AND 
                      cp_retencion.IdTipoCbte_Ogiro = cp_retencion_det.IdTipoCbte_Ogiro AND cp_retencion.IdRetencion = cp_retencion_det.IdRetencion
WHERE     (cp_conciliacion_Caja.IdEmpresa = @i_idempresa) AND (cp_conciliacion_Caja.IdConciliacion_Caja = @i_idConciliacion_Caja)

select '***Diario ret cabecera***'  
SELECT     ct_cbtecble.*
FROM         cp_conciliacion_Caja INNER JOIN
                      cp_orden_giro ON cp_conciliacion_Caja.IdEmpresa_OGiro = cp_orden_giro.IdEmpresa AND 
                      cp_conciliacion_Caja.IdCbteCble_Ogiro = cp_orden_giro.IdCbteCble_Ogiro AND cp_conciliacion_Caja.IdTipoCbte_Ogiro = cp_orden_giro.IdTipoCbte_Ogiro INNER JOIN
                      cp_retencion ON cp_orden_giro.IdEmpresa = cp_retencion.IdEmpresa AND cp_orden_giro.IdCbteCble_Ogiro = cp_retencion.IdCbteCble_Ogiro AND 
                      cp_orden_giro.IdTipoCbte_Ogiro = cp_retencion.IdTipoCbte_Ogiro INNER JOIN
                      cp_retencion_x_ct_cbtecble ON cp_retencion.IdEmpresa = cp_retencion_x_ct_cbtecble.rt_IdEmpresa AND 
                      cp_retencion.IdCbteCble_Ogiro = cp_retencion_x_ct_cbtecble.rt_IdCbteCble_Ogiro AND 
                      cp_retencion.IdTipoCbte_Ogiro = cp_retencion_x_ct_cbtecble.rt_IdTipoCbte_Ogiro AND 
                      cp_retencion.IdRetencion = cp_retencion_x_ct_cbtecble.rt_IdRetencion INNER JOIN
                      ct_cbtecble ON cp_retencion_x_ct_cbtecble.ct_IdEmpresa = ct_cbtecble.IdEmpresa AND cp_retencion_x_ct_cbtecble.ct_IdTipoCbte = ct_cbtecble.IdTipoCbte AND 
                      cp_retencion_x_ct_cbtecble.ct_IdCbteCble = ct_cbtecble.IdCbteCble
WHERE     (cp_conciliacion_Caja.IdEmpresa = @i_idempresa) AND (cp_conciliacion_Caja.IdConciliacion_Caja = @i_idConciliacion_Caja)

select '***Diario ret detalle***'  
SELECT     ct_cbtecble_det.*, ct_plancta.IdCtaCble AS Expr1, ct_plancta.pc_Cuenta
FROM         cp_conciliacion_Caja INNER JOIN
                      cp_orden_giro ON cp_conciliacion_Caja.IdEmpresa_OGiro = cp_orden_giro.IdEmpresa AND 
                      cp_conciliacion_Caja.IdCbteCble_Ogiro = cp_orden_giro.IdCbteCble_Ogiro AND cp_conciliacion_Caja.IdTipoCbte_Ogiro = cp_orden_giro.IdTipoCbte_Ogiro INNER JOIN
                      cp_retencion ON cp_orden_giro.IdEmpresa = cp_retencion.IdEmpresa AND cp_orden_giro.IdCbteCble_Ogiro = cp_retencion.IdCbteCble_Ogiro AND 
                      cp_orden_giro.IdTipoCbte_Ogiro = cp_retencion.IdTipoCbte_Ogiro INNER JOIN
                      cp_retencion_x_ct_cbtecble ON cp_retencion.IdEmpresa = cp_retencion_x_ct_cbtecble.rt_IdEmpresa AND 
                      cp_retencion.IdCbteCble_Ogiro = cp_retencion_x_ct_cbtecble.rt_IdCbteCble_Ogiro AND 
                      cp_retencion.IdTipoCbte_Ogiro = cp_retencion_x_ct_cbtecble.rt_IdTipoCbte_Ogiro AND 
                      cp_retencion.IdRetencion = cp_retencion_x_ct_cbtecble.rt_IdRetencion INNER JOIN
                      ct_cbtecble_det ON cp_retencion_x_ct_cbtecble.ct_IdEmpresa = ct_cbtecble_det.IdEmpresa AND 
                      cp_retencion_x_ct_cbtecble.ct_IdTipoCbte = ct_cbtecble_det.IdTipoCbte AND cp_retencion_x_ct_cbtecble.ct_IdCbteCble = ct_cbtecble_det.IdCbteCble INNER JOIN
                      ct_plancta ON ct_cbtecble_det.IdEmpresa = ct_plancta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ct_plancta.IdCtaCble
WHERE     (cp_conciliacion_Caja.IdEmpresa = @i_idempresa) AND (cp_conciliacion_Caja.IdConciliacion_Caja = @i_idConciliacion_Caja)


select '***cabecera orden pago**'  
SELECT     cp_orden_pago.*
FROM         cp_orden_pago_det INNER JOIN
                      cp_orden_pago ON cp_orden_pago_det.IdEmpresa = cp_orden_pago.IdEmpresa AND cp_orden_pago_det.IdOrdenPago = cp_orden_pago.IdOrdenPago INNER JOIN
                      cp_conciliacion_Caja INNER JOIN
                      cp_orden_giro ON cp_conciliacion_Caja.IdEmpresa_OGiro = cp_orden_giro.IdEmpresa AND 
                      cp_conciliacion_Caja.IdCbteCble_Ogiro = cp_orden_giro.IdCbteCble_Ogiro AND cp_conciliacion_Caja.IdTipoCbte_Ogiro = cp_orden_giro.IdTipoCbte_Ogiro ON 
                      cp_orden_pago_det.IdEmpresa_cxp = cp_orden_giro.IdEmpresa AND cp_orden_pago_det.IdCbteCble_cxp = cp_orden_giro.IdCbteCble_Ogiro AND 
                      cp_orden_pago_det.IdTipoCbte_cxp = cp_orden_giro.IdTipoCbte_Ogiro
WHERE     (cp_conciliacion_Caja.IdEmpresa = @i_idempresa) AND (cp_conciliacion_Caja.IdConciliacion_Caja = @i_idConciliacion_Caja)

select '***detalle orden pago**'  
SELECT     cp_orden_pago_det.*
FROM         cp_orden_pago_det INNER JOIN
                      cp_orden_pago ON cp_orden_pago_det.IdEmpresa = cp_orden_pago.IdEmpresa AND cp_orden_pago_det.IdOrdenPago = cp_orden_pago.IdOrdenPago INNER JOIN
                      cp_conciliacion_Caja INNER JOIN
                      cp_orden_giro ON cp_conciliacion_Caja.IdEmpresa_OGiro = cp_orden_giro.IdEmpresa AND 
                      cp_conciliacion_Caja.IdCbteCble_Ogiro = cp_orden_giro.IdCbteCble_Ogiro AND cp_conciliacion_Caja.IdTipoCbte_Ogiro = cp_orden_giro.IdTipoCbte_Ogiro ON 
                      cp_orden_pago_det.IdEmpresa_cxp = cp_orden_giro.IdEmpresa AND cp_orden_pago_det.IdCbteCble_cxp = cp_orden_giro.IdCbteCble_Ogiro AND 
                      cp_orden_pago_det.IdTipoCbte_cxp = cp_orden_giro.IdTipoCbte_Ogiro
WHERE     (cp_conciliacion_Caja.IdEmpresa = @i_idempresa) AND (cp_conciliacion_Caja.IdConciliacion_Caja = @i_idConciliacion_Caja)


select '***cabecera caja Movi**' 
SELECT     caj_Caja_Movimiento.*
FROM         cp_orden_pago_det INNER JOIN
                      cp_orden_pago ON cp_orden_pago_det.IdEmpresa = cp_orden_pago.IdEmpresa AND cp_orden_pago_det.IdOrdenPago = cp_orden_pago.IdOrdenPago INNER JOIN
                      cp_conciliacion_Caja INNER JOIN
                      cp_orden_giro ON cp_conciliacion_Caja.IdEmpresa_OGiro = cp_orden_giro.IdEmpresa AND 
                      cp_conciliacion_Caja.IdCbteCble_Ogiro = cp_orden_giro.IdCbteCble_Ogiro AND cp_conciliacion_Caja.IdTipoCbte_Ogiro = cp_orden_giro.IdTipoCbte_Ogiro ON 
                      cp_orden_pago_det.IdEmpresa_cxp = cp_orden_giro.IdEmpresa AND cp_orden_pago_det.IdCbteCble_cxp = cp_orden_giro.IdCbteCble_Ogiro AND 
                      cp_orden_pago_det.IdTipoCbte_cxp = cp_orden_giro.IdTipoCbte_Ogiro INNER JOIN
                      caj_Caja_Movimiento_det ON cp_orden_pago.IdEmpresa = caj_Caja_Movimiento_det.IdEmpresa_OP AND 
                      cp_orden_pago.IdOrdenPago = caj_Caja_Movimiento_det.IdOrdenPago_OP INNER JOIN
                      caj_Caja_Movimiento ON caj_Caja_Movimiento_det.IdEmpresa = caj_Caja_Movimiento.IdEmpresa AND 
                      caj_Caja_Movimiento_det.IdCbteCble = caj_Caja_Movimiento.IdCbteCble AND caj_Caja_Movimiento_det.IdTipocbte = caj_Caja_Movimiento.IdTipocbte
WHERE     (cp_conciliacion_Caja.IdEmpresa = @i_idempresa) AND (cp_conciliacion_Caja.IdConciliacion_Caja = @i_idConciliacion_Caja)


select '***detalle caja Movi**' 
SELECT     caj_Caja_Movimiento_det.*
FROM         cp_orden_pago_det INNER JOIN
                      cp_orden_pago ON cp_orden_pago_det.IdEmpresa = cp_orden_pago.IdEmpresa AND cp_orden_pago_det.IdOrdenPago = cp_orden_pago.IdOrdenPago INNER JOIN
                      cp_conciliacion_Caja INNER JOIN
                      cp_orden_giro ON cp_conciliacion_Caja.IdEmpresa_OGiro = cp_orden_giro.IdEmpresa AND 
                      cp_conciliacion_Caja.IdCbteCble_Ogiro = cp_orden_giro.IdCbteCble_Ogiro AND cp_conciliacion_Caja.IdTipoCbte_Ogiro = cp_orden_giro.IdTipoCbte_Ogiro ON 
                      cp_orden_pago_det.IdEmpresa_cxp = cp_orden_giro.IdEmpresa AND cp_orden_pago_det.IdCbteCble_cxp = cp_orden_giro.IdCbteCble_Ogiro AND 
                      cp_orden_pago_det.IdTipoCbte_cxp = cp_orden_giro.IdTipoCbte_Ogiro INNER JOIN
                      caj_Caja_Movimiento_det ON cp_orden_pago.IdEmpresa = caj_Caja_Movimiento_det.IdEmpresa_OP AND 
                      cp_orden_pago.IdOrdenPago = caj_Caja_Movimiento_det.IdOrdenPago_OP INNER JOIN
                      caj_Caja_Movimiento ON caj_Caja_Movimiento_det.IdEmpresa = caj_Caja_Movimiento.IdEmpresa AND 
                      caj_Caja_Movimiento_det.IdCbteCble = caj_Caja_Movimiento.IdCbteCble AND caj_Caja_Movimiento_det.IdTipocbte = caj_Caja_Movimiento.IdTipocbte
WHERE     (cp_conciliacion_Caja.IdEmpresa = @i_idempresa) AND (cp_conciliacion_Caja.IdConciliacion_Caja = @i_idConciliacion_Caja)


select '***diario cab Movi Caja**' 
SELECT     ct_cbtecble.*
FROM         cp_orden_pago_det INNER JOIN
                      cp_orden_pago ON cp_orden_pago_det.IdEmpresa = cp_orden_pago.IdEmpresa AND cp_orden_pago_det.IdOrdenPago = cp_orden_pago.IdOrdenPago INNER JOIN
                      cp_conciliacion_Caja INNER JOIN
                      cp_orden_giro ON cp_conciliacion_Caja.IdEmpresa_OGiro = cp_orden_giro.IdEmpresa AND 
                      cp_conciliacion_Caja.IdCbteCble_Ogiro = cp_orden_giro.IdCbteCble_Ogiro AND cp_conciliacion_Caja.IdTipoCbte_Ogiro = cp_orden_giro.IdTipoCbte_Ogiro ON 
                      cp_orden_pago_det.IdEmpresa_cxp = cp_orden_giro.IdEmpresa AND cp_orden_pago_det.IdCbteCble_cxp = cp_orden_giro.IdCbteCble_Ogiro AND 
                      cp_orden_pago_det.IdTipoCbte_cxp = cp_orden_giro.IdTipoCbte_Ogiro INNER JOIN
                      caj_Caja_Movimiento_det ON cp_orden_pago.IdEmpresa = caj_Caja_Movimiento_det.IdEmpresa_OP AND 
                      cp_orden_pago.IdOrdenPago = caj_Caja_Movimiento_det.IdOrdenPago_OP INNER JOIN
                      caj_Caja_Movimiento ON caj_Caja_Movimiento_det.IdEmpresa = caj_Caja_Movimiento.IdEmpresa AND 
                      caj_Caja_Movimiento_det.IdCbteCble = caj_Caja_Movimiento.IdCbteCble AND caj_Caja_Movimiento_det.IdTipocbte = caj_Caja_Movimiento.IdTipocbte INNER JOIN
                      ct_cbtecble ON caj_Caja_Movimiento.IdEmpresa = ct_cbtecble.IdEmpresa AND caj_Caja_Movimiento.IdTipocbte = ct_cbtecble.IdTipoCbte AND 
                      caj_Caja_Movimiento.IdCbteCble = ct_cbtecble.IdCbteCble
WHERE     (cp_conciliacion_Caja.IdEmpresa = @i_idempresa) AND (cp_conciliacion_Caja.IdConciliacion_Caja = @i_idConciliacion_Caja)

select '***diario det Movi Caja**' 
SELECT     ct_cbtecble_det.IdEmpresa, ct_cbtecble_det.IdTipoCbte, ct_cbtecble_det.IdCbteCble, ct_cbtecble_det.secuencia, ct_cbtecble_det.IdCtaCble, 
                      ct_cbtecble_det.IdCentroCosto, ct_cbtecble_det.IdCentroCosto_sub_centro_costo, ct_cbtecble_det.dc_Valor, ct_cbtecble_det.dc_Observacion, 
                      ct_cbtecble_det.dc_Numconciliacion, ct_cbtecble_det.dc_EstaConciliado, ct_plancta.IdCtaCble, ct_plancta.pc_Cuenta
FROM         cp_orden_pago_det INNER JOIN
                      cp_orden_pago ON cp_orden_pago_det.IdEmpresa = cp_orden_pago.IdEmpresa AND cp_orden_pago_det.IdOrdenPago = cp_orden_pago.IdOrdenPago INNER JOIN
                      cp_conciliacion_Caja INNER JOIN
                      cp_orden_giro ON cp_conciliacion_Caja.IdEmpresa_OGiro = cp_orden_giro.IdEmpresa AND 
                      cp_conciliacion_Caja.IdCbteCble_Ogiro = cp_orden_giro.IdCbteCble_Ogiro AND cp_conciliacion_Caja.IdTipoCbte_Ogiro = cp_orden_giro.IdTipoCbte_Ogiro ON 
                      cp_orden_pago_det.IdEmpresa_cxp = cp_orden_giro.IdEmpresa AND cp_orden_pago_det.IdCbteCble_cxp = cp_orden_giro.IdCbteCble_Ogiro AND 
                      cp_orden_pago_det.IdTipoCbte_cxp = cp_orden_giro.IdTipoCbte_Ogiro INNER JOIN
                      caj_Caja_Movimiento_det ON cp_orden_pago.IdEmpresa = caj_Caja_Movimiento_det.IdEmpresa_OP AND 
                      cp_orden_pago.IdOrdenPago = caj_Caja_Movimiento_det.IdOrdenPago_OP INNER JOIN
                      caj_Caja_Movimiento ON caj_Caja_Movimiento_det.IdEmpresa = caj_Caja_Movimiento.IdEmpresa AND 
                      caj_Caja_Movimiento_det.IdCbteCble = caj_Caja_Movimiento.IdCbteCble AND caj_Caja_Movimiento_det.IdTipocbte = caj_Caja_Movimiento.IdTipocbte INNER JOIN
                      ct_cbtecble_det ON caj_Caja_Movimiento.IdEmpresa = ct_cbtecble_det.IdEmpresa AND caj_Caja_Movimiento.IdTipocbte = ct_cbtecble_det.IdTipoCbte AND 
                      caj_Caja_Movimiento.IdCbteCble = ct_cbtecble_det.IdCbteCble INNER JOIN
                      ct_plancta ON ct_cbtecble_det.IdEmpresa = ct_plancta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ct_plancta.IdCtaCble
WHERE     (cp_conciliacion_Caja.IdEmpresa = @i_idempresa) AND (cp_conciliacion_Caja.IdConciliacion_Caja = @i_idConciliacion_Caja)

select '***cp_orden_pago_cancelaciones**' 
SELECT     cp_orden_pago_cancelaciones.*
FROM         cp_orden_pago_det INNER JOIN
                      cp_conciliacion_Caja INNER JOIN
                      cp_orden_giro ON cp_conciliacion_Caja.IdEmpresa_OGiro = cp_orden_giro.IdEmpresa AND 
                      cp_conciliacion_Caja.IdCbteCble_Ogiro = cp_orden_giro.IdCbteCble_Ogiro AND cp_conciliacion_Caja.IdTipoCbte_Ogiro = cp_orden_giro.IdTipoCbte_Ogiro ON 
                      cp_orden_pago_det.IdEmpresa_cxp = cp_orden_giro.IdEmpresa AND cp_orden_pago_det.IdCbteCble_cxp = cp_orden_giro.IdCbteCble_Ogiro AND 
                      cp_orden_pago_det.IdTipoCbte_cxp = cp_orden_giro.IdTipoCbte_Ogiro INNER JOIN
                      cp_orden_pago_cancelaciones ON cp_orden_pago_det.IdEmpresa = cp_orden_pago_cancelaciones.IdEmpresa_op AND 
                      cp_orden_pago_det.IdOrdenPago = cp_orden_pago_cancelaciones.IdOrdenPago_op AND 
                      cp_orden_pago_det.Secuencia = cp_orden_pago_cancelaciones.Secuencia_op
WHERE     (cp_conciliacion_Caja.IdEmpresa = @i_idempresa) AND (cp_conciliacion_Caja.IdConciliacion_Caja = @i_idConciliacion_Caja)
*/