/* select * from vwin_movi_inve_x_Ing_Ordencompra_local                      */
CREATE VIEW [dbo].[vwin_movi_inve_x_Ing_Ordencompra_local]
AS
SELECT DISTINCT 
                         mov_inv.IdEmpresa, mov_inv.IdSucursal, mov_inv.IdBodega, mov_inv.IdMovi_inven_tipo AS IdTipoMoviInven, mov_inv.IdNumMovi, 
                         sucu.Su_Descripcion AS nom_sucursal, bod.bo_Descripcion AS nom_bodega, Tip_Mov_inv.tm_descripcion AS tipo_movi_inven, OC.IdProveedor, 
                         pe_nombreCompleto AS nom_proveedor, mov_inv.Estado, mov_inv.cm_fecha, mov_inv.cm_observacion
FROM            dbo.cp_proveedor AS PROV INNER JOIN
                         dbo.com_ordencompra_local AS OC INNER JOIN
                         dbo.vwin_movi_inve_x_com_ordencompra_local AS moviInven_x_OC ON OC.IdEmpresa = moviInven_x_OC.ocd_IdEmpresa AND 
                         OC.IdSucursal = moviInven_x_OC.ocd_IdSucursal AND OC.IdOrdenCompra = moviInven_x_OC.ocd_IdOrdenCompra INNER JOIN
                         dbo.tb_sucursal AS sucu INNER JOIN
                         dbo.tb_bodega AS bod ON sucu.IdEmpresa = bod.IdEmpresa AND sucu.IdSucursal = bod.IdSucursal INNER JOIN
                         dbo.in_movi_inve AS mov_inv ON bod.IdEmpresa = mov_inv.IdEmpresa AND bod.IdSucursal = mov_inv.IdSucursal AND 
                         bod.IdBodega = mov_inv.IdBodega INNER JOIN
                         dbo.in_movi_inven_tipo AS Tip_Mov_inv ON mov_inv.IdEmpresa = Tip_Mov_inv.IdEmpresa AND mov_inv.IdMovi_inven_tipo = Tip_Mov_inv.IdMovi_inven_tipo ON 
                         moviInven_x_OC.mi_IdEmpresa = mov_inv.IdEmpresa AND moviInven_x_OC.mi_IdSucursal = mov_inv.IdSucursal AND 
                         moviInven_x_OC.mi_IdBodega = mov_inv.IdBodega AND moviInven_x_OC.mi_IdMovi_inven_tipo = mov_inv.IdMovi_inven_tipo AND 
                         moviInven_x_OC.mi_IdNumMovi = mov_inv.IdNumMovi ON PROV.IdEmpresa = OC.IdEmpresa AND PROV.IdProveedor = OC.IdProveedor
						 inner join tb_persona as per on per.IdPersona = prov.IdPersona
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[64] 4[21] 2[4] 3) )"
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
         Begin Table = "PROV"
            Begin Extent = 
               Top = 133
               Left = 1311
               Bottom = 458
               Right = 1512
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OC"
            Begin Extent = 
               Top = 40
               Left = 1033
               Bottom = 263
               Right = 1219
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "moviInven_x_OC"
            Begin Extent = 
               Top = 141
               Left = 669
               Bottom = 414
               Right = 853
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sucu"
            Begin Extent = 
               Top = 0
               Left = 23
               Bottom = 108
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bod"
            Begin Extent = 
               Top = 210
               Left = 3
               Bottom = 318
               Right = 192
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "mov_inv"
            Begin Extent = 
               Top = 71
               Left = 310
               Bottom = 513
               Right = 553
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tip_Mov_inv"
            Begin Extent = 
               Top = 0
               Left = 707
               Bottom = 108
               Right = 886
            End
            DisplayFlags = 280
  ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_movi_inve_x_Ing_Ordencompra_local';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'          TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 14
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_movi_inve_x_Ing_Ordencompra_local';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_movi_inve_x_Ing_Ordencompra_local';

