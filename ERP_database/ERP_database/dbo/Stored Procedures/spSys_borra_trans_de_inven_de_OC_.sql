create proc spSys_borra_trans_de_inven_de_OC_
as

declare @idempresa int
declare @idsucursal int
declare @idoc int


set @idempresa =1
set @idsucursal =1
set @idoc =22



declare @idempresa_ing_egr int
declare @idsucursal_ing_egr int
declare @idMovi_tipo_ing_egr int
declare @idNumMovi_ing_egr int


declare @idempresa_movi_inv int
declare @idsucursal_movi_inv int
declare @idbodega_movi_inv int
declare @idMovi_tipo_movi_inv int
declare @idNumMovi_movi_inv int


declare @idempresa_cbte_cble int
declare @idtipo_cbte_cble int
declare @idcbte_cble numeric

select @idempresa_ing_egr =A.IdEmpresa,@idsucursal_ing_egr=A.IdSucursal,@idMovi_tipo_ing_egr=A.IdMovi_inven_tipo,@idNumMovi_ing_egr=A.IdNumMovi
,@idempresa_movi_inv=A.IdEmpresa_inv,@idsucursal_movi_inv=A.IdSucursal_inv,@idbodega_movi_inv=A.IdBodega_inv,@idMovi_tipo_movi_inv=A.IdMovi_inven_tipo_inv
,@idNumMovi_movi_inv=A.IdNumMovi_inv
from in_Ing_Egr_Inven_det A where IdEmpresa_oc=@idempresa and IdSucursal_oc=@idsucursal and IdOrdenCompra=@idoc


select @idempresa_cbte_cble=IdEmpresa_ct,@idtipo_cbte_cble=IdTipoCbte,@idcbte_cble=IdCbteCble from in_movi_inve_x_ct_cbteCble where IdEmpresa=@idempresa_movi_inv and IdSucursal=@idsucursal_movi_inv and IdBodega=@idbodega_movi_inv 
and IdMovi_inven_tipo=@idMovi_tipo_movi_inv and IdNumMovi=@idNumMovi_movi_inv

select 'enlace contable  in_movi_inve_x_ct_cbteCble '
select * from in_movi_inve_x_ct_cbteCble where IdEmpresa=@idempresa_movi_inv and IdSucursal=@idsucursal_movi_inv and IdBodega=@idbodega_movi_inv 
and IdMovi_inven_tipo=@idMovi_tipo_movi_inv and IdNumMovi=@idNumMovi_movi_inv

select * from ct_cbtecble_det where IdEmpresa=@idempresa_cbte_cble and IdTipoCbte=@idtipo_cbte_cble and IdCbteCble=@idcbte_cble
select * from ct_cbtecble where IdEmpresa=@idempresa_cbte_cble and IdTipoCbte=@idtipo_cbte_cble and IdCbteCble=@idcbte_cble

select 'in_Ing_Egr_Inven_det '
select * from in_Ing_Egr_Inven_det where IdEmpresa=@idempresa_ing_egr and IdSucursal=@idsucursal_ing_egr and IdMovi_inven_tipo=@idMovi_tipo_ing_egr and IdNumMovi=@idNumMovi_ing_egr
select 'in_Ing_Egr_Inven'
select * from in_Ing_Egr_Inven where IdEmpresa=@idempresa_ing_egr and IdSucursal=@idsucursal_ing_egr and IdMovi_inven_tipo=@idMovi_tipo_ing_egr and IdNumMovi=@idNumMovi_ing_egr


select 'in_movi_inve_detalle '
select * from in_movi_inve_detalle where IdEmpresa=@idempresa_movi_inv and IdSucursal=@idsucursal_movi_inv and IdBodega=@idbodega_movi_inv
and IdMovi_inven_tipo=@idMovi_tipo_movi_inv and IdNumMovi=@idNumMovi_movi_inv
select 'in_movi_inve '
select * from in_movi_inve where IdEmpresa=@idempresa_movi_inv and IdSucursal=@idsucursal_movi_inv and IdBodega=@idbodega_movi_inv
and IdMovi_inven_tipo=@idMovi_tipo_movi_inv and IdNumMovi=@idNumMovi_movi_inv

--SELECT @idNumMovi_movi_inv



select * from com_ordencompra_local where IdEmpresa=@idempresa and IdSucursal=@idsucursal and IdOrdenCompra=@idoc
select * from com_ordencompra_local_det where IdEmpresa=@idempresa and IdSucursal=@idsucursal and IdOrdenCompra=@idoc



return ---DELETE 


DELETE from in_movi_inve_x_ct_cbteCble where IdEmpresa=@idempresa_movi_inv and IdSucursal=@idsucursal_movi_inv and IdBodega=@idbodega_movi_inv 
and IdMovi_inven_tipo=@idMovi_tipo_movi_inv and IdNumMovi=@idNumMovi_movi_inv

DELETE  from ct_cbtecble_det where IdEmpresa=@idempresa_cbte_cble and IdTipoCbte=@idtipo_cbte_cble and IdCbteCble=@idcbte_cble
DELETE from ct_cbtecble where IdEmpresa=@idempresa_cbte_cble and IdTipoCbte=@idtipo_cbte_cble and IdCbteCble=@idcbte_cble

select 'in_Ing_Egr_Inven_det '
DELETE from in_Ing_Egr_Inven_det where IdEmpresa=@idempresa_ing_egr and IdSucursal=@idsucursal_ing_egr and IdMovi_inven_tipo=@idMovi_tipo_ing_egr and IdNumMovi=@idNumMovi_ing_egr
select 'in_Ing_Egr_Inven'
DELETE from in_Ing_Egr_Inven where IdEmpresa=@idempresa_ing_egr and IdSucursal=@idsucursal_ing_egr and IdMovi_inven_tipo=@idMovi_tipo_ing_egr and IdNumMovi=@idNumMovi_ing_egr


select 'in_movi_inve_detalle '
DELETE from in_movi_inve_detalle where IdEmpresa=@idempresa_movi_inv and IdSucursal=@idsucursal_movi_inv and IdBodega=@idbodega_movi_inv
and IdMovi_inven_tipo=@idMovi_tipo_movi_inv and IdNumMovi=@idNumMovi_movi_inv
select 'DELETE in_movi_inve '
DELETE from in_movi_inve where IdEmpresa=@idempresa_movi_inv and IdSucursal=@idsucursal_movi_inv and IdBodega=@idbodega_movi_inv
and IdMovi_inven_tipo=@idMovi_tipo_movi_inv and IdNumMovi=@idNumMovi_movi_inv

/*
DELETE from com_ordencompra_local_det where IdEmpresa=@idempresa and IdSucursal=@idsucursal and IdOrdenCompra=@idoc
DELETE from com_ordencompra_local where IdEmpresa=@idempresa and IdSucursal=@idsucursal and IdOrdenCompra=@idoc
*/