CREATE VIEW vwba_Caja_Movimiento_x_Cbte_Ban_x_Deposito_x_depositar
AS
SELECT        caj_Caja_Movimiento_det.IdEmpresa, caj_Caja_Movimiento_det.IdTipocbte, caj_Caja_Movimiento_det.IdCbteCble, caj_Caja_Movimiento_det.Secuencia, cxc_cobro_tipo.tc_descripcion, caj_Caja_Movimiento_det.cr_Valor, 
                         caj_Caja_Movimiento.cm_fecha, caj_Caja_Movimiento.cm_observacion, caj_Caja_Movimiento_Tipo.tm_descripcion, caj_Caja_Movimiento.Estado, tb_persona.pe_nombreCompleto, cxc_cobro.cr_NumDocumento, 
                         caj_Caja.IdCtaCble, caj_Caja.IdCaja, caj_Caja.ca_Descripcion
FROM            caj_Caja_Movimiento_det INNER JOIN
                         cxc_cobro_tipo ON caj_Caja_Movimiento_det.IdCobro_tipo = cxc_cobro_tipo.IdCobro_tipo INNER JOIN
                         caj_Caja_Movimiento ON caj_Caja_Movimiento_det.IdEmpresa = caj_Caja_Movimiento.IdEmpresa AND caj_Caja_Movimiento_det.IdCbteCble = caj_Caja_Movimiento.IdCbteCble AND 
                         caj_Caja_Movimiento_det.IdTipocbte = caj_Caja_Movimiento.IdTipocbte INNER JOIN
                         caj_Caja_Movimiento_Tipo ON caj_Caja_Movimiento.IdEmpresa = caj_Caja_Movimiento_Tipo.IdEmpresa AND caj_Caja_Movimiento.IdTipoMovi = caj_Caja_Movimiento_Tipo.IdTipoMovi INNER JOIN
                         tb_persona ON caj_Caja_Movimiento.IdPersona = tb_persona.IdPersona INNER JOIN
                         caj_Caja ON caj_Caja_Movimiento.IdEmpresa = caj_Caja.IdEmpresa AND caj_Caja_Movimiento.IdCaja = caj_Caja.IdCaja LEFT OUTER JOIN
                         cxc_cobro_x_ct_cbtecble INNER JOIN
                         cxc_cobro ON cxc_cobro_x_ct_cbtecble.cbr_IdEmpresa = cxc_cobro.IdEmpresa AND cxc_cobro_x_ct_cbtecble.cbr_IdSucursal = cxc_cobro.IdSucursal AND cxc_cobro_x_ct_cbtecble.cbr_IdCobro = cxc_cobro.IdCobro ON 
                         caj_Caja_Movimiento.IdEmpresa = cxc_cobro_x_ct_cbtecble.ct_IdEmpresa AND caj_Caja_Movimiento.IdTipocbte = cxc_cobro_x_ct_cbtecble.ct_IdTipoCbte AND 
                         caj_Caja_Movimiento.IdCbteCble = cxc_cobro_x_ct_cbtecble.ct_IdCbteCble
WHERE        (caj_Caja_Movimiento_Tipo.SeDeposita = 1) AND (caj_Caja_Movimiento.Estado = 'A') AND (NOT EXISTS
                             (SELECT        mcj_IdEmpresa
                               FROM            ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito AS f
                               WHERE        (caj_Caja_Movimiento_det.IdEmpresa = mcj_IdEmpresa) AND (caj_Caja_Movimiento_det.IdTipocbte = mcj_IdTipocbte) AND (caj_Caja_Movimiento_det.IdCbteCble = mcj_IdCbteCble)))