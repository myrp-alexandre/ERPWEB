CREATE VIEW [dbo].[vwCXC_Rpt003] AS
SELECT        dbo.cxc_conciliacion.IdEmpresa, dbo.cxc_conciliacion.IdSucursal, dbo.cxc_conciliacion.IdConciliacion, dbo.cxc_conciliacion.Fecha, dbo.cxc_conciliacion_det.IdTipoConciliacion,
						 (case dbo.cxc_conciliacion_det.IdTipoConciliacion when 'NT_CR_DB' then ( dbo.fa_notaCreDeb.Serie1 + '-' + dbo.fa_notaCreDeb.Serie2 + '-' +
						  dbo.fa_notaCreDeb.NumNota_Impresa + '/' + CAST(dbo.fa_notaCreDeb.IdNota AS varchar(20))) else (dbo.fa_factura.vt_serie1 + '-' + dbo.fa_factura.vt_serie2 + '-' + 
						  dbo.fa_factura.vt_NumFactura + '/' + CAST(dbo.fa_factura.IdCbteVta AS varchar(100))) end  ) as numDocumento,
						  dbo.cxc_conciliacion_det.Saldo_por_aplicar, dbo.cxc_conciliacion_det.Valor_Aplicado, 
                         dbo.cxc_conciliacion_det.TipoDoc_vta, dbo.cxc_conciliacion.Observacion, dbo.cxc_conciliacion.IdCliente, dbo.cxc_conciliacion.IdUsuario, 
                         dbo.tb_persona.pe_nombreCompleto, dbo.tb_persona.pe_cedulaRuc, null pe_telefonoCasa, dbo.tb_persona.pe_direccion, 
                         dbo.tb_sucursal.Su_Descripcion, dbo.cxc_conciliacion.IdEmpresa_cbte_cble, dbo.cxc_conciliacion.IdTipoCbte_cbte_cble, 
                         dbo.cxc_conciliacion.IdCbteCble_cbte_cble						 
FROM            dbo.cxc_conciliacion INNER JOIN
                         dbo.cxc_conciliacion_det ON dbo.cxc_conciliacion.IdEmpresa = dbo.cxc_conciliacion_det.IdEmpresa AND 
                         dbo.cxc_conciliacion.IdConciliacion = dbo.cxc_conciliacion_det.IdConciliacion AND 
                         dbo.cxc_conciliacion.IdSucursal = dbo.cxc_conciliacion_det.IdSucursal INNER JOIN
                         dbo.fa_cliente ON dbo.cxc_conciliacion.IdEmpresa = dbo.fa_cliente.IdEmpresa AND dbo.cxc_conciliacion.IdCliente = dbo.fa_cliente.IdCliente INNER JOIN
                         dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.tb_sucursal ON dbo.cxc_conciliacion.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.cxc_conciliacion.IdSucursal = dbo.tb_sucursal.IdSucursal LEFT OUTER JOIN
						 dbo.fa_notaCreDeb ON dbo.fa_notaCreDeb.IdEmpresa = dbo.cxc_conciliacion_det.IdEmpresa_nt AND
						 dbo.fa_notaCreDeb.IdSucursal = dbo.cxc_conciliacion_det.IdSucursal_nt  AND dbo.fa_notaCreDeb.IdBodega = dbo.cxc_conciliacion_det.IdBodega_nt AND
						 dbo.fa_notaCreDeb.IdNota = dbo.cxc_conciliacion_det.IdNota_nt LEFT OUTER JOIN
						 dbo.fa_factura ON dbo.fa_factura.IdEmpresa = dbo.cxc_conciliacion_det.IdEmpresa_fa and dbo.fa_factura.IdSucursal = dbo.cxc_conciliacion_det.IdSucursal_fa and
						 dbo.fa_factura.IdBodega = dbo.cxc_conciliacion_det.IdBodega_fa and dbo.fa_factura.IdCbteVta = dbo.cxc_conciliacion_det.IdCbteVta_fa