CREATE VIEW dbo.vwACTF_Rpt006
AS
SELECT        af.IdEmpresa, af.Id_Mejora_Baja_Activo, af.Id_Tipo, act.IdActivoFijo, act.Af_Nombre, '' AS NomCompleto, mar.Descripcion AS Af_Marca, dis.Descripcion AS Af_Modelo, act.Af_NumSerie, 
                         col.Descripcion AS Af_Color, ubi.Descripcion AS Af_Ubicacion, act.Af_Vida_Util, act.Af_Meses_depreciar, act.Af_porcentaje_deprec, pro.IdProveedor, '' pr_nombre, af.ValorActivo, af.Valor_Mej_Baj_Activo, af.Compr_Mej_Baj, 
                         af.DescripcionTecnica, af.Motivo, af.Estado, af.Fecha_Transac, af.IdUsuario
FROM            dbo.Af_Mej_Baj_Activo AS af INNER JOIN
                         dbo.Af_Activo_fijo AS act ON af.IdEmpresa = act.IdEmpresa AND af.IdActivoFijo = act.IdActivoFijo INNER JOIN
                         dbo.cp_proveedor AS pro ON pro.IdEmpresa = af.IdEmpresa AND pro.IdProveedor = 0 INNER JOIN
                         dbo.Af_Catalogo AS mar ON mar.IdCatalogo = act.IdCatalogo_Marca INNER JOIN
                         dbo.Af_Catalogo AS col ON col.IdCatalogo = act.IdCatalogo_Color INNER JOIN
                         dbo.Af_Catalogo AS dis ON dis.IdCatalogo = act.IdCatalogo_Modelo LEFT OUTER JOIN
                         dbo.Af_Catalogo AS ubi ON ubi.IdCatalogo = act.IdTipoCatalogo_Ubicacion
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[43] 4[5] 2[5] 3) )"
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
         Top = -96
         Left = 0
      End
      Begin Tables = 
         Begin Table = "af"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 245
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "act"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pro"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 400
               Right = 270
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "mar"
            Begin Extent = 
               Top = 6
               Left = 283
               Bottom = 136
               Right = 462
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "col"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 532
               Right = 217
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ubi"
            Begin Extent = 
               Top = 330
               Left = 667
               Bottom = 460
               Right = 846
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "dis"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 664
               Right = 217
            End
            DisplayFlags = 280
            TopColumn = 0
   ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwACTF_Rpt006';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'      End
         Begin Table = "emp"
            Begin Extent = 
               Top = 534
               Left = 255
               Bottom = 664
               Right = 430
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
      Begin ColumnWidths = 25
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwACTF_Rpt006';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwACTF_Rpt006';

