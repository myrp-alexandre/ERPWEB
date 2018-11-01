
CREATE VIEW [dbo].[vwcxc_cobro_x_documentos_x_cobrar]
AS
SELECT     cbr.IdEmpresa, cbr.IdSucursal, cbr.IdCobro, ROUND(cbr.cr_TotalCobro, 2) AS cr_TotalCobro, cbr.cr_fecha, cbr.cr_fechaCobro, cbr.cr_estado, EstaAct.IdEstadoCobro, 
                      cbr.cr_observacion, cbr.cr_NumDocumento AS NumDocumento, cbr_det.secuencial, cbr_det.dc_TipoDocumento AS TipoDoc_aplicado, 
                      cbr_det.IdBodega_Cbte AS IdBodega_Cbte_doc_aplica, cbr_det.IdCbte_vta_nota, Fac_deb.Referencia AS Documento_Aplicado, Perso.pe_nombreCompleto AS Cliente, 
                      cbr.IdCliente, cbr.IdCobro_tipo, 0 AS Saldo, Sucu.Su_Descripcion AS Sucursal, cbr_tip.tc_descripcion AS TipoCobro, bodg.bo_Descripcion AS Bodega, 
                      Esta_cbr.Descripcion AS EstadoCobro, Fac_deb.fecha AS Fecha_vta, ROUND(Fac_deb.SubTotal, 2) AS SubTotal_Doc_vta, ROUND(Fac_deb.Iva, 2) AS Iva_Doc_vta, 
                      ROUND(Fac_deb.Total, 2) AS Total_Doc_vta
FROM         dbo.cxc_cobro AS cbr INNER JOIN
                      dbo.cxc_cobro_det AS cbr_det ON cbr.IdEmpresa = cbr_det.IdEmpresa AND cbr.IdSucursal = cbr_det.IdSucursal AND cbr.IdCobro = cbr_det.IdCobro INNER JOIN
                      dbo.fa_cliente AS cli ON cbr.IdEmpresa = cli.IdEmpresa AND cbr.IdCliente = cli.IdCliente INNER JOIN
                      dbo.vwcxc_EstadoCobro_Actual AS EstaAct ON cbr.IdEmpresa = EstaAct.IdEmpresa AND cbr.IdSucursal = EstaAct.IdSucursal AND 
                      cbr.IdCobro = EstaAct.IdCobro INNER JOIN
                      dbo.cxc_cobro_tipo AS cbr_tip ON cbr.IdCobro_tipo = cbr_tip.IdCobro_tipo INNER JOIN
                      dbo.vwFa_Facturas_y_NotasDebito AS Fac_deb ON cbr_det.IdEmpresa = Fac_deb.IdEmpresa AND cbr_det.IdSucursal = Fac_deb.IdSucursal AND 
                      cbr_det.IdBodega_Cbte = Fac_deb.IdBodega AND cbr_det.dc_TipoDocumento = Fac_deb.Tipo AND cbr_det.IdCbte_vta_nota = Fac_deb.IdCbte INNER JOIN
                      dbo.tb_persona AS Perso ON cli.IdPersona = Perso.IdPersona INNER JOIN
                      dbo.tb_sucursal AS Sucu ON cbr.IdEmpresa = Sucu.IdEmpresa AND cbr.IdSucursal = Sucu.IdSucursal INNER JOIN
                      dbo.tb_bodega AS bodg ON cbr_det.IdEmpresa = bodg.IdEmpresa AND cbr_det.IdSucursal = bodg.IdSucursal AND cbr_det.IdBodega_Cbte = bodg.IdBodega INNER JOIN
                      dbo.cxc_EstadoCobro AS Esta_cbr ON EstaAct.IdEstadoCobro = Esta_cbr.IdEstadoCobro
WHERE     (cbr_tip.tc_docXCobrar = 'S')
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[14] 4[39] 2[4] 3) )"
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
         Top = -31
         Left = 0
      End
      Begin Tables = 
         Begin Table = "cbr"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 217
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cbr_det"
            Begin Extent = 
               Top = 308
               Left = 434
               Bottom = 599
               Right = 614
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cli"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 245
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EstaAct"
            Begin Extent = 
               Top = 1
               Left = 683
               Bottom = 190
               Right = 955
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cbr_tip"
            Begin Extent = 
               Top = 203
               Left = 986
               Bottom = 483
               Right = 1223
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Perso"
            Begin Extent = 
               Top = 154
               Left = 326
               Bottom = 273
               Right = 518
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Sucu"
            Begin Extent = 
               Top = 61
               Left = 426
               Bottom = 180
               Right = 640
            End
            DisplayFlags = 280
          ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_cobro_x_documentos_x_cobrar';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'  TopColumn = 0
         End
         Begin Table = "bodg"
            Begin Extent = 
               Top = 257
               Left = 671
               Bottom = 471
               Right = 869
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Esta_cbr"
            Begin Extent = 
               Top = 20
               Left = 1050
               Bottom = 174
               Right = 1283
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Fac_deb"
            Begin Extent = 
               Top = 26
               Left = 116
               Bottom = 333
               Right = 294
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 28
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
         Alias = 2190
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_cobro_x_documentos_x_cobrar';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_cobro_x_documentos_x_cobrar';

