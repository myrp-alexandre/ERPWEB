CREATE proc [dbo].[spSys_Verificador_flujo_Transferencia]
 @i_idempresa int
,@i_idtransferencia int
as
/*
declare @i_idempresa int
declare @i_idtransferencia int

set @i_idempresa =1
set @i_idtransferencia =28
*/


select 'cabecera transf'
select * from in_transferencia
where IdEmpresa=@i_idempresa and IdTransferencia=@i_idtransferencia

select 'detalle transf'
select * from in_transferencia_det 
where IdEmpresa=@i_idempresa and IdTransferencia=@i_idtransferencia


/*
select 'cab movi inven x egr transf'
SELECT     movi.*, trans.IdEmpresa, trans.IdTransferencia
FROM         in_transferencia AS trans INNER JOIN
                      in_movi_inve AS movi ON trans.IdEmpresa = movi.IdEmpresa AND trans.IdSucursalOrigen = movi.IdSucursal AND trans.IdBodegaOrigen = movi.IdBodega AND 
                      trans.IdMovi_inven_tipo_SucuOrig = movi.IdMovi_inven_tipo AND trans.IdNumMovi_SucOrig = movi.IdNumMovi
WHERE     (trans.IdEmpresa = @i_idempresa) AND (trans.IdTransferencia = @i_idtransferencia)


select 'det movi inven x egr transf'
SELECT     movi.*, trans.IdEmpresa, trans.IdTransferencia
FROM         in_transferencia AS trans INNER JOIN
                      in_movi_inve_detalle  AS movi ON trans.IdEmpresa = movi.IdEmpresa AND trans.IdSucursalOrigen = movi.IdSucursal AND trans.IdBodegaOrigen = movi.IdBodega AND 
                      trans.IdMovi_inven_tipo_SucuOrig = movi.IdMovi_inven_tipo AND trans.IdNumMovi_SucOrig = movi.IdNumMovi
WHERE     (trans.IdEmpresa = @i_idempresa) AND (trans.IdTransferencia = @i_idtransferencia)
*/

/*
select 'tabla intermedia x movi inven x egr transf'
SELECT     trans.IdEmpresa AS Expr1, trans.IdTransferencia, in_movi_inve_x_ct_cbteCble.*
FROM         in_transferencia AS trans INNER JOIN
                      in_movi_inve_x_ct_cbteCble ON trans.IdEmpresa = in_movi_inve_x_ct_cbteCble.IdEmpresa AND 
                      trans.IdSucursalOrigen = in_movi_inve_x_ct_cbteCble.IdSucursal AND trans.IdBodegaOrigen = in_movi_inve_x_ct_cbteCble.IdBodega AND 
                      trans.IdMovi_inven_tipo_SucuOrig = in_movi_inve_x_ct_cbteCble.IdMovi_inven_tipo AND 
                      trans.IdNumMovi_SucOrig = in_movi_inve_x_ct_cbteCble.IdNumMovi
WHERE     (trans.IdEmpresa = @i_idempresa) AND (trans.IdTransferencia = @i_idtransferencia)
*/
/*
select 'cbte cble cab x movi inven x egr transf'
SELECT     trans.IdEmpresa AS Expr1, trans.IdTransferencia, cbte.*, Tcbte.tc_TipoCbte
FROM         in_transferencia AS trans INNER JOIN
                      in_movi_inve_x_ct_cbteCble AS b ON trans.IdEmpresa = b.IdEmpresa AND trans.IdSucursalOrigen = b.IdSucursal AND trans.IdBodegaOrigen = b.IdBodega AND 
                      trans.IdMovi_inven_tipo_SucuOrig = b.IdMovi_inven_tipo AND trans.IdNumMovi_SucOrig = b.IdNumMovi INNER JOIN
                      ct_cbtecble AS cbte ON b.IdEmpresa = cbte.IdEmpresa AND b.IdTipoCbte = cbte.IdTipoCbte AND b.IdCbteCble = cbte.IdCbteCble INNER JOIN
                      ct_cbtecble_tipo AS Tcbte ON cbte.IdTipoCbte = Tcbte.IdTipoCbte
WHERE     (trans.IdEmpresa = @i_idempresa) AND (trans.IdTransferencia = @i_idtransferencia)



select 'cbte cble det x movi inven x egr transf'
SELECT     trans.IdEmpresa AS Expr1, trans.IdTransferencia, ct_cbtecble_det.*, ct_plancta.pc_Cuenta
FROM         ct_plancta INNER JOIN
                      ct_cbtecble_det ON ct_plancta.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_plancta.IdCtaCble = ct_cbtecble_det.IdCtaCble INNER JOIN
                      in_transferencia AS trans INNER JOIN
                      in_movi_inve_x_ct_cbteCble AS b ON trans.IdEmpresa = b.IdEmpresa AND trans.IdSucursalOrigen = b.IdSucursal AND trans.IdBodegaOrigen = b.IdBodega AND 
                      trans.IdMovi_inven_tipo_SucuOrig = b.IdMovi_inven_tipo AND trans.IdNumMovi_SucOrig = b.IdNumMovi ON ct_cbtecble_det.IdEmpresa = b.IdEmpresa AND 
                      ct_cbtecble_det.IdTipoCbte = b.IdTipoCbte AND ct_cbtecble_det.IdCbteCble = b.IdCbteCble
WHERE     (trans.IdEmpresa = @i_idempresa) AND (trans.IdTransferencia = @i_idtransferencia)

*/

