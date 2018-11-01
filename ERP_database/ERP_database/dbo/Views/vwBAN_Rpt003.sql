CREATE VIEW [dbo].[vwBAN_Rpt003]
AS
SELECT        dbo.ba_Cbte_Ban.IdEmpresa, TipCbB.CodTipoCbteBan AS Tipo_Cbte, dbo.ba_Cbte_Ban.IdCbteCble AS Num_Cbte, ban.IdBanco, ban.ba_descripcion AS Banco, 
                         dbo.ba_Cbte_Ban.cb_Fecha AS Fch_Cbte, dbo.ba_Cbte_Ban.cb_Observacion AS Observacion, 
						 
						 
						 CASE WHEN TipCbB.CodTipoCbteBan = 'CHEQ' THEN 0 WHEN TipCbB.CodTipoCbteBan = 'NDBA' THEN 0 WHEN TipCbB.CodTipoCbteBan = 'NCBA' THEN opCan.MontoAplicado
                         WHEN TipCbB.CodTipoCbteBan = 'DEPO' THEN opCan.MontoAplicado END AS debe, 

                         CASE WHEN TipCbB.CodTipoCbteBan = 'CHEQ' THEN opCan.MontoAplicado WHEN TipCbB.CodTipoCbteBan = 'NDBA' THEN opCan.MontoAplicado WHEN TipCbB.CodTipoCbteBan
                          = 'NCBA' THEN 0 WHEN TipCbB.CodTipoCbteBan = 'DEPO' THEN 0 END AS haber, 
						  
						  opCan.MontoAplicado AS saldo, 
						  
						  dbo.ba_Cbte_Ban.cb_Valor AS Valor, 
						 
												
                         dbo.ba_Cbte_Ban.cb_Cheque AS Cheque, 
						 
						 dbo.ba_Cbte_Ban.cb_giradoA AS Chq_Girado_A,
						 
						 dbo.ba_Cbte_Ban.IdPersona_Girado_a AS IdPersona_Girado_a,
						 
						  TPF.IdTipoFlujo, TPF.Descricion AS Tipo_Flujo, tipN.IdTipoNota, 
                         tipN.Descripcion AS Tipo_Nota, 'N' AS Fch_PostFechado, 
                         CASE '' WHEN 'S' THEN 'Impreso' ELSE 'No Impreso' END AS Es_Chq_Impreso, 
                         getdate() AS Fch_Chq, ban.IdCtaCble AS Cta_Cble_Banco, cal.IdCalendario, cal.AnioFiscal, cal.NombreMes, cal.NombreCortoFecha, 
                         cal.IdMes, plaCta.pc_Cuenta, opCan.MontoAplicado, opCan.IdOrdenPago_op, opCan.Secuencia_op, vwOPCan.Referencia, vwOPCan.Fecha_Venc_Fac_Prov, 
                         vwOPCan.Observacion AS Observacion_FP, 'CBTE_CHEQ' AS TipoRegistro,1 AS IdReg
FROM            dbo.ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo INNER JOIN
                         dbo.ba_Cbte_Ban_tipo AS TipCbB ON dbo.ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo.CodTipoCbteBan = TipCbB.CodTipoCbteBan INNER JOIN
                         dbo.ba_Cbte_Ban ON dbo.ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo.IdEmpresa = dbo.ba_Cbte_Ban.IdEmpresa AND 
                         dbo.ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo.IdTipoCbteCble = dbo.ba_Cbte_Ban.IdTipocbte INNER JOIN
                         dbo.ba_Banco_Cuenta AS ban ON dbo.ba_Cbte_Ban.IdEmpresa = ban.IdEmpresa AND dbo.ba_Cbte_Ban.IdBanco = ban.IdBanco INNER JOIN
                         dbo.tb_Calendario AS cal ON dbo.ba_Cbte_Ban.cb_Fecha = cal.fecha INNER JOIN
                         dbo.cp_orden_pago_cancelaciones AS opCan ON dbo.ba_Cbte_Ban.IdEmpresa = opCan.IdEmpresa_pago AND 
                         dbo.ba_Cbte_Ban.IdTipocbte = opCan.IdTipoCbte_pago AND dbo.ba_Cbte_Ban.IdCbteCble = opCan.IdCbteCble_pago INNER JOIN
                         dbo.vwcp_orden_pago_con_cancelacion AS vwOPCan ON opCan.IdEmpresa_op = vwOPCan.IdEmpresa AND opCan.IdOrdenPago_op = vwOPCan.IdOrdenPago AND 
                         opCan.Secuencia_op = vwOPCan.Secuencia_OP LEFT OUTER JOIN
                         dbo.ct_plancta AS plaCta ON ban.IdEmpresa = plaCta.IdEmpresa AND ban.IdCtaCble = plaCta.IdCtaCble LEFT OUTER JOIN
                         dbo.ba_tipo_nota AS tipN ON dbo.ba_Cbte_Ban.IdEmpresa = tipN.IdEmpresa AND dbo.ba_Cbte_Ban.IdTipoNota = tipN.IdTipoNota LEFT OUTER JOIN
                         dbo.ba_TipoFlujo AS TPF ON dbo.ba_Cbte_Ban.IdEmpresa = TPF.IdEmpresa AND dbo.ba_Cbte_Ban.IdTipoFlujo = TPF.IdTipoFlujo
