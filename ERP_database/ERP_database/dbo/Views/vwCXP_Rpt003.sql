
CREATE VIEW [dbo].[vwCXP_Rpt003]
AS
SELECT        dbo.cp_orden_giro.IdEmpresa, dbo.cp_orden_giro.IdCbteCble_Ogiro, dbo.cp_orden_giro.IdTipoCbte_Ogiro, dbo.cp_orden_giro.IdOrden_giro_Tipo, 
                         dbo.cp_orden_giro.IdProveedor, dbo.cp_orden_giro.co_fechaOg AS Fecha, dbo.cp_orden_giro.co_factura AS num_comprobante, dbo.cp_orden_giro.co_FechaFactura, 
                         dbo.cp_orden_giro.co_FechaContabilizacion, dbo.cp_orden_giro.co_FechaFactura_vct, dbo.cp_orden_giro.co_observacion AS Detalle, 
                         dbo.ct_cbtecble_det.secuencia, dbo.ct_cbtecble_det.IdCtaCble, dbo.ct_cbtecble_det.IdCentroCosto, dbo.ct_cbtecble_det.IdCentroCosto_sub_centro_costo, 
                         dbo.ct_cbtecble_det.dc_Valor, CASE WHEN dbo.ct_cbtecble_det.dc_Valor > 0 THEN ISNULL(dbo.ct_cbtecble_det.dc_Valor, 0) ELSE 0 END AS valor_debe, 
                         CASE WHEN dbo.ct_cbtecble_det.dc_Valor < 0 THEN ISNULL(dbo.ct_cbtecble_det.dc_Valor * - 1, 0) ELSE 0 END AS valor_haber, 
                         dbo.ct_cbtecble_det.dc_Observacion, dbo.ct_plancta.pc_Cuenta AS nom_cuenta, dbo.ct_plancta.pc_clave_corta AS clave_cuenta, 
                         per.pe_nombreCompleto AS nom_proveedor, dbo.cp_TipoDocumento.Codigo, dbo.cp_TipoDocumento.Descripcion AS nom_comprobante, 
                         dbo.ct_cbtecble_tipo.CodTipoCbte, dbo.ct_cbtecble_tipo.tc_TipoCbte, dbo.tb_empresa.em_nombre
FROM            dbo.cp_proveedor RIGHT OUTER JOIN
                         dbo.ct_cbtecble_tipo INNER JOIN
                         dbo.cp_orden_giro INNER JOIN
                         dbo.cp_TipoDocumento ON dbo.cp_orden_giro.IdOrden_giro_Tipo = dbo.cp_TipoDocumento.CodTipoDocumento INNER JOIN
                         dbo.tb_empresa ON dbo.cp_orden_giro.IdEmpresa = dbo.tb_empresa.IdEmpresa ON dbo.ct_cbtecble_tipo.IdEmpresa = dbo.cp_orden_giro.IdEmpresa AND 
                         dbo.ct_cbtecble_tipo.IdTipoCbte = dbo.cp_orden_giro.IdTipoCbte_Ogiro ON dbo.cp_proveedor.IdProveedor = dbo.cp_orden_giro.IdProveedor AND 
                         dbo.cp_proveedor.IdEmpresa = dbo.cp_orden_giro.IdEmpresa LEFT OUTER JOIN
                         dbo.ct_cbtecble_det INNER JOIN
                         dbo.ct_plancta ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_plancta.IdEmpresa AND dbo.ct_cbtecble_det.IdCtaCble = dbo.ct_plancta.IdCtaCble ON 
                         dbo.cp_orden_giro.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND dbo.cp_orden_giro.IdTipoCbte_Ogiro = dbo.ct_cbtecble_det.IdTipoCbte AND 
                         dbo.cp_orden_giro.IdCbteCble_Ogiro = dbo.ct_cbtecble_det.IdCbteCble
						 inner join tb_persona as per on cp_proveedor.IdPersona = per.IdPersona
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[26] 4[10] 2[13] 3) )"
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
               Top = 2
               Left = 45
               Bottom = 292
               Right = 271
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_TipoDocumento"
            Begin Extent = 
               Top = 366
               Left = 767
               Bottom = 430
               Right = 960
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_cbtecble_tipo"
            Begin Extent = 
               Top = 221
               Left = 759
               Bottom = 282
               Right = 968
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_cbtecble_tipo_x_empresa"
            Begin Extent = 
               Top = 74
               Left = 729
               Bottom = 141
               Right = 938
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_empresa"
            Begin Extent = 
               Top = 64
               Left = 417
               Bottom = 193
               Right = 634
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "cp_proveedor"
            Begin Extent = 
               Top = 290
               Left = 736
               Bottom = 357
               Right = 957
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "ct_cbtecble_det"
            Begin Extent = 
               Top = 0
               Left = 585
               Bottom = 61
               Rig', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt003';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'ht = 848
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_plancta"
            Begin Extent = 
               Top = 148
               Left = 757
               Bottom = 215
               Right = 966
            End
            DisplayFlags = 280
            TopColumn = 8
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 27
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
         Width = 915
         Width = 2715
         Width = 1230
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 7890
         Alias = 3135
         Table = 3285
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt003';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt003';

