CREATE VIEW web.VWCOMP_001
AS
SELECT d.IdEmpresa, d.IdSucursal, d.IdOrdenCompra, d.Secuencia, d.IdProducto, su.Su_Descripcion, c.oc_fecha, c.oc_observacion, c.Estado, term.Descripcion AS NombreTerminoPago, cast(c.oc_plazo as varchar(20)) +' días' as oc_plazo,
c.IdProveedor, per.pe_nombreCompleto AS NombreProveedor,
				  case when prov.pr_telefonos is null then '' else prov.pr_telefonos end 
				  +case when prov.pr_telefonos is not null and prov.pr_celular is not null then '-' else '' end
				  +case when prov.pr_celular is null then '' else prov.pr_celular end as TelefonosProveedor, 				  
				  prov.pr_direccion AS DireccionProveedor, per.pe_cedulaRuc AS RucProveedor, com.Descripcion AS NombreComprador, pro.pr_descripcion NombreProducto, uni.Descripcion AS NomUnidadMedida,
                  d.do_Cantidad, d.do_precioCompra, d.do_porc_des, d.do_descuento, d.do_precioFinal, d.do_subtotal, d.do_iva, d.do_subtotal + d.do_iva do_total, d.Por_Iva,
				  CASE WHEN d.Por_Iva > 0 then d.do_Cantidad * d.do_precioCompra else 0 end as SubtotalIVA,
				  CASE WHEN d.Por_Iva = 0 then d.do_Cantidad * d.do_precioCompra else 0 end as Subtotal0,
				  D.do_Cantidad * d.do_descuento as DescuentoTotal
FROM     com_ordencompra_local AS c INNER JOIN
                  com_ordencompra_local_det AS d ON c.IdEmpresa = d.IdEmpresa AND c.IdSucursal = d.IdSucursal AND c.IdOrdenCompra = d.IdOrdenCompra INNER JOIN
                  com_comprador AS com ON c.IdEmpresa = com.IdEmpresa AND c.IdComprador = com.IdComprador INNER JOIN
                  tb_sucursal AS su ON c.IdEmpresa = su.IdEmpresa AND c.IdSucursal = su.IdSucursal INNER JOIN
                  cp_proveedor AS prov ON c.IdEmpresa = prov.IdEmpresa AND c.IdProveedor = prov.IdProveedor INNER JOIN
                  tb_persona AS per ON prov.IdPersona = per.IdPersona INNER JOIN
                  in_UnidadMedida AS uni ON d.IdUnidadMedida = uni.IdUnidadMedida INNER JOIN
                  com_TerminoPago AS term ON c.IdTerminoPago = term.IdTerminoPago LEFT OUTER JOIN
                  in_Producto AS pro ON d.IdEmpresa = pro.IdEmpresa AND d.IdProducto = pro.IdProducto