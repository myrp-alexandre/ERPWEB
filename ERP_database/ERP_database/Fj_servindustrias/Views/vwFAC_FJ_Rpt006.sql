CREATE VIEW [Fj_servindustrias].[vwFAC_FJ_Rpt006]
AS
SELECT      ISNULL(ROW_NUMBER() over(order by liq_cab.IdEmpresa),0) AS IdRow,  liq_cab.IdEmpresa, liq_cab.IdSucursal, dbo.tb_sucursal.Su_Descripcion, liq_cab.IdCentroCosto, liq_cab.IdLiquidacion, liq_cab.IdCentroCosto_sub_centro_costo, dbo.ct_centro_costo_sub_centro_costo.Centro_costo, 
                         liq_cab.IdPunto_cargo, dbo.ct_punto_cargo.nom_punto_cargo, tec_1.pe_nombreCompleto as tecnico_1, tec_2.pe_nombreCompleto as tecnico_2, isnull(A.subtotal_eg,0)subtotal_eg, isnull(B.subtotal_in,0)subtotal_in, isnull(C.subtotal_mo,0)subtotal_mo, isnull(D.subtotal_lo,0)subtotal_lo, liq_cab.li_subtotal, liq_cab.li_valor_iva, liq_cab.li_total, liq_cab.li_fecha, liq_cab.li_num_orden, 
                         liq_cab.li_reporte_mantenimiento, liq_cab.li_fecha_orden_mantenimiento, liq_cab.li_fecha_reporte_mantenimiento, liq_fac.num_oc, liq_fac.vta_subtotal AS subtotal_fa, liq_fac.vta_iva AS iva_fa, liq_fac.vta_total AS total_fa, 
                         liq_fac.vt_fecha, liq_cab.li_referencia_facturas AS vt_NumFactura, CASE WHEN liq_cab.li_referencia_facturas IS NULL OR
                         liq_cab.li_referencia_facturas = '' THEN NULL ELSE 'FACTURADO' END AS estado_fac, CAST(CAST(YEAR(liq_cab.li_fecha) AS VARCHAR(4)) + RIGHT('00' + CAST(MONTH(liq_cab.li_fecha) AS VARCHAR(2)), 2) AS INT) AS IdPeriodo, 
                         dbo.vwct_periodo.smes, dbo.vwct_periodo.pe_mes, dbo.vwct_periodo.IdanioFiscal
