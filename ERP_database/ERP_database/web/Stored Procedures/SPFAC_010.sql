CREATE PROCEDURE [web].[SPFAC_010]
(
@IdEmpresa int,
@IdSucursalIni int, 
@IdSucursalFin int,
@FechaIni datetime,
@FechaFin datetime
)
AS
SELECT        c.IdEmpresa, c.IdSucursal, c.IdBodega, c.IdCbteVta, c.vt_serie1 + '-' + c.vt_serie2 + '-' + c.vt_NumFactura AS vt_NumFactura, c.IdCliente, per.pe_nombreCompleto, cat.Nombre AS NombreFormaPago, c.IdCatalogo_FormaPago, c.Estado, 
                         c.vt_fecha, c.IdUsuario Ve_Vendedor, c.IdUsuario IdVendedor, tb_sucursal.Su_Descripcion, tb_sucursal.Su_Telefonos, tb_sucursal.Su_Direccion, tb_sucursal.Su_Ruc,
						 r.SubtotalIVAConDscto, r.SubtotalSinIVAConDscto, r.ValorIVA, r.Total
FROM            fa_factura AS c INNER JOIN
                         fa_cliente AS cli ON c.IdEmpresa = cli.IdEmpresa AND c.IdCliente = cli.IdCliente INNER JOIN
                         tb_persona AS per ON cli.IdPersona = per.IdPersona INNER JOIN
                         fa_Vendedor AS ve ON c.IdEmpresa = ve.IdEmpresa AND c.IdVendedor = ve.IdVendedor INNER JOIN
                         tb_sucursal ON c.IdEmpresa = tb_sucursal.IdEmpresa AND c.IdSucursal = tb_sucursal.IdSucursal LEFT OUTER JOIN
                         fa_catalogo AS cat ON c.IdCatalogo_FormaPago = cat.IdCatalogo
						 
						 /*left join(
							SELECT        IdEmpresa, IdSucursal, IdBodega, IdCbteVta, ROUND(sum(SubtotalSinIVA),2) SubtotalSinIVA, round(sum(SubtotalIVA),2) SubtotalIVA, round(sum(vt_iva),2)vt_iva, ROUND(sum(SubtotalSinIVA),2) + round(sum(SubtotalIVA),2) + round(sum(vt_iva),2) vt_total
							FROM            (SELECT        fa_factura.IdEmpresa, fa_factura.IdSucursal, fa_factura.IdBodega, fa_factura.IdCbteVta, CASE WHEN fa_factura_det.vt_por_iva = 0 THEN fa_factura_det.vt_Subtotal ELSE 0 END AS SubtotalSinIVA, 
							CASE WHEN fa_factura_det.vt_por_iva > 0 THEN fa_factura_det.vt_Subtotal ELSE 0 END AS SubtotalIVA, fa_factura_det.vt_iva, fa_factura_det.vt_Subtotal + fa_factura_det.vt_iva AS vt_total
							FROM            fa_factura INNER JOIN
							fa_factura_det ON fa_factura.IdEmpresa = fa_factura_det.IdEmpresa AND fa_factura.IdSucursal = fa_factura_det.IdSucursal AND fa_factura.IdBodega = fa_factura_det.IdBodega AND 
							fa_factura.IdCbteVta = fa_factura_det.IdCbteVta
							where fa_factura.IdEmpresa = @IdEmpresa and fa_factura.IdSucursal between @IdSucursalIni and @IdSucursalFin and fa_factura.vt_fecha between @FechaIni and @FechaFin
							) AS Det
							GROUP BY IdEmpresa, IdSucursal, IdBodega, IdCbteVta
						 ) as d on c.IdEmpresa = d.IdEmpresa and c.IdSucursal = d.IdSucursal and c.IdBodega = d.IdBodega and c.IdCbteVta = d.IdCbteVta
						 */
						 LEFT JOIN fa_factura_resumen AS R on c.IdEmpresa = r.IdEmpresa and c.IdSucursal = r.IdSucursal and c.IdBodega = r.IdBodega and c.IdCbteVta = r.IdCbteVta
						 where c.IdEmpresa = @IdEmpresa and c.IdSucursal between @IdSucursalIni and @IdSucursalFin and c.vt_fecha between @FechaIni and @FechaFin