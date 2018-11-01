CREATE VIEW [dbo].[vwcp_orden_pago_Anticipo_Saldo]
AS
--ANTICIPOS
SELECT       
 OPD.IdEmpresa_cxp AS IdEmpresa, 
 OPD.IdCbteCble_cxp as IdCbteCble, 
 OPD.IdTipoCbte_cxp as IdTipoCbte, 
 
 OP.Fecha, 
 OP.Observacion, 
 '' AS Referencia, 
 CBT_TP.tc_TipoCbte, 
 OPD.Valor_a_pagar AS Valor_cbte, 
 ISNULL(CAN.Total_Pagado, 0) AS valor_cancelado,
  OPD.Valor_a_pagar - ISNULL(CAN.Total_Pagado, 0) AS valor_saldo_cbte, 
  'ANTICIPO' AS Tipo, 
  OPD.IdEmpresa AS IdEmpresaOP,
  OPD.IdOrdenPago AS IdOrdenPagoOP,
   OPD.Secuencia AS SecuenciaOP, 
   Per.IdCtaCble, 
   Per.IdCtaCble_Anticipo, '[' + OP.IdTipo_Persona + ']-' + '[' + CAST(OP.IdEntidad AS varchar(20)) + ']-' + Per.Nombre AS Beneficiario,
   OP.IdEntidad
FROM            dbo.cp_orden_pago AS OP INNER JOIN
                         dbo.cp_orden_pago_det AS OPD ON OP.IdEmpresa = OPD.IdEmpresa AND OP.IdOrdenPago = OPD.IdOrdenPago INNER JOIN
                         dbo.vwtb_persona_beneficiario AS Per ON OP.IdEmpresa = Per.IdEmpresa AND OP.IdTipo_Persona = Per.IdTipo_Persona AND OP.IdPersona = Per.IdPersona AND 
                         OP.IdEntidad = Per.IdEntidad LEFT OUTER JOIN
                         dbo.vwcp_orden_pago_cancelacion_Total_pagado_x_cbteble AS CAN ON OPD.IdEmpresa_cxp = CAN.IdEmpresa_cbtecble AND 
                         OPD.IdTipoCbte_cxp = CAN.IdTipoCbte_cbtecble AND OPD.IdCbteCble_cxp = CAN.IdCbteCble_cbtecble LEFT OUTER JOIN
                         dbo.ct_cbtecble_tipo AS CBT_TP ON OPD.IdTipoCbte_cxp = CBT_TP.IdTipoCbte
WHERE        (OP.IdTipo_op = 'ANTI_PROVEE') AND (OPD.IdCbteCble_cxp IS NOT NULL) AND (OPD.Valor_a_pagar - ISNULL(CAN.Total_Pagado, 0) > 0) AND (OP.Estado = 'A')

UNION ALL
---NOTAS DE CREDITOS
SELECT       
A.IdEmpresa, 
A.IdCbteCble_Nota, 
A.IdTipoCbte_Nota, 
A.cn_fecha, 
A.cn_observacion, 
A.cn_observacion AS referencia, 
D .tc_TipoCbte, 
C.dc_Valor AS Valor_Cbte, 
  ISNULL(B.Total_Pagado, 0) AS Valor_Cancelado_cbte, 
  C.dc_Valor - ISNULL(B.Total_Pagado, 0) AS Valor_saldo_cbte, 
  'NOTA-CRED' AS Tipo, 
  NULL AS Expr1, 
  NULL AS Expr2,
   NULL AS Expr3, 
   P.IdCtaCble_CXP AS IdCtaCble,
    P.IdCtaCble_Anticipo AS IdCtaAnticipo, 
	pe_nombreCompleto AS Beneficiario,
	P.IdProveedor AS IdEntidad
FROM            cp_nota_DebCre AS A INNER JOIN
                         cp_proveedor AS P ON A.IdEmpresa = P.IdEmpresa AND A.IdProveedor = P.IdProveedor INNER JOIN
                         vwct_cbtecble_det_TotalDiario AS C ON A.IdEmpresa = C.IdEmpresa AND A.IdTipoCbte_Nota = C.IdTipoCbte AND A.IdCbteCble_Nota = C.IdCbteCble INNER JOIN
                         ct_cbtecble_tipo AS D ON A.IdTipoCbte_Nota = D .IdTipoCbte LEFT OUTER JOIN
                         vwcp_orden_pago_cancelacion_Total_pagado_x_cbteble AS B ON A.IdEmpresa = B.IdEmpresa_cbtecble AND A.IdTipoCbte_Nota = B.IdTipoCbte_cbtecble AND 
                         A.IdCbteCble_Nota = B.IdCbteCble_cbtecble inner join tb_persona as per on per.IdPersona = p.IdPersona
WHERE        A.Estado = 'A' AND A.DebCre = 'C'
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[16] 4[32] 2[9] 3) )"
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
      Begin ColumnWidths = 20
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_orden_pago_Anticipo_Saldo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_orden_pago_Anticipo_Saldo';

