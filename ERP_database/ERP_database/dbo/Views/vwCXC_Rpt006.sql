CREATE VIEW [dbo].[vwCXC_Rpt006]
AS
SELECT        ISNULL(ROW_NUMBER() OVER (ORDER BY (dbo.cxc_cobro.IdEmpresa)),0) AS fila, dbo.cxc_cobro.IdEmpresa, dbo.cxc_cobro.IdSucursal, dbo.cxc_cobro.IdCobro, 
dbo.cxc_cobro.IdCobro_tipo, dbo.cxc_cobro.cr_Banco, dbo.cxc_cobro.cr_cuenta, dbo.cxc_cobro.cr_NumDocumento, dbo.cxc_cobro.cr_Tarjeta, dbo.cxc_cobro.cr_propietarioCta, 
dbo.cxc_cobro.cr_TotalCobro, dbo.cxc_cobro.cr_fecha, dbo.cxc_cobro.cr_fechaDocu, dbo.cxc_cobro.cr_fechaCobro, dbo.cxc_cobro.cr_observacion, dbo.cxc_cobro.IdCliente, 
dbo.cxc_cobro.IdUsuario, dbo.cxc_cobro_det.dc_TipoDocumento, dbo.cxc_cobro_det.IdBodega_Cbte, dbo.cxc_cobro_det.IdCbte_vta_nota, 
(CASE WHEN dbo.cxc_cobro_det.dc_ValorPago IS NULL THEN dbo.cxc_cobro.cr_TotalCobro ELSE dbo.cxc_cobro_det.dc_ValorPago END) AS dc_ValorPago, 
dbo.tb_persona.pe_nombreCompleto, dbo.tb_persona.pe_cedulaRuc, null pe_telefonoCasa, dbo.tb_persona.pe_direccion, dbo.tb_sucursal.Su_Descripcion, 
dbo.cxc_cobro.IdBanco, dbo.cxc_cobro.IdCaja, (CASE dbo.cxc_cobro_det.dc_TipoDocumento WHEN 'FACT' THEN
    (SELECT        dbo.fa_factura.vt_tipoDoc + ' ' + dbo.fa_factura.vt_serie1 + '-' + dbo.fa_factura.vt_serie2 + '-' + dbo.fa_factura.vt_NumFactura + '/' + CAST(dbo.cxc_cobro_det.IdCbte_vta_nota
                                 AS varchar(50))
      FROM            dbo.fa_factura
      WHERE        dbo.cxc_cobro_det.IdEmpresa = dbo.fa_factura.IdEmpresa AND dbo.cxc_cobro_det.IdSucursal = dbo.fa_factura.IdSucursal AND 
                                dbo.cxc_cobro_det.IdBodega_Cbte = dbo.fa_factura.IdBodega AND dbo.cxc_cobro_det.IdCbte_vta_nota = dbo.fa_factura.IdCbteVta AND 
                                dbo.cxc_cobro_det.dc_TipoDocumento = dbo.fa_factura.vt_tipoDoc) ELSE
    (SELECT        (CASE WHEN dbo.vwfa_notaCreDeb.NumNota_Impresa IS NULL THEN dbo.vwfa_notaCreDeb.Tipo + ' # ' + CAST(dbo.vwfa_notaCreDeb.IdNota AS varchar(30)) 
                                ELSE dbo.vwfa_notaCreDeb.Tipo + ' ' + dbo.vwfa_notaCreDeb.Serie1 + '-' + dbo.vwfa_notaCreDeb.Serie2 + '-' + dbo.vwfa_notaCreDeb.NumNota_Impresa + '/' + CAST(dbo.cxc_cobro_det.IdCbte_vta_nota
                                 AS varchar(20)) END)
      FROM            dbo.vwfa_notaCreDeb
      WHERE        dbo.cxc_cobro_det.IdEmpresa = dbo.vwfa_notaCreDeb.IdEmpresa AND dbo.cxc_cobro_det.IdSucursal = dbo.vwfa_notaCreDeb.IdSucursal AND 
                                dbo.cxc_cobro_det.IdBodega_Cbte = dbo.vwfa_notaCreDeb.IdBodega AND dbo.cxc_cobro_det.dc_TipoDocumento = dbo.vwfa_notaCreDeb.tipo AND 
                                dbo.cxc_cobro_det.IdCbte_vta_nota = dbo.vwfa_notaCreDeb.IdNota) END) AS Documento_Cobrado, dbo.cxc_cobro_det.secuencial
FROM            dbo.cxc_cobro INNER JOIN
                         dbo.fa_cliente ON dbo.fa_cliente.IdCliente = dbo.cxc_cobro.IdCliente AND dbo.fa_cliente.IdEmpresa = dbo.cxc_cobro.IdEmpresa INNER JOIN
                         dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.tb_sucursal ON dbo.tb_sucursal.IdEmpresa = dbo.cxc_cobro.IdEmpresa AND dbo.tb_sucursal.IdSucursal = dbo.cxc_cobro.IdSucursal LEFT OUTER JOIN
                         dbo.cxc_cobro_det ON dbo.cxc_cobro.IdEmpresa = dbo.cxc_cobro_det.IdEmpresa AND dbo.cxc_cobro.IdSucursal = dbo.cxc_cobro_det.IdSucursal AND 
                         dbo.cxc_cobro.IdCobro = dbo.cxc_cobro_det.IdCobro
WHERE        (dbo.cxc_cobro.cr_estado = 'A')