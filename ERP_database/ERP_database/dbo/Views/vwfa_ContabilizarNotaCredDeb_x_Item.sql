

CREATE view [dbo].[vwfa_ContabilizarNotaCredDeb_x_Item]
as
SELECT        det_NT.IdEmpresa, det_NT.IdSucursal, det_NT.IdBodega, det_NT.IdNota, SUM(det_NT.sc_iva) AS Iva, SUM(det_NT.sc_subtotal) AS Sub_total, SUM(det_NT.sc_total) AS Total, 
                         SUM(det_NT.sc_descUni * det_NT.sc_cantidad) AS Des_total, det_NT.IdPunto_cargo_grupo, det_NT.IdPunto_Cargo, prod_x_bod.IdProducto, prod_x_bod.IdCtaCble_Vta, '' IdCtaCble_Des0, 
                         '' IdCtaCble_DesIva, det_NT.IdCod_Impuesto_Iva, det_NT.IdCod_Impuesto_Ice, det_NT.IdCentroCosto, det_NT.IdCentroCosto_sub_centro_costo, Imp_Iva.IdCtaCble AS IdCtaCble_Iva, 
                         Imp_Ice.IdCtaCble AS IdCtaCble_Ice
FROM            in_producto_x_tb_bodega AS prod_x_bod INNER JOIN
                         fa_notaCreDeb_det AS det_NT ON prod_x_bod.IdEmpresa = det_NT.IdEmpresa AND prod_x_bod.IdProducto = det_NT.IdProducto AND prod_x_bod.IdSucursal = det_NT.IdSucursal AND 
                         prod_x_bod.IdBodega = det_NT.IdBodega LEFT OUTER JOIN
                         tb_sis_Impuesto_x_ctacble AS Imp_Iva ON det_NT.IdEmpresa = Imp_Iva.IdEmpresa_cta AND det_NT.IdCod_Impuesto_Iva = Imp_Iva.IdCod_Impuesto LEFT OUTER JOIN
                         tb_sis_Impuesto_x_ctacble AS Imp_Ice ON det_NT.IdEmpresa = Imp_Ice.IdEmpresa_cta AND det_NT.IdCod_Impuesto_Ice = Imp_Ice.IdCod_Impuesto
GROUP BY det_NT.IdEmpresa, det_NT.IdSucursal, det_NT.IdBodega, det_NT.IdNota, det_NT.IdPunto_cargo_grupo, det_NT.IdPunto_Cargo, prod_x_bod.IdProducto, prod_x_bod.IdCtaCble_Vta,  det_NT.IdCod_Impuesto_Iva, det_NT.IdCod_Impuesto_Ice, det_NT.IdCentroCosto, det_NT.IdCentroCosto_sub_centro_costo, Imp_Iva.IdCtaCble, Imp_Ice.IdCtaCble