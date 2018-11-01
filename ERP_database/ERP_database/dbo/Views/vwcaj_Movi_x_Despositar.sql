CREATE VIEW [dbo].[vwcaj_Movi_x_Despositar]
AS
SELECT        B.IdEmpresa, B.IdCobro, B.IdCobro_tipo, B.IdCliente, caj_Caja_Movimiento_det.cr_Valor AS cr_TotalCobro, B.cr_fecha, B.cr_fechaCobro, 
                         B.cr_observacion, B.cr_Banco, B.cr_cuenta, B.cr_Tarjeta, B.cr_NumDocumento, B.cr_estado, B.cr_recibo, A.Su_Descripcion AS nSucursal, 
                         D .pe_nombreCompleto AS nCliente, B.cr_fechaDocu, E.IdCaja, E.ca_Descripcion, F.IdTipoMovi, F.tm_descripcion, F.tm_Signo, B.IdUsuario, 
                         G.IdCbteCble AS IdCbteCble_MoviCaja, G.IdTipocbte AS IdTipocbte_MoviCaja, ct_cbtecble_det.IdCtaCble, caj_Caja_Movimiento_det.Secuencia
						 ,F.SeDeposita
FROM            tb_persona AS D INNER JOIN
                         tb_sucursal AS A INNER JOIN
                         cxc_cobro AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdSucursal = B.IdSucursal INNER JOIN
                         fa_cliente AS C ON B.IdCliente = C.IdCliente AND B.IdEmpresa = C.IdEmpresa ON D .IdPersona = C.IdPersona INNER JOIN
                         cxc_cobro_x_caj_Caja_Movimiento AS H ON B.IdEmpresa = H.cbr_IdEmpresa AND B.IdSucursal = H.cbr_IdSucursal AND B.IdCobro = H.cbr_IdCobro INNER JOIN
                         caj_Caja_Movimiento AS G ON H.mcj_IdEmpresa = G.IdEmpresa AND H.mcj_IdCbteCble = G.IdCbteCble AND H.mcj_IdTipocbte = G.IdTipocbte INNER JOIN
                         caj_Caja AS E ON G.IdEmpresa = E.IdEmpresa AND G.IdCaja = E.IdCaja INNER JOIN
                         caj_Caja_Movimiento_Tipo AS F ON G.IdTipoMovi = F.IdTipoMovi INNER JOIN
                         cxc_cobro_tipo ON B.IdCobro_tipo = cxc_cobro_tipo.IdCobro_tipo INNER JOIN
                         vwcxc_EstadoCobro_Actual ON B.IdEmpresa = vwcxc_EstadoCobro_Actual.IdEmpresa AND B.IdSucursal = vwcxc_EstadoCobro_Actual.IdSucursal AND 
                         B.IdCobro = vwcxc_EstadoCobro_Actual.IdCobro INNER JOIN
                         caj_Caja_Movimiento_det ON G.IdEmpresa = caj_Caja_Movimiento_det.IdEmpresa AND G.IdCbteCble = caj_Caja_Movimiento_det.IdCbteCble AND 
                         G.IdTipocbte = caj_Caja_Movimiento_det.IdTipocbte LEFT OUTER JOIN
                         cxc_cobro_x_ct_cbtecble ON cxc_cobro_x_ct_cbtecble.cbr_IdEmpresa = B.IdEmpresa AND cxc_cobro_x_ct_cbtecble.cbr_IdSucursal = B.IdSucursal AND 
                         cxc_cobro_x_ct_cbtecble.cbr_IdCobro = B.IdCobro LEFT OUTER JOIN
                         ct_cbtecble_det ON ct_cbtecble_det.IdEmpresa = cxc_cobro_x_ct_cbtecble.ct_IdEmpresa AND 
                         ct_cbtecble_det.IdTipoCbte = cxc_cobro_x_ct_cbtecble.ct_IdTipoCbte AND ct_cbtecble_det.IdCbteCble = cxc_cobro_x_ct_cbtecble.ct_IdCbteCble AND 
                         ct_cbtecble_det.dc_Valor > 0
WHERE        (cxc_cobro_tipo.tc_SePuede_Depositar = 'S') 
and B.cr_estado='A'
AND (vwcxc_EstadoCobro_Actual.IdEstadoCobro = 'COBR') AND (NOT EXISTS
                             (SELECT        mcj_IdEmpresa, mcj_IdCbteCble, mcj_IdTipocbte
                               FROM            ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito AS A
                               WHERE        (mcj_IdEmpresa = G.IdEmpresa) AND (mcj_IdCbteCble = G.IdCbteCble) AND (mcj_IdTipocbte = G.IdTipocbte) AND 
                                                         (mcj_Secuencia = caj_Caja_Movimiento_det.Secuencia)))
UNION
SELECT        B.IdEmpresa,  B.IdCbteCble AS IdCobro, CASE WHEN C.IdCobro_tipo IS NULL 
                         THEN B.CodMoviCaja WHEN cm_Signo = '+' THEN 'ING' WHEN cm_Signo = '-' THEN 'EGR' END AS IdCobro_tipo, 0 AS IdCliente, C.cr_Valor, B.cm_fecha, B.cm_fecha,
                         B.cm_observacion,NULL AS Banco, NULL AS Cuenta, NULL AS Tarjeta, NULL AS Documento, B.Estado, NULL AS Recibo,NULL AS nom_sucursal,
                         per.pe_nombreCompleto cm_beneficiario, B.cm_fecha,  E.IdCaja, E.ca_Descripcion, F.IdTipoMovi, F.tm_descripcion, B.cm_Signo, B.IdUsuario, B.IdCbteCble AS IdCbteCble_MoviCaja, 
                         B.IdTipocbte AS IdTipocbte_MoviCaja, E.IdCtaCble, C.Secuencia,F.SeDeposita
FROM            caj_Caja AS E INNER JOIN
                         caj_Caja_Movimiento AS B ON E.IdEmpresa = B.IdEmpresa AND E.IdCaja = B.IdCaja INNER JOIN
                         caj_Caja_Movimiento_det AS C ON B.IdEmpresa = C.IdEmpresa AND B.IdCbteCble = C.IdCbteCble AND B.IdTipocbte = C.IdTipocbte INNER JOIN
                         caj_Caja_Movimiento_Tipo AS F ON B.IdTipoMovi = F.IdTipoMovi inner join tb_persona as per on per.IdPersona = B.IdPersona
WHERE        
B.Estado='A'
and NOT EXISTS
                             (SELECT        A.mcj_IdEmpresa, A.mcj_IdCbteCble, A.mcj_IdTipocbte
                               FROM            ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito A
                               WHERE        A.mcj_IdEmpresa = B.IdEmpresa AND A.mcj_IdCbteCble = B.IdCbteCble AND A.mcj_IdTipocbte = B.IdTipocbte AND A.mcj_secuencia = C.Secuencia) 
                         AND NOT EXISTS
                             (SELECT        *
                               FROM            cxc_cobro_x_caj_Caja_Movimiento cb_x_mov_caja
                               WHERE        cb_x_mov_caja.mcj_IdEmpresa = B.IdEmpresa AND cb_x_mov_caja.mcj_IdTipocbte = B.IdTipocbte AND 
                                                         cb_x_mov_caja.mcj_IdCbteCble = B.IdCbteCble)