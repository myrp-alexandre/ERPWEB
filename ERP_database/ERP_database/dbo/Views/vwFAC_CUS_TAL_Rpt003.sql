CREATE VIEW [dbo].[vwFAC_CUS_TAL_Rpt003]
AS
SELECT        guia.IdEmpresa, guia.IdSucursal, guia.IdBodega, guia.IdGuiaRemision, guia.CodGuiaRemision, guia.Serie1, guia.Serie2, guia.NumGuia_Preimpresa, guia.IdCliente, 
                          guia.IdTransportista, guia.gi_fecha, guia.gi_plazo, guia.gi_fech_venc, guia.gi_Observacion,
                         guia.IdUsuario,   gui_det.Secuencia, gui_det.IdProducto, gui_det.gi_cantidad, 
                       
                         gui_det.gi_detallexItems,  emp.em_nombre AS nom_empresa, emp.em_ruc AS ruc_empresa, emp.em_logo AS logo_empresa, 
                         sucu.Su_Descripcion AS nom_sucursal, bod.bo_Descripcion AS nom_bodega, perso.pe_nombreCompleto AS nom_cliente, prod.pr_codigo AS cod_producto, 
                         prod.pr_descripcion AS nom_producto, perso.pe_cedulaRuc AS cedula_ruc_cliente, perso.pe_direccion AS direccion_cliente, 
                         emp.em_direccion AS direccion_empresa, tb_transportista.Nombre AS nom_transportista
FROM            tb_bodega AS bod INNER JOIN
                         fa_guia_remision AS guia INNER JOIN
                         fa_guia_remision_det AS gui_det ON guia.IdEmpresa = gui_det.IdEmpresa AND guia.IdSucursal = gui_det.IdSucursal AND guia.IdBodega = gui_det.IdBodega AND 
                         guia.IdGuiaRemision = gui_det.IdGuiaRemision ON bod.IdEmpresa = guia.IdEmpresa AND bod.IdSucursal = guia.IdSucursal AND 
                         bod.IdBodega = guia.IdBodega INNER JOIN
                         tb_sucursal AS sucu INNER JOIN
                         tb_empresa AS emp ON sucu.IdEmpresa = emp.IdEmpresa ON bod.IdEmpresa = sucu.IdEmpresa AND bod.IdSucursal = sucu.IdSucursal INNER JOIN
                         fa_cliente AS clien ON guia.IdEmpresa = clien.IdEmpresa AND guia.IdCliente = clien.IdCliente INNER JOIN
                         tb_persona AS perso ON clien.IdPersona = perso.IdPersona INNER JOIN
                         in_Producto AS prod ON gui_det.IdEmpresa = prod.IdEmpresa AND gui_det.IdProducto = prod.IdProducto INNER JOIN
                         tb_transportista ON guia.IdEmpresa = tb_transportista.IdEmpresa AND guia.IdTransportista = tb_transportista.IdTransportista

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[72] 4[20] 2[4] 3) )"
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
         Top = -166
         Left = 0
      End
      Begin Tables = 
         Begin Table = "bod"
            Begin Extent = 
               Top = 0
               Left = 910
               Bottom = 119
               Right = 1108
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "guia"
            Begin Extent = 
               Top = 0
               Left = 417
               Bottom = 216
               Right = 607
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "gui_det"
            Begin Extent = 
               Top = 0
               Left = 8
               Bottom = 119
               Right = 187
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sucu"
            Begin Extent = 
               Top = 211
               Left = 1076
               Bottom = 330
               Right = 1290
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "emp"
            Begin Extent = 
               Top = 125
               Left = 848
               Bottom = 244
               Right = 1052
            End
            DisplayFlags = 280
            TopColumn = 8
         End
         Begin Table = "clien"
            Begin Extent = 
               Top = 119
               Left = 165
               Bottom = 453
               Right = 375
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "perso"
            Begin Extent = 
               Top = 222
               Left = 439
               Bottom = 347
               Right = 631
            End
            DisplayFlags = 280
            ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_CUS_TAL_Rpt003';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'TopColumn = 4
         End
         Begin Table = "prod"
            Begin Extent = 
               Top = 373
               Left = 445
               Bottom = 492
               Right = 667
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_transportista"
            Begin Extent = 
               Top = 139
               Left = 637
               Bottom = 342
               Right = 800
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 249
               Left = 823
               Bottom = 511
               Right = 1015
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
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1710
         Alias = 2400
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_CUS_TAL_Rpt003';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_CUS_TAL_Rpt003';

