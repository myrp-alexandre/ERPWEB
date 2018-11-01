-- exec spSys_Inv_Borrado_CbteCbles_x_Movi_Inven  1,'01/11/2016','30/11/2016',0

CREATE proc spSys_Inv_Borrado_CbteCbles_x_Movi_Inven 
(
 @idempresa int
,@fechaIni_Movi_Inven datetime
,@fechaFin_Movi_Inven datetime
,@Aplicar_Borrado bit
)
as
/*

*/


SELECT        ct_cbtecble.*
FROM            ct_cbtecble INNER JOIN
                         in_movi_inve_x_ct_cbteCble ON ct_cbtecble.IdEmpresa = in_movi_inve_x_ct_cbteCble.IdEmpresa AND ct_cbtecble.IdTipoCbte = in_movi_inve_x_ct_cbteCble.IdTipoCbte AND 
                         ct_cbtecble.IdCbteCble = in_movi_inve_x_ct_cbteCble.IdCbteCble INNER JOIN
                         in_movi_inve ON in_movi_inve_x_ct_cbteCble.IdEmpresa = in_movi_inve.IdEmpresa AND in_movi_inve_x_ct_cbteCble.IdSucursal = in_movi_inve.IdSucursal AND 
                         in_movi_inve_x_ct_cbteCble.IdBodega = in_movi_inve.IdBodega AND in_movi_inve_x_ct_cbteCble.IdMovi_inven_tipo = in_movi_inve.IdMovi_inven_tipo AND 
                         in_movi_inve_x_ct_cbteCble.IdNumMovi = in_movi_inve.IdNumMovi
WHERE        in_movi_inve.cm_fecha BETWEEN @fechaIni_Movi_Inven and @fechaFin_Movi_Inven
AND (ct_cbtecble.IdEmpresa = @idempresa)



SELECT   ct_cbtecble_det.*     
FROM            ct_cbtecble_det INNER JOIN
                         in_movi_inve_x_ct_cbteCble ON ct_cbtecble_det.IdEmpresa = in_movi_inve_x_ct_cbteCble.IdEmpresa AND ct_cbtecble_det.IdTipoCbte = in_movi_inve_x_ct_cbteCble.IdTipoCbte AND 
                         ct_cbtecble_det.IdCbteCble = in_movi_inve_x_ct_cbteCble.IdCbteCble INNER JOIN
                         ct_cbtecble ON ct_cbtecble_det.IdEmpresa = ct_cbtecble.IdEmpresa AND ct_cbtecble_det.IdTipoCbte = ct_cbtecble.IdTipoCbte AND ct_cbtecble_det.IdCbteCble = ct_cbtecble.IdCbteCble INNER JOIN
                         in_movi_inve ON in_movi_inve_x_ct_cbteCble.IdEmpresa = in_movi_inve.IdEmpresa AND in_movi_inve_x_ct_cbteCble.IdSucursal = in_movi_inve.IdSucursal AND 
                         in_movi_inve_x_ct_cbteCble.IdBodega = in_movi_inve.IdBodega AND in_movi_inve_x_ct_cbteCble.IdMovi_inven_tipo = in_movi_inve.IdMovi_inven_tipo AND 
                         in_movi_inve_x_ct_cbteCble.IdNumMovi = in_movi_inve.IdNumMovi
WHERE        in_movi_inve.cm_fecha BETWEEN @fechaIni_Movi_Inven and @fechaFin_Movi_Inven
and     (ct_cbtecble_det.IdEmpresa = @idempresa)




SELECT        in_movi_inve_detalle.*
FROM            in_movi_inve_x_ct_cbteCble INNER JOIN
                         ct_cbtecble ON in_movi_inve_x_ct_cbteCble.IdEmpresa_ct = ct_cbtecble.IdEmpresa AND in_movi_inve_x_ct_cbteCble.IdTipoCbte = ct_cbtecble.IdTipoCbte AND 
                         in_movi_inve_x_ct_cbteCble.IdCbteCble = ct_cbtecble.IdCbteCble INNER JOIN
                         in_movi_inve ON in_movi_inve_x_ct_cbteCble.IdEmpresa = in_movi_inve.IdEmpresa AND in_movi_inve_x_ct_cbteCble.IdSucursal = in_movi_inve.IdSucursal AND 
                         in_movi_inve_x_ct_cbteCble.IdBodega = in_movi_inve.IdBodega AND in_movi_inve_x_ct_cbteCble.IdMovi_inven_tipo = in_movi_inve.IdMovi_inven_tipo AND 
                         in_movi_inve_x_ct_cbteCble.IdNumMovi = in_movi_inve.IdNumMovi INNER JOIN
                         in_movi_inve_detalle ON in_movi_inve.IdEmpresa = in_movi_inve_detalle.IdEmpresa AND in_movi_inve.IdSucursal = in_movi_inve_detalle.IdSucursal AND 
                         in_movi_inve.IdBodega = in_movi_inve_detalle.IdBodega AND in_movi_inve.IdMovi_inven_tipo = in_movi_inve_detalle.IdMovi_inven_tipo AND 
                         in_movi_inve.IdNumMovi = in_movi_inve_detalle.IdNumMovi
