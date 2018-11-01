CREATE view [dbo].[vwba_Archivo_Transferencia_Det]
as
SELECT        dbo.ba_Archivo_Transferencia_Det.IdEmpresa, dbo.ba_Archivo_Transferencia_Det.IdArchivo, dbo.ba_Archivo_Transferencia_Det.Secuencia, dbo.ba_Archivo_Transferencia_Det.IdProceso_bancario, 
                         dbo.ba_Archivo_Transferencia.Origen_Archivo, per_op.pe_cedulaRuc, per_op.num_cta_acreditacion, per_op.pe_nombreCompleto, dbo.ba_Archivo_Transferencia_Det.Valor, 
                         dbo.ba_Archivo_Transferencia_Det.Valor_cobrado, ISNULL(dbo.ba_Archivo_Transferencia_Det.Valor - dbo.ba_Archivo_Transferencia_Det.Valor_cobrado, 0) AS Saldo, 
                         dbo.ba_Archivo_Transferencia_Det.IdEstadoRegistro_cat, dbo.ba_Catalogo.ca_descripcion AS nom_EstadoRegistro_cat, dbo.ba_Archivo_Transferencia_Det.Id_Item, 
                         dbo.ba_Archivo_Transferencia.IdOrden_Bancaria, dbo.ba_Archivo_Transferencia.Fecha, dbo.ba_Archivo_Transferencia.IdBanco, dbo.ba_Archivo_Transferencia_Det.Secuencial_reg_x_proceso, 
                         dbo.ba_Archivo_Transferencia_Det.IdEmpresa_pago, dbo.ba_Archivo_Transferencia_Det.IdTipoCbte_pago, dbo.ba_Archivo_Transferencia_Det.IdCbteCble_pago, dbo.ct_cbtecble.cb_Estado, NULL 
                         AS IdEmpresa_fac, NULL AS IdSucursal_fac, NULL AS IdBodega_fac, NULL AS IdCbteVta_fac, per_op.CodPersona, dbo.ba_Archivo_Transferencia_Det.IdInstitucion_contrato, 
                         dbo.ba_Archivo_Transferencia_Det.idContrato, dbo.ba_Archivo_Transferencia_Det.IdEmpresaNomina, dbo.ba_Archivo_Transferencia_Det.IdNominaTipo, dbo.ba_Archivo_Transferencia_Det.IdNominaTipoLiqui, 
                         dbo.ba_Archivo_Transferencia_Det.IdPeriodo, dbo.ba_Archivo_Transferencia_Det.IdRubro, dbo.ba_Archivo_Transferencia_Det.IdEmpleado
FROM            dbo.tb_persona AS per_op INNER JOIN
                         dbo.cp_orden_pago INNER JOIN
                         dbo.cp_orden_pago_det ON dbo.cp_orden_pago.IdEmpresa = dbo.cp_orden_pago_det.IdEmpresa AND dbo.cp_orden_pago.IdOrdenPago = dbo.cp_orden_pago_det.IdOrdenPago ON 
                         per_op.IdPersona = dbo.cp_orden_pago.IdPersona INNER JOIN
                         dbo.ba_Catalogo INNER JOIN
                         dbo.ba_Archivo_Transferencia_Det INNER JOIN
                         dbo.ba_Archivo_Transferencia ON dbo.ba_Archivo_Transferencia_Det.IdEmpresa = dbo.ba_Archivo_Transferencia.IdEmpresa AND 
                         dbo.ba_Archivo_Transferencia_Det.IdArchivo = dbo.ba_Archivo_Transferencia.IdArchivo ON dbo.ba_Catalogo.IdCatalogo = dbo.ba_Archivo_Transferencia_Det.IdEstadoRegistro_cat ON 
                         dbo.cp_orden_pago_det.IdEmpresa = dbo.ba_Archivo_Transferencia_Det.IdEmpresa_OP AND dbo.cp_orden_pago_det.IdOrdenPago = dbo.ba_Archivo_Transferencia_Det.IdOrdenPago AND 
                         dbo.cp_orden_pago_det.Secuencia = dbo.ba_Archivo_Transferencia_Det.Secuencia_OP LEFT OUTER JOIN
                         dbo.ct_cbtecble ON dbo.ba_Archivo_Transferencia_Det.IdEmpresa_pago = dbo.ct_cbtecble.IdEmpresa AND dbo.ba_Archivo_Transferencia_Det.IdTipoCbte_pago = dbo.ct_cbtecble.IdTipoCbte AND 
                         dbo.ba_Archivo_Transferencia_Det.IdCbteCble_pago = dbo.ct_cbtecble.IdCbteCble
UNION
SELECT        dbo.ba_Archivo_Transferencia_Det.IdEmpresa, dbo.ba_Archivo_Transferencia_Det.IdArchivo, dbo.ba_Archivo_Transferencia_Det.Secuencia, dbo.ba_Archivo_Transferencia_Det.IdProceso_bancario, 
                         dbo.ba_Archivo_Transferencia.Origen_Archivo, per_rol.pe_cedulaRuc, dbo.ro_empleado.em_NumCta, per_rol.pe_nombreCompleto, dbo.ba_Archivo_Transferencia_Det.Valor, 
                         dbo.ba_Archivo_Transferencia_Det.Valor_cobrado, ISNULL(dbo.ba_Archivo_Transferencia_Det.Valor - dbo.ba_Archivo_Transferencia_Det.Valor_cobrado, 0) AS Saldo, 
                         dbo.ba_Archivo_Transferencia_Det.IdEstadoRegistro_cat, dbo.ba_Catalogo.ca_descripcion AS nom_EstadoRegistro_cat, dbo.ba_Archivo_Transferencia_Det.Id_Item, 
                         dbo.ba_Archivo_Transferencia.IdOrden_Bancaria, dbo.ba_Archivo_Transferencia.Fecha, dbo.ba_Archivo_Transferencia.IdBanco, dbo.ba_Archivo_Transferencia_Det.Secuencial_reg_x_proceso, 
                         dbo.ba_Archivo_Transferencia_Det.IdEmpresa_pago, dbo.ba_Archivo_Transferencia_Det.IdTipoCbte_pago, dbo.ba_Archivo_Transferencia_Det.IdCbteCble_pago, dbo.ct_cbtecble.cb_Estado, NULL 
                         AS IdEmpresa_fac, NULL AS dSucursal_fac, NULL AS IdBodega_fac, NULL AS IdCbteVta_fac, dbo.ro_empleado.em_codigo, dbo.ba_Archivo_Transferencia_Det.IdInstitucion_contrato, 
                         dbo.ba_Archivo_Transferencia_Det.idContrato, dbo.ba_Archivo_Transferencia_Det.IdEmpresaNomina, dbo.ba_Archivo_Transferencia_Det.IdNominaTipo, dbo.ba_Archivo_Transferencia_Det.IdNominaTipoLiqui, 
                         dbo.ba_Archivo_Transferencia_Det.IdPeriodo, dbo.ba_Archivo_Transferencia_Det.IdRubro, dbo.ba_Archivo_Transferencia_Det.IdEmpleado
FROM            dbo.ba_Catalogo INNER JOIN
                         dbo.ba_Archivo_Transferencia_Det INNER JOIN
                         dbo.ba_Archivo_Transferencia ON dbo.ba_Archivo_Transferencia_Det.IdEmpresa = dbo.ba_Archivo_Transferencia.IdEmpresa AND 
                         dbo.ba_Archivo_Transferencia_Det.IdArchivo = dbo.ba_Archivo_Transferencia.IdArchivo ON dbo.ba_Catalogo.IdCatalogo = dbo.ba_Archivo_Transferencia_Det.IdEstadoRegistro_cat INNER JOIN
                         dbo.ro_empleado INNER JOIN
                         dbo.tb_persona AS per_rol ON dbo.ro_empleado.IdPersona = per_rol.IdPersona ON dbo.ba_Archivo_Transferencia_Det.IdEmpresa = dbo.ro_empleado.IdEmpresa AND 
                         dbo.ba_Archivo_Transferencia_Det.IdEmpleado = dbo.ro_empleado.IdEmpleado LEFT OUTER JOIN
                         dbo.ct_cbtecble ON dbo.ba_Archivo_Transferencia_Det.IdEmpresa_pago = dbo.ct_cbtecble.IdEmpresa AND dbo.ba_Archivo_Transferencia_Det.IdTipoCbte_pago = dbo.ct_cbtecble.IdTipoCbte AND 
                         dbo.ba_Archivo_Transferencia_Det.IdCbteCble_pago = dbo.ct_cbtecble.IdCbteCble
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[84] 4[4] 2[4] 3) )"
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
         Top = -288
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ro_empleado"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 327
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "per_rol"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 270
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ba_Catalogo"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 399
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ba_Archivo_Transferencia_Det"
            Begin Extent = 
               Top = 317
               Left = 450
               Bottom = 653
               Right = 679
            End
            DisplayFlags = 280
            TopColumn = 19
         End
         Begin Table = "ba_Archivo_Transferencia"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 663
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "per_op"
            Begin Extent = 
               Top = 666
               Left = 38
               Bottom = 795
               Right = 270
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_orden_pago"
            Begin Extent = 
               Top = 798
               Left = 38
               Bottom = 927
               Right = 2', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwba_Archivo_Transferencia_Det';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'47
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_orden_pago_det"
            Begin Extent = 
               Top = 930
               Left = 38
               Bottom = 1059
               Right = 247
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
      Begin ColumnWidths = 43
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwba_Archivo_Transferencia_Det';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwba_Archivo_Transferencia_Det';

