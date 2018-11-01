CREATE VIEW dbo.vwin_movi_inve
AS
SELECT        A.IdEmpresa, A.IdSucursal, A.IdBodega, A.IdMovi_inven_tipo, A.IdNumMovi, A.cm_tipo, A.cm_observacion, A.cm_fecha, A.IdCbteCble_Tipo, A.IdCbteCble, A.IdCtaCble, A.cm_anio, A.cm_mes, A.IdUsuario, A.Fecha_Transac, 
                         A.IdUsuarioUltModi, A.Fecha_UltMod, A.IdusuarioUltAnu, A.Fecha_UltAnu, A.nom_pc, A.ip, A.Estado, C.Su_Descripcion AS NomSucursal, D.bo_Descripcion AS NomBodega, B.Codigo AS CodTipoMovi, 
                         B.tm_descripcion AS NomTipoMovi, B.cm_descripcionCorta AS NemoTipoMovi, A.CodMoviInven, A.IdCentroCosto, CC.CodCentroCosto, CC.Centro_costo, A.IdProvedor, A.NumDocumentoRelacionado, A.NumFactura, 
                         A.IdEmpresa_x_Anu, A.IdSucursal_x_Anu, A.IdBodega_x_Anu, A.IdMovi_inven_tipo_x_Anu, A.IdNumMovi_x_Anu, A.MotivoAnulacion, A.IdMotivo_Inv
FROM            dbo.in_movi_inven_tipo AS B INNER JOIN
                         dbo.in_movi_inve AS A ON B.IdEmpresa = A.IdEmpresa AND B.IdMovi_inven_tipo = A.IdMovi_inven_tipo LEFT OUTER JOIN
                         dbo.ct_centro_costo AS CC ON A.IdEmpresa = CC.IdEmpresa AND A.IdCentroCosto = CC.IdCentroCosto INNER JOIN
                         dbo.tb_bodega AS D INNER JOIN
                         dbo.tb_sucursal AS C ON D.IdEmpresa = C.IdEmpresa AND D.IdSucursal = C.IdSucursal ON A.IdEmpresa = D.IdEmpresa AND A.IdBodega = D.IdBodega AND A.IdSucursal = D.IdSucursal
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[30] 4[3] 2[50] 3) )"
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
         Begin Table = "B"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 226
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "A"
            Begin Extent = 
               Top = 5
               Left = 311
               Bottom = 304
               Right = 488
            End
            DisplayFlags = 280
            TopColumn = 17
         End
         Begin Table = "CC"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 245
               Right = 226
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "D"
            Begin Extent = 
               Top = 35
               Left = 640
               Bottom = 154
               Right = 838
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "C"
            Begin Extent = 
               Top = 52
               Left = 905
               Bottom = 171
               Right = 1119
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
         Output', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_movi_inve';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' = 720
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_movi_inve';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_movi_inve';