WHERE        
(in_movi_inve_detalle.IdEmpresa = @idempresa)
and in_movi_inve.cm_fecha BETWEEN @fechaIni_Movi_Inven and @fechaFin_Movi_Inven




SELECT        in_movi_inve.*
FROM            in_movi_inve_x_ct_cbteCble INNER JOIN
                         ct_cbtecble ON in_movi_inve_x_ct_cbteCble.IdEmpresa_ct = ct_cbtecble.IdEmpresa AND in_movi_inve_x_ct_cbteCble.IdTipoCbte = ct_cbtecble.IdTipoCbte AND 
                         in_movi_inve_x_ct_cbteCble.IdCbteCble = ct_cbtecble.IdCbteCble INNER JOIN
                         in_movi_inve ON in_movi_inve_x_ct_cbteCble.IdEmpresa = in_movi_inve.IdEmpresa AND in_movi_inve_x_ct_cbteCble.IdSucursal = in_movi_inve.IdSucursal AND 
                         in_movi_inve_x_ct_cbteCble.IdBodega = in_movi_inve.IdBodega AND in_movi_inve_x_ct_cbteCble.IdMovi_inven_tipo = in_movi_inve.IdMovi_inven_tipo AND 
                         in_movi_inve_x_ct_cbteCble.IdNumMovi = in_movi_inve.IdNumMovi
WHERE        
   (ct_cbtecble.IdEmpresa = @idempresa)
and in_movi_inve.cm_fecha BETWEEN @fechaIni_Movi_Inven and @fechaFin_Movi_Inven





SELECT        in_movi_inve_x_ct_cbteCble.*
FROM            in_movi_inve_x_ct_cbteCble INNER JOIN
                         ct_cbtecble ON in_movi_inve_x_ct_cbteCble.IdEmpresa_ct = ct_cbtecble.IdEmpresa AND in_movi_inve_x_ct_cbteCble.IdTipoCbte = ct_cbtecble.IdTipoCbte AND 
                         in_movi_inve_x_ct_cbteCble.IdCbteCble = ct_cbtecble.IdCbteCble INNER JOIN
                         in_movi_inve ON in_movi_inve_x_ct_cbteCble.IdEmpresa = in_movi_inve.IdEmpresa AND in_movi_inve_x_ct_cbteCble.IdSucursal = in_movi_inve.IdSucursal AND 
                         in_movi_inve_x_ct_cbteCble.IdBodega = in_movi_inve.IdBodega AND in_movi_inve_x_ct_cbteCble.IdMovi_inven_tipo = in_movi_inve.IdMovi_inven_tipo AND 
                         in_movi_inve_x_ct_cbteCble.IdNumMovi = in_movi_inve.IdNumMovi
WHERE        
   (ct_cbtecble.IdEmpresa = @idempresa)
and in_movi_inve.cm_fecha BETWEEN @fechaIni_Movi_Inven and @fechaFin_Movi_Inven




SELECT        in_movi_inve_detalle_x_ct_cbtecble_det.*, in_movi_inve.cm_fecha
FROM            in_movi_inve_detalle_x_ct_cbtecble_det INNER JOIN
                         in_movi_inve ON in_movi_inve_detalle_x_ct_cbtecble_det.IdEmpresa_inv = in_movi_inve.IdEmpresa AND in_movi_inve_detalle_x_ct_cbtecble_det.IdSucursal_inv = in_movi_inve.IdSucursal AND 
                         in_movi_inve_detalle_x_ct_cbtecble_det.IdBodega_inv = in_movi_inve.IdBodega AND in_movi_inve_detalle_x_ct_cbtecble_det.IdMovi_inven_tipo_inv = in_movi_inve.IdMovi_inven_tipo AND 
                         in_movi_inve_detalle_x_ct_cbtecble_det.IdNumMovi_inv = in_movi_inve.IdNumMovi
