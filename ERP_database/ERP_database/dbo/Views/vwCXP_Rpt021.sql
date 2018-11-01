CREATE view  vwCXP_Rpt021
as
SELECT        dbo.cp_TipoDocumento.Codigo, dbo.cp_TipoDocumento.Descripcion, dbo.cp_orden_giro.IdEmpresa, dbo.cp_orden_giro.IdCbteCble_Ogiro, 
                         dbo.cp_orden_giro.IdTipoCbte_Ogiro, dbo.cp_codigo_SRI.codigoSRI, dbo.cp_codigo_SRI.co_descripcion, dbo.tb_empresa.em_nombre, 
                         dbo.tb_sucursal.Su_Descripcion, pe_nombreCompleto pr_nombre, dbo.ct_centro_costo.Centro_costo AS nom_CentroCosto, dbo.cp_orden_giro.IdIden_credito, 
                         dbo.cp_orden_giro.IdOrden_giro_Tipo, dbo.cp_orden_giro.IdProveedor, dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS nom_CentroCosto_sub_centro_costo,
                          dbo.cp_orden_giro.co_fechaOg, dbo.cp_orden_giro.co_serie, dbo.cp_orden_giro.co_factura, dbo.cp_orden_giro.co_FechaFactura, 
                         dbo.cp_orden_giro.co_FechaFactura_vct, dbo.cp_orden_giro.co_observacion, dbo.cp_orden_giro.co_subtotal_iva, dbo.cp_orden_giro.co_subtotal_siniva, 
                         dbo.cp_orden_giro.co_baseImponible, dbo.cp_orden_giro.co_total, dbo.cp_orden_giro.co_valorpagar, dbo.ct_cbtecble_det.secuencia, dbo.ct_cbtecble_det.IdCtaCble, 
                         dbo.ct_plancta.pc_Cuenta, ISNULL(dbo.ct_cbtecble_det.IdCentroCosto, '') AS idCentroCosto, ISNULL(dbo.ct_cbtecble_det.IdCentroCosto_sub_centro_costo, '') 
                         AS idCentroCosto_sub_centro_costo, dbo.ct_cbtecble_det.dc_Valor, dbo.ct_cbtecble_det.dc_Observacion, dbo.ct_punto_cargo.IdPunto_cargo, 
                         dbo.ct_punto_cargo.nom_punto_cargo, dbo.ct_punto_cargo_grupo.IdPunto_cargo_grupo, dbo.ct_punto_cargo_grupo.nom_punto_cargo_grupo
FROM            dbo.cp_orden_giro INNER JOIN
                         dbo.tb_sucursal ON dbo.cp_orden_giro.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.cp_orden_giro.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.tb_empresa ON dbo.tb_sucursal.IdEmpresa = dbo.tb_empresa.IdEmpresa INNER JOIN
                         dbo.cp_proveedor ON dbo.cp_orden_giro.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND 
                         dbo.cp_orden_giro.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
                         dbo.cp_TipoDocumento ON dbo.cp_orden_giro.IdOrden_giro_Tipo = dbo.cp_TipoDocumento.CodTipoDocumento INNER JOIN
                         dbo.ct_cbtecble_det ON dbo.cp_orden_giro.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND 
                         dbo.cp_orden_giro.IdTipoCbte_Ogiro = dbo.ct_cbtecble_det.IdTipoCbte AND dbo.cp_orden_giro.IdCbteCble_Ogiro = dbo.ct_cbtecble_det.IdCbteCble INNER JOIN
                         dbo.cp_codigo_SRI ON dbo.cp_orden_giro.IdIden_credito = dbo.cp_codigo_SRI.IdCodigo_SRI INNER JOIN
                         dbo.ct_plancta ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_plancta.IdEmpresa AND dbo.ct_cbtecble_det.IdCtaCble = dbo.ct_plancta.IdCtaCble LEFT OUTER JOIN
                         dbo.ct_punto_cargo_grupo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_punto_cargo_grupo.IdEmpresa AND 
                         dbo.ct_cbtecble_det.IdPunto_cargo_grupo = dbo.ct_punto_cargo_grupo.IdPunto_cargo_grupo LEFT OUTER JOIN
                         dbo.ct_punto_cargo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND 
                         dbo.ct_cbtecble_det.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo LEFT OUTER JOIN
                         dbo.ct_centro_costo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND 
                         dbo.ct_cbtecble_det.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto LEFT OUTER JOIN
                         dbo.ct_centro_costo_sub_centro_costo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                         dbo.ct_cbtecble_det.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                         dbo.ct_cbtecble_det.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo
						 inner join tb_persona as per on cp_proveedor.IdPersona = per.IdPersona
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[62] 4[26] 2[5] 3) )"
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
         Left = -4
      End
      Begin Tables = 
         Begin Table = "cp_orden_giro"
            Begin Extent = 
               Top = 0
               Left = 39
               Bottom = 456
               Right = 280
            End
            DisplayFlags = 280
            TopColumn = 12
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 2
               Left = 592
               Bottom = 63
               Right = 822
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_empresa"
            Begin Extent = 
               Top = 0
               Left = 908
               Bottom = 61
               Right = 1127
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_proveedor"
            Begin Extent = 
               Top = 0
               Left = 767
               Bottom = 129
               Right = 988
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_TipoDocumento"
            Begin Extent = 
               Top = 0
               Left = 1070
               Bottom = 129
               Right = 1339
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_codigo_SRI"
            Begin Extent = 
               Top = 86
               Left = 1145
               Bottom = 298
               Right = 1354
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_cbtecble_det"
            Begin Extent = 
               Top = 151
               Left = 402
               Bottom = 418
               Right = 665
        ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt021';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'    End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo"
            Begin Extent = 
               Top = 34
               Left = 853
               Bottom = 140
               Right = 1062
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "ct_centro_costo_sub_centro_costo"
            Begin Extent = 
               Top = 117
               Left = 1007
               Bottom = 246
               Right = 1270
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_plancta"
            Begin Extent = 
               Top = 216
               Left = 843
               Bottom = 414
               Right = 1052
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
      Begin ColumnWidths = 62
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2910
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
         Column = 5445
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt021';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt021';

