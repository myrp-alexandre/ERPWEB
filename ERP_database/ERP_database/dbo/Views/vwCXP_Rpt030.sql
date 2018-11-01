CREATE VIEW [dbo].[vwCXP_Rpt030]
AS
SELECT        dbo.cp_orden_giro.IdEmpresa, dbo.cp_orden_giro.IdTipoCbte_Ogiro, dbo.cp_orden_giro.IdCbteCble_Ogiro, pe_nombreCompleto pr_nombre, 
                         dbo.cp_orden_giro.co_serie + '-' + dbo.cp_orden_giro.co_factura AS NumDocumento, dbo.cp_orden_giro.co_observacion, 
                         dbo.cp_orden_giro.co_FechaFactura AS FechaEmision, dbo.cp_orden_giro.co_fechaOg AS FechaRegistro, dbo.cp_orden_giro.co_Por_iva, 
                         dbo.cp_orden_giro.co_valoriva, dbo.cp_orden_giro.co_subtotal_iva, dbo.cp_orden_giro.co_subtotal_siniva, dbo.cp_orden_giro.co_baseImponible, 
                         dbo.cp_orden_giro.co_total, 
                         CASE WHEN dbo.cp_orden_giro.co_vaCoa = 'S' THEN 'CREDITO TRIBUTARIO' ELSE 'SIN DERECHO A CREDITO TRIBUTARIO' END AS co_vaCoa, 
                         dbo.cp_orden_giro.IdIden_credito, dbo.cp_TipoDocumento.Codigo, dbo.cp_codigo_SRI.codigoSRI, dbo.cp_codigo_SRI.co_descripcion, 
                         CASE WHEN dbo.cp_orden_giro.IdTipoServicio = 'SERVI' THEN 'SERVICIOS' WHEN dbo.cp_orden_giro.IdTipoServicio = 'BIEN' THEN 'BIENES' ELSE 'BIENES Y SERVICIOS'
                          END AS TipoServicio, dbo.cp_orden_giro.co_FechaContabilizacion
FROM            dbo.cp_orden_giro INNER JOIN
                         dbo.cp_proveedor ON dbo.cp_orden_giro.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND 
                         dbo.cp_orden_giro.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
                         dbo.cp_TipoDocumento ON dbo.cp_orden_giro.IdOrden_giro_Tipo = dbo.cp_TipoDocumento.CodTipoDocumento INNER JOIN
                         dbo.cp_codigo_SRI ON dbo.cp_orden_giro.IdIden_credito = dbo.cp_codigo_SRI.IdCodigo_SRI
						 inner join tb_persona as per on per.IdPersona = cp_proveedor.IdPersona
WHERE        (dbo.cp_orden_giro.co_vaCoa = 'S') and dbo.cp_orden_giro.Estado = 'A'
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
         Configuration = "(H (1[32] 4[43] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[58] 2[13] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4[50] 3) )"
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
      ActivePaneConfig = 3
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "cp_orden_giro"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 279
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_proveedor"
            Begin Extent = 
               Top = 6
               Left = 317
               Bottom = 135
               Right = 549
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_TipoDocumento"
            Begin Extent = 
               Top = 6
               Left = 587
               Bottom = 135
               Right = 856
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_codigo_SRI"
            Begin Extent = 
               Top = 6
               Left = 894
               Bottom = 135
               Right = 1103
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
         Width = 1605
         Width = 1605
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1815
         Width = 1800
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
     ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt030';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' Begin ColumnWidths = 11
         Column = 2325
         Alias = 2025
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt030';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt030';