/*
select 'cab movi inven x ing transf'
SELECT     movi.*, trans.IdEmpresa, trans.IdTransferencia
FROM         in_transferencia AS trans INNER JOIN
                      in_movi_inve AS movi ON trans.IdEmpresa = movi.IdEmpresa AND trans.IdSucursalDest = movi.IdSucursal AND trans.IdBodegaDest = movi.IdBodega AND 
                      trans.IdMovi_inven_tipo_SucuDest = movi.IdMovi_inven_tipo AND trans.IdNumMovi_SucDest = movi.IdNumMovi
WHERE     (trans.IdEmpresa = @i_idempresa) AND (trans.IdTransferencia = @i_idtransferencia)


select 'det movi inven x ing transf'
SELECT     movi.*, trans.IdEmpresa, trans.IdTransferencia
FROM         in_transferencia AS trans INNER JOIN
                      in_movi_inve_detalle  AS movi ON trans.IdEmpresa = movi.IdEmpresa AND trans.IdSucursalDest = movi.IdSucursal AND trans.IdBodegaDest = movi.IdBodega AND 
                      trans.IdMovi_inven_tipo_SucuDest = movi.IdMovi_inven_tipo AND trans.IdNumMovi_SucDest = movi.IdNumMovi
WHERE     (trans.IdEmpresa = @i_idempresa) AND (trans.IdTransferencia = @i_idtransferencia)



select 'cbte cble cab x movi inven x ing transf'
SELECT     trans.IdEmpresa AS Expr1, trans.IdTransferencia, ct_cbtecble.*, ct_cbtecble_tipo.tc_TipoCbte
FROM         in_transferencia AS trans INNER JOIN
                      in_movi_inve_x_ct_cbteCble AS b ON trans.IdEmpresa = b.IdEmpresa AND trans.IdSucursalDest = b.IdSucursal AND trans.IdBodegaDest = b.IdBodega AND 
                      trans.IdMovi_inven_tipo_SucuDest = b.IdMovi_inven_tipo AND trans.IdNumMovi_SucDest = b.IdNumMovi INNER JOIN
                      ct_cbtecble ON b.IdEmpresa = ct_cbtecble.IdEmpresa AND b.IdTipoCbte = ct_cbtecble.IdTipoCbte AND b.IdCbteCble = ct_cbtecble.IdCbteCble INNER JOIN
                      ct_cbtecble_tipo ON ct_cbtecble.IdTipoCbte = ct_cbtecble_tipo.IdTipoCbte
WHERE     (trans.IdEmpresa = @i_idempresa) AND (trans.IdTransferencia = @i_idtransferencia)


select 'cbte cble det x movi inven x ing transf'
SELECT     trans.IdEmpresa AS Expr1, trans.IdTransferencia, ct_cbtecble_det.*, ct_plancta.pc_Cuenta
FROM         in_transferencia AS trans INNER JOIN
                      in_movi_inve_x_ct_cbteCble AS b ON trans.IdEmpresa = b.IdEmpresa AND trans.IdSucursalDest = b.IdSucursal AND trans.IdBodegaDest = b.IdBodega AND 
                      trans.IdMovi_inven_tipo_SucuDest = b.IdMovi_inven_tipo AND trans.IdNumMovi_SucDest = b.IdNumMovi INNER JOIN
                      ct_cbtecble ON b.IdEmpresa = ct_cbtecble.IdEmpresa AND b.IdTipoCbte = ct_cbtecble.IdTipoCbte AND b.IdCbteCble = ct_cbtecble.IdCbteCble INNER JOIN
                      ct_cbtecble_det ON ct_cbtecble.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_cbtecble.IdTipoCbte = ct_cbtecble_det.IdTipoCbte AND 
                      ct_cbtecble.IdCbteCble = ct_cbtecble_det.IdCbteCble INNER JOIN
                      ct_plancta ON ct_cbtecble_det.IdEmpresa = ct_plancta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ct_plancta.IdCtaCble
WHERE     (trans.IdEmpresa = @i_idempresa) AND (trans.IdTransferencia = @i_idtransferencia)
*/