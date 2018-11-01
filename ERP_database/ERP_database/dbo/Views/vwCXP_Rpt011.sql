CREATE VIEW [dbo].[vwCXP_Rpt011]
AS
SELECT        dbo.cp_orden_giro.IdEmpresa, dbo.cp_orden_giro.IdCbteCble_Ogiro, dbo.cp_orden_giro.IdTipoCbte_Ogiro, dbo.cp_orden_giro.IdOrden_giro_Tipo, 
                         dbo.cp_orden_giro.IdProveedor, dbo.vwcp_ProveedorRuc.pr_nombre AS nom_proveedor, dbo.vwcp_ProveedorRuc.pe_cedulaRuc AS ced_proveedor, 
                         dbo.vwcp_ProveedorRuc.pe_direccion AS dir_proveedor, dbo.cp_orden_giro.co_fechaOg, dbo.cp_orden_giro.co_serie, dbo.cp_orden_giro.co_factura AS num_factura, 
                         dbo.cp_orden_giro.co_FechaFactura, dbo.cp_orden_giro.Estado, dbo.cp_TipoDocumento.Descripcion AS TipoDocumento, dbo.cp_retencion.fecha AS fecha_retencion, 
                         YEAR(dbo.cp_retencion.fecha) AS ejercicio_fiscal, dbo.cp_retencion_det.IdRetencion, dbo.cp_retencion_det.Idsecuencia, 
                         dbo.cp_retencion_det.re_tipoRet AS Impuesto, dbo.cp_retencion_det.re_baseRetencion AS base_retencion, dbo.cp_retencion_det.IdCodigo_SRI, 
                         dbo.cp_codigo_SRI.codigoSRI AS cod_Impuesto_SRI, dbo.cp_codigo_SRI.co_porRetencion AS por_Retencion_SRI, 
                         dbo.cp_retencion_det.re_valor_retencion AS valor_Retenido, dbo.cp_retencion.IdEmpresa_Ogiro, dbo.cp_retencion.serie1 + '-'+ dbo.cp_retencion.serie2  as serie, dbo.cp_retencion.NumRetencion, 
                         dbo.cp_retencion.re_EstaImpresa, dbo.cp_TipoDocumento.Codigo AS cod_Tipo_Documento
FROM            dbo.cp_orden_giro INNER JOIN
                         dbo.vwcp_ProveedorRuc ON dbo.cp_orden_giro.IdEmpresa = dbo.vwcp_ProveedorRuc.IdEmpresa AND 
                         dbo.cp_orden_giro.IdProveedor = dbo.vwcp_ProveedorRuc.IdProveedor INNER JOIN
                         dbo.cp_TipoDocumento ON dbo.cp_orden_giro.IdOrden_giro_Tipo = dbo.cp_TipoDocumento.CodTipoDocumento INNER JOIN
                         dbo.cp_retencion ON dbo.cp_orden_giro.IdEmpresa = dbo.cp_retencion.IdEmpresa AND 
                         dbo.cp_orden_giro.IdCbteCble_Ogiro = dbo.cp_retencion.IdCbteCble_Ogiro AND dbo.cp_orden_giro.IdTipoCbte_Ogiro = dbo.cp_retencion.IdTipoCbte_Ogiro AND 
                         dbo.cp_orden_giro.IdEmpresa = dbo.cp_retencion.IdEmpresa_Ogiro INNER JOIN
                         dbo.cp_retencion_det ON dbo.cp_retencion.IdEmpresa = dbo.cp_retencion_det.IdEmpresa AND 
                         dbo.cp_retencion.IdRetencion = dbo.cp_retencion_det.IdRetencion INNER JOIN
                         dbo.cp_codigo_SRI ON dbo.cp_retencion_det.IdCodigo_SRI = dbo.cp_codigo_SRI.IdCodigo_SRI
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[24] 4[38] 2[9] 3) )"
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
         Begin Table = "vwcp_ProveedorRuc"
            Begin Extent = 
               Top = 6
               Left = 317
               Bottom = 135
               Right = 538
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_TipoDocumento"
            Begin Extent = 
               Top = 6
               Left = 576
               Bottom = 135
               Right = 845
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_retencion"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 15
         End
         Begin Table = "cp_retencion_det"
            Begin Extent = 
               Top = 138
               Left = 285
               Bottom = 267
               Right = 494
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_codigo_SRI"
            Begin Extent = 
               Top = 138
               Left = 532
               Bottom = 267
               Right = 741
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
      Begin ColumnWidths = 29
         Width = 284
       ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt011';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'  Width = 1500
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
         Alias = 2910
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt011';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt011';

