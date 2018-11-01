CREATE VIEW [dbo].[vwFAC_CUS_TAL_Rpt004]
AS
SELECT     fa.IdEmpresa, fa.IdSucursal, fa.IdBodega, fa.IdCbteVta, fa.CodCbteVta, fa.vt_tipoDoc, fa.vt_autorizacion, fa.vt_serie1, fa.vt_serie2, fa.vt_NumFactura, fa.IdCliente, 
                      fa.IdVendedor, fa.vt_fecha, fa.vt_plazo, fa.vt_fech_venc, fa.vt_tipo_venta, fa.vt_Observacion, 
                      fa.IdCaja, fa_det.Secuencia, fa_det.IdProducto, fa_det.vt_cantidad, fa_det.vt_Precio, fa_det.vt_PorDescUnitario, fa_det.vt_DescUnitario, fa_det.vt_PrecioFinal, 
                      fa_det.vt_Subtotal, fa_det.vt_iva, fa_det.vt_total,0 vt_costo,  fa_det.vt_detallexItems, caj.ca_Descripcion AS nom_caja, 
                      vend.Ve_Vendedor AS nom_vendedor, prod.pr_codigo AS cod_producto, prod.pr_descripcion AS nom_producto, perso.pe_nombreCompleto AS nom_cliente, 
                      perso.pe_razonSocial AS razon_social_cliente, perso.pe_cedulaRuc AS cedu_ruc_cliente, perso.pe_direccion AS direccion_cliente, 
                      null AS telef_cliente, perso.pe_correo AS correo_cliente
FROM         dbo.fa_factura AS fa INNER JOIN
                      dbo.fa_factura_det AS fa_det ON fa.IdEmpresa = fa_det.IdEmpresa AND fa.IdSucursal = fa_det.IdSucursal AND fa.IdBodega = fa_det.IdBodega AND 
                      fa.IdCbteVta = fa_det.IdCbteVta INNER JOIN
                      dbo.in_Producto AS prod ON fa_det.IdEmpresa = prod.IdEmpresa AND fa_det.IdProducto = prod.IdProducto INNER JOIN
                      dbo.fa_cliente AS clie ON fa.IdEmpresa = clie.IdEmpresa AND fa.IdCliente = clie.IdCliente INNER JOIN
                      dbo.tb_persona AS perso ON clie.IdPersona = perso.IdPersona INNER JOIN
                      dbo.fa_Vendedor AS vend ON fa.IdEmpresa = vend.IdEmpresa AND fa.IdVendedor = vend.IdVendedor INNER JOIN
                      dbo.caj_Caja AS caj ON fa.IdEmpresa = caj.IdEmpresa AND fa.IdCaja = caj.IdCaja
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[5] 4[84] 2[4] 3) )"
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
         Begin Table = "fa"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 219
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_det"
            Begin Extent = 
               Top = 6
               Left = 257
               Bottom = 125
               Right = 438
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "prod"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 245
               Right = 260
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "clie"
            Begin Extent = 
               Top = 14
               Left = 656
               Bottom = 463
               Right = 866
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "perso"
            Begin Extent = 
               Top = 0
               Left = 927
               Bottom = 463
               Right = 1119
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vend"
            Begin Extent = 
               Top = 126
               Left = 298
               Bottom = 245
               Right = 466
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "caj"
            Begin Extent = 
               Top = 366
               Left = 268
               Bottom = 485
               Right = 470
            End
            DisplayFlags = 280
            TopColumn =', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_CUS_TAL_Rpt004';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' 0
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
         Column = 2445
         Alias = 2055
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_CUS_TAL_Rpt004';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_CUS_TAL_Rpt004';

