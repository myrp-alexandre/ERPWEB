CREATE VIEW dbo.vwcp_orden_pago_con_cancelacion
AS
SELECT        isnull(ROW_NUMBER() OVER (ORDER BY A.IdEmpresa DESC), 0) AS Fila, *
FROM            (SELECT        A.IdEmpresa, A.IdTipo_op, SUBSTRING(D .Descripcion, 1, 3) + '#' + C.co_serie + ' -' + C.co_factura AS Referencia, SUBSTRING(D .Descripcion, 1, 3) + '#' + CAST(CAST(C.co_factura AS NUMERIC) AS VARCHAR) 
                                                    AS Referencia2, A.IdOrdenPago, B.Secuencia AS Secuencia_OP, 'PROVEE' AS IdTipoPersona, Pr.IdPersona, C.IdProveedor AS IdEntidad, A.Fecha AS Fecha_OP, C.co_fechaOg AS Fecha_Fa_Prov, 
                                                    C.co_FechaFactura_vct AS Fecha_Venc_Fac_Prov, A.Observacion, pe_nombreCompleto AS Nom_Beneficiario, pe_nombreCompleto AS Girar_Cheque_a, C.co_valorpagar AS Valor_a_pagar, 
                                                    B.Valor_a_pagar AS Valor_estimado_a_pagar_OP, ISNULL(Can.Total_cancelado, 0) AS Total_cancelado_OP, round(B.Valor_a_pagar - ISNULL(Can.Total_cancelado, 0), 2) AS Saldo_x_Pagar_OP, 
                                                    B.IdEstadoAprobacion, B.IdFormaPago, B.Fecha_Pago, vwct_cbtecble_con_ctacble_acreedora.IdCtaCble_Acreedora AS IdCtaCble, NULL IdCentroCosto, NULL AS IdSubCentro_Costo, C.IdCbteCble_Ogiro AS Cbte_cxp, 
                                                    A.Estado, '[PROVEE]' + '[' + CAST(Pr.IdPersona AS varchar(20)) + ']' + '[' + CAST(C.IdProveedor AS varchar(20)) + ']' + pe_nombreCompleto AS Nom_Beneficiario_2, C.IdEmpresa AS IdEmpresa_cxp, 
                                                    C.IdTipoCbte_Ogiro AS IdTipoCbte_cxp, C.IdCbteCble_Ogiro AS IdCbteCble_cxp, A.IdBanco
                          FROM            cp_proveedor AS Pr INNER JOIN
                                                    cp_orden_giro AS C ON Pr.IdEmpresa = C.IdEmpresa AND Pr.IdProveedor = C.IdProveedor INNER JOIN
                                                    cp_TipoDocumento AS D ON C.IdOrden_giro_Tipo = D .CodTipoDocumento INNER JOIN
                                                    cp_orden_pago AS A INNER JOIN
                                                    cp_orden_pago_det AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdOrdenPago = B.IdOrdenPago ON C.IdEmpresa = B.IdEmpresa_cxp AND C.IdCbteCble_Ogiro = B.IdCbteCble_cxp AND 
                                                    C.IdTipoCbte_Ogiro = B.IdTipoCbte_cxp INNER JOIN
                                                    vwct_cbtecble_con_ctacble_acreedora ON C.IdEmpresa = vwct_cbtecble_con_ctacble_acreedora.IdEmpresa AND C.IdTipoCbte_Ogiro = vwct_cbtecble_con_ctacble_acreedora.IdTipoCbte AND 
                                                    C.IdCbteCble_Ogiro = vwct_cbtecble_con_ctacble_acreedora.IdCbteCble LEFT OUTER JOIN
                                                    vwcp_orden_pago_Total_cancelacion AS Can ON B.IdEmpresa = Can.IdEmpresa_op AND B.IdOrdenPago = Can.IdOrdenPago_op AND B.Secuencia = Can.Secuencia_op
													inner join tb_persona as per on pr.IdPersona = per.IdPersona
													where C.Estado='A'
                          UNION ALL
                          SELECT        A.IdEmpresa, A.IdTipo_op, 'ND' + '#' + cast(cp_nota_DebCre.IdCbteCble_Nota AS varchar(20)) + cp_nota_DebCre.cn_observacion AS Referencia, CASE WHEN cp_nota_DebCre.cod_nota IS NULL 
                                                   THEN 'ND' + '#:' + cast(cp_nota_DebCre.IdCbteCble_Nota AS varchar(20)) ELSE 'ND' + '#' + CAST(CAST(isnull(cp_nota_DebCre.cod_nota, 0) AS varchar) AS varchar(20)) END AS Referencia2, A.IdOrdenPago, 
                                                   B.Secuencia AS Secuencia_OP, 'PROVEE' AS IdTipoPersona, Pr.IdPersona, cp_nota_DebCre.IdProveedor AS IdEntidad, A.Fecha AS Fecha_OP, cp_nota_DebCre.cn_fecha, cp_nota_DebCre.cn_Fecha_vcto, 
                                                   A.Observacion, pe_nombreCompleto AS Nom_Beneficiario, pe_nombreCompleto AS Girar_Cheque_a, cp_nota_DebCre.cn_total Valor_a_pagar, B.Valor_a_pagar AS Valor_estimado_a_pagar_OP, 
                                                   ISNULL(Can.Total_cancelado, 0) AS Total_cancelado_OP, round(B.Valor_a_pagar - ISNULL(Can.Total_cancelado, 0), 2) AS Saldo_x_Pagar_OP, B.IdEstadoAprobacion, B.IdFormaPago, B.Fecha_Pago, 
                                                   vwct_cbtecble_con_ctacble_acreedora.IdCtaCble_Acreedora AS IdCtaCble, cp_nota_DebCre.IdCentroCosto, NULL IdSubCentroCosto, cp_nota_DebCre.IdCbteCble_Nota Cbte_cxp, cp_nota_DebCre.Estado, 
                                                   pe_nombreCompleto nom_beneficiario2, cp_nota_DebCre.IdEmpresa, cp_nota_DebCre.IdTipoCbte_Nota, cp_nota_DebCre.IdCbteCble_Nota, A.IdBanco
                          FROM            cp_nota_DebCre INNER JOIN
                                                   cp_proveedor AS Pr ON cp_nota_DebCre.IdEmpresa = Pr.IdEmpresa AND cp_nota_DebCre.IdProveedor = Pr.IdProveedor INNER JOIN
                                                   cp_orden_pago AS A INNER JOIN
                                                   cp_orden_pago_det AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdOrdenPago = B.IdOrdenPago ON cp_nota_DebCre.IdEmpresa = B.IdEmpresa_cxp AND cp_nota_DebCre.IdCbteCble_Nota = B.IdCbteCble_cxp AND 
                                                   cp_nota_DebCre.IdTipoCbte_Nota = B.IdTipoCbte_cxp INNER JOIN
                                                   vwct_cbtecble_con_ctacble_acreedora ON cp_nota_DebCre.IdEmpresa = vwct_cbtecble_con_ctacble_acreedora.IdEmpresa AND 
                                                   cp_nota_DebCre.IdTipoCbte_Nota = vwct_cbtecble_con_ctacble_acreedora.IdTipoCbte AND cp_nota_DebCre.IdCbteCble_Nota = vwct_cbtecble_con_ctacble_acreedora.IdCbteCble LEFT OUTER JOIN
                                                   vwcp_orden_pago_Total_cancelacion AS Can ON B.IdEmpresa = Can.IdEmpresa_op AND B.IdOrdenPago = Can.IdOrdenPago_op AND 
                                                   B.Secuencia = Can.Secuencia_op inner join tb_persona as per on pr.IdPersona = per.IdPersona
												   where A.Estado='A'
                          /* where  cp_nota_DebCre.IdEmpresa=1 and		cp_nota_DebCre.IdProveedor=49*/ UNION ALL
                          SELECT        OP.IdEmpresa, OP.IdTipo_op, 'OP#' + CAST(OP.IdOrdenPago AS varchar(20)) AS Referencia, 'OP#' + CAST(OP.IdOrdenPago AS varchar(20)) AS Referencia2, OP.IdOrdenPago, OPD.Secuencia, OP.IdTipo_Persona, 
                                                   OP.IdPersona, OP.IdEntidad, OP.Fecha, OP.Fecha AS Fecha_Prov, OP.Fecha AS Fecha_Vct, OP.Observacion, ben.Nombre, ben.pr_girar_cheque_a, OPD.Valor_a_pagar, 
                                                   OPD.Valor_a_pagar AS Valor_estimado_a_pagar_OP, ISNULL(CAN_1.Total_cancelado, 0) AS Total_cancelado_OP, round(OPD.Valor_a_pagar - ISNULL(CAN_1.Total_cancelado, 0), 2) AS Saldo_x_pagar_OP, 
                                                   OPD.IdEstadoAprobacion, OPD.IdFormaPago, OPD.Fecha_Pago, vwct_cbtecble_con_ctacble_acreedora.IdCtaCble_Acreedora, ben.IdCentroCosto, ben.IdSubCentroCosto, NULL AS Expr1, OP.Estado, 
                                                   '[' + OP.IdTipo_Persona + ']' + '[' + CAST(OP.IdPersona AS varchar(20)) + ']' + '[' + CAST(OP.IdEntidad AS varchar(20)) + ']' + ben.Nombre AS Expr2, OPD.IdEmpresa_cxp, OPD.IdTipoCbte_cxp, OPD.IdCbteCble_cxp, 
                                                   OP.IdBanco
                          FROM            cp_orden_pago AS OP INNER JOIN
                                                   cp_orden_pago_det AS OPD ON OP.IdEmpresa = OPD.IdEmpresa AND OP.IdOrdenPago = OPD.IdOrdenPago INNER JOIN
                                                   vwtb_persona_beneficiario AS ben ON OP.IdEmpresa = ben.IdEmpresa AND OP.IdTipo_Persona = ben.IdTipo_Persona AND OP.IdPersona = ben.IdPersona AND OP.IdEntidad = ben.IdEntidad LEFT OUTER JOIN
                                                   vwct_cbtecble_con_ctacble_acreedora ON OPD.IdEmpresa_cxp = vwct_cbtecble_con_ctacble_acreedora.IdEmpresa AND OPD.IdCbteCble_cxp = vwct_cbtecble_con_ctacble_acreedora.IdCbteCble AND 
                                                   OPD.IdTipoCbte_cxp = vwct_cbtecble_con_ctacble_acreedora.IdTipoCbte LEFT OUTER JOIN
                                                   vwcp_orden_pago_Total_cancelacion AS CAN_1 ON OPD.IdEmpresa = CAN_1.IdEmpresa_op AND OPD.IdOrdenPago = CAN_1.IdOrdenPago_op AND OPD.Secuencia = CAN_1.Secuencia_op
                          WHERE        NOT EXISTS
                                                       (SELECT        og.IdEmpresa
                                                         FROM            cp_orden_giro og
                                                         WHERE        og.IdEmpresa = opd.IdEmpresa_cxp AND og.IdTipoCbte_Ogiro = opd.IdTipoCbte_cxp AND og.IdCbteCble_Ogiro = opd.IdCbteCble_cxp) AND NOT EXISTS
                                                       (SELECT        nd.IdEmpresa
                                                         FROM            cp_nota_DebCre nd
                                                         WHERE        nd.IdEmpresa = opd.IdEmpresa_cxp AND nd.IdTipoCbte_Nota = opd.IdTipoCbte_cxp AND nd.IdCbteCble_Nota = opd.IdCbteCble_cxp)
                          UNION ALL
                          SELECT        C.IdEmpresa, 'FACT_PROVEE' AS IdTipo_op, SUBSTRING(D .Descripcion, 1, 3) + '#' + C.co_serie + ' -' + C.co_factura AS Referencia, 'FA#:' + CAST(CAST(C.co_factura AS NUMERIC) AS VARCHAR(20)) 
                                                   AS Referencia2, NULL AS IdOrdenPago, NULL AS Secuencia_OP, 'PROVEE' AS IdTipoPersona, Pr.IdPersona, C.IdProveedor AS IdEntidad, C.co_fechaOg AS Fecha_OP, C.co_fechaOg AS Fecha_Fa_Prov, 
                                                   C.co_FechaFactura_vct AS Fecha_Venc_Fac_Prov, C.co_observacion, pe_nombreCompleto AS Nom_Beneficiario, pe_nombreCompleto AS Girar_Cheque_a, C.co_valorpagar AS Valor_a_pagar, 
                                                   C.co_valorpagar AS Valor_estimado_a_pagar_OP, ISNULL(Total_OP.Valor_a_pagar, 0) AS Total_cancelado_OP, round(C.co_valorpagar - ISNULL(Total_OP.Valor_a_pagar, 0), 2) AS Saldo_x_Pagar_OP, 
                                                   'APRO' AS IdEstadoAprobacion, 'EFEC' AS IdFormaPago, NULL AS Fecha_Pago, vwct_cbtecble_con_ctacble_acreedora.IdCtaCble_Acreedora AS IdCtaCble, NULL IdCentroCosto, NULL AS IdSubCentro_Costo, 
                                                   C.IdCbteCble_Ogiro AS Cbte_cxp, C.Estado, '[PROVEE]' + '[' + CAST(Pr.IdPersona AS varchar(20)) + ']' + '[' + CAST(C.IdProveedor AS varchar(20)) + ']' + pe_nombreCompleto AS Nom_Beneficiario_2, 
                                                   C.IdEmpresa AS IdEmpresa_cxp, C.IdTipoCbte_Ogiro AS IdTipoCbte_cxp, C.IdCbteCble_Ogiro AS IdCbteCble_cxp, NULL AS IdBanco
                          FROM            cp_proveedor AS Pr 
						  inner join tb_persona as per on pr.IdPersona = per.IdPersona
						  INNER JOIN
                                                   cp_orden_giro AS C ON Pr.IdEmpresa = C.IdEmpresa AND Pr.IdProveedor = C.IdProveedor INNER JOIN
                                                   cp_TipoDocumento AS D ON C.IdOrden_giro_Tipo = D .CodTipoDocumento INNER JOIN
                                                   vwct_cbtecble_con_ctacble_acreedora ON C.IdEmpresa = vwct_cbtecble_con_ctacble_acreedora.IdEmpresa AND C.IdCbteCble_Ogiro = vwct_cbtecble_con_ctacble_acreedora.IdCbteCble AND 
                                                   C.IdTipoCbte_Ogiro = vwct_cbtecble_con_ctacble_acreedora.IdTipoCbte LEFT OUTER JOIN
                                                       (SELECT        IdEmpresa_cxp, IdCbteCble_cxp, IdTipoCbte_cxp, SUM(Valor_a_pagar) AS Valor_a_pagar
                                                         FROM            cp_orden_pago_det AS A
                                                         WHERE        (IdEmpresa_cxp IS NOT NULL) AND (IdCbteCble_cxp IS NOT NULL)
                                                         GROUP BY IdEmpresa_cxp, IdCbteCble_cxp, IdTipoCbte_cxp) AS Total_OP ON Total_OP.IdEmpresa_cxp = C.IdEmpresa AND Total_OP.IdTipoCbte_cxp = C.IdTipoCbte_Ogiro AND 
                                                   Total_OP.IdCbteCble_cxp = C.IdCbteCble_Ogiro) A
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[6] 4[4] 2[53] 3) )"
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
         Top = -576
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_orden_pago_con_cancelacion';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_orden_pago_con_cancelacion';

