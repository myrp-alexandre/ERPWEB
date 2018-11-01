CREATE VIEW [dbo].[vwCXP_Rpt004]
AS
SELECT        dbo.cp_orden_giro.IdEmpresa, dbo.cp_orden_giro.IdCbteCble_Ogiro, dbo.cp_orden_giro.IdTipoCbte_Ogiro, dbo.cp_orden_giro.IdOrden_giro_Tipo, 
                         dbo.cp_orden_giro.IdProveedor, dbo.cp_orden_giro.co_observacion AS Detalle, dbo.cp_orden_giro.co_factura AS num_comprobante, 
                         dbo.cp_orden_giro.co_fechaOg AS Fecha, dbo.cp_orden_giro.co_FechaFactura, dbo.cp_retencion.IdRetencion, dbo.ct_cbtecble_det.secuencia, 
                         dbo.ct_cbtecble_det.IdCtaCble, dbo.ct_cbtecble_det.dc_Valor, CASE WHEN dbo.ct_cbtecble_det.dc_Valor > 0 THEN ISNULL(dbo.ct_cbtecble_det.dc_Valor, 0) 
                         ELSE 0 END AS valor_debe, CASE WHEN dbo.ct_cbtecble_det.dc_Valor < 0 THEN ISNULL(dbo.ct_cbtecble_det.dc_Valor * - 1, 0) ELSE 0 END AS valor_haber, 
                         dbo.ct_cbtecble_det.IdCentroCosto, dbo.ct_cbtecble_det.IdCentroCosto_sub_centro_costo, dbo.ct_cbtecble_det.dc_Observacion, 
                         dbo.ct_plancta.pc_Cuenta AS nom_cuenta, dbo.ct_plancta.pc_clave_corta AS clave_cuenta, dbo.ct_cbtecble_tipo.CodTipoCbte, dbo.ct_cbtecble_tipo.tc_TipoCbte, 
                         dbo.cp_TipoDocumento.Codigo, dbo.cp_TipoDocumento.Descripcion AS nom_comprobante, pe_nombreCompleto AS nom_proveedor, 
                         dbo.tb_empresa.em_nombre, dbo.cp_retencion.serie1 + '-' + dbo.cp_retencion.serie2 AS Serie_Ret, dbo.cp_retencion.NumRetencion, 
                         dbo.cp_retencion.NAutorizacion AS Num_Auto_Reten, dbo.cp_retencion.fecha AS Fecha_Reten, dbo.cp_retencion.observacion AS Observacion_Reten, 
                         dbo.cp_retencion.re_Tiene_RTiva AS Tiene_RTIva, dbo.cp_retencion.re_Tiene_RFuente AS Tiene_RTFte, 
                         dbo.cp_retencion_x_ct_cbtecble.ct_IdTipoCbte AS IdTipoCbte_Ret, dbo.cp_retencion_x_ct_cbtecble.ct_IdCbteCble AS IdCbteCble_Ret, 
                         ct_cbtecble_tipo_1.tc_TipoCbte AS nom_TipoCbte_Ret, dbo.cp_retencion_x_ct_cbtecble.ct_IdEmpresa AS IdEmpresa_Ret
FROM            dbo.ct_cbtecble_tipo AS ct_cbtecble_tipo_1 INNER JOIN
                         dbo.ct_cbtecble_det INNER JOIN
                         dbo.cp_retencion_x_ct_cbtecble ON dbo.ct_cbtecble_det.IdEmpresa = dbo.cp_retencion_x_ct_cbtecble.ct_IdEmpresa AND 
                         dbo.ct_cbtecble_det.IdTipoCbte = dbo.cp_retencion_x_ct_cbtecble.ct_IdTipoCbte AND 
                         dbo.ct_cbtecble_det.IdCbteCble = dbo.cp_retencion_x_ct_cbtecble.ct_IdCbteCble INNER JOIN
                         dbo.ct_plancta ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_plancta.IdEmpresa AND dbo.ct_cbtecble_det.IdCtaCble = dbo.ct_plancta.IdCtaCble ON 
                         ct_cbtecble_tipo_1.IdTipoCbte = dbo.ct_cbtecble_det.IdTipoCbte AND ct_cbtecble_tipo_1.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa RIGHT OUTER JOIN
                         dbo.cp_orden_giro INNER JOIN
                         dbo.cp_TipoDocumento ON dbo.cp_orden_giro.IdOrden_giro_Tipo = dbo.cp_TipoDocumento.CodTipoDocumento INNER JOIN
                         dbo.cp_proveedor ON dbo.cp_orden_giro.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND 
                         dbo.cp_orden_giro.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
                         dbo.tb_empresa ON dbo.cp_orden_giro.IdEmpresa = dbo.tb_empresa.IdEmpresa INNER JOIN
                         dbo.ct_cbtecble_tipo ON dbo.cp_orden_giro.IdTipoCbte_Ogiro = dbo.ct_cbtecble_tipo.IdTipoCbte AND 
                         dbo.cp_orden_giro.IdEmpresa = dbo.ct_cbtecble_tipo.IdEmpresa INNER JOIN
                         dbo.cp_retencion ON dbo.cp_orden_giro.IdEmpresa = dbo.cp_retencion.IdEmpresa_Ogiro AND 
                         dbo.cp_orden_giro.IdCbteCble_Ogiro = dbo.cp_retencion.IdCbteCble_Ogiro AND dbo.cp_orden_giro.IdTipoCbte_Ogiro = dbo.cp_retencion.IdTipoCbte_Ogiro ON 
                         dbo.cp_retencion_x_ct_cbtecble.rt_IdEmpresa = dbo.cp_retencion.IdEmpresa AND dbo.cp_retencion_x_ct_cbtecble.rt_IdRetencion = dbo.cp_retencion.IdRetencion
						 inner join tb_persona as per on per.IdPersona = cp_proveedor.IdPersona
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[11] 4[79] 2[4] 3) )"
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
               Top = 20
               Left = 66
               Bottom = 202
               Right = 292
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_TipoDocumento"
            Begin Extent = 
               Top = 383
               Left = 101
               Bottom = 444
               Right = 332
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_proveedor"
            Begin Extent = 
               Top = 415
               Left = 28
               Bottom = 487
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "tb_empresa"
            Begin Extent = 
               Top = 27
               Left = 1
               Bottom = 123
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_cbtecble_tipo"
            Begin Extent = 
               Top = 294
               Left = 0
               Bottom = 355
               Right = 209
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "cp_retencion"
            Begin Extent = 
               Top = 17
               Left = 391
               Bottom = 378
               Right = 648
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_cbtecble_det"
            Begin Extent = 
               Top = 239
               Left = 673
               Bottom = 413
               Right = 919
      ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt004';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'      End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_retencion_x_ct_cbtecble"
            Begin Extent = 
               Top = 20
               Left = 703
               Bottom = 209
               Right = 913
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "ct_plancta"
            Begin Extent = 
               Top = 75
               Left = 1143
               Bottom = 177
               Right = 1263
            End
            DisplayFlags = 280
            TopColumn = 8
         End
         Begin Table = "ct_cbtecble_tipo_1"
            Begin Extent = 
               Top = 146
               Left = 1068
               Bottom = 365
               Right = 1277
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
      Begin ColumnWidths = 24
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1905
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1815
         Width = 1500
         Width = 1965
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
         Column = 4605
         Alias = 2805
         Table = 2895
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt004';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt004';

