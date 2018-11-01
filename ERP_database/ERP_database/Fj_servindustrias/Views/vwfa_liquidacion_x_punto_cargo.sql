CREATE VIEW [Fj_servindustrias].[vwfa_liquidacion_x_punto_cargo]
AS
SELECT isnull(ROW_NUMBER() OVER (ORDER BY Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdEmpresa), 0) AS IdRow, Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdEmpresa, Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdSucursal, 
Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdCentroCosto, Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdLiquidacion, dbo.tb_sucursal.Su_Descripcion, dbo.ct_centro_costo.Centro_costo AS nom_Centro_costo, 
Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdPunto_cargo, dbo.ct_punto_cargo.nom_punto_cargo, Fj_servindustrias.fa_liquidacion_x_punto_cargo.li_fecha, Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdTerminoPago, 
Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdCentroCosto_sub_centro_costo, dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS nom_Centro_costo_sub_centro_costo, Fj_servindustrias.fa_liquidacion_x_punto_cargo.li_num_orden, 
Fj_servindustrias.fa_liquidacion_x_punto_cargo.li_num_horas, Fj_servindustrias.fa_liquidacion_x_punto_cargo.li_atencion_a, Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdBodega, 
Fj_servindustrias.fa_liquidacion_x_punto_cargo.li_tipo_pedido, Fj_servindustrias.fa_liquidacion_x_punto_cargo.estado, Fj_servindustrias.fa_liquidacion_x_punto_cargo.lo_IdProducto, 
Fj_servindustrias.fa_liquidacion_x_punto_cargo.li_reporte_mantenimiento, Fj_servindustrias.fa_liquidacion_x_punto_cargo.in_IdProducto, Fj_servindustrias.fa_liquidacion_x_punto_cargo.eg_IdProducto, 
Fj_servindustrias.fa_liquidacion_x_punto_cargo.li_por_iva, Fj_servindustrias.fa_liquidacion_x_punto_cargo.li_subtotal, Fj_servindustrias.fa_liquidacion_x_punto_cargo.li_valor_iva, Fj_servindustrias.fa_liquidacion_x_punto_cargo.li_total, 
Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdCod_Impuesto, Fj_servindustrias.fa_liquidacion_x_punto_cargo.li_observacion, ISNULL(ISNULL(egresos.numero_lineas, 0) + ISNULL(ingresos.numero_lineas, 0) + ISNULL(logistica.numero_lineas, 
0) + ISNULL(mano_obra.numero_lineas, 0), 0) AS numero_lineas, Fj_servindustrias.fa_cliente_x_ct_centro_costo.IdCliente_cli, dbo.tb_sucursal.codigo + ' ' + CAST(Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdLiquidacion AS varchar(20)) 
AS cod_liquidacion, Fj_servindustrias.fa_liquidacion_x_punto_cargo.li_fecha_orden_mantenimiento, Fj_servindustrias.fa_liquidacion_x_punto_cargo.li_fecha_reporte_mantenimiento, Fj_servindustrias.fa_liquidacion_x_punto_cargo.li_referencia_facturas
FROM     Fj_servindustrias.fa_liquidacion_x_punto_cargo INNER JOIN
                  dbo.ct_centro_costo ON Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto INNER JOIN
                  dbo.tb_sucursal ON Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                  dbo.ct_punto_cargo ON Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo AND 
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo INNER JOIN
                  Fj_servindustrias.fa_cliente_x_ct_centro_costo ON Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdEmpresa = Fj_servindustrias.fa_cliente_x_ct_centro_costo.IdEmpresa_cc AND 
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdCentroCosto = Fj_servindustrias.fa_cliente_x_ct_centro_costo.IdCentroCosto_cc LEFT OUTER JOIN
                  dbo.ct_centro_costo_sub_centro_costo ON Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo AND 
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo LEFT OUTER JOIN
                      (SELECT IdEmpresa, IdSucursal, IdCentroCosto, IdLiquidacion, 1 AS numero_lineas
                       FROM      Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_egresos_inventario
                       GROUP BY IdEmpresa, IdSucursal, IdCentroCosto, IdLiquidacion) AS egresos ON Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdEmpresa = egresos.IdEmpresa AND 
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdSucursal = egresos.IdSucursal AND Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdCentroCosto = egresos.IdCentroCosto AND 
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdLiquidacion = egresos.IdLiquidacion LEFT OUTER JOIN
                      (SELECT IdEmpresa, IdSucursal, IdCentroCosto, IdLiquidacion, 1 AS numero_lineas
                       FROM      Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_ingresos_consumo_directo
                       GROUP BY IdEmpresa, IdSucursal, IdCentroCosto, IdLiquidacion) AS ingresos ON Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdEmpresa = ingresos.IdEmpresa AND 
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdSucursal = ingresos.IdSucursal AND Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdCentroCosto = ingresos.IdCentroCosto AND 
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdLiquidacion = ingresos.IdLiquidacion LEFT OUTER JOIN
                      (SELECT IdEmpresa, IdSucursal, IdCentroCosto, IdLiquidacion, 1 AS numero_lineas
                       FROM      Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_logistica
                       GROUP BY IdEmpresa, IdSucursal, IdCentroCosto, IdLiquidacion) AS logistica ON Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdEmpresa = logistica.IdEmpresa AND 
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdSucursal = logistica.IdSucursal AND Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdCentroCosto = logistica.IdCentroCosto AND 
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdLiquidacion = logistica.IdLiquidacion LEFT OUTER JOIN
                      (SELECT IdEmpresa, IdSucursal, IdCentroCosto, IdLiquidacion, COUNT(IdLiquidacion) AS numero_lineas
                       FROM      (SELECT IdEmpresa, IdSucursal, IdCentroCosto, IdLiquidacion, IdProducto
                                          FROM      Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra
                                          GROUP BY IdEmpresa, IdSucursal, IdCentroCosto, IdLiquidacion, IdProducto) AS a
                       GROUP BY IdEmpresa, IdSucursal, IdCentroCosto, IdLiquidacion) AS mano_obra ON Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdEmpresa = mano_obra.IdEmpresa AND 
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdSucursal = mano_obra.IdSucursal AND Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdCentroCosto = mano_obra.IdCentroCosto AND 
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdLiquidacion = mano_obra.IdLiquidacion
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[70] 4[3] 2[8] 3) )"
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
         Begin Table = "fa_liquidacion_x_punto_cargo (Fj_servindustrias)"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 357
            End
            DisplayFlags = 280
            TopColumn = 24
         End
         Begin Table = "ct_centro_costo"
            Begin Extent = 
               Top = 7
               Left = 405
               Bottom = 170
               Right = 633
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 7
               Left = 681
               Bottom = 170
               Right = 953
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_punto_cargo"
            Begin Extent = 
               Top = 7
               Left = 1001
               Bottom = 170
               Right = 1237
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo_sub_centro_costo"
            Begin Extent = 
               Top = 7
               Left = 1285
               Bottom = 170
               Right = 1594
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_factura"
            Begin Extent = 
               Top = 182
               Left = 1088
               Bottom = 345
               Right = 1311
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
   Begi', @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwfa_liquidacion_x_punto_cargo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'n CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwfa_liquidacion_x_punto_cargo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwfa_liquidacion_x_punto_cargo';