WHERE        
(in_movi_inve.IdEmpresa = @idempresa)
and in_movi_inve.cm_fecha BETWEEN @fechaIni_Movi_Inven and @fechaFin_Movi_Inven

if (@Aplicar_Borrado =1)
begin

----///======================= APLICANDO LA ACTUALIZACION ANTES DE BORRAR ==========



UPDATE ct_cbtecble
SET IdUsuarioAnu='**A_BORRAR**'
FROM            ct_cbtecble INNER JOIN
                         in_movi_inve_x_ct_cbteCble ON ct_cbtecble.IdEmpresa = in_movi_inve_x_ct_cbteCble.IdEmpresa AND ct_cbtecble.IdTipoCbte = in_movi_inve_x_ct_cbteCble.IdTipoCbte AND 
                         ct_cbtecble.IdCbteCble = in_movi_inve_x_ct_cbteCble.IdCbteCble INNER JOIN
                         in_movi_inve ON in_movi_inve_x_ct_cbteCble.IdEmpresa = in_movi_inve.IdEmpresa AND in_movi_inve_x_ct_cbteCble.IdSucursal = in_movi_inve.IdSucursal AND 
                         in_movi_inve_x_ct_cbteCble.IdBodega = in_movi_inve.IdBodega AND in_movi_inve_x_ct_cbteCble.IdMovi_inven_tipo = in_movi_inve.IdMovi_inven_tipo AND 
                         in_movi_inve_x_ct_cbteCble.IdNumMovi = in_movi_inve.IdNumMovi
WHERE        in_movi_inve.cm_fecha BETWEEN @fechaIni_Movi_Inven and @fechaFin_Movi_Inven
AND (ct_cbtecble.IdEmpresa = @idempresa)


UPDATE ct_cbtecble_det 
SET dc_Observacion='**A_BORRAR**' + dc_Observacion
FROM            ct_cbtecble_det INNER JOIN
                         in_movi_inve_x_ct_cbteCble ON ct_cbtecble_det.IdEmpresa = in_movi_inve_x_ct_cbteCble.IdEmpresa AND ct_cbtecble_det.IdTipoCbte = in_movi_inve_x_ct_cbteCble.IdTipoCbte AND 
                         ct_cbtecble_det.IdCbteCble = in_movi_inve_x_ct_cbteCble.IdCbteCble INNER JOIN
                         ct_cbtecble ON ct_cbtecble_det.IdEmpresa = ct_cbtecble.IdEmpresa AND ct_cbtecble_det.IdTipoCbte = ct_cbtecble.IdTipoCbte AND ct_cbtecble_det.IdCbteCble = ct_cbtecble.IdCbteCble INNER JOIN
                         in_movi_inve ON in_movi_inve_x_ct_cbteCble.IdEmpresa = in_movi_inve.IdEmpresa AND in_movi_inve_x_ct_cbteCble.IdSucursal = in_movi_inve.IdSucursal AND 
                         in_movi_inve_x_ct_cbteCble.IdBodega = in_movi_inve.IdBodega AND in_movi_inve_x_ct_cbteCble.IdMovi_inven_tipo = in_movi_inve.IdMovi_inven_tipo AND 
                         in_movi_inve_x_ct_cbteCble.IdNumMovi = in_movi_inve.IdNumMovi
WHERE        in_movi_inve.cm_fecha BETWEEN @fechaIni_Movi_Inven and @fechaFin_Movi_Inven
and     (ct_cbtecble_det.IdEmpresa = @idempresa)



update in_movi_inve_x_ct_cbteCble
set Observacion='**A_BORRAR**' 
FROM            in_movi_inve_x_ct_cbteCble INNER JOIN
                         ct_cbtecble ON in_movi_inve_x_ct_cbteCble.IdEmpresa_ct = ct_cbtecble.IdEmpresa AND in_movi_inve_x_ct_cbteCble.IdTipoCbte = ct_cbtecble.IdTipoCbte AND 
                         in_movi_inve_x_ct_cbteCble.IdCbteCble = ct_cbtecble.IdCbteCble INNER JOIN
                         in_movi_inve ON in_movi_inve_x_ct_cbteCble.IdEmpresa = in_movi_inve.IdEmpresa AND in_movi_inve_x_ct_cbteCble.IdSucursal = in_movi_inve.IdSucursal AND 
                         in_movi_inve_x_ct_cbteCble.IdBodega = in_movi_inve.IdBodega AND in_movi_inve_x_ct_cbteCble.IdMovi_inven_tipo = in_movi_inve.IdMovi_inven_tipo AND 
                         in_movi_inve_x_ct_cbteCble.IdNumMovi = in_movi_inve.IdNumMovi
