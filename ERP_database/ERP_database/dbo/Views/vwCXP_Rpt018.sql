CREATE VIEW [dbo].[vwCXP_Rpt018]
AS
SELECT        dbo.cp_orden_giro.IdEmpresa, dbo.cp_orden_giro.IdCbteCble_Ogiro, dbo.cp_orden_giro.IdTipoCbte_Ogiro, dbo.cp_orden_giro.IdOrden_giro_Tipo, 
                         dbo.cp_orden_giro.IdProveedor, dbo.cp_orden_giro.co_fechaOg, 
                         dbo.cp_TipoDocumento.Codigo + '-' + dbo.cp_orden_giro.co_serie + '-' + dbo.cp_orden_giro.co_factura AS Documento, dbo.cp_orden_giro.co_FechaFactura, 
                         dbo.cp_orden_giro.co_observacion, dbo.cp_orden_giro.co_subtotal_iva, dbo.cp_orden_giro.co_subtotal_siniva, dbo.cp_orden_giro.co_baseImponible, 
                         dbo.cp_orden_giro.co_Por_iva, dbo.cp_orden_giro.co_valoriva, dbo.cp_orden_giro.co_total, dbo.cp_orden_giro.co_valorpagar, dbo.cp_orden_giro.Estado, 
                         dbo.cp_orden_giro.IdSucursal, dbo.cp_orden_giro.Num_Autorizacion, dbo.cp_retencion.IdRetencion, dbo.cp_retencion.serie1 + '-' + dbo.cp_retencion.serie2  serie, dbo.cp_retencion.NumRetencion, 
                         dbo.cp_retencion_det.re_tipoRet, dbo.cp_retencion_det.re_baseRetencion, dbo.cp_retencion_det.IdCodigo_SRI, dbo.cp_retencion_det.re_Codigo_impuesto, 
                         dbo.cp_retencion_det.re_Porcen_retencion, dbo.cp_retencion_det.re_valor_retencion, dbo.cp_codigo_SRI.co_descripcion, dbo.cp_codigo_SRI.IdTipoSRI, 
                         pe_nombreCompleto AS nom_proveedor, dbo.tb_sucursal.Su_Descripcion AS nom_sucursal, dbo.cp_TipoDocumento.Descripcion AS nom_TipoDocumento, 
                         dbo.tb_persona.pe_cedulaRuc
FROM            dbo.cp_orden_giro INNER JOIN
                         dbo.cp_retencion ON dbo.cp_orden_giro.IdEmpresa = dbo.cp_retencion.IdEmpresa_Ogiro AND 
                         dbo.cp_orden_giro.IdCbteCble_Ogiro = dbo.cp_retencion.IdCbteCble_Ogiro AND 
                         dbo.cp_orden_giro.IdTipoCbte_Ogiro = dbo.cp_retencion.IdTipoCbte_Ogiro INNER JOIN
                         dbo.cp_retencion_det ON dbo.cp_retencion.IdEmpresa = dbo.cp_retencion_det.IdEmpresa AND 
                         dbo.cp_retencion.IdRetencion = dbo.cp_retencion_det.IdRetencion INNER JOIN
                         dbo.cp_codigo_SRI ON dbo.cp_retencion_det.IdCodigo_SRI = dbo.cp_codigo_SRI.IdCodigo_SRI INNER JOIN
                         dbo.cp_proveedor ON dbo.cp_orden_giro.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND 
                         dbo.cp_orden_giro.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
                         dbo.tb_sucursal ON dbo.cp_orden_giro.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.cp_orden_giro.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.cp_TipoDocumento ON dbo.cp_orden_giro.IdOrden_giro_Tipo = dbo.cp_TipoDocumento.CodTipoDocumento INNER JOIN
                         dbo.tb_persona ON dbo.cp_proveedor.IdPersona = dbo.tb_persona.IdPersona
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[26] 4[4] 2[22] 3) )"
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
         Begin Table = "cp_retencion"
            Begin Extent = 
               Top = 6
               Left = 317
               Bottom = 135
               Right = 526
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_retencion_det"
            Begin Extent = 
               Top = 6
               Left = 564
               Bottom = 135
               Right = 773
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_codigo_SRI"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_proveedor"
            Begin Extent = 
               Top = 138
               Left = 285
               Bottom = 267
               Right = 506
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 138
               Left = 544
               Bottom = 267
               Right = 774
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_TipoDocumento"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 399
               Right = 307
       ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt018';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'     End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 270
               Left = 345
               Bottom = 399
               Right = 555
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt018';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt018';

