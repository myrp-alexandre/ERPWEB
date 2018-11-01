
CREATE view [dbo].[vwCXC_Rpt005] as
SELECT        dbo.cxc_cobro.IdEmpresa, dbo.cxc_cobro.IdSucursal, dbo.cxc_cobro.IdCobro, dbo.cxc_cobro.IdCobro_tipo, dbo.cxc_cobro.cr_Banco, dbo.cxc_cobro.cr_cuenta, 
                         dbo.cxc_cobro.cr_NumDocumento, dbo.cxc_cobro.cr_Tarjeta, dbo.cxc_cobro.cr_propietarioCta, dbo.cxc_cobro.cr_TotalCobro, dbo.cxc_cobro.cr_fechaCobro, 
                         dbo.cxc_cobro.cr_observacion, dbo.cxc_cobro.IdCliente, dbo.cxc_cobro.IdUsuario, dbo.cxc_cobro_det.dc_TipoDocumento, dbo.cxc_cobro_det.IdBodega_Cbte, 
                         dbo.cxc_cobro_det.IdCbte_vta_nota, dbo.cxc_cobro_det.dc_ValorPago, dbo.tb_persona.pe_nombreCompleto, dbo.tb_persona.pe_cedulaRuc, 
                         null pe_telefonoCasa, dbo.tb_persona.pe_direccion, dbo.tb_sucursal.Su_Descripcion, dbo.cxc_cobro.IdBanco, dbo.cxc_cobro.IdCaja, 
                         dbo.fa_factura.vt_tipoDoc + ' ' + dbo.fa_factura.vt_serie1 + '-' + dbo.fa_factura.vt_serie2 + '-' + dbo.fa_factura.vt_NumFactura + '/' + cast(dbo.cxc_cobro_det.IdCbte_vta_nota
                          AS varchar(50)) AS Documento_Cobrado
FROM            dbo.cxc_cobro INNER JOIN
                         dbo.cxc_cobro_det ON dbo.cxc_cobro.IdEmpresa = dbo.cxc_cobro_det.IdEmpresa AND dbo.cxc_cobro.IdSucursal = dbo.cxc_cobro_det.IdSucursal AND 
                         dbo.cxc_cobro.IdCobro = dbo.cxc_cobro_det.IdCobro INNER JOIN
                         dbo.fa_cliente ON dbo.fa_cliente.IdCliente = dbo.cxc_cobro.IdCliente AND dbo.fa_cliente.IdEmpresa = dbo.cxc_cobro.IdEmpresa INNER JOIN
                         dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.tb_sucursal ON dbo.tb_sucursal.IdEmpresa = dbo.cxc_cobro.IdEmpresa AND dbo.tb_sucursal.IdSucursal = dbo.cxc_cobro.IdSucursal INNER JOIN
                         dbo.fa_factura ON dbo.cxc_cobro_det.IdEmpresa = dbo.fa_factura.IdEmpresa AND dbo.cxc_cobro_det.IdSucursal = dbo.fa_factura.IdSucursal AND 
                         dbo.cxc_cobro_det.IdBodega_Cbte = dbo.fa_factura.IdBodega AND dbo.cxc_cobro_det.IdCbte_vta_nota = dbo.fa_factura.IdCbteVta AND 
                         dbo.cxc_cobro_det.dc_TipoDocumento = dbo.fa_factura.vt_tipoDoc
UNION
SELECT        dbo.cxc_cobro.IdEmpresa, dbo.cxc_cobro.IdSucursal, dbo.cxc_cobro.IdCobro, dbo.cxc_cobro.IdCobro_tipo, dbo.cxc_cobro.cr_Banco, dbo.cxc_cobro.cr_cuenta, 
                         dbo.cxc_cobro.cr_NumDocumento, dbo.cxc_cobro.cr_Tarjeta, dbo.cxc_cobro.cr_propietarioCta, dbo.cxc_cobro.cr_TotalCobro, dbo.cxc_cobro.cr_fechaCobro, 
                         dbo.cxc_cobro.cr_observacion, dbo.cxc_cobro.IdCliente, dbo.cxc_cobro.IdUsuario, dbo.cxc_cobro_det.dc_TipoDocumento, dbo.cxc_cobro_det.IdBodega_Cbte, 
                         dbo.cxc_cobro_det.IdCbte_vta_nota, dbo.cxc_cobro_det.dc_ValorPago, dbo.tb_persona.pe_nombreCompleto, dbo.tb_persona.pe_cedulaRuc, 
                         null pe_telefonoCasa, dbo.tb_persona.pe_direccion, dbo.tb_sucursal.Su_Descripcion, dbo.cxc_cobro.IdBanco, dbo.cxc_cobro.IdCaja, 
                         (CASE WHEN dbo.vwfa_notaCreDeb.NumNota_Impresa IS NULL THEN dbo.vwfa_notaCreDeb.Tipo + ' # ' + cast(dbo.vwfa_notaCreDeb.IdNota AS varchar(30)) 
                         ELSE dbo.vwfa_notaCreDeb.Tipo + ' ' + dbo.vwfa_notaCreDeb.Serie1 + '-' + dbo.vwfa_notaCreDeb.Serie2 + '-' + dbo.vwfa_notaCreDeb.NumNota_Impresa + '/' + cast(dbo.cxc_cobro_det.IdCbte_vta_nota
                          AS varchar(20)) END) AS Documento_Cobrado
FROM            dbo.cxc_cobro INNER JOIN
                         dbo.cxc_cobro_det ON dbo.cxc_cobro.IdEmpresa = dbo.cxc_cobro_det.IdEmpresa AND dbo.cxc_cobro.IdSucursal = dbo.cxc_cobro_det.IdSucursal AND 
                         dbo.cxc_cobro.IdCobro = dbo.cxc_cobro_det.IdCobro INNER JOIN
                         dbo.fa_cliente ON dbo.fa_cliente.IdCliente = dbo.cxc_cobro.IdCliente AND dbo.fa_cliente.IdEmpresa = dbo.cxc_cobro.IdEmpresa INNER JOIN
                         dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.tb_sucursal ON dbo.tb_sucursal.IdEmpresa = dbo.cxc_cobro.IdEmpresa AND dbo.tb_sucursal.IdSucursal = dbo.cxc_cobro.IdSucursal INNER JOIN
                         dbo.vwfa_notaCreDeb ON dbo.cxc_cobro_det.IdEmpresa = dbo.vwfa_notaCreDeb.IdEmpresa AND 
                         dbo.cxc_cobro_det.IdSucursal = dbo.vwfa_notaCreDeb.IdSucursal AND dbo.cxc_cobro_det.IdBodega_Cbte = dbo.vwfa_notaCreDeb.IdBodega AND 
                         dbo.cxc_cobro_det.dc_TipoDocumento = dbo.vwfa_notaCreDeb.tipo AND dbo.cxc_cobro_det.IdCbte_vta_nota = dbo.vwfa_notaCreDeb.IdNota