FROM            Fj_servindustrias.fa_liquidacion_x_punto_cargo AS liq_cab LEFT OUTER JOIN
                         dbo.ct_punto_cargo ON liq_cab.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND liq_cab.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo LEFT OUTER JOIN
                         dbo.ct_centro_costo_sub_centro_costo ON liq_cab.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND liq_cab.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                         liq_cab.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo LEFT OUTER JOIN
                         dbo.tb_sucursal ON liq_cab.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND liq_cab.IdSucursal = dbo.tb_sucursal.IdSucursal LEFT OUTER JOIN
                             (SELECT        IdEmpresa, IdSucursal, IdCentroCosto, IdLiquidacion, SUM(eg_precio_total) AS subtotal_eg
                               FROM            Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_egresos_inventario AS liq_eg
                               GROUP BY IdEmpresa, IdSucursal, IdCentroCosto, IdLiquidacion) AS A ON liq_cab.IdEmpresa = A.IdEmpresa AND liq_cab.IdSucursal = A.IdSucursal AND liq_cab.IdCentroCosto = A.IdCentroCosto AND 
                         liq_cab.IdLiquidacion = A.IdLiquidacion LEFT OUTER JOIN
                             (SELECT        IdEmpresa, IdSucursal, IdCentroCosto, IdLiquidacion, SUM(in_precio_total) AS subtotal_in
                               FROM            Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_ingresos_consumo_directo AS liq_eg
                               GROUP BY IdEmpresa, IdSucursal, IdCentroCosto, IdLiquidacion) AS B ON liq_cab.IdEmpresa = B.IdEmpresa AND liq_cab.IdSucursal = B.IdSucursal AND liq_cab.IdCentroCosto = B.IdCentroCosto AND 
                         liq_cab.IdLiquidacion = B.IdLiquidacion LEFT OUTER JOIN
                             (SELECT        IdEmpresa, IdSucursal, IdCentroCosto, IdLiquidacion, SUM(mo_precio_total) AS subtotal_mo
                               FROM            Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra AS liq_eg
                               GROUP BY IdEmpresa, IdSucursal, IdCentroCosto, IdLiquidacion) AS C ON liq_cab.IdEmpresa = C.IdEmpresa AND liq_cab.IdSucursal = C.IdSucursal AND liq_cab.IdCentroCosto = C.IdCentroCosto AND 
                         liq_cab.IdLiquidacion = C.IdLiquidacion LEFT OUTER JOIN
                             (SELECT        IdEmpresa, IdSucursal, IdCentroCosto, IdLiquidacion, SUM(lo_precio_total) AS subtotal_lo
                               FROM            Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_logistica AS liq_eg
                               GROUP BY IdEmpresa, IdSucursal, IdCentroCosto, IdLiquidacion) AS D ON liq_cab.IdEmpresa = D.IdEmpresa AND liq_cab.IdSucursal = D.IdSucursal AND liq_cab.IdCentroCosto = D.IdCentroCosto AND 
                         liq_cab.IdLiquidacion = D.IdLiquidacion LEFT OUTER JOIN
                             (SELECT        liq_f.IdEmpresa, liq_f.IdSucursal, liq_f.IdCentroCosto, liq_f.IdLiquidacion, SUM(liq_f.vta_subtotal) AS vta_subtotal, SUM(liq_f.vta_iva) AS vta_iva, SUM(liq_f.vta_total) AS vta_total, MAX(dbo.fa_factura.vt_fecha) 
                                                         AS vt_fecha, MAX(Fj_servindustrias.fa_factura_fj.num_oc) AS num_oc
                               FROM            Fj_servindustrias.fa_liquidacion_x_punto_cargo_x_fa_factura AS liq_f INNER JOIN
                                                         dbo.fa_factura ON liq_f.IdEmpresa_vta = dbo.fa_factura.IdEmpresa AND liq_f.IdSucursal_vta = dbo.fa_factura.IdSucursal AND liq_f.IdBodega_vta = dbo.fa_factura.IdBodega AND 
                                                         liq_f.IdCbteVta = dbo.fa_factura.IdCbteVta INNER JOIN
                                                         Fj_servindustrias.fa_factura_fj ON dbo.fa_factura.IdEmpresa = Fj_servindustrias.fa_factura_fj.IdEmpresa AND dbo.fa_factura.IdSucursal = Fj_servindustrias.fa_factura_fj.IdSucursal AND 
                                                         dbo.fa_factura.IdBodega = Fj_servindustrias.fa_factura_fj.IdBodega AND dbo.fa_factura.IdCbteVta = Fj_servindustrias.fa_factura_fj.IdCbteVta
                               GROUP BY liq_f.IdEmpresa, liq_f.IdSucursal, liq_f.IdCentroCosto, liq_f.IdLiquidacion) AS liq_fac ON liq_cab.IdEmpresa = liq_fac.IdEmpresa AND liq_cab.IdSucursal = liq_fac.IdSucursal AND 
                         liq_cab.IdCentroCosto = liq_fac.IdCentroCosto AND liq_cab.IdLiquidacion = liq_fac.IdLiquidacion LEFT OUTER JOIN
                         dbo.vwct_periodo ON dbo.vwct_periodo.IdEmpresa = liq_cab.IdEmpresa AND dbo.vwct_periodo.IdPeriodo = CAST(CAST(YEAR(liq_cab.li_fecha) AS VARCHAR(4)) + RIGHT('00' + CAST(MONTH(liq_cab.li_fecha) AS VARCHAR(2)), 2) 
                         AS INT)
						 LEFT JOIN
						 (
							SELECT A.IdEmpresa, A.IdSucursal, A.IdCentroCosto, A.IdLiquidacion, A.pe_nombreCompleto FROM (
							SELECT      ROW_NUMBER() OVER(PARTITION BY mo.IdEmpresa, mo.IdSucursal, mo.IdCentroCosto, mo.IdLiquidacion order by mo.IdEmpresa) AS IdRow, 
							mo.IdEmpresa, mo.IdSucursal, mo.IdCentroCosto, mo.IdLiquidacion, per.pe_nombreCompleto
							FROM            Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra AS mo INNER JOIN
							dbo.man_tecnico AS te ON mo.IdEmpresa = te.IdEmpresa AND mo.IdTecnico = te.IdTecnico INNER JOIN
							dbo.ro_empleado AS emp ON te.IdEmpresa = emp.IdEmpresa AND te.IdEmpleado = emp.IdEmpleado INNER JOIN
							dbo.tb_persona AS per ON emp.IdPersona = per.IdPersona
							GROUP BY mo.IdEmpresa, mo.IdSucursal, mo.IdCentroCosto, mo.IdLiquidacion, per.pe_nombreCompleto
							) A WHERE A.IdRow = 1
						 ) tec_1 on tec_1.IdEmpresa = liq_cab.IdEmpresa and tec_1.IdSucursal = liq_cab.IdSucursal and tec_1.IdCentroCosto = liq_cab.IdCentroCosto and tec_1.IdLiquidacion = liq_cab.IdLiquidacion
						 LEFT JOIN
						 (
							SELECT A.IdEmpresa, A.IdSucursal, A.IdCentroCosto, A.IdLiquidacion, A.pe_nombreCompleto FROM (
							SELECT      ROW_NUMBER() OVER(PARTITION BY mo.IdEmpresa, mo.IdSucursal, mo.IdCentroCosto, mo.IdLiquidacion order by mo.IdEmpresa) AS IdRow, 
							mo.IdEmpresa, mo.IdSucursal, mo.IdCentroCosto, mo.IdLiquidacion, per.pe_nombreCompleto
							FROM            Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra AS mo INNER JOIN
							dbo.man_tecnico AS te ON mo.IdEmpresa = te.IdEmpresa AND mo.IdTecnico = te.IdTecnico INNER JOIN
							dbo.ro_empleado AS emp ON te.IdEmpresa = emp.IdEmpresa AND te.IdEmpleado = emp.IdEmpleado INNER JOIN
							dbo.tb_persona AS per ON emp.IdPersona = per.IdPersona
							GROUP BY mo.IdEmpresa, mo.IdSucursal, mo.IdCentroCosto, mo.IdLiquidacion, per.pe_nombreCompleto
							) A WHERE A.IdRow = 2
						 ) tec_2 on tec_2.IdEmpresa = liq_cab.IdEmpresa and tec_2.IdSucursal = liq_cab.IdSucursal and tec_2.IdCentroCosto = liq_cab.IdCentroCosto and tec_2.IdLiquidacion = liq_cab.IdLiquidacion
WHERE        (liq_cab.estado = 1)