WHERE        
   (ct_cbtecble.IdEmpresa = @idempresa)
and in_movi_inve.cm_fecha BETWEEN @fechaIni_Movi_Inven and @fechaFin_Movi_Inven



update in_movi_inve_detalle_x_ct_cbtecble_det
set observacion ='**A_BORRAR**' 
FROM            in_movi_inve_detalle_x_ct_cbtecble_det INNER JOIN
                         in_movi_inve ON in_movi_inve_detalle_x_ct_cbtecble_det.IdEmpresa_inv = in_movi_inve.IdEmpresa AND in_movi_inve_detalle_x_ct_cbtecble_det.IdSucursal_inv = in_movi_inve.IdSucursal AND 
                         in_movi_inve_detalle_x_ct_cbtecble_det.IdBodega_inv = in_movi_inve.IdBodega AND in_movi_inve_detalle_x_ct_cbtecble_det.IdMovi_inven_tipo_inv = in_movi_inve.IdMovi_inven_tipo AND 
                         in_movi_inve_detalle_x_ct_cbtecble_det.IdNumMovi_inv = in_movi_inve.IdNumMovi
WHERE        
(in_movi_inve.IdEmpresa = @idempresa)
and in_movi_inve.cm_fecha BETWEEN @fechaIni_Movi_Inven and @fechaFin_Movi_Inven


--//======================= BORRANDO ====================


delete in_movi_inve_x_ct_cbteCble
FROM            in_movi_inve_x_ct_cbteCble INNER JOIN
                         ct_cbtecble ON in_movi_inve_x_ct_cbteCble.IdEmpresa_ct = ct_cbtecble.IdEmpresa AND in_movi_inve_x_ct_cbteCble.IdTipoCbte = ct_cbtecble.IdTipoCbte AND 
                         in_movi_inve_x_ct_cbteCble.IdCbteCble = ct_cbtecble.IdCbteCble INNER JOIN
                         in_movi_inve ON in_movi_inve_x_ct_cbteCble.IdEmpresa = in_movi_inve.IdEmpresa AND in_movi_inve_x_ct_cbteCble.IdSucursal = in_movi_inve.IdSucursal AND 
                         in_movi_inve_x_ct_cbteCble.IdBodega = in_movi_inve.IdBodega AND in_movi_inve_x_ct_cbteCble.IdMovi_inven_tipo = in_movi_inve.IdMovi_inven_tipo AND 
                         in_movi_inve_x_ct_cbteCble.IdNumMovi = in_movi_inve.IdNumMovi
WHERE        
   (ct_cbtecble.IdEmpresa = @idempresa)
and in_movi_inve.cm_fecha BETWEEN @fechaIni_Movi_Inven and @fechaFin_Movi_Inven
and Observacion like '%**A_BORRAR**%' 


delete in_movi_inve_detalle_x_ct_cbtecble_det
FROM            in_movi_inve_detalle_x_ct_cbtecble_det INNER JOIN
                         in_movi_inve ON in_movi_inve_detalle_x_ct_cbtecble_det.IdEmpresa_inv = in_movi_inve.IdEmpresa AND in_movi_inve_detalle_x_ct_cbtecble_det.IdSucursal_inv = in_movi_inve.IdSucursal AND 
                         in_movi_inve_detalle_x_ct_cbtecble_det.IdBodega_inv = in_movi_inve.IdBodega AND in_movi_inve_detalle_x_ct_cbtecble_det.IdMovi_inven_tipo_inv = in_movi_inve.IdMovi_inven_tipo AND 
                         in_movi_inve_detalle_x_ct_cbtecble_det.IdNumMovi_inv = in_movi_inve.IdNumMovi
WHERE        
(in_movi_inve.IdEmpresa = @idempresa)
and in_movi_inve.cm_fecha BETWEEN @fechaIni_Movi_Inven and @fechaFin_Movi_Inven
and observacion like '%**A_BORRAR**%' 




delete ct_cbtecble_det 
WHERE        
 ct_cbtecble_det.IdEmpresa = @idempresa
and dc_Observacion like '%**A_BORRAR**%' 


delete ct_cbtecble
WHERE        
     (ct_cbtecble.IdEmpresa = @idempresa)
and IdUsuarioAnu like '%**A_BORRAR**%'


end 




--select * from in_movi_inve where cm_fecha between '01/11/2016' and '30/11/2016'  and cm_tipo='-'