WHERE        (TipCbB.CodTipoCbteBan = 'CHEQ')
UNION
--PAGO
SELECT        dbo.ba_Cbte_Ban.IdEmpresa, dbo.ba_Cbte_Ban_tipo.CodTipoCbteBan AS Tipo_Cbte, dbo.ba_Cbte_Ban.IdCbteCble AS Num_Cbte, dbo.ba_Banco_Cuenta.IdBanco, 
                         dbo.ba_Banco_Cuenta.ba_descripcion AS Banco, dbo.ba_Cbte_Ban.cb_Fecha AS Fch_Cbte, dbo.ba_Cbte_Ban.cb_Observacion AS Observacion, 

						     CASE WHEN dbo.ba_Cbte_Ban_tipo.CodTipoCbteBan = 'CHEQ' THEN 0 WHEN dbo.ba_Cbte_Ban_tipo.CodTipoCbteBan = 'NDBA' THEN 0 WHEN dbo.ba_Cbte_Ban_tipo.CodTipoCbteBan
                          = 'NCBA' THEN dbo.ba_Cbte_Ban.cb_Valor WHEN dbo.ba_Cbte_Ban_tipo.CodTipoCbteBan = 'DEPO' THEN dbo.ba_Cbte_Ban.cb_Valor END AS debe, 

                         CASE WHEN dbo.ba_Cbte_Ban_tipo.CodTipoCbteBan = 'CHEQ' THEN dbo.ba_Cbte_Ban.cb_Valor WHEN dbo.ba_Cbte_Ban_tipo.CodTipoCbteBan = 'NDBA' THEN dbo.ba_Cbte_Ban.cb_Valor
                          WHEN dbo.ba_Cbte_Ban_tipo.CodTipoCbteBan = 'NCBA' THEN 0 WHEN dbo.ba_Cbte_Ban_tipo.CodTipoCbteBan = 'DEPO' THEN 0 END AS haber, 

                         dbo.ba_Cbte_Ban.cb_Valor AS saldo, 

						 dbo.ba_Cbte_Ban.cb_Valor AS Valor, 
											 						 
						 dbo.ba_Cbte_Ban.cb_Cheque AS Cheque, 
						 
						 
						 dbo.ba_Cbte_Ban.cb_giradoA AS Chq_Girado_A, 
						 dbo.ba_Cbte_Ban.IdPersona_Girado_a AS IdPersona_Girado_a, 
						 
						 
						 
						 dbo.ba_TipoFlujo.IdTipoFlujo, 
                         dbo.ba_TipoFlujo.Descricion AS Tipo_Flujo, dbo.ba_tipo_nota.IdTipoNota, dbo.ba_tipo_nota.Descripcion AS Tipo_Nota, 
                         'N' AS Fch_PostFechado, 
                         CASE '' WHEN 'S' THEN 'Impreso' ELSE 'No Impreso' END AS Es_Chq_Impreso, 
                         GETDATE() AS Fch_Chq, dbo.ba_Banco_Cuenta.IdCtaCble AS Cta_Cble_Banco, dbo.tb_Calendario.IdCalendario, 
                         dbo.tb_Calendario.AnioFiscal, dbo.tb_Calendario.NombreMes, dbo.tb_Calendario.NombreCortoFecha, dbo.tb_Calendario.IdMes, dbo.ct_plancta.pc_Cuenta, 
                         0, NULL, NULL, NULL, NULL, NULL, 'CBTE_PAGO' AS TipoRegistro,0 AS IdReg
FROM            dbo.ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo INNER JOIN
                         dbo.ba_Cbte_Ban_tipo ON dbo.ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo.CodTipoCbteBan = dbo.ba_Cbte_Ban_tipo.CodTipoCbteBan INNER JOIN
                         dbo.ba_Cbte_Ban ON dbo.ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo.IdEmpresa = dbo.ba_Cbte_Ban.IdEmpresa AND 
                         dbo.ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo.IdTipoCbteCble = dbo.ba_Cbte_Ban.IdTipocbte INNER JOIN
                         dbo.ba_Banco_Cuenta ON dbo.ba_Cbte_Ban.IdEmpresa = dbo.ba_Banco_Cuenta.IdEmpresa AND 
                         dbo.ba_Cbte_Ban.IdBanco = dbo.ba_Banco_Cuenta.IdBanco INNER JOIN
                         dbo.tb_Calendario ON dbo.ba_Cbte_Ban.cb_Fecha = dbo.tb_Calendario.fecha LEFT OUTER JOIN
                         dbo.ct_plancta ON dbo.ba_Banco_Cuenta.IdEmpresa = dbo.ct_plancta.IdEmpresa AND dbo.ba_Banco_Cuenta.IdCtaCble = dbo.ct_plancta.IdCtaCble LEFT OUTER JOIN
                         dbo.ba_tipo_nota ON dbo.ba_Cbte_Ban.IdEmpresa = dbo.ba_tipo_nota.IdEmpresa AND 
                         dbo.ba_Cbte_Ban.IdTipoNota = dbo.ba_tipo_nota.IdTipoNota LEFT OUTER JOIN
                         dbo.ba_TipoFlujo ON dbo.ba_Cbte_Ban.IdEmpresa = dbo.ba_TipoFlujo.IdEmpresa AND dbo.ba_Cbte_Ban.IdTipoFlujo = dbo.ba_TipoFlujo.IdTipoFlujo
WHERE        (dbo.ba_Cbte_Ban_tipo.CodTipoCbteBan = 'CHEQ')
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwBAN_Rpt003';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwBAN_Rpt003';

