-- EXEC web.SPFAC_007 2,2,1,346
CREATE PROCEDURE web.SPFAC_007
(
@IdEmpresa int,
@IdSucursal int,
@IdBodega int,
@IdCbteVta numeric
)
AS
SELECT d.IdEmpresa, d.IdSucursal, d.IdBodega, d.IdCbteVta, d.Secuencia, d.IdProducto, pro.pr_descripcion, d.vt_cantidad, d.vt_Precio, d.vt_cantidad * d.vt_Precio AS SubtotalSinDscto, d.vt_cantidad * d.vt_DescUnitario AS DescuentoTotal, 
                  d.vt_Subtotal AS SubtotalConDscto, d.vt_iva, D.vt_total AS vt_Total, d.vt_por_iva, CASE WHEN d .vt_por_iva > 0 THEN vt_cantidad * vt_Precio ELSE 0 END AS SubtotalIVA, 
                  CASE WHEN d .vt_por_iva = 0 THEN vt_cantidad * vt_Precio ELSE 0 END AS SubtotalSinIVA, c.vt_fecha, c.vt_serie1 + '-' + c.vt_serie2 + '-' + c.vt_NumFactura AS vt_NumFactura, per.pe_nombreCompleto AS cli_Nombre, 
                  per.pe_cedulaRuc AS cli_cedulaRuc, con.Direccion AS cli_direccion, con.Telefono AS cli_Telefonos, con.Correo AS cli_correo, su.Su_Descripcion, su.Su_Telefonos, su.Su_Direccion, cat.Nombre AS FormaDePago, c.IdCatalogo_FormaPago, 
                  c.vt_ValorEfectivo, c.vt_Cambio, c.vt_autorizacion, c.Fecha_Autorizacion, c.vt_Observacion, T.SubtotalIVA T_SubtotalIVA, T.SubtotalSinIVA T_SubtotalSinIVA, t.vt_iva T_vt_iva, T.vt_total T_vt_total,c.vt_serie1 + '-' + c.vt_serie2 + '-' + c.vt_NumFactura AS vt_NumFactura
FROM     dbo.fa_cliente_contactos AS con INNER JOIN
                  dbo.fa_factura AS c ON con.IdEmpresa = c.IdEmpresa AND con.IdCliente = c.IdCliente AND con.IdContacto = c.IdContacto INNER JOIN
                  dbo.fa_factura_det AS d ON c.IdEmpresa = d.IdEmpresa AND c.IdSucursal = d.IdSucursal AND c.IdBodega = d.IdBodega AND c.IdCbteVta = d.IdCbteVta INNER JOIN
                  dbo.in_Producto AS pro ON d.IdEmpresa = pro.IdEmpresa AND d.IdProducto = pro.IdProducto INNER JOIN
                  dbo.fa_cliente AS cli ON con.IdEmpresa = cli.IdEmpresa AND con.IdCliente = cli.IdCliente INNER JOIN
                  dbo.tb_persona AS per ON cli.IdPersona = per.IdPersona INNER JOIN
                  dbo.tb_sucursal AS su ON c.IdEmpresa = su.IdEmpresa AND c.IdSucursal = su.IdSucursal LEFT OUTER JOIN
                  dbo.fa_catalogo AS cat ON c.IdCatalogo_FormaPago = cat.IdCatalogo left join
				  (
						SELECT        IdEmpresa, IdSucursal, IdBodega, IdCbteVta, ROUND(sum(SubtotalSinIVA),2) SubtotalSinIVA, round(sum(SubtotalIVA),2) SubtotalIVA, round(sum(vt_iva),2)vt_iva, ROUND(sum(SubtotalSinIVA),2) + round(sum(SubtotalIVA),2) + round(sum(vt_iva),2) vt_total
						FROM            (SELECT        fa_factura.IdEmpresa, fa_factura.IdSucursal, fa_factura.IdBodega, fa_factura.IdCbteVta, CASE WHEN fa_factura_det.vt_por_iva = 0 THEN fa_factura_det.vt_Subtotal ELSE 0 END AS SubtotalSinIVA, 
						CASE WHEN fa_factura_det.vt_por_iva > 0 THEN fa_factura_det.vt_Subtotal ELSE 0 END AS SubtotalIVA, fa_factura_det.vt_iva, fa_factura_det.vt_Subtotal + fa_factura_det.vt_iva AS vt_total,
						fa_factura_det.vt_cantidad * fa_factura_det.vt_DescUnitario as DescuentoTotal
						FROM            fa_factura INNER JOIN
						fa_factura_det ON fa_factura.IdEmpresa = fa_factura_det.IdEmpresa AND fa_factura.IdSucursal = fa_factura_det.IdSucursal AND fa_factura.IdBodega = fa_factura_det.IdBodega AND 
						fa_factura.IdCbteVta = fa_factura_det.IdCbteVta
							where fa_factura_det.IdEmpresa = @IdEmpresa
							and fa_factura_det.IdSucursal = @IdSucursal
							and fa_factura_det.IdBodega = @IdBodega
							and fa_factura_det.IdCbteVta = @IdCbteVta
						) AS Det
						GROUP BY IdEmpresa, IdSucursal, IdBodega, IdCbteVta
				  ) as T on c.IdEmpresa = T.IdEmpresa and c.IdSucursal = t.IdSucursal and c.IdBodega = t.IdBodega and c.IdCbteVta = t.IdCbteVta
where c.IdEmpresa = @IdEmpresa
and c.IdSucursal = @IdSucursal
and c.IdBodega = @IdBodega
and c.IdCbteVta = @IdCbteVta