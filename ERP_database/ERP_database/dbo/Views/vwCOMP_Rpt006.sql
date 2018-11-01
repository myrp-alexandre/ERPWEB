

CREATE VIEW [dbo].[vwCOMP_Rpt006]
AS
SELECT        apro.IdEmpresa, suc.IdSucursal, apro.IdSolicitudCompra, apro.Secuencia_SC, apro.IdProducto_SC, suc.Su_Descripcion, apro.NomProducto_SC, solDet.do_Cantidad, apro.Cantidad_aprobada, 
                         apro.IdUsuarioAprueba, apro.FechaHoraAprobacion, apro.observacion, uniMed.IdUnidadMedida, uniMed.Descripcion, apro.do_precioCompra, apro.do_porc_des, apro.do_subtotal, apro.do_iva, apro.do_total, 
                         apro.do_ManejaIva, dbo.com_departamento.IdDepartamento, dbo.com_departamento.nom_departamento AS de_descripcion, dbo.cp_proveedor.IdProveedor, pe_nombreCompleto pr_nombre, 
                         apro.IdEstadoAprobacion, apro.IdEstadoPreAprobacion, estApro.descripcion AS DescrpcionEstadoAprobacion, estPreApro.descripcion AS DescrpcionEstadoPreAprobacion, dbo.ct_punto_cargo.IdPunto_cargo, 
                         dbo.ct_punto_cargo.codPunto_cargo, dbo.ct_punto_cargo.nom_punto_cargo, sol.IdSolicitante AS IdPersona, dbo.com_solicitante.nom_solicitante AS nomSolicitante
FROM            dbo.com_solicitud_compra_det_aprobacion AS apro INNER JOIN
                         dbo.tb_sucursal AS suc ON apro.IdEmpresa = suc.IdEmpresa AND apro.IdSucursal_SC = suc.IdSucursal INNER JOIN
                         dbo.tb_empresa ON apro.IdEmpresa = dbo.tb_empresa.IdEmpresa INNER JOIN
                         dbo.com_solicitud_compra_det AS solDet ON apro.IdEmpresa = solDet.IdEmpresa AND apro.IdSucursal_SC = solDet.IdSucursal AND apro.IdSolicitudCompra = solDet.IdSolicitudCompra AND 
                         apro.Secuencia_SC = solDet.Secuencia AND apro.IdProducto_SC = solDet.IdProducto INNER JOIN
                         dbo.com_solicitud_compra AS sol ON sol.IdEmpresa = solDet.IdEmpresa AND sol.IdSucursal = solDet.IdSucursal AND sol.IdSolicitudCompra = solDet.IdSolicitudCompra INNER JOIN
                         dbo.vwcom_EstadoAprobacion_sol_compra AS estApro ON estApro.Id = apro.IdEstadoAprobacion INNER JOIN
                         dbo.com_solicitante ON sol.IdEmpresa = dbo.com_solicitante.IdEmpresa AND sol.IdSolicitante = dbo.com_solicitante.IdSolicitante INNER JOIN
                         dbo.com_departamento ON sol.IdEmpresa = dbo.com_departamento.IdEmpresa AND sol.IdDepartamento = dbo.com_departamento.IdDepartamento LEFT OUTER JOIN
                         dbo.cp_proveedor ON apro.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND apro.IdProveedor_SC = dbo.cp_proveedor.IdProveedor LEFT OUTER JOIN
                         dbo.vwcom_EstadoAprobacion_sol_compra AS estPreApro ON estPreApro.Id = apro.IdEstadoPreAprobacion LEFT OUTER JOIN
                         dbo.ct_punto_cargo ON dbo.ct_punto_cargo.IdEmpresa = apro.IdEmpresa AND dbo.ct_punto_cargo.IdPunto_cargo = apro.IdPunto_cargo LEFT OUTER JOIN
                         dbo.in_UnidadMedida AS uniMed ON apro.IdUnidadMedida = uniMed.IdUnidadMedida inner join tb_persona as per on per.IdPersona = cp_proveedor.IdPersona
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[80] 4[13] 2[5] 3) )"
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
         Begin Table = "apro"
            Begin Extent = 
               Top = 11
               Left = 299
               Bottom = 134
               Right = 562
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_proveedor"
            Begin Extent = 
               Top = 0
               Left = 1049
               Bottom = 130
               Right = 1281
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "suc"
            Begin Extent = 
               Top = 272
               Left = 960
               Bottom = 402
               Right = 1190
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_empresa"
            Begin Extent = 
               Top = 441
               Left = 134
               Bottom = 571
               Right = 353
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "solDet"
            Begin Extent = 
               Top = 298
               Left = 0
               Bottom = 428
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sol"
            Begin Extent = 
               Top = 313
               Left = 320
               Bottom = 471
               Right = 529
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "estApro"
            Begin Extent = 
               Top = 809
               Left = 364
               Bottom = 939
               Right = 573
            End
            DisplayFlags = 280', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCOMP_Rpt006';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
            TopColumn = 0
         End
         Begin Table = "com_solicitante"
            Begin Extent = 
               Top = 924
               Left = 732
               Bottom = 1054
               Right = 941
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_departamento"
            Begin Extent = 
               Top = 313
               Left = 714
               Bottom = 516
               Right = 923
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "estPreApro"
            Begin Extent = 
               Top = 1096
               Left = 407
               Bottom = 1226
               Right = 616
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_punto_cargo"
            Begin Extent = 
               Top = 1136
               Left = 901
               Bottom = 1266
               Right = 1110
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "uniMed"
            Begin Extent = 
               Top = 1404
               Left = 748
               Bottom = 1534
               Right = 958
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
         Column = 2085
         Alias = 4365
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCOMP_Rpt006';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCOMP_Rpt006';

