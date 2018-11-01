CREATE VIEW [dbo].[vwCXC_Rpt001]
AS
SELECT     dbo.cxc_cobro.IdEmpresa, dbo.cxc_cobro.IdSucursal, dbo.cxc_cobro.IdCobro, dbo.cxc_cobro.IdCobro_a_aplicar, dbo.cxc_cobro.cr_Codigo, 
                      dbo.cxc_cobro.IdCobro_tipo, dbo.cxc_cobro.IdCliente, dbo.tb_persona.pe_nombreCompleto AS nombreCliente, dbo.cxc_cobro.cr_fecha, 
                      dbo.tb_Calendario.IdCalendario, dbo.tb_Calendario.AnioFiscal, dbo.tb_Calendario.NombreMes, dbo.tb_Calendario.NombreCortoFecha, dbo.cxc_cobro.cr_TotalCobro, 
                      dbo.cxc_cobro.cr_fechaDocu, dbo.cxc_cobro.cr_fechaCobro, dbo.cxc_cobro.cr_observacion, 'REF#' + (CASE WHEN (cxc_cobro.cr_Banco = '' OR
                      cxc_cobro.cr_Banco IS NULL) THEN '' ELSE cxc_cobro.cr_Banco END) + (CASE WHEN (cxc_cobro.cr_cuenta = '' OR
                      cxc_cobro.cr_cuenta IS NULL) THEN '' ELSE '- Cta.# ' + cxc_cobro.cr_cuenta END) + (CASE WHEN (cxc_cobro.cr_NumDocumento = '' OR
                      cxc_cobro.cr_NumDocumento = NULL) THEN '' ELSE '- Doc.# ' + cxc_cobro.cr_NumDocumento END) + (CASE WHEN (cxc_cobro.cr_Tarjeta = '' OR
                      cxc_cobro.cr_Tarjeta = NULL) THEN '' ELSE '- Tarj.# ' + cxc_cobro.cr_Tarjeta END) + (CASE WHEN (cxc_cobro.cr_propietarioCta = '' OR
                      cxc_cobro.cr_propietarioCta = NULL) THEN '' ELSE '-' + cxc_cobro.cr_propietarioCta END) AS Referencia, 
                      dbo.fa_factura.vt_tipoDoc + '-' + dbo.fa_factura.vt_serie1 + '-' + dbo.fa_factura.vt_serie2 + '-' + dbo.fa_factura.vt_NumFactura + '/' + CAST(dbo.fa_factura.IdCbteVta AS varchar(20))
                       AS numDocumento, dbo.cxc_cobro.IdTipoNotaCredito
FROM         dbo.cxc_cobro INNER JOIN
                      dbo.fa_cliente ON dbo.cxc_cobro.IdEmpresa = dbo.fa_cliente.IdEmpresa AND dbo.cxc_cobro.IdCliente = dbo.fa_cliente.IdCliente INNER JOIN
                      dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona LEFT OUTER JOIN
                      dbo.cxc_cobro_det ON dbo.cxc_cobro.IdEmpresa = dbo.cxc_cobro_det.IdEmpresa AND dbo.cxc_cobro.IdSucursal = dbo.cxc_cobro_det.IdSucursal AND 
                      dbo.cxc_cobro.IdCobro = dbo.cxc_cobro_det.IdCobro INNER JOIN
                      dbo.tb_Calendario ON dbo.cxc_cobro.cr_fecha = dbo.tb_Calendario.fecha LEFT OUTER JOIN
                      dbo.fa_factura ON dbo.fa_factura.IdCbteVta = dbo.cxc_cobro_det.IdCbte_vta_nota AND dbo.fa_factura.vt_tipoDoc = dbo.cxc_cobro_det.dc_TipoDocumento AND 
                      dbo.fa_factura.IdEmpresa = dbo.cxc_cobro_det.IdEmpresa AND dbo.fa_factura.IdSucursal = dbo.cxc_cobro_det.IdSucursal
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[14] 4[4] 2[59] 3) )"
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
         Begin Table = "cxc_cobro"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_cliente"
            Begin Extent = 
               Top = 6
               Left = 285
               Bottom = 135
               Right = 504
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 6
               Left = 542
               Bottom = 135
               Right = 772
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 6
               Left = 810
               Bottom = 135
               Right = 1019
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cxc_cobro_det"
            Begin Extent = 
               Top = 6
               Left = 1057
               Bottom = 135
               Right = 1266
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_Calendario"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_factura"
            Begin Extent = 
               Top = 138
               Left = 285
               Bottom = 267
               Right = 494
            End
       ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXC_Rpt001';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'     DisplayFlags = 280
            TopColumn = 0
         End
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXC_Rpt001';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXC_Rpt001';

