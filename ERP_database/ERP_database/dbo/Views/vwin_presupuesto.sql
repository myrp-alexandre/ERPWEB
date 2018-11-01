CREATE VIEW [dbo].[vwin_presupuesto]
AS
SELECT     A.IdEmpresa, A.IdSucursal, A.IdPresupuesto, A.Tipo, A.IdProveedor, A.pr_plazo, A.pr_fecha, A.pr_subtotal, A.pr_iva, A.pr_descuento, A.pr_pordesc, A.pr_flete, 
                      A.pr_total, A.pr_Base_conIva, A.pr_Base_sinIva, A.pr_observacion, A.Fechreg, A.Estado, A.pr_NumDocumento, A.IdEstadoAprobacion, A.co_fecha_aprobacion, 
                      A.IdTerminoPago, A.co_FechaFactProv, A.co_DiasFecFacProv, A.co_fecha_salida, A.co_fecha_llegada, A.IdUsuario_Aprueba, A.IdUsuario_Reprue, A.co_fechaReproba, 
                      A.Fecha_Transac, A.Fecha_UltMod, A.IdUsuarioUltMod, A.FechaHoraAnul, A.IdUsuarioUltAnu, S.Su_Descripcion AS NomSucursal, pe_nombreCompleto AS NomProveedor, 
                      A.pr_PesoTotal, null AS TerPagoDescripcion, A.IdCentroCosto, CC.CodCentroCosto, CC.Centro_costo AS NomCentroCosto, A.pr_fecha_emision, 
                      A.IdUsuario_Solicitante, A.IdUsuario_Emicion
FROM         dbo.in_presupuesto AS A INNER JOIN
                      dbo.tb_sucursal AS S ON S.IdSucursal = A.IdSucursal AND A.IdEmpresa = S.IdEmpresa INNER JOIN
                      dbo.cp_proveedor AS P ON P.IdProveedor = A.IdProveedor AND P.IdEmpresa = A.IdEmpresa 
                      LEFT OUTER JOIN
                      dbo.ct_centro_costo AS CC ON CC.IdCentroCosto = A.IdCentroCosto AND CC.IdEmpresa = A.IdEmpresa
					  inner join tb_persona as per on per.IdPersona = p.IdPersona
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
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 230
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "S"
            Begin Extent = 
               Top = 6
               Left = 268
               Bottom = 125
               Right = 482
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "P"
            Begin Extent = 
               Top = 6
               Left = 520
               Bottom = 125
               Right = 730
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TER"
            Begin Extent = 
               Top = 6
               Left = 768
               Bottom = 125
               Right = 929
            End
            DisplayFlags = 280
            TopColumn = 0
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
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
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
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_presupuesto';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'= 1170
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_presupuesto';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_presupuesto';

