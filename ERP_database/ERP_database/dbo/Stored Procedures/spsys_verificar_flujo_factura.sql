
---exec [spsys_verificar_flujo_factura]  1,1,1,30


CREATE  proc [dbo].[spsys_verificar_flujo_factura]
(
 @i_idempresa int
,@i_idsucursal int
,@i_idbodega int
,@i_idcteVta int
)
as
/*
declare @i_idempresa int
declare @i_idsucursal int
declare @i_idbodega int
declare @i_idcteVta int

set @i_idempresa =1
set @i_idsucursal =1
set @i_idbodega =1
set @i_idcteVta =76846

*/

select '**FACTURA**'
select * from fa_factura
where IdEmpresa=@i_idempresa
and IdSucursal=@i_idsucursal
and IdBodega=@i_idbodega
and IdCbteVta=@i_idcteVta

select '**FACTURA DETALLE**'
select * from fa_factura_det
where IdEmpresa=@i_idempresa
and IdSucursal=@i_idsucursal
and IdBodega=@i_idbodega
and IdCbteVta=@i_idcteVta


select '**FORMA PAGO**'
select * 
from fa_factura_x_formaPago
where IdEmpresa=@i_idempresa
and IdSucursal=@i_idsucursal
and IdBodega=@i_idbodega
and IdCbteVta=@i_idcteVta


select '**fa_factura_x_ct_cbtecble**'
select * 
from fa_factura_x_ct_cbtecble A
where A.vt_IdEmpresa=@i_idempresa
and A.vt_IdSucursal=@i_idsucursal
and A.vt_IdBodega=@i_idbodega
and A.vt_IdCbteVta=@i_idcteVta


select '**CBTE CABECERA **'
SELECT     ct_cbtecble.*
FROM         fa_factura_x_ct_cbtecble AS A INNER JOIN
ct_cbtecble ON A.ct_IdEmpresa = ct_cbtecble.IdEmpresa 
AND A.ct_IdTipoCbte = ct_cbtecble.IdTipoCbte 
AND A.ct_IdCbteCble = ct_cbtecble.IdCbteCble
where A.vt_IdEmpresa=@i_idempresa
and A.vt_IdSucursal=@i_idsucursal
and A.vt_IdBodega=@i_idbodega
and A.vt_IdCbteVta=@i_idcteVta


select '**CBTE DETALLE **'
SELECT     ct_cbtecble_det.*, ct_cbtecble_tipo.tc_TipoCbte, ct_plancta.IdCtaCble, ct_plancta.pc_Cuenta
FROM         ct_cbtecble_tipo INNER JOIN
ct_cbtecble_det ON ct_cbtecble_tipo.IdTipoCbte = ct_cbtecble_det.IdTipoCbte INNER JOIN
ct_plancta ON ct_cbtecble_det.IdEmpresa = ct_plancta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ct_plancta.IdCtaCble INNER JOIN
fa_factura_x_ct_cbtecble AS A ON ct_cbtecble_det.IdEmpresa = A.ct_IdEmpresa AND ct_cbtecble_det.IdTipoCbte = A.ct_IdTipoCbte AND 
ct_cbtecble_det.IdCbteCble = A.ct_IdCbteCble
where A.vt_IdEmpresa=@i_idempresa
and A.vt_IdSucursal=@i_idsucursal
and A.vt_IdBodega=@i_idbodega
and A.vt_IdCbteVta=@i_idcteVta

select '**FACT X MOVI INVEN **'
select * from fa_factura_x_in_movi_inve A
where A.fa_IdEmpresa=@i_idempresa
and A.fa_IdSucursal=@i_idsucursal
and A.fa_IdBodega=@i_idbodega
and A.fa_IdCbteVta=@i_idcteVta


--select * from in_Ing_Egr_Inven


select '**MOVI INVEN CAB**'
SELECT     in_movi_inve.*, in_movi_inven_tipo.tm_descripcion
FROM         fa_factura_x_in_movi_inve AS A INNER JOIN
in_movi_inve ON A.inv_IdEmpresa = in_movi_inve.IdEmpresa AND A.inv_IdSucursal = in_movi_inve.IdSucursal AND A.inv_IdBodega = in_movi_inve.IdBodega AND 
A.inv_IdMovi_inven_tipo = in_movi_inve.IdMovi_inven_tipo AND A.inv_IdNumMovi = in_movi_inve.IdNumMovi INNER JOIN
in_movi_inven_tipo ON in_movi_inve.IdEmpresa = in_movi_inven_tipo.IdEmpresa 
AND in_movi_inve.IdMovi_inven_tipo = in_movi_inven_tipo.IdMovi_inven_tipo
where A.fa_IdEmpresa=@i_idempresa
and A.fa_IdSucursal=@i_idsucursal
and A.fa_IdBodega=@i_idbodega
and A.fa_IdCbteVta=@i_idcteVta

select '**MOVI INVEN DET**'
SELECT     in_movi_inve_detalle.*, in_Producto.pr_descripcion
FROM         in_Producto INNER JOIN
                      in_movi_inve_detalle ON in_Producto.IdEmpresa = in_movi_inve_detalle.IdEmpresa AND in_Producto.IdProducto = in_movi_inve_detalle.IdProducto INNER JOIN
                      fa_factura_x_in_movi_inve AS A ON in_movi_inve_detalle.IdEmpresa = A.inv_IdEmpresa AND in_movi_inve_detalle.IdSucursal = A.inv_IdSucursal AND 
                      in_movi_inve_detalle.IdBodega = A.inv_IdBodega AND in_movi_inve_detalle.IdMovi_inven_tipo = A.inv_IdMovi_inven_tipo AND 
                      in_movi_inve_detalle.IdNumMovi = A.inv_IdNumMovi 
where A.fa_IdEmpresa=@i_idempresa
and A.fa_IdSucursal=@i_idsucursal
and A.fa_IdBodega=@i_idbodega
and A.fa_IdCbteVta=@i_idcteVta