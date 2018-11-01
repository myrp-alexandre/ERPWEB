/*select * from cp_catalogo*/
CREATE VIEW [dbo].[vwcp_Retenciones_x_tipo_impresion]
AS
SELECT        OG.IdEmpresa, SUBSTRING(Sucu.Su_Descripcion, 1, 4) AS Sucursal, Prov.IdProveedor, 
                         Per.pe_apellido + ' ' + Per.pe_nombre + ' / ' + Per.pe_razonSocial AS Proveedor, OG.IdCbteCble_Ogiro AS NumCbteCXP, SUBSTRING(TipDoc.Descripcion, 1, 5) 
                         + '#' + OG.co_serie + '-' + OG.co_factura AS NumDocumento, OG.co_FechaFactura, OG.co_FechaFactura_vct, OG.co_observacion AS Referencia, OG.co_total, 
                         OG.co_valorpagar, RT.NAutorizacion, RT.fecha AS FechaRT, 
                         CASE WHEN RT.re_EstaImpresa = 'S' THEN 'IMPRESO' WHEN RT.re_EstaImpresa = 'N' THEN 'NO IMPRESO' END AS sImpresion, 
                         CASE WHEN RT.re_EstaImpresa = 'S' THEN 'T_IMPR_RET_IMPR' WHEN RT.re_EstaImpresa = 'N' THEN 'T_IMPR_RET_NO_IMP' END AS TipoImpresion, 
                         OG.IdTipoCbte_Ogiro, OG.IdCbteCble_Ogiro, RT.IdRetencion, RT.serie1 + '-'+ RT.serie2 as serie  , RT.NumRetencion AS NumRetencion
FROM            dbo.cp_orden_giro AS OG INNER JOIN
                         dbo.cp_proveedor AS Prov ON OG.IdEmpresa = Prov.IdEmpresa AND OG.IdProveedor = Prov.IdProveedor INNER JOIN
                         dbo.tb_persona AS Per ON Prov.IdPersona = Per.IdPersona INNER JOIN
                         dbo.cp_TipoDocumento AS TipDoc ON OG.IdOrden_giro_Tipo = TipDoc.CodTipoDocumento INNER JOIN
                         dbo.cp_retencion AS RT ON OG.IdEmpresa = RT.IdEmpresa AND OG.IdCbteCble_Ogiro = RT.IdCbteCble_Ogiro AND 
                         OG.IdTipoCbte_Ogiro = RT.IdTipoCbte_Ogiro LEFT OUTER JOIN
                         dbo.tb_sucursal AS Sucu ON OG.IdEmpresa = Sucu.IdEmpresa AND OG.IdSucursal = Sucu.IdSucursal
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[24] 4[18] 2[21] 3) )"
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
         Top = -518
         Left = 0
      End
      Begin Tables = 
         Begin Table = "OG"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 279
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Prov"
            Begin Extent = 
               Top = 0
               Left = 342
               Bottom = 129
               Right = 563
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Per"
            Begin Extent = 
               Top = 254
               Left = 443
               Bottom = 383
               Right = 652
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TipDoc"
            Begin Extent = 
               Top = 238
               Left = 163
               Bottom = 367
               Right = 432
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RT"
            Begin Extent = 
               Top = 486
               Left = 241
               Bottom = 615
               Right = 450
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Sucu"
            Begin Extent = 
               Top = 666
               Left = 38
               Bottom = 795
               Right = 268
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
         Width = 1500', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_Retenciones_x_tipo_impresion';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
         Width = 1500
         Width = 1500
         Width = 2490
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2655
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
         Column = 7050
         Alias = 2700
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_Retenciones_x_tipo_impresion';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_Retenciones_x_tipo_impresion';

