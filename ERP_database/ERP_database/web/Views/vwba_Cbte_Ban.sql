 CREATE VIEW web.vwba_Cbte_Ban
AS
SELECT ba_Cbte_Ban.IdEmpresa, ba_Cbte_Ban.IdTipocbte, ba_Cbte_Ban.IdCbteCble, ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo.CodTipoCbteBan, ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo.IdTipoCbteCble, ba_Cbte_Ban.IdPeriodo, 
                  ba_Cbte_Ban.IdBanco, ba_Banco_Cuenta.ba_descripcion, ba_Cbte_Ban.cb_Fecha, ba_Cbte_Ban.cb_Observacion, ba_Cbte_Ban.cb_Valor, ba_Cbte_Ban.cb_Cheque, ba_Cbte_Ban.Estado, ba_Cbte_Ban.cb_giradoA, 
                  ba_Cbte_Ban.IdPersona, tb_persona.pe_nombreCompleto, ba_Cbte_Ban.IdSucursal, tb_sucursal.Su_Descripcion,ba_Banco_Cuenta.Imprimir_Solo_el_cheque
FROM     ba_Cbte_Ban INNER JOIN
                  ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo ON ba_Cbte_Ban.IdEmpresa = ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo.IdEmpresa AND ba_Cbte_Ban.IdTipocbte = ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo.IdTipoCbteCble INNER JOIN
                  ba_Banco_Cuenta ON ba_Cbte_Ban.IdEmpresa = ba_Banco_Cuenta.IdEmpresa AND ba_Cbte_Ban.IdBanco = ba_Banco_Cuenta.IdBanco INNER JOIN
                  tb_sucursal ON ba_Cbte_Ban.IdEmpresa = tb_sucursal.IdEmpresa AND ba_Cbte_Ban.IdSucursal = tb_sucursal.IdSucursal LEFT OUTER JOIN
                  tb_persona ON ba_Cbte_Ban.IdPersona = tb_persona.IdPersona