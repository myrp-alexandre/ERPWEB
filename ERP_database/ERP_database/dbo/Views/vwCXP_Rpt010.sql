CREATE view [dbo].[vwCXP_Rpt010]
as
SELECT        dbo.cp_orden_giro.IdEmpresa, dbo.cp_orden_giro.IdCbteCble_Ogiro, dbo.cp_orden_giro.IdTipoCbte_Ogiro, dbo.cp_orden_giro.IdOrden_giro_Tipo, 
                         dbo.cp_TipoDocumento.Codigo + '#:' + CAST(dbo.cp_orden_giro.IdCbteCble_Ogiro AS VARCHAR(20)) 
                         + '/' + dbo.cp_orden_giro.co_serie + '-' + dbo.cp_orden_giro.co_factura AS Documento, dbo.cp_TipoDocumento.Descripcion AS nom_tipo_doc, 
                         dbo.cp_TipoDocumento.Codigo AS cod_tipo_doc, dbo.cp_orden_giro.co_fechaOg, dbo.cp_proveedor.IdProveedor, tb_persona.pe_nombreCompleto AS nom_proveedor, 
                         dbo.cp_orden_giro.co_valorpagar AS Valor_a_pagar, 0 AS Valor_debe, dbo.cp_orden_giro.co_total * - 1 AS Valor_Haber, 
                         dbo.cp_orden_giro.co_observacion AS Observacion, dbo.tb_persona.pe_cedulaRuc AS Ruc_Proveedor, dbo.cp_proveedor.representante_legal,
						 CAST(dbo.cp_orden_giro.co_FechaFactura_vct AS date) AS co_FechaFactura_vct 
FROM            dbo.cp_orden_giro INNER JOIN
                         dbo.cp_TipoDocumento ON dbo.cp_orden_giro.IdOrden_giro_Tipo = dbo.cp_TipoDocumento.CodTipoDocumento INNER JOIN
                         dbo.cp_proveedor ON dbo.cp_orden_giro.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND 
                         dbo.cp_orden_giro.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
                         dbo.tb_persona ON dbo.cp_proveedor.IdPersona = dbo.tb_persona.IdPersona
UNION
SELECT        dbo.cp_nota_DebCre.IdEmpresa, dbo.cp_nota_DebCre.IdCbteCble_Nota, dbo.cp_nota_DebCre.IdTipoCbte_Nota, 
                         dbo.cp_TipoDocumento.CodTipoDocumento AS IdTipoDocumento, 'ND#' + cast(cp_nota_DebCre.IdCbteCble_Nota AS varchar(20)) AS Documeto, 
                         dbo.cp_TipoDocumento.Descripcion, dbo.cp_TipoDocumento.CodTipoDocumento AS cod_tipo_doc, dbo.cp_nota_DebCre.cn_fecha, dbo.cp_proveedor.IdProveedor, 
                         tb_persona.pe_nombreCompleto AS nom_proveedor, dbo.cp_nota_DebCre.cn_total AS Valor_a_pagar, 0 AS Valor_debe, 
                         dbo.cp_nota_DebCre.cn_total * - 1 AS Valor_Haber, dbo.cp_nota_DebCre.cn_observacion, dbo.tb_persona.pe_cedulaRuc AS Ruc_Proveedor, 
                         dbo.cp_proveedor.representante_legal, dbo.cp_nota_DebCre.cn_Fecha_vcto
FROM            dbo.tb_persona INNER JOIN
                         dbo.cp_proveedor ON dbo.tb_persona.IdPersona = dbo.cp_proveedor.IdPersona INNER JOIN
                         dbo.cp_nota_DebCre ON dbo.cp_proveedor.IdEmpresa = dbo.cp_nota_DebCre.IdEmpresa AND 
                         dbo.cp_proveedor.IdProveedor = dbo.cp_nota_DebCre.IdProveedor CROSS JOIN
                         dbo.cp_TipoDocumento 
WHERE        (dbo.cp_nota_DebCre.DebCre = 'D') AND (dbo.cp_TipoDocumento.CodTipoDocumento = '05')
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[5] 2[4] 3) )"
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
         Begin Table = "cp_TipoDocumento"
            Begin Extent = 
               Top = 6
               Left = 317
               Bottom = 135
               Right = 586
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_proveedor"
            Begin Extent = 
               Top = 6
               Left = 624
               Bottom = 135
               Right = 845
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 6
               Left = 883
               Bottom = 135
               Right = 1092
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
         Or = ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt010';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt010';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt010';

