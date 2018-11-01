--select * from tb_sis_reporte where modulo='cxp'

CREATE view vwCXP_Rpt033
as
SELECT        cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa, cp_conciliacion_Caja_det_x_ValeCaja.IdConciliacion_Caja, cp_conciliacion_Caja_det_x_ValeCaja.Secuencia, 
                         cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa_movcaja, cp_conciliacion_Caja_det_x_ValeCaja.IdCbteCble_movcaja, cp_conciliacion_Caja_det_x_ValeCaja.IdTipocbte_movcaja, 
                         cp_conciliacion_Caja_det_x_ValeCaja.IdCtaCble, cp_conciliacion_Caja_det_x_ValeCaja.IdPunto_cargo, cp_conciliacion_Caja_det_x_ValeCaja.IdPunto_cargo_grupo, pe_nombreCompleto cm_beneficiario, 
                         caj_Caja_Movimiento.cm_observacion, caj_Caja_Movimiento.cm_fecha, caj_Caja_Movimiento.IdPersona, tb_persona.pe_nombreCompleto AS nom_persona, caj_Caja_Movimiento_Tipo.IdTipoMovi, 
                         caj_Caja_Movimiento_Tipo.tm_descripcion AS nom_TipoMovi, caj_Caja_Movimiento.cm_valor
FROM            cp_conciliacion_Caja_det_x_ValeCaja INNER JOIN
                         caj_Caja_Movimiento ON cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa_movcaja = caj_Caja_Movimiento.IdEmpresa AND 
                         cp_conciliacion_Caja_det_x_ValeCaja.IdCbteCble_movcaja = caj_Caja_Movimiento.IdCbteCble AND cp_conciliacion_Caja_det_x_ValeCaja.IdTipocbte_movcaja = caj_Caja_Movimiento.IdTipocbte INNER JOIN
                         caj_Caja_Movimiento_Tipo ON caj_Caja_Movimiento.IdTipoMovi = caj_Caja_Movimiento_Tipo.IdTipoMovi LEFT OUTER JOIN
                         tb_persona ON caj_Caja_Movimiento.IdPersona = tb_persona.IdPersona