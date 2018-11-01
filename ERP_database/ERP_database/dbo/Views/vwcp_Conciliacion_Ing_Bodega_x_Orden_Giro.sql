CREATE VIEW [dbo].[vwcp_Conciliacion_Ing_Bodega_x_Orden_Giro] AS
SELECT con.IdEmpresa, con.IdConciliacion, pro.IdProveedor, pe_nombreCompleto pr_nombre, con.IdEmpresa_Apro_Ing, con.IdAprobacion_Apro_Ing,
		apro.IdEmpresa_Ogiro, apro.IdCbteCble_Ogiro, apro.IdTipoCbte_Ogiro, apro.IdOrden_giro_Tipo, apro.Serie, apro.Serie2,
		apro.num_documento, apro.Serie + '-' + apro.Serie2 + '-' + apro.num_documento AS num_Factura , apro.num_auto_Proveedor, apro.num_auto_Imprenta, apro.Fecha_Factura, apro.co_subtotal_iva,
		apro.co_subtotal_siniva, apro.Descuento, apro.co_baseImponible, apro.co_Por_iva, apro.co_valoriva, apro.co_total ,
		con.Fecha_Conciliacion, con.Observacion, con.IdUsuario, con.Estado
FROM cp_Conciliacion_Ing_Bodega_x_Orden_Giro con INNER JOIN 
	 cp_proveedor pro ON con.IdEmpresa = pro.IdEmpresa AND con.IdProveedor = pro.IdProveedor INNER JOIN 
	 cp_Aprobacion_Ing_Bod_x_OC apro ON con.IdEmpresa_Apro_Ing = apro.IdEmpresa AND con.IdAprobacion_Apro_Ing = apro.IdAprobacion
	 inner join tb_persona as per on pro.IdPersona = per.IdPersona