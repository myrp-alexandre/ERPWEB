CREATE VIEW dbo.vwcp_Aprobacion_Ing_Bod_x_OC
AS
SELECT        dbo.cp_Aprobacion_Ing_Bod_x_OC.IdEmpresa, dbo.cp_Aprobacion_Ing_Bod_x_OC.IdAprobacion, dbo.cp_Aprobacion_Ing_Bod_x_OC.Fecha_aprobacion, 
                         dbo.cp_Aprobacion_Ing_Bod_x_OC.IdEmpresa_Ogiro, dbo.cp_Aprobacion_Ing_Bod_x_OC.IdCbteCble_Ogiro, dbo.cp_Aprobacion_Ing_Bod_x_OC.IdTipoCbte_Ogiro, 
                         per.pe_nombreCompleto AS nom_proveedor, dbo.cp_Aprobacion_Ing_Bod_x_OC.IdProveedor, dbo.cp_Aprobacion_Ing_Bod_x_OC.num_auto_Proveedor, 
                         dbo.cp_Aprobacion_Ing_Bod_x_OC.num_documento, dbo.cp_Aprobacion_Ing_Bod_x_OC.Serie, dbo.cp_Aprobacion_Ing_Bod_x_OC.Observacion, 
                         dbo.cp_Aprobacion_Ing_Bod_x_OC.num_auto_Imprenta, dbo.cp_Aprobacion_Ing_Bod_x_OC.Fecha_Factura, dbo.cp_Aprobacion_Ing_Bod_x_OC.co_subtotal_iva, 
                         dbo.cp_Aprobacion_Ing_Bod_x_OC.co_subtotal_siniva, dbo.cp_Aprobacion_Ing_Bod_x_OC.Descuento, dbo.cp_Aprobacion_Ing_Bod_x_OC.co_baseImponible, 
                         dbo.cp_Aprobacion_Ing_Bod_x_OC.co_Por_iva, dbo.cp_Aprobacion_Ing_Bod_x_OC.co_valoriva, dbo.cp_Aprobacion_Ing_Bod_x_OC.co_total, 
                         dbo.cp_Aprobacion_Ing_Bod_x_OC.IdOrden_giro_Tipo, dbo.cp_Aprobacion_Ing_Bod_x_OC.IdIden_credito, dbo.cp_Aprobacion_Ing_Bod_x_OC.Serie2, 
                         dbo.cp_Aprobacion_Ing_Bod_x_OC.co_plazo, dbo.cp_Aprobacion_Ing_Bod_x_OC.co_FechaVctoAutorizacion
FROM            dbo.cp_Aprobacion_Ing_Bod_x_OC INNER JOIN
                         dbo.cp_proveedor ON dbo.cp_Aprobacion_Ing_Bod_x_OC.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND 
                         dbo.cp_Aprobacion_Ing_Bod_x_OC.IdProveedor = dbo.cp_proveedor.IdProveedor inner join tb_persona as per
						 on cp_proveedor.IdPersona = per.IdPersona
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "cp_Aprobacion_Ing_Bod_x_OC"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 203
               Right = 311
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_proveedor"
            Begin Extent = 
               Top = 13
               Left = 479
               Bottom = 188
               Right = 700
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
      Begin ColumnWidths = 22
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
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1830
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_Aprobacion_Ing_Bod_x_OC';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_Aprobacion_Ing_Bod_x_OC';

