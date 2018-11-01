CREATE VIEW [dbo].[vwCXP_Rpt016]
AS
SELECT        dbo.cp_orden_giro.IdEmpresa, dbo.cp_orden_giro.IdCbteCble_Ogiro, dbo.cp_orden_giro.IdTipoCbte_Ogiro, dbo.cp_orden_giro.IdOrden_giro_Tipo, 
                         dbo.cp_orden_giro.IdProveedor, 
                         CASE WHEN dbo.cp_orden_giro.co_serie + '-' + dbo.cp_orden_giro.co_factura = '-' THEN '' ELSE dbo.cp_orden_giro.co_serie + '-' + dbo.cp_orden_giro.co_factura END
                          AS num_factura, dbo.cp_orden_giro.co_FechaFactura, dbo.cp_orden_giro.co_observacion, dbo.cp_orden_giro.IdSucursal, dbo.cp_orden_giro.co_fechaOg, 
                         dbo.cp_orden_giro.co_subtotal_iva, dbo.cp_orden_giro.co_subtotal_siniva, dbo.cp_orden_giro.co_baseImponible, dbo.cp_orden_giro.co_Por_iva, 
                         dbo.cp_orden_giro.co_valoriva, dbo.cp_orden_giro.co_total, dbo.cp_orden_giro.co_valorpagar, dbo.cp_TipoDocumento.Descripcion AS nom_tipo_Documento, 
                         tb_persona.pe_nombreCompleto AS nom_proveedor, dbo.ct_cbtecble_tipo.CodTipoCbte, dbo.ct_cbtecble_tipo.tc_TipoCbte, 
                         dbo.cp_orden_pago_tipo_x_empresa.IdTipo_op, dbo.cp_orden_pago_tipo_x_empresa.IdEstadoAprobacion, dbo.cp_orden_giro.co_FechaFactura_vct, 
                         dbo.cp_orden_giro.IdTipoFlujo, dbo.ba_TipoFlujo.Descricion AS nom_flujo, dbo.tb_persona.IdPersona, dbo.cp_TipoDocumento.Codigo AS cod_Documento, 
                         dbo.cp_orden_pago_estado_aprob.Descripcion AS nom_Estado_Aproba, dbo.tb_sucursal.IdSucursal AS Expr1, dbo.tb_sucursal.Su_Descripcion
FROM            dbo.cp_orden_giro INNER JOIN
                         dbo.cp_orden_pago_tipo_x_empresa ON dbo.cp_orden_giro.IdEmpresa = dbo.cp_orden_pago_tipo_x_empresa.IdEmpresa INNER JOIN
                         dbo.cp_TipoDocumento ON dbo.cp_orden_giro.IdOrden_giro_Tipo = dbo.cp_TipoDocumento.CodTipoDocumento INNER JOIN
                         dbo.cp_proveedor ON dbo.cp_orden_giro.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND 
                         dbo.cp_orden_giro.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
                         dbo.ct_cbtecble_tipo ON dbo.cp_orden_giro.IdTipoCbte_Ogiro = dbo.ct_cbtecble_tipo.IdTipoCbte INNER JOIN
                         dbo.tb_persona ON dbo.cp_proveedor.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.cp_orden_pago_estado_aprob ON 
                         dbo.cp_orden_pago_tipo_x_empresa.IdEstadoAprobacion = dbo.cp_orden_pago_estado_aprob.IdEstadoAprobacion LEFT OUTER JOIN
                         dbo.tb_sucursal ON dbo.cp_orden_giro.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.cp_orden_giro.IdSucursal = dbo.tb_sucursal.IdSucursal LEFT OUTER JOIN
                         dbo.ba_TipoFlujo ON dbo.cp_orden_giro.IdEmpresa = dbo.ba_TipoFlujo.IdEmpresa AND dbo.cp_orden_giro.IdTipoFlujo = dbo.ba_TipoFlujo.IdTipoFlujo
						 inner join tb_persona as per on cp_proveedor.IdPersona = per.IdPersona
WHERE        (dbo.cp_orden_pago_tipo_x_empresa.IdTipo_op = 'FACT_PROVEE')
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[46] 4[4] 2[4] 3) )"
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
         Begin Table = "cp_orden_giro"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 283
               Right = 279
            End
            DisplayFlags = 280
            TopColumn = 41
         End
         Begin Table = "cp_orden_pago_tipo_x_empresa"
            Begin Extent = 
               Top = 189
               Left = 714
               Bottom = 368
               Right = 940
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "cp_TipoDocumento"
            Begin Extent = 
               Top = 2
               Left = 650
               Bottom = 137
               Right = 919
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_proveedor"
            Begin Extent = 
               Top = 346
               Left = 143
               Bottom = 475
               Right = 364
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_cbtecble_tipo"
            Begin Extent = 
               Top = 169
               Left = 796
               Bottom = 298
               Right = 1005
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 256
               Left = 737
               Bottom = 385
               Right = 946
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_orden_pago_estado_aprob"
            Begin Extent = 
               Top = 142
               Left = 701
               Bottom = 237
  ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt016';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'             Right = 910
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ba_TipoFlujo"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 399
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 159
               Left = 409
               Bottom = 288
               Right = 639
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
      Begin ColumnWidths = 31
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
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 3435
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
         Alias = 3960
         Table = 3945
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt016';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt016';

