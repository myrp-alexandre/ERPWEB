CREATE VIEW [dbo].[vwACTF_Rpt004]
AS
SELECT        TOP (100) PERCENT act.IdEmpresa, act.IdActivoFijo, act.Af_Codigo_Barra, 0 IdTipoDepreciacion, ' ' cod_tipo_depreciacion, 'lineal' nom_tipo_depreciacion, 
                         act.Af_Nombre, 0 IdDepartamento, suc.IdSucursal, suc.Su_Descripcion, act.Af_fecha_compra, act.Af_costo_compra, act.Estado_Proceso, det.IdDepreciacion, 
                         det.Secuencia,det.Valor_Compra, det.Valor_Salvamento, det.Vida_Util, det.Valor_Depreciacion, det.Valor_Depre_Acum,  ct.IdPeriodo, 
                         ct.IdanioFiscal, ct.pe_mes, mes.smes, mes.Nemonico
FROM            dbo.Af_Activo_fijo AS act INNER JOIN
                         dbo.tb_sucursal AS suc ON suc.IdSucursal = act.IdSucursal AND suc.IdEmpresa = act.IdEmpresa INNER JOIN
                         dbo.Af_Depreciacion_Det AS det ON act.IdEmpresa = det.IdEmpresa AND act.IdActivoFijo = det.IdActivoFijo INNER JOIN
                         dbo.Af_Depreciacion AS dpc ON dpc.IdEmpresa = det.IdEmpresa AND dpc.IdDepreciacion = det.IdDepreciacion AND dpc.Estado = 'A' INNER JOIN
                         dbo.ct_periodo AS ct ON dpc.IdEmpresa = ct.IdEmpresa AND dpc.IdPeriodo = ct.IdPeriodo INNER JOIN
                         dbo.tb_mes AS mes ON mes.idMes = ct.pe_mes

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
         Begin Table = "act"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 291
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "suc"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 268
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tip"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 399
               Right = 251
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "det"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 531
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "dpc"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 663
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct"
            Begin Extent = 
               Top = 666
               Left = 38
               Bottom = 795
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "mes"
            Begin Extent = 
               Top = 798
               Left = 38
               Bottom = 927
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
   ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwACTF_Rpt004';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'      End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwACTF_Rpt004';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwACTF_Rpt004';

