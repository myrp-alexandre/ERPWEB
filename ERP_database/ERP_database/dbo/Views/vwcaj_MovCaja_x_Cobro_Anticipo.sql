
CREATE VIEW [dbo].[vwcaj_MovCaja_x_Cobro_Anticipo]
AS
SELECT        dbo.caj_Caja_Movimiento.IdEmpresa, dbo.caj_Caja_Movimiento.IdCbteCble, dbo.caj_Caja_Movimiento.IdTipocbte, dbo.vwcxc_cobro.IdBanco, 
                         dbo.vwcxc_cobro.IdCaja, '' AS IdCtaCble_TipoCobro, dbo.ba_Banco_Cuenta.IdCtaCble AS IdCtaCble_ban, dbo.vwcxc_cobro.IdCobro, dbo.vwcxc_cobro.IdCobro_tipo, 
                         dbo.vwcxc_cobro.cr_TotalCobro, NULL AS Documento_Cobrado, dbo.vwcxc_cobro.nCliente, dbo.vwcxc_cobro.nSucursal, 
                         dbo.caj_Caja_Movimiento.IdPeriodo AS IdPeriodo_Caja, dbo.vwcxc_cobro.cr_fecha, dbo.vwcxc_cobro.cr_fechaDocu, dbo.vwcxc_cobro.cr_NumDocumento, 
                         dbo.vwcxc_cobro.cr_TotalCobro AS Expr1, dbo.caj_Caja_Movimiento.cm_valor
FROM            dbo.cxc_cobro_x_Anticipo_det INNER JOIN
                         dbo.caj_Caja_Movimiento INNER JOIN
                         dbo.cxc_cobro_x_caj_Caja_Movimiento ON dbo.caj_Caja_Movimiento.IdEmpresa = dbo.cxc_cobro_x_caj_Caja_Movimiento.mcj_IdEmpresa AND 
                         dbo.caj_Caja_Movimiento.IdCbteCble = dbo.cxc_cobro_x_caj_Caja_Movimiento.mcj_IdCbteCble AND 
                         dbo.caj_Caja_Movimiento.IdTipocbte = dbo.cxc_cobro_x_caj_Caja_Movimiento.mcj_IdTipocbte INNER JOIN
                         dbo.vwcxc_cobro ON dbo.cxc_cobro_x_caj_Caja_Movimiento.cbr_IdEmpresa = dbo.vwcxc_cobro.IdEmpresa AND 
                         dbo.cxc_cobro_x_caj_Caja_Movimiento.cbr_IdSucursal = dbo.vwcxc_cobro.IdSucursal AND 
                         dbo.cxc_cobro_x_caj_Caja_Movimiento.cbr_IdCobro = dbo.vwcxc_cobro.IdCobro INNER JOIN
                         dbo.caj_Caja ON dbo.vwcxc_cobro.IdCaja = dbo.caj_Caja.IdCaja AND dbo.vwcxc_cobro.IdEmpresa = dbo.caj_Caja.IdEmpresa INNER JOIN
                         dbo.ba_Banco_Cuenta ON dbo.vwcxc_cobro.IdEmpresa = dbo.ba_Banco_Cuenta.IdEmpresa AND 
                         dbo.vwcxc_cobro.IdBanco = dbo.ba_Banco_Cuenta.IdBanco INNER JOIN
                         dbo.cxc_cobro_tipo_Param_conta_x_sucursal ON dbo.vwcxc_cobro.IdEmpresa = dbo.cxc_cobro_tipo_Param_conta_x_sucursal.IdEmpresa AND 
                         dbo.vwcxc_cobro.IdSucursal = dbo.cxc_cobro_tipo_Param_conta_x_sucursal.IdSucursal AND 
                         dbo.vwcxc_cobro.IdCobro_tipo = dbo.cxc_cobro_tipo_Param_conta_x_sucursal.IdCobro_tipo ON 
                         dbo.cxc_cobro_x_Anticipo_det.IdEmpresa_Cobro = dbo.vwcxc_cobro.IdEmpresa AND 
                         dbo.cxc_cobro_x_Anticipo_det.IdSucursal_cobro = dbo.vwcxc_cobro.IdSucursal AND dbo.cxc_cobro_x_Anticipo_det.IdCobro_cobro = dbo.vwcxc_cobro.IdCobro