--exec spSys_Inv_Verificador_CbteCble_x_Movi_Inven 1,36,1828 

CREATE proc spSys_Inv_Verificador_CbteCble_x_Movi_Inven
 @idempresa int
,@idtipocbte int
,@idCbteCble numeric
as


SELECT        ct_cbtecble.*
FROM            ct_cbtecble INNER JOIN
                         in_movi_inve_x_ct_cbteCble ON ct_cbtecble.IdEmpresa = in_movi_inve_x_ct_cbteCble.IdEmpresa AND ct_cbtecble.IdTipoCbte = in_movi_inve_x_ct_cbteCble.IdTipoCbte AND 
                         ct_cbtecble.IdCbteCble = in_movi_inve_x_ct_cbteCble.IdCbteCble
WHERE        
     (ct_cbtecble.IdTipoCbte = @idtipocbte) 
AND (ct_cbtecble.IdCbteCble = @idCbteCble)
AND (ct_cbtecble.IdEmpresa = @idempresa)

SELECT        ct_cbtecble_det.*
FROM            in_movi_inve_x_ct_cbteCble INNER JOIN
                         ct_cbtecble_det ON in_movi_inve_x_ct_cbteCble.IdEmpresa_ct = ct_cbtecble_det.IdEmpresa AND in_movi_inve_x_ct_cbteCble.IdTipoCbte = ct_cbtecble_det.IdTipoCbte AND 
                         in_movi_inve_x_ct_cbteCble.IdCbteCble = ct_cbtecble_det.IdCbteCble
WHERE        
(ct_cbtecble_det.IdTipoCbte = @idtipocbte) 
AND (ct_cbtecble_det.IdCbteCble = @idCbteCble)
AND (ct_cbtecble_det.IdEmpresa = @idempresa)



SELECT        in_movi_inve.*
FROM            in_movi_inve_x_ct_cbteCble INNER JOIN
                         in_movi_inve ON in_movi_inve_x_ct_cbteCble.IdEmpresa = in_movi_inve.IdEmpresa AND in_movi_inve_x_ct_cbteCble.IdSucursal = in_movi_inve.IdSucursal AND 
                         in_movi_inve_x_ct_cbteCble.IdBodega = in_movi_inve.IdBodega AND in_movi_inve_x_ct_cbteCble.IdMovi_inven_tipo = in_movi_inve.IdMovi_inven_tipo AND 
                         in_movi_inve_x_ct_cbteCble.IdNumMovi = in_movi_inve.IdNumMovi
WHERE        
     (in_movi_inve_x_ct_cbteCble.IdEmpresa_ct = @idempresa) 
AND (in_movi_inve_x_ct_cbteCble.IdTipoCbte = @idtipocbte) 
AND (in_movi_inve_x_ct_cbteCble.IdCbteCble = @idCbteCble)


SELECT        in_movi_inve_detalle.*
FROM            in_movi_inve_x_ct_cbteCble INNER JOIN
                         in_movi_inve_detalle ON in_movi_inve_x_ct_cbteCble.IdEmpresa_ct = in_movi_inve_detalle.IdEmpresa AND in_movi_inve_x_ct_cbteCble.IdSucursal = in_movi_inve_detalle.IdSucursal AND 
                         in_movi_inve_x_ct_cbteCble.IdBodega = in_movi_inve_detalle.IdBodega AND in_movi_inve_x_ct_cbteCble.IdMovi_inven_tipo = in_movi_inve_detalle.IdMovi_inven_tipo AND 
                         in_movi_inve_x_ct_cbteCble.IdNumMovi = in_movi_inve_detalle.IdNumMovi
WHERE        
(in_movi_inve_x_ct_cbteCble.IdEmpresa_ct = @idempresa) 
AND (in_movi_inve_x_ct_cbteCble.IdTipoCbte = @idtipocbte) 
AND (in_movi_inve_x_ct_cbteCble.IdCbteCble = @idCbteCble)





SELECT        in_movi_inve_detalle.IdEmpresa, in_movi_inve_detalle.IdSucursal, in_movi_inve_detalle.IdBodega, in_movi_inve_detalle.IdMovi_inven_tipo, in_movi_inve_detalle.IdNumMovi, in_movi_inve_detalle.Secuencia, 
                         in_movi_inve_detalle.IdProducto, in_Producto.pr_codigo, in_Producto.pr_descripcion, in_parametro.IdCtaCble_Inven AS IdCtaCble_Inven_Param, 
                         in_parametro.IdCtaCble_CostoInven AS IdCtaCble_CostoInven_Param, tb_bodega.IdCtaCtble_Inve AS IdCtaCtble_Inve_Bod, tb_bodega.IdCtaCtble_Costo AS IdCtaCtble_Costo_Bod, 
                         in_producto_x_tb_bodega.IdCtaCble_Inven AS IdCtaCble_Inven_Prod_x_Bod, 
                         in_producto_x_tb_bodega.IdCtaCble_Costo AS IdCtaCble_Costo_Prod_x_Bod, NULL AS IdCtaCble_Inven_x_Motivo, 
                         NULL AS IdCtaCble_Costo_x_Motivo
FROM            in_movi_inve_x_ct_cbteCble INNER JOIN
                         in_movi_inve_detalle ON in_movi_inve_x_ct_cbteCble.IdSucursal = in_movi_inve_detalle.IdSucursal AND in_movi_inve_x_ct_cbteCble.IdBodega = in_movi_inve_detalle.IdBodega AND 
                         in_movi_inve_x_ct_cbteCble.IdMovi_inven_tipo = in_movi_inve_detalle.IdMovi_inven_tipo AND in_movi_inve_x_ct_cbteCble.IdNumMovi = in_movi_inve_detalle.IdNumMovi AND 
                         in_movi_inve_x_ct_cbteCble.IdEmpresa = in_movi_inve_detalle.IdEmpresa INNER JOIN
                         in_parametro ON in_movi_inve_detalle.IdEmpresa = in_parametro.IdEmpresa INNER JOIN
                         in_Producto ON in_movi_inve_detalle.IdEmpresa = in_Producto.IdEmpresa AND in_movi_inve_detalle.IdProducto = in_Producto.IdProducto INNER JOIN
                         tb_bodega ON in_movi_inve_detalle.IdEmpresa = tb_bodega.IdEmpresa AND in_movi_inve_detalle.IdSucursal = tb_bodega.IdSucursal AND in_movi_inve_detalle.IdBodega = tb_bodega.IdBodega INNER JOIN
                         in_subgrupo ON in_Producto.IdEmpresa = in_subgrupo.IdEmpresa AND in_Producto.IdCategoria = in_subgrupo.IdCategoria AND in_Producto.IdLinea = in_subgrupo.IdLinea AND 
                         in_Producto.IdGrupo = in_subgrupo.IdGrupo AND in_Producto.IdSubGrupo = in_subgrupo.IdSubgrupo LEFT OUTER JOIN
                         in_Motivo_Inven ON in_movi_inve_detalle.IdEmpresa = in_Motivo_Inven.IdEmpresa AND in_movi_inve_detalle.IdMotivo_Inv = in_Motivo_Inven.IdMotivo_Inv LEFT OUTER JOIN
                         in_producto_x_tb_bodega ON in_movi_inve_detalle.IdEmpresa = in_producto_x_tb_bodega.IdEmpresa AND in_movi_inve_detalle.IdSucursal = in_producto_x_tb_bodega.IdSucursal AND 
                         in_movi_inve_detalle.IdBodega = in_producto_x_tb_bodega.IdBodega AND in_movi_inve_detalle.IdProducto = in_producto_x_tb_bodega.IdProducto
WHERE        
(in_movi_inve_x_ct_cbteCble.IdEmpresa_ct = @idempresa) 
AND (in_movi_inve_x_ct_cbteCble.IdTipoCbte = @idtipocbte) 
AND (in_movi_inve_x_ct_cbteCble.IdCbteCble = @idCbteCble)




SELECT        in_movi_inve_x_ct_cbteCble.*
FROM            in_movi_inve_x_ct_cbteCble INNER JOIN
                         ct_cbtecble_det ON in_movi_inve_x_ct_cbteCble.IdEmpresa_ct = ct_cbtecble_det.IdEmpresa AND in_movi_inve_x_ct_cbteCble.IdTipoCbte = ct_cbtecble_det.IdTipoCbte AND 
                         in_movi_inve_x_ct_cbteCble.IdCbteCble = ct_cbtecble_det.IdCbteCble
WHERE        
(ct_cbtecble_det.IdTipoCbte = @idtipocbte) 
AND (ct_cbtecble_det.IdCbteCble = @idCbteCble)
AND (ct_cbtecble_det.IdEmpresa = @idempresa)



SELECT        in_movi_inve_detalle_x_ct_cbtecble_det.*
FROM            in_movi_inve_detalle_x_ct_cbtecble_det INNER JOIN
                         ct_cbtecble_det ON in_movi_inve_detalle_x_ct_cbtecble_det.IdEmpresa_ct = ct_cbtecble_det.IdEmpresa 
						 AND in_movi_inve_detalle_x_ct_cbtecble_det.IdTipoCbte_ct = ct_cbtecble_det.IdTipoCbte AND 
                         in_movi_inve_detalle_x_ct_cbtecble_det.IdCbteCble_ct = ct_cbtecble_det.IdCbteCble
WHERE        
(ct_cbtecble_det.IdTipoCbte = @idtipocbte) 
AND (ct_cbtecble_det.IdCbteCble = @idCbteCble)
AND (ct_cbtecble_det.IdEmpresa = @idempresa)