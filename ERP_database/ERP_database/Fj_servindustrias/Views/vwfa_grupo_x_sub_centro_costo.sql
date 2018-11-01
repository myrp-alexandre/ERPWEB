CREATE VIEW Fj_servindustrias.vwfa_grupo_x_sub_centro_costo
AS
SELECT        Fj_servindustrias.fa_grupo_x_sub_centro_costo.IdEmpresa, Fj_servindustrias.fa_grupo_x_sub_centro_costo.IdGrupo, Fj_servindustrias.fa_grupo_x_sub_centro_costo.IdCentroCosto, 
                         Fj_servindustrias.fa_grupo_x_sub_centro_costo.nom_Grupo, Fj_servindustrias.fa_grupo_x_sub_centro_costo.Fecha, Fj_servindustrias.fa_grupo_x_sub_centro_costo.Estado, 
                         dbo.ct_centro_costo.Centro_costo AS nom_Centro_costo, dbo.tb_persona.pe_nombreCompleto AS nom_Cliente, Fj_servindustrias.fa_grupo_x_sub_centro_costo.IdUsuario, 
                         Fj_servindustrias.fa_grupo_x_sub_centro_costo.Fecha_Transaccion, Fj_servindustrias.fa_grupo_x_sub_centro_costo.IdUsuarioUltModi, Fj_servindustrias.fa_grupo_x_sub_centro_costo.Fecha_UltMod, 
                         Fj_servindustrias.fa_grupo_x_sub_centro_costo.IdUsuarioUltAnu, Fj_servindustrias.fa_grupo_x_sub_centro_costo.Fecha_UltAnu, Fj_servindustrias.fa_grupo_x_sub_centro_costo.MotivoAnulacion, 
                         Fj_servindustrias.fa_grupo_x_sub_centro_costo.nom_pc, Fj_servindustrias.fa_grupo_x_sub_centro_costo.ip, Fj_servindustrias.fa_grupo_x_sub_centro_costo.Observacion,Fj_servindustrias.fa_grupo_x_sub_centro_costo.IdProducto
FROM            Fj_servindustrias.fa_grupo_x_sub_centro_costo INNER JOIN
                         Fj_servindustrias.fa_cliente_x_ct_centro_costo INNER JOIN
                         dbo.fa_cliente ON Fj_servindustrias.fa_cliente_x_ct_centro_costo.IdEmpresa_cli = dbo.fa_cliente.IdEmpresa AND Fj_servindustrias.fa_cliente_x_ct_centro_costo.IdCliente_cli = dbo.fa_cliente.IdCliente INNER JOIN
                         dbo.ct_centro_costo ON Fj_servindustrias.fa_cliente_x_ct_centro_costo.IdEmpresa_cc = dbo.ct_centro_costo.IdEmpresa AND 
                         Fj_servindustrias.fa_cliente_x_ct_centro_costo.IdCentroCosto_cc = dbo.ct_centro_costo.IdCentroCosto ON Fj_servindustrias.fa_grupo_x_sub_centro_costo.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND 
                         Fj_servindustrias.fa_grupo_x_sub_centro_costo.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto INNER JOIN
                         dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona LEFT OUTER JOIN
                         dbo.in_Producto ON Fj_servindustrias.fa_grupo_x_sub_centro_costo.IdEmpresa = dbo.in_Producto.IdEmpresa AND Fj_servindustrias.fa_grupo_x_sub_centro_costo.IdProducto = dbo.in_Producto.IdProducto
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[75] 4[20] 2[5] 3) )"
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
         Begin Table = "fa_grupo_x_sub_centro_costo (Fj_servindustrias)"
            Begin Extent = 
               Top = 18
               Left = 491
               Bottom = 316
               Right = 700
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_cliente_x_ct_centro_costo (Fj_servindustrias)"
            Begin Extent = 
               Top = 206
               Left = 38
               Bottom = 267
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_cliente"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 399
               Right = 276
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 531
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 663
               Right = 270
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 272
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
   End', @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwfa_grupo_x_sub_centro_costo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3330
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
', @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwfa_grupo_x_sub_centro_costo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwfa_grupo_x_sub_centro_costo';

