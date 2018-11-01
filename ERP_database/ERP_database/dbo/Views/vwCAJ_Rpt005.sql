CREATE view vwCAJ_Rpt005 as
SELECT        tb_empresa.IdEmpresa, tb_empresa.em_nombre, caj_Caja.IdCaja, caj_Caja.ca_Descripcion, 
                         caj_Caja_Movimiento_Tipo.IdTipoMovi, caj_Caja_Movimiento_Tipo.tm_descripcion, caj_Caja_Movimiento.cm_fecha, caj_Caja_Movimiento.IdUsuario, 
                        ISNULL( caj_Caja_Movimiento_det.IdCobro_tipo,'EGRESO') AS IdCobro_tipo, cxc_cobro_tipo.tc_descripcion, caj_Caja_Movimiento.IdCbteCble, caj_Caja_Movimiento.IdTipocbte, 
                         caj_Caja_Movimiento_det.cr_Valor, 
                         caj_Caja_Movimiento.cm_Signo
FROM            caj_Caja_Movimiento INNER JOIN
                         caj_Caja_Movimiento_det ON caj_Caja_Movimiento.IdEmpresa = caj_Caja_Movimiento_det.IdEmpresa AND 
                         caj_Caja_Movimiento.IdCbteCble = caj_Caja_Movimiento_det.IdCbteCble AND caj_Caja_Movimiento.IdTipocbte = caj_Caja_Movimiento_det.IdTipocbte INNER JOIN
                         caj_Caja ON caj_Caja_Movimiento.IdEmpresa = caj_Caja.IdEmpresa AND caj_Caja_Movimiento.IdCaja = caj_Caja.IdCaja INNER JOIN
                         caj_Caja_Movimiento_Tipo ON caj_Caja_Movimiento.IdTipoMovi = caj_Caja_Movimiento_Tipo.IdTipoMovi INNER JOIN
                         tb_empresa ON caj_Caja.IdEmpresa = tb_empresa.IdEmpresa LEFT OUTER JOIN
                         cxc_cobro_tipo ON caj_Caja_Movimiento_det.IdCobro_tipo = cxc_cobro_tipo.IdCobro_tipo