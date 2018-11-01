CREATE VIEW [dbo].[vwBAN_Rpt004]
AS
SELECT      ISNULL(ROW_NUMBER() OVER(ORDER BY A.IdEmpresa),0) AS IdRow  ,A.IdEmpresa, A.IdTipocbte, A.IdCbteCble, A.cb_Fecha, A.cb_Observacion, A.cb_Cheque, A.cb_Valor, A.debe, A.haber, round(sum(a.cb_Valor) OVER (partition BY A.IdEmpresa, A.IdTipocbte, A.IdCbteCble
ORDER BY A.IdEmpresa, A.IdTipocbte, A.IdCbteCble, A.orden, A.IdEmpresa_cxp, A.IdTipoCbte_cxp, A.IdCbteCble_cxp), 2) AS saldo, A.CodTipoCbte, A.tc_TipoCbte, A.pe_nombreCompleto, A.Estado, A.IdEmpresa_cxp, A.IdTipoCbte_cxp, 
A.IdCbteCble_cxp, A.observacion_deuda, A.fecha_deuda, A.num_querry, A.orden, A.IdBanco, A.ba_descripcion
FROM            (SELECT        dbo.ba_Cbte_Ban.IdEmpresa, dbo.ba_Cbte_Ban.IdTipocbte, dbo.ba_Cbte_Ban.IdCbteCble, dbo.ba_Cbte_Ban.cb_Fecha, dbo.ba_Cbte_Ban.cb_Observacion, dbo.ba_Cbte_Ban.cb_Cheque, CASE WHEN CodTipoCbte = 'DEP' OR
                         CodTipoCbte = 'NCB' THEN det.cb_Valor ELSE det.cb_Valor * - 1 END AS cb_Valor, CASE WHEN CodTipoCbte = 'DEP' OR
                         CodTipoCbte = 'NCB' THEN det.cb_Valor ELSE 0 END AS debe, CASE WHEN CodTipoCbte = 'DEP' OR
                         CodTipoCbte = 'NCB' THEN 0 ELSE det.cb_Valor END AS haber, dbo.ct_cbtecble_tipo.CodTipoCbte, dbo.ct_cbtecble_tipo.tc_TipoCbte, 
						 CASE WHEN per_cheque.IdPersona IS NOT NULL 
                         THEN per_cheque.pe_nombreCompleto WHEN per_emp.pe_nombreCompleto IS NOT NULL THEN per_emp.pe_nombreCompleto ELSE per_prov.pe_nombreCompleto END AS pe_nombreCompleto, 
                         dbo.ba_Cbte_Ban.Estado, NULL AS IdEmpresa_cxp, NULL AS IdTipoCbte_cxp, NULL AS IdCbteCble_cxp, NULL AS observacion_deuda, NULL AS fecha_deuda, 1 AS num_querry, 1 AS orden, dbo.ba_Banco_Cuenta.IdBanco, 
                         dbo.ba_Banco_Cuenta.ba_descripcion
FROM            dbo.ba_Banco_Cuenta INNER JOIN
                         dbo.ba_Cbte_Ban LEFT OUTER JOIN
                         dbo.tb_persona AS per_cheque ON dbo.ba_Cbte_Ban.IdPersona_Girado_a = per_cheque.IdPersona INNER JOIN
                         dbo.ct_cbtecble_tipo ON dbo.ba_Cbte_Ban.IdEmpresa = dbo.ct_cbtecble_tipo.IdEmpresa AND dbo.ba_Cbte_Ban.IdTipocbte = dbo.ct_cbtecble_tipo.IdTipoCbte ON 
                         dbo.ba_Banco_Cuenta.IdEmpresa = dbo.ba_Cbte_Ban.IdEmpresa AND dbo.ba_Banco_Cuenta.IdBanco = dbo.ba_Cbte_Ban.IdBanco LEFT OUTER JOIN
                         dbo.tb_persona AS per_prov INNER JOIN
                         dbo.cp_proveedor ON per_prov.IdPersona = dbo.cp_proveedor.IdPersona ON dbo.ba_Cbte_Ban.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND dbo.ba_Cbte_Ban.IdEntidad = dbo.cp_proveedor.IdProveedor LEFT OUTER JOIN
                             (SELECT        IdEmpresa, IdTipoCbte, IdCbteCble, SUM(cb_Valor) AS cb_Valor
                               FROM            dbo.ct_cbtecble AS ct_cbtecble_1
                               GROUP BY IdEmpresa, IdTipoCbte, IdCbteCble) AS det ON dbo.ba_Cbte_Ban.IdEmpresa = det.IdEmpresa AND dbo.ba_Cbte_Ban.IdTipocbte = det.IdTipoCbte AND 
                         dbo.ba_Cbte_Ban.IdCbteCble = det.IdCbteCble LEFT OUTER JOIN
                             (SELECT        dbo.ba_Archivo_Transferencia_Det.IdEmpresa_pago, dbo.ba_Archivo_Transferencia_Det.IdTipoCbte_pago, dbo.ba_Archivo_Transferencia_Det.IdCbteCble_pago, dbo.tb_persona.pe_nombreCompleto
                               FROM            dbo.tb_persona INNER JOIN
                                                         dbo.ro_empleado ON dbo.tb_persona.IdPersona = dbo.ro_empleado.IdPersona INNER JOIN
                                                         dbo.ba_Archivo_Transferencia_Det ON dbo.ro_empleado.IdEmpleado = dbo.ba_Archivo_Transferencia_Det.IdEmpleado AND dbo.ro_empleado.IdEmpresa = dbo.ba_Archivo_Transferencia_Det.IdEmpresa
                               GROUP BY dbo.ba_Archivo_Transferencia_Det.IdEmpresa_pago, dbo.ba_Archivo_Transferencia_Det.IdTipoCbte_pago, dbo.ba_Archivo_Transferencia_Det.IdCbteCble_pago, dbo.tb_persona.pe_nombreCompleto) 
                         AS per_emp ON per_emp.IdEmpresa_pago = dbo.ba_Cbte_Ban.IdEmpresa AND per_emp.IdTipoCbte_pago = dbo.ba_Cbte_Ban.IdTipocbte AND per_emp.IdCbteCble_pago = dbo.ba_Cbte_Ban.IdCbteCble
                          UNION
                          SELECT        dbo.ba_Cbte_Ban.IdEmpresa, dbo.ba_Cbte_Ban.IdTipocbte, dbo.ba_Cbte_Ban.IdCbteCble, dbo.ba_Cbte_Ban.cb_Fecha, dbo.ba_Cbte_Ban.cb_Observacion, dbo.ba_Cbte_Ban.cb_Cheque, 
                         dbo.cp_orden_pago_cancelaciones.MontoAplicado AS cb_Valor, dbo.cp_orden_pago_cancelaciones.MontoAplicado AS debe, 0 AS haber, dbo.ct_cbtecble_tipo.CodTipoCbte, dbo.ct_cbtecble_tipo.tc_TipoCbte, 
                         dbo.tb_persona.pe_nombreCompleto, dbo.ba_Cbte_Ban.Estado, dbo.cp_orden_pago_cancelaciones.IdEmpresa_cxp, dbo.cp_orden_pago_cancelaciones.IdTipoCbte_cxp, dbo.cp_orden_pago_cancelaciones.IdCbteCble_cxp, 
                         dbo.ct_cbtecble.cb_Observacion AS observacion_deuda, dbo.ct_cbtecble.cb_Fecha AS fecha_deuda, 2 AS num_querry, 2 AS orden, dbo.ba_Banco_Cuenta.IdBanco, dbo.ba_Banco_Cuenta.ba_descripcion
FROM            dbo.cp_orden_pago INNER JOIN
                         dbo.ba_Cbte_Ban INNER JOIN
                         dbo.ct_cbtecble_tipo ON dbo.ba_Cbte_Ban.IdEmpresa = dbo.ct_cbtecble_tipo.IdEmpresa AND dbo.ba_Cbte_Ban.IdTipocbte = dbo.ct_cbtecble_tipo.IdTipoCbte INNER JOIN
                         dbo.cp_orden_pago_cancelaciones ON dbo.ba_Cbte_Ban.IdEmpresa = dbo.cp_orden_pago_cancelaciones.IdEmpresa_pago AND dbo.ba_Cbte_Ban.IdTipocbte = dbo.cp_orden_pago_cancelaciones.IdTipoCbte_pago AND 
                         dbo.ba_Cbte_Ban.IdCbteCble = dbo.cp_orden_pago_cancelaciones.IdCbteCble_pago INNER JOIN
                         dbo.cp_orden_pago_det ON dbo.cp_orden_pago_cancelaciones.IdEmpresa_op = dbo.cp_orden_pago_det.IdEmpresa AND dbo.cp_orden_pago_cancelaciones.IdOrdenPago_op = dbo.cp_orden_pago_det.IdOrdenPago AND 
                         dbo.cp_orden_pago_cancelaciones.Secuencia_op = dbo.cp_orden_pago_det.Secuencia ON dbo.cp_orden_pago.IdEmpresa = dbo.cp_orden_pago_det.IdEmpresa AND 
                         dbo.cp_orden_pago.IdOrdenPago = dbo.cp_orden_pago_det.IdOrdenPago INNER JOIN
                         dbo.tb_persona ON dbo.cp_orden_pago.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.ba_Banco_Cuenta ON dbo.ba_Cbte_Ban.IdEmpresa = dbo.ba_Banco_Cuenta.IdEmpresa AND dbo.ba_Cbte_Ban.IdBanco = dbo.ba_Banco_Cuenta.IdBanco LEFT OUTER JOIN
                             (SELECT        IdEmpresa, IdTipoCbte, IdCbteCble, SUM(cb_Valor) AS cb_Valor
                               FROM            dbo.ct_cbtecble AS ct_cbtecble_1
                               GROUP BY IdEmpresa, IdTipoCbte, IdCbteCble) AS det ON dbo.ba_Cbte_Ban.IdEmpresa = det.IdEmpresa AND dbo.ba_Cbte_Ban.IdTipocbte = det.IdTipoCbte AND 
                         dbo.ba_Cbte_Ban.IdCbteCble = det.IdCbteCble LEFT OUTER JOIN
                         dbo.ct_cbtecble ON dbo.cp_orden_pago_cancelaciones.IdEmpresa_cxp = dbo.ct_cbtecble.IdEmpresa AND dbo.cp_orden_pago_cancelaciones.IdTipoCbte_cxp = dbo.ct_cbtecble.IdTipoCbte AND 
                         dbo.cp_orden_pago_cancelaciones.IdCbteCble_cxp = dbo.ct_cbtecble.IdCbteCble
                          UNION
                          SELECT        dbo.ba_Cbte_Ban.IdEmpresa, dbo.ba_Cbte_Ban.IdTipocbte, dbo.ba_Cbte_Ban.IdCbteCble, dbo.ba_Cbte_Ban.cb_Fecha, dbo.ba_Cbte_Ban.cb_Observacion, dbo.ba_Cbte_Ban.cb_Cheque, 
                         dbo.caj_Caja_Movimiento.cm_valor * - 1 AS cb_Valor, 0 AS debe, dbo.caj_Caja_Movimiento.cm_valor AS haber, dbo.ct_cbtecble_tipo.CodTipoCbte, dbo.ct_cbtecble_tipo.tc_TipoCbte, dbo.tb_persona.pe_nombreCompleto, 
                         dbo.ba_Cbte_Ban.Estado, dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mcj_IdEmpresa, dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mcj_IdTipocbte, 
                         dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mcj_IdCbteCble, dbo.caj_Caja_Movimiento.cm_observacion AS observacion_deuda, dbo.caj_Caja_Movimiento.cm_fecha AS fecha_deuda, 3 AS num_querry, 2 AS orden, 
                         dbo.ba_Banco_Cuenta.IdBanco, dbo.ba_Banco_Cuenta.ba_descripcion
FROM            dbo.ba_Cbte_Ban INNER JOIN
                         dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito ON dbo.ba_Cbte_Ban.IdEmpresa = dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mba_IdEmpresa AND 
                         dbo.ba_Cbte_Ban.IdCbteCble = dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mba_IdCbteCble AND dbo.ba_Cbte_Ban.IdTipocbte = dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mba_IdTipocbte INNER JOIN
                         dbo.caj_Caja_Movimiento ON dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mcj_IdEmpresa = dbo.caj_Caja_Movimiento.IdEmpresa AND 
                         dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mcj_IdCbteCble = dbo.caj_Caja_Movimiento.IdCbteCble AND 
                         dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mcj_IdTipocbte = dbo.caj_Caja_Movimiento.IdTipocbte INNER JOIN
                         dbo.tb_persona ON dbo.caj_Caja_Movimiento.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.ct_cbtecble_tipo ON dbo.ba_Cbte_Ban.IdEmpresa = dbo.ct_cbtecble_tipo.IdEmpresa AND dbo.ba_Cbte_Ban.IdTipocbte = dbo.ct_cbtecble_tipo.IdTipoCbte INNER JOIN
                         dbo.ba_Banco_Cuenta ON dbo.ba_Cbte_Ban.IdEmpresa = dbo.ba_Banco_Cuenta.IdEmpresa AND dbo.ba_Cbte_Ban.IdBanco = dbo.ba_Banco_Cuenta.IdBanco) A
						 where a.Estado = 'A'
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[15] 4[18] 2[42] 3) )"
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
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 32
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwBAN_Rpt004';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwBAN_Rpt004';

