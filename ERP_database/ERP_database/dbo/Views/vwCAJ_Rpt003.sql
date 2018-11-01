CREATE VIEW [dbo].[vwCAJ_Rpt003]
AS
SELECT ISNULL(ROW_NUMBER() OVER (ORDER BY A.IdEmpresa), 0) AS IdRow, A.*
FROM     (SELECT OG.IdEmpresa, OG.IdCbteCble_Ogiro, OG.IdTipoCbte_Ogiro, OG.co_fechaOg, prov.IdPersona, pers.pe_cedulaRuc, pers.IdTipoDocumento, OG.IdOrden_giro_Tipo, tip_doc.Descripcion, prov.IdProveedor, OG.Num_Autorizacion, 
                                    OG.co_serie, OG.co_factura, OG.co_FechaFactura, con_caj.IdConciliacion_Caja, caj.IdCaja, caj.ca_Descripcion, caj.IdCtaCble, OG.co_observacion, caj_mov_tip.IdTipoMovi, caj_mov_tip.tm_descripcion, OG.co_baseImponible, 
                                    OG.co_subtotal_iva, OG.co_subtotal_siniva, OG.co_valoriva, 0 co_Serv_valor, OG.co_total, con_det.Valor_a_aplicar AS co_valorpagar, RT_ft.IdRetencion, RT_ft.serie, RT_ft.NumRetencion, RT_ft.NAutorizacion, 
                                    RT_ft.re_tipoRet_RF, RT_ft.re_baseRetencion_RF, RT_ft.re_Porcen_retencion_RF, RT_ft.re_valor_retencion_RF, RT_Iva.re_tipoRet_RIVA, RT_Iva.re_baseRetencion_RIVA, RT_Iva.re_Porcen_retencion_RIVA, 
                                    RT_Iva.re_valor_retencion_RIVA, pers.pe_nombreCompleto, pers.pe_razonSocial, pers.pe_apellido, pers.pe_nombre, con_caj.IdPeriodo, per.IdanioFiscal, per.pe_mes, mes.smes, con_caj.Fecha_ini AS pe_FechaIni, 
                                    con_caj.Fecha_fin AS pe_FechaFin, con_caj.Fecha, con_caj.IdEstadoCierre, con_caj.Observacion, con_caj.Saldo_cont_al_periodo, con_caj.Ingresos, con_caj.Total_Ing, con_caj.Total_fact_vale, con_caj.Total_fondo, 
                                    con_caj.Dif_x_pagar_o_cobrar, 0 co_OtroValor_a_descontar
                  FROM      dbo.vwcp_retencion_x_RET_FT AS RT_ft RIGHT OUTER JOIN
                                    dbo.caj_Caja_Movimiento_Tipo_x_CtaCble INNER JOIN
                                    dbo.caj_Caja_Movimiento_Tipo AS caj_mov_tip ON dbo.caj_Caja_Movimiento_Tipo_x_CtaCble.IdTipoMovi = caj_mov_tip.IdTipoMovi INNER JOIN
                                    dbo.tb_persona AS pers INNER JOIN
                                    dbo.cp_orden_giro AS OG INNER JOIN
                                    dbo.cp_proveedor AS prov ON OG.IdEmpresa = prov.IdEmpresa AND OG.IdProveedor = prov.IdProveedor ON pers.IdPersona = prov.IdPersona INNER JOIN
                                    dbo.cp_TipoDocumento AS tip_doc ON OG.IdOrden_giro_Tipo = tip_doc.CodTipoDocumento INNER JOIN
                                    dbo.cp_conciliacion_Caja_det AS con_det ON OG.IdEmpresa = con_det.IdEmpresa_OGiro AND OG.IdCbteCble_Ogiro = con_det.IdCbteCble_Ogiro AND OG.IdTipoCbte_Ogiro = con_det.IdTipoCbte_Ogiro INNER JOIN
                                    dbo.cp_conciliacion_Caja AS con_caj ON con_det.IdEmpresa = con_caj.IdEmpresa AND con_det.IdConciliacion_Caja = con_caj.IdConciliacion_Caja INNER JOIN
                                    dbo.ct_periodo AS per ON con_caj.IdEmpresa = per.IdEmpresa AND con_caj.IdPeriodo = per.IdPeriodo INNER JOIN
                                    dbo.caj_Caja AS caj ON con_caj.IdEmpresa = caj.IdEmpresa AND con_caj.IdCaja = caj.IdCaja INNER JOIN
                                    dbo.tb_mes AS mes ON per.pe_mes = mes.idMes ON dbo.caj_Caja_Movimiento_Tipo_x_CtaCble.IdEmpresa = OG.IdEmpresa AND dbo.caj_Caja_Movimiento_Tipo_x_CtaCble.IdTipoMovi = OG.IdTipoMovi LEFT OUTER JOIN
                                    dbo.vwcp_retencion_x_RET_IVA AS RT_Iva ON OG.IdEmpresa = RT_Iva.IdEmpresa_Ogiro AND OG.IdCbteCble_Ogiro = RT_Iva.IdCbteCble_Ogiro AND OG.IdTipoCbte_Ogiro = RT_Iva.IdTipoCbte_Ogiro ON 
                                    RT_ft.IdEmpresa_Ogiro = OG.IdEmpresa AND RT_ft.IdCbteCble_Ogiro = OG.IdCbteCble_Ogiro AND RT_ft.IdTipoCbte_Ogiro = OG.IdTipoCbte_Ogiro
                  WHERE   (caj_mov_tip.Estado = 'A')
                  UNION ALL
                  SELECT con_caj.IdEmpresa, NULL AS IdCbteCble_Ogiro, NULL AS IdTipoCbte_Ogiro, caj_Caja_Movimiento.cm_fecha AS co_fechaOg, caj_Caja_Movimiento.IdPersona, pers.pe_cedulaRuc, pers.IdTipoDocumento, 
                                    'VALE_CAJ' AS IdOrden_giro_Tipo, 'Vale de Caja' AS Descripcion, NULL AS IdProveedor, NULL AS Num_Autorizacion, NULL AS co_serie, NULL AS co_factura, caj_Caja_Movimiento.cm_fecha AS co_FechaFactura, 
                                    con_caj.IdConciliacion_Caja, caj.IdCaja, caj.ca_Descripcion, caj.IdCtaCble, caj_Caja_Movimiento.cm_observacion AS co_observacion, caj_mov_tip.IdTipoMovi, caj_mov_tip.tm_descripcion, 
                                    caj_Caja_Movimiento.cm_Valor AS co_baseImponible, 0 AS co_subtotal_iva, caj_Caja_Movimiento.cm_Valor AS co_subtotal_siniva, 0 AS co_valoriva, 0 AS co_Serv_valor, caj_Caja_Movimiento.cm_Valor AS co_total, 
                                    caj_Caja_Movimiento.cm_Valor AS co_valorpagar, NULL AS IdRetencion, NULL AS serie, NULL AS NumRetencion, NULL AS NAutorizacion, NULL AS re_tipoRet_RF, NULL AS re_baseRetencion_RF, NULL 
                                    AS re_Porcen_retencion_RF, NULL AS re_valor_retencion_RF, NULL AS re_tipoRet_RIVA, NULL AS re_baseRetencion_RIVA, NULL AS re_Porcen_retencion_RIVA, NULL AS re_valor_retencion_RIVA, pers.pe_nombreCompleto, 
                                    pers.pe_razonSocial, pers.pe_apellido, pers.pe_nombre, con_caj.IdPeriodo, per.IdanioFiscal, per.pe_mes, mes.smes, con_caj.Fecha_ini pe_FechaIni, con_caj.Fecha_fin pe_FechaFin, con_caj.Fecha, con_caj.IdEstadoCierre, 
                                    con_caj.Observacion, con_caj.Saldo_cont_al_periodo, con_caj.Ingresos, con_caj.Total_Ing, con_caj.Total_fact_vale, con_caj.Total_fondo, con_caj.Dif_x_pagar_o_cobrar, NULL co_OtroValor_a_descontar
                  FROM     cp_conciliacion_Caja AS con_caj INNER JOIN
                                    ct_periodo AS per ON con_caj.IdEmpresa = per.IdEmpresa AND con_caj.IdPeriodo = per.IdPeriodo INNER JOIN
                                    caj_Caja AS caj ON con_caj.IdEmpresa = caj.IdEmpresa AND con_caj.IdCaja = caj.IdCaja INNER JOIN
                                    tb_mes AS mes ON per.pe_mes = mes.idMes INNER JOIN
                                    cp_conciliacion_Caja_det_x_ValeCaja ON con_caj.IdEmpresa = cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa AND con_caj.IdConciliacion_Caja = cp_conciliacion_Caja_det_x_ValeCaja.IdConciliacion_Caja INNER JOIN
                                    caj_Caja_Movimiento ON cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa_movcaja = caj_Caja_Movimiento.IdEmpresa AND cp_conciliacion_Caja_det_x_ValeCaja.IdCbteCble_movcaja = caj_Caja_Movimiento.IdCbteCble AND 
                                    cp_conciliacion_Caja_det_x_ValeCaja.IdTipocbte_movcaja = caj_Caja_Movimiento.IdTipocbte INNER JOIN
                                    caj_Caja_Movimiento_Tipo AS caj_mov_tip ON caj_Caja_Movimiento.IdTipoMovi = caj_mov_tip.IdTipoMovi INNER JOIN
                                    caj_Caja_Movimiento_det ON caj_Caja_Movimiento.IdEmpresa = caj_Caja_Movimiento_det.IdEmpresa AND caj_Caja_Movimiento.IdCbteCble = caj_Caja_Movimiento_det.IdCbteCble AND 
                                    caj_Caja_Movimiento.IdTipocbte = caj_Caja_Movimiento_det.IdTipocbte LEFT OUTER JOIN
                                    tb_persona AS pers ON caj_Caja_Movimiento.IdPersona = pers.IdPersona) A
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[5] 4[4] 2[26] 3) )"
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
      Begin ColumnWidths = 47
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
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2415
         Alias = 975
         Table = 2805
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCAJ_Rpt003';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCAJ_Rpt003';

