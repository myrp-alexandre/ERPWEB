CREATE VIEW [dbo].[vwcxc_conciliacion]
AS
SELECT        dbo.cxc_conciliacion.IdEmpresa, dbo.cxc_conciliacion.IdSucursal, dbo.cxc_conciliacion.Fecha, dbo.cxc_conciliacion.IdConciliacion, 
                         dbo.cxc_conciliacion.Observacion, dbo.cxc_conciliacion.IdCliente, dbo.cxc_conciliacion.Estado, dbo.cxc_conciliacion.IdUsuario, 
                         dbo.cxc_conciliacion.Fecha_Transaccion, dbo.cxc_conciliacion.IdUsuarioUltModi, dbo.cxc_conciliacion.Fecha_UltMod, dbo.cxc_conciliacion.IdUsuarioUltAnu, 
                         dbo.cxc_conciliacion.Fecha_UltAnu, dbo.cxc_conciliacion.MotivoAnulacion, dbo.cxc_conciliacion.nom_pc, dbo.tb_persona.pe_nombreCompleto, 
                         dbo.tb_sucursal.Su_Descripcion, dbo.cxc_conciliacion.ip, dbo.cxc_conciliacion.IdEmpresa_cbte_cble, dbo.cxc_conciliacion.IdTipoCbte_cbte_cble, 
                         dbo.cxc_conciliacion.IdCbteCble_cbte_cble
FROM            dbo.cxc_conciliacion INNER JOIN
                         dbo.fa_cliente ON dbo.cxc_conciliacion.IdEmpresa = dbo.fa_cliente.IdEmpresa AND dbo.cxc_conciliacion.IdCliente = dbo.fa_cliente.IdCliente INNER JOIN
                         dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.tb_sucursal ON dbo.cxc_conciliacion.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.cxc_conciliacion.IdSucursal = dbo.tb_sucursal.IdSucursal
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[27] 4[1] 2[46] 3) )"
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
         Begin Table = "cxc_conciliacion"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 289
               Right = 219
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "fa_cliente"
            Begin Extent = 
               Top = 1
               Left = 572
               Bottom = 120
               Right = 782
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 6
               Left = 829
               Bottom = 125
               Right = 1021
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 145
               Left = 831
               Bottom = 264
               Right = 1045
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
      Begin ColumnWidths = 18
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
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_conciliacion';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_conciliacion';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_conciliacion';

