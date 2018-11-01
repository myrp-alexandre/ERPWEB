CREATE VIEW [Fj_servindustrias].[vwfa_liquidacion_x_punto_cargo_x_fa_factura_x_aplicar]
AS
SELECT        isnull(ROW_NUMBER() OVER (ORDER BY fa_factura.IdEmpresa), 0) AS IdRow, CAST(fa_factura.IdEmpresa AS varchar(1)) + '-' + CAST(fa_factura.IdSucursal AS varchar(2)) + '-' + CAST(fa_factura.IdBodega AS varchar(2)) 
+ '-' + CAST(fa_factura.IdCbteVta AS varchar(10)) AS ID, fa_factura.IdEmpresa, fa_factura.IdSucursal, fa_factura.IdBodega, fa_factura.IdCbteVta, tb_sucursal.Su_Descripcion, tb_bodega.bo_Descripcion, fa_factura.vt_serie1, 
fa_factura.vt_serie2, fa_factura.vt_NumFactura, fa_factura.IdCliente, tb_persona.pe_nombreCompleto, isnull(DET.vt_Subtotal,0)vt_Subtotal, isnull(DET.vt_iva,0)vt_iva, isnull(DET.vt_total,0)vt_total, DET.vt_saldo, Fj_servindustrias.fa_factura_fj.num_oc, 
Fj_servindustrias.fa_factura_fj.descripcion_fact, Fj_servindustrias.fa_cliente_x_ct_centro_costo.IdCentroCosto_cc
FROM            fa_factura INNER JOIN
                         fa_cliente ON fa_factura.IdEmpresa = fa_cliente.IdEmpresa AND fa_factura.IdCliente = fa_cliente.IdCliente INNER JOIN
                         tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona INNER JOIN
                         tb_bodega ON fa_factura.IdEmpresa = tb_bodega.IdEmpresa AND fa_factura.IdSucursal = tb_bodega.IdSucursal AND fa_factura.IdBodega = tb_bodega.IdBodega INNER JOIN
                         tb_sucursal ON tb_bodega.IdEmpresa = tb_sucursal.IdEmpresa AND tb_bodega.IdSucursal = tb_sucursal.IdSucursal INNER JOIN
                             (SELECT        fa_factura_det.IdEmpresa, fa_factura_det.IdSucursal, fa_factura_det.IdBodega, fa_factura_det.IdCbteVta, ROUND(SUM(fa_factura_det.vt_Subtotal), 2) AS vt_Subtotal, ROUND(SUM(fa_factura_det.vt_iva), 2) 
                                                         AS vt_iva, ROUND(SUM(fa_factura_det.vt_total), 2) AS vt_total, ROUND(ROUND(SUM(fa_factura_det.vt_total) - SUM(ISNULL(Fj_servindustrias.fa_liquidacion_x_punto_cargo_x_fa_factura.vta_total, 0)), 2), 2) 
                                                         AS vt_saldo
                               FROM            fa_factura_det LEFT OUTER JOIN
                                                         Fj_servindustrias.fa_liquidacion_x_punto_cargo_x_fa_factura ON fa_factura_det.IdEmpresa = Fj_servindustrias.fa_liquidacion_x_punto_cargo_x_fa_factura.IdEmpresa_vta AND 
                                                         fa_factura_det.IdSucursal = Fj_servindustrias.fa_liquidacion_x_punto_cargo_x_fa_factura.IdSucursal_vta AND 
                                                         fa_factura_det.IdBodega = Fj_servindustrias.fa_liquidacion_x_punto_cargo_x_fa_factura.IdBodega_vta AND 
                                                         fa_factura_det.IdCbteVta = Fj_servindustrias.fa_liquidacion_x_punto_cargo_x_fa_factura.IdCbteVta
                               GROUP BY fa_factura_det.IdEmpresa, fa_factura_det.IdSucursal, fa_factura_det.IdBodega, fa_factura_det.IdCbteVta) AS DET ON DET.IdEmpresa = fa_factura.IdEmpresa AND fa_factura.IdSucursal = DET.IdSucursal AND 
                         fa_factura.IdBodega = DET.IdBodega AND fa_factura.IdCbteVta = DET.IdCbteVta INNER JOIN
                         Fj_servindustrias.fa_cliente_x_ct_centro_costo ON fa_cliente.IdEmpresa = Fj_servindustrias.fa_cliente_x_ct_centro_costo.IdEmpresa_cli AND 
                         fa_cliente.IdCliente = Fj_servindustrias.fa_cliente_x_ct_centro_costo.IdCliente_cli LEFT OUTER JOIN
                         Fj_servindustrias.fa_factura_fj ON fa_factura.IdEmpresa = Fj_servindustrias.fa_factura_fj.IdEmpresa AND fa_factura.IdSucursal = Fj_servindustrias.fa_factura_fj.IdSucursal AND 
                         fa_factura.IdBodega = Fj_servindustrias.fa_factura_fj.IdBodega AND fa_factura.IdCbteVta = Fj_servindustrias.fa_factura_fj.IdCbteVta