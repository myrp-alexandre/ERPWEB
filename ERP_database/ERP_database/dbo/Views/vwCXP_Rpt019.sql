CREATE VIEW [dbo].[vwCXP_Rpt019]
AS
SELECT        dbo.cp_conciliacion_Caja.IdEmpresa, dbo.cp_conciliacion_Caja.IdConciliacion_Caja, dbo.cp_conciliacion_Caja.Fecha, dbo.cp_conciliacion_Caja.IdCaja, 
                         dbo.cp_conciliacion_Caja.IdEstadoCierre, dbo.cp_conciliacion_Caja.Observacion, dbo.cp_conciliacion_Caja.IdEmpresa_op, 
                         dbo.cp_conciliacion_Caja.IdOrdenPago_op, dbo.caj_Caja.ca_Descripcion, dbo.cp_conciliacion_Caja_det.IdEmpresa_OGiro, 
                         dbo.cp_conciliacion_Caja_det.IdCbteCble_Ogiro, dbo.cp_conciliacion_Caja_det.IdTipoCbte_Ogiro, dbo.cp_orden_giro.co_serie, dbo.cp_orden_giro.co_factura, 
                         dbo.cp_orden_giro.co_valorpagar, dbo.cp_orden_giro.co_observacion, dbo.cp_catalogo.Nombre, dbo.cp_orden_giro.co_FechaFactura, 
                         dbo.cp_orden_giro.co_fechaOg, pe_nombreCompleto pr_nombre
FROM            dbo.caj_Caja RIGHT OUTER JOIN
                         dbo.cp_conciliacion_Caja INNER JOIN
                         dbo.cp_conciliacion_Caja_det ON dbo.cp_conciliacion_Caja.IdEmpresa = dbo.cp_conciliacion_Caja_det.IdEmpresa AND 
                         dbo.cp_conciliacion_Caja.IdConciliacion_Caja = dbo.cp_conciliacion_Caja_det.IdConciliacion_Caja INNER JOIN
                         dbo.cp_catalogo_tipo INNER JOIN
                         dbo.cp_catalogo ON dbo.cp_catalogo_tipo.IdCatalogo_tipo = dbo.cp_catalogo.IdCatalogo_tipo ON 
                         dbo.cp_conciliacion_Caja.IdEstadoCierre = dbo.cp_catalogo.IdCatalogo LEFT OUTER JOIN
                         dbo.cp_orden_pago ON dbo.cp_conciliacion_Caja.IdEmpresa_op = dbo.cp_orden_pago.IdEmpresa AND 
                         dbo.cp_conciliacion_Caja.IdOrdenPago_op = dbo.cp_orden_pago.IdOrdenPago LEFT OUTER JOIN
                         dbo.cp_orden_giro ON dbo.cp_conciliacion_Caja_det.IdEmpresa_OGiro = dbo.cp_orden_giro.IdEmpresa AND 
                         dbo.cp_conciliacion_Caja_det.IdCbteCble_Ogiro = dbo.cp_orden_giro.IdCbteCble_Ogiro AND 
                         dbo.cp_conciliacion_Caja_det.IdTipoCbte_Ogiro = dbo.cp_orden_giro.IdTipoCbte_Ogiro ON dbo.caj_Caja.IdEmpresa = dbo.cp_conciliacion_Caja.IdEmpresa AND 
                         dbo.caj_Caja.IdCaja = dbo.cp_conciliacion_Caja.IdCaja LEFT OUTER JOIN
						 dbo.cp_proveedor ON dbo.cp_orden_giro.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND dbo.cp_orden_giro.IdProveedor = dbo.cp_proveedor.IdProveedor
						 inner join tb_persona as per on cp_proveedor.IdPersona = per.IdPersona
UNION ALL
SELECT        dbo.cp_conciliacion_Caja.IdEmpresa, dbo.cp_conciliacion_Caja.IdConciliacion_Caja, dbo.cp_conciliacion_Caja.Fecha, dbo.cp_conciliacion_Caja.IdCaja, 
                         dbo.cp_conciliacion_Caja.IdEstadoCierre, dbo.cp_conciliacion_Caja.Observacion, dbo.cp_conciliacion_Caja.IdEmpresa_op, 
                         dbo.cp_conciliacion_Caja.IdOrdenPago_op, dbo.caj_Caja.ca_Descripcion, dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa_movcaja, 
                         dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdCbteCble_movcaja, dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdTipocbte_movcaja, null as co_serie, null as co_factura, 
                         dbo.caj_Caja_Movimiento.cm_valor, dbo.caj_Caja_Movimiento.cm_observacion, dbo.cp_catalogo.Nombre, null AS co_FechaFactura, 
                         dbo.caj_Caja_Movimiento.cm_fecha, per.pe_nombreCompleto cm_beneficiario
FROM            dbo.caj_Caja RIGHT OUTER JOIN
                         dbo.cp_conciliacion_Caja INNER JOIN
                         dbo.cp_conciliacion_Caja_det_x_ValeCaja ON dbo.cp_conciliacion_Caja.IdEmpresa = dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa AND 
                         dbo.cp_conciliacion_Caja.IdConciliacion_Caja = dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdConciliacion_Caja INNER JOIN
                         dbo.cp_catalogo_tipo INNER JOIN
                         dbo.cp_catalogo ON dbo.cp_catalogo_tipo.IdCatalogo_tipo = dbo.cp_catalogo.IdCatalogo_tipo ON 
                         dbo.cp_conciliacion_Caja.IdEstadoCierre = dbo.cp_catalogo.IdCatalogo LEFT OUTER JOIN
                         dbo.cp_orden_pago ON dbo.cp_conciliacion_Caja.IdEmpresa_op = dbo.cp_orden_pago.IdEmpresa AND 
                         dbo.cp_conciliacion_Caja.IdOrdenPago_op = dbo.cp_orden_pago.IdOrdenPago LEFT OUTER JOIN
                         dbo.caj_Caja_Movimiento ON dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa_movcaja = dbo.caj_Caja_Movimiento.IdEmpresa AND 
                         dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdCbteCble_movcaja= dbo.caj_Caja_Movimiento.IdCbteCble AND 
                         dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdTipocbte_movcaja = dbo.caj_Caja_Movimiento.IdTipoCbte ON dbo.caj_Caja.IdEmpresa = dbo.cp_conciliacion_Caja.IdEmpresa AND 
                         dbo.caj_Caja.IdCaja = dbo.cp_conciliacion_Caja.IdCaja inner join tb_persona as per on per.IdPersona = caj_Caja_Movimiento.IdPersona
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
         Begin Table = "caj_Caja"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_conciliacion_Caja"
            Begin Extent = 
               Top = 6
               Left = 286
               Bottom = 135
               Right = 495
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_conciliacion_Caja_det"
            Begin Extent = 
               Top = 6
               Left = 533
               Bottom = 135
               Right = 742
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_catalogo_tipo"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 250
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_catalogo"
            Begin Extent = 
               Top = 138
               Left = 285
               Bottom = 267
               Right = 494
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_orden_pago"
            Begin Extent = 
               Top = 138
               Left = 532
               Bottom = 267
               Right = 741
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_orden_giro"
            Begin Extent = 
               Top = 252
               Left = 38
               Bottom = 381
               Right =', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt019';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' 279
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt019';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt019';

