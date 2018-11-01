CREATE VIEW [dbo].[vwCXP_Rpt026]
AS
SELECT        dbo.cp_conciliacion_Caja.IdEmpresa, dbo.cp_conciliacion_Caja.IdConciliacion_Caja, dbo.cp_conciliacion_Caja.Fecha, dbo.cp_conciliacion_Caja.IdCaja, 
                         dbo.cp_conciliacion_Caja.IdEstadoCierre, dbo.cp_conciliacion_Caja.Observacion, dbo.cp_conciliacion_Caja.IdEmpresa_op, 
                         dbo.cp_conciliacion_Caja.IdOrdenPago_op, dbo.caj_Caja.ca_Descripcion, dbo.cp_conciliacion_Caja_det.IdEmpresa_OGiro, 
                         dbo.cp_conciliacion_Caja_det.IdCbteCble_Ogiro, dbo.cp_conciliacion_Caja_det.IdTipoCbte_Ogiro, dbo.cp_orden_giro.co_serie, dbo.cp_orden_giro.co_factura, 
                         dbo.cp_orden_giro.co_valorpagar, dbo.cp_orden_giro.co_observacion, dbo.cp_catalogo.Nombre, dbo.cp_orden_giro.co_FechaFactura, 
                         dbo.cp_orden_giro.co_fechaOg, pe_nombreCompleto pr_nombre
FROM            dbo.caj_Caja RIGHT OUTER JOIN
                         dbo.cp_conciliacion_Caja INNER JOIN
                         dbo.cp_conciliacion_Caja_det ON dbo.cp_conciliacion_Caja.IdEmpresa = dbo.cp_conciliacion_Caja_det.IdEmpresa AND 
                         dbo.cp_conciliacion_Caja.IdConciliacion_Caja = dbo.cp_conciliacion_Caja_det.IdConciliacion_Caja INNER JOIN
                         dbo.cp_catalogo_tipo INNER JOIN
                         dbo.cp_catalogo ON dbo.cp_catalogo_tipo.IdCatalogo_tipo = dbo.cp_catalogo.IdCatalogo_tipo ON 
                         dbo.cp_conciliacion_Caja.IdEstadoCierre = dbo.cp_catalogo.IdCatalogo LEFT OUTER JOIN
                         dbo.cp_orden_pago ON dbo.cp_conciliacion_Caja.IdEmpresa_op = dbo.cp_orden_pago.IdEmpresa AND 
                         dbo.cp_conciliacion_Caja.IdOrdenPago_op = dbo.cp_orden_pago.IdOrdenPago LEFT OUTER JOIN
                         dbo.cp_orden_giro ON dbo.cp_conciliacion_Caja_det.IdEmpresa_OGiro = dbo.cp_orden_giro.IdEmpresa AND 
                         dbo.cp_conciliacion_Caja_det.IdCbteCble_Ogiro = dbo.cp_orden_giro.IdCbteCble_Ogiro AND 
                         dbo.cp_conciliacion_Caja_det.IdTipoCbte_Ogiro = dbo.cp_orden_giro.IdTipoCbte_Ogiro ON dbo.caj_Caja.IdEmpresa = dbo.cp_conciliacion_Caja.IdEmpresa AND 
                         dbo.caj_Caja.IdCaja = dbo.cp_conciliacion_Caja.IdCaja LEFT OUTER JOIN
                         dbo.cp_proveedor ON dbo.cp_orden_giro.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND dbo.cp_orden_giro.IdProveedor = dbo.cp_proveedor.IdProveedor
						 inner join tb_persona as per on per.IdPersona = cp_proveedor.IdPersona
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[6] 4[4] 2[49] 3) )"
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
         Begin Table = "caj_Caja"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_conciliacion_Caja"
            Begin Extent = 
               Top = 6
               Left = 286
               Bottom = 135
               Right = 495
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_conciliacion_Caja_det"
            Begin Extent = 
               Top = 6
               Left = 533
               Bottom = 135
               Right = 796
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_catalogo_tipo"
            Begin Extent = 
               Top = 6
               Left = 834
               Bottom = 118
               Right = 1043
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_catalogo"
            Begin Extent = 
               Top = 6
               Left = 1081
               Bottom = 135
               Right = 1290
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_orden_pago"
            Begin Extent = 
               Top = 120
               Left = 834
               Bottom = 249
               Right = 1043
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_orden_giro"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt026';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'279
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_proveedor"
            Begin Extent = 
               Top = 138
               Left = 317
               Bottom = 267
               Right = 538
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt026';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt026';

