CREATE VIEW web.vwcaj_Caja_Movimiento
AS
SELECT caj_Caja_Movimiento.IdEmpresa, caj_Caja_Movimiento.IdTipocbte, caj_Caja_Movimiento.IdCbteCble, caj_Caja_Movimiento.cm_Signo, caj_Caja_Movimiento.cm_valor, caj_Caja_Movimiento.cm_observacion, caj_Caja_Movimiento.cm_fecha, 
                  caj_Caja_Movimiento.IdPersona, tb_persona.pe_nombreCompleto, caj_Caja_Movimiento.Estado, caj_Caja_Movimiento_Tipo.tm_descripcion, caj_Caja_Movimiento.IdCaja, caj_Caja.ca_Descripcion
FROM     caj_Caja_Movimiento INNER JOIN
                  tb_persona ON caj_Caja_Movimiento.IdPersona = tb_persona.IdPersona INNER JOIN
                  caj_Caja_Movimiento_Tipo ON caj_Caja_Movimiento.IdEmpresa = caj_Caja_Movimiento_Tipo.IdEmpresa AND caj_Caja_Movimiento.IdTipoMovi = caj_Caja_Movimiento_Tipo.IdTipoMovi INNER JOIN
                  caj_Caja ON caj_Caja_Movimiento.IdEmpresa = caj_Caja.IdEmpresa AND caj_Caja_Movimiento.IdCaja = caj_Caja.IdCaja