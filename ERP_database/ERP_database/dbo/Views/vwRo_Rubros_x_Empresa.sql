﻿CREATE VIEW [dbo].[vwRo_Rubros_x_Empresa]
AS
SELECT        dbo.ro_rubro_tipo.IdRubro, dbo.ro_rubro_tipo.rub_codigo, dbo.ro_rubro_tipo.ru_codRolGen, dbo.ro_rubro_tipo.ru_descripcion, dbo.ro_rubro_tipo.NombreCorto, 
                         dbo.ro_rubro_tipo.ru_tipo, dbo.ro_rubro_tipo.ru_estado, dbo.ro_rubro_tipo.ru_orden,  dbo.ro_rubro_tipo.IdUsuario, 
                         dbo.ro_rubro_tipo.Fecha_Transac, dbo.ro_rubro_tipo.IdUsuarioUltMod, dbo.ro_rubro_tipo.Fecha_UltMod, dbo.ro_rubro_tipo.IdUsuarioUltAnu, 
                         dbo.ro_rubro_tipo.Fecha_UltAnu,  dbo.ro_rubro_tipo.rub_concep,
                         
                         dbo.ro_rubro_tipo.rub_ctacon, dbo.ro_rubro_tipo.rub_grupo, 
                         dbo.ro_rubro_tipo.rub_provision,  dbo.ro_rubro_tipo.rub_nocontab, 
                           dbo.ro_rubro_tipo.rub_aplica_IESS
FROM            dbo.ro_rubro_tipo

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
         Begin Table = "ro_rubro_tipo"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 211
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 29
         End
         Begin Table = "ro_Config_Rubros_x_empresa"
            Begin Extent = 
               Top = 21
               Left = 449
               Bottom = 211
               Right = 658
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwRo_Rubros_x_Empresa';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwRo_Rubros_x_Empresa';

