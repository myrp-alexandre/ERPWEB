CREATE view vwCXC_Rpt004 
as
select ROW_NUMBER() OVER(ORDER BY A.IdEmpresa) as fila, * from (
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
UNION
SELECT        cxc_cobro.IdEmpresa, cxc_cobro.IdSucursal, cxc_cobro.IdCobro, cxc_cobro.IdCobro_tipo, cxc_cobro.cr_Banco, cxc_cobro.cr_cuenta, 'cobro sin fact.', 
                         cxc_cobro.cr_Tarjeta, cxc_cobro.cr_propietarioCta, cxc_cobro.cr_TotalCobro, cxc_cobro.cr_fechaCobro, cxc_cobro.cr_observacion, cxc_cobro.IdCliente, 
                         cxc_cobro.IdUsuario, cxc_cobro_det.dc_TipoDocumento, cxc_cobro_det.IdBodega_Cbte, cxc_cobro_det.IdCbte_vta_nota, isnull(cxc_cobro_det.dc_ValorPago, 0) 
                         AS dc_ValorPago, tb_persona.pe_nombreCompleto, tb_persona.pe_cedulaRuc, null pe_telefonoCasa, tb_persona.pe_direccion, tb_sucursal.Su_Descripcion, 
                         cxc_cobro.IdBanco, cxc_cobro.IdCaja, 'sin factura'
FROM            cxc_cobro INNER JOIN
                         fa_cliente ON fa_cliente.IdCliente = cxc_cobro.IdCliente AND fa_cliente.IdEmpresa = cxc_cobro.IdEmpresa INNER JOIN
                         tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona INNER JOIN
                         tb_sucursal ON tb_sucursal.IdEmpresa = cxc_cobro.IdEmpresa AND tb_sucursal.IdSucursal = cxc_cobro.IdSucursal LEFT OUTER JOIN
                         cxc_cobro_det ON cxc_cobro.IdEmpresa = cxc_cobro_det.IdEmpresa AND cxc_cobro.IdSucursal = cxc_cobro_det.IdSucursal AND 
                         cxc_cobro.IdCobro = cxc_cobro_det.IdCobro
WHERE        cxc_cobro_det.IdCbte_vta_nota IS NULL
) A
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[25] 4[5] 2[53] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXC_Rpt004';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXC_Rpt004';

