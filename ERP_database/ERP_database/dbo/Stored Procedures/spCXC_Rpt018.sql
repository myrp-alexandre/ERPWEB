--EXEC spCXC_Rpt018 1,1,999,'2017-09-22',1,'A'
CREATE PROCEDURE [dbo].[spCXC_Rpt018]
(
@IdEmpresa int,
@IdCliente_ini numeric,
@IdCliente_fin numeric,
@Fecha_corte datetime,
@No_mostrar_saldo_0 bit,
@estado varchar(1)
)
AS
BEGIN
delete cxc_spCXC_Rpt018

	BEGIN --INSERTO FACTURAS
	INSERT INTO cxc_spCXC_Rpt018
	SELECT fa_factura.IdEmpresa, fa_factura.IdSucursal, fa_factura.IdBodega, fa_factura.IdCbteVta, fa_factura.vt_tipoDoc,fa_factura.vt_Observacion, 
	fa_factura.vt_NumFactura, fa_factura.vt_fecha, fa_factura.vt_fech_venc, fa_cliente.IdCliente, tb_persona.pe_nombreCompleto,
	 isnull(fac_det.vt_Subtotal,0), isnull(fac_det.vt_iva,0), isnull(fac_det.vt_total,0),0,0,0,0
	FROM     fa_factura INNER JOIN
			fa_cliente ON fa_factura.IdEmpresa = fa_cliente.IdEmpresa AND fa_factura.IdCliente = fa_cliente.IdCliente INNER JOIN
			tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona INNER JOIN 
			(
			select det.IdEmpresa,det.IdSucursal,det.IdBodega,det.IdCbteVta,sum(det.vt_Subtotal) vt_Subtotal, sum(det.vt_iva) vt_iva, sum(det.vt_total) as vt_total
			from fa_factura_det det
			group by det.IdEmpresa,det.IdSucursal,det.IdBodega,det.IdCbteVta
			) fac_det on fa_factura.IdEmpresa = fac_det.IdEmpresa and fa_factura.IdSucursal = fac_det.IdSucursal
			and fa_factura.IdBodega = fac_det.IdBodega and fa_factura.IdCbteVta = fac_det.IdCbteVta
	WHERE fa_factura.vt_fecha <= @Fecha_corte and fa_factura.Estado like '%'+@estado+'%'
		and fa_factura.IdCliente between @IdCliente_ini and @IdCliente_fin and fa_factura.IdEmpresa = @IdEmpresa
	END

	BEGIN --INSERTO ND
	INSERT INTO cxc_spCXC_Rpt018
	SELECT fa_notaCreDeb.IdEmpresa, fa_notaCreDeb.IdSucursal, fa_notaCreDeb.IdBodega, fa_notaCreDeb.IdNota, fa_notaCreDeb.CodDocumentoTipo, 
			fa_notaCreDeb.sc_observacion, fa_notaCreDeb.CodNota, fa_notaCreDeb.no_fecha,fa_notaCreDeb.no_fecha_venc, fa_cliente.IdCliente, 
			tb_persona.pe_nombreCompleto, isnull(nota_det.sc_subtotal,0),isnull(nota_det.sc_iva,0),isnull(nota_det.sc_total,0),0,0,0,0
	FROM     fa_cliente INNER JOIN
			tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona INNER JOIN
			fa_notaCreDeb ON fa_cliente.IdEmpresa = fa_notaCreDeb.IdEmpresa AND fa_cliente.IdCliente = fa_notaCreDeb.IdCliente
			INNER JOIN(
			SELECT det.IdEmpresa,det.IdSucursal,det.IdBodega,det.IdNota, sum(det.sc_subtotal) sc_subtotal , sum(det.sc_iva) sc_iva, sum(det.sc_total) sc_total 
			FROM fa_notaCreDeb_det det
			group by det.IdEmpresa,det.IdSucursal,det.IdBodega,det.IdNota
			)nota_det on fa_notaCreDeb.IdEmpresa = nota_det.IdEmpresa and fa_notaCreDeb.IdSucursal = nota_det.IdSucursal
			and fa_notaCreDeb.IdBodega = nota_det.IdBodega and fa_notaCreDeb.IdNota = nota_det.IdNota
	WHERE  (fa_notaCreDeb.CreDeb = 'D') and fa_notaCreDeb.no_fecha <= @Fecha_corte and fa_notaCreDeb.Estado like '%'+@estado+'%'
		and fa_notaCreDeb.IdCliente between @IdCliente_ini and @IdCliente_fin and fa_notaCreDeb.IdEmpresa = @IdEmpresa
	END

	BEGIN --ACTUALIZO VALOR RETENCION

			UPDATE cxc_spCXC_Rpt018 SET valor_retencion = ROUND(A.dc_ValorPago,2)
			FROM(
			SELECT cxc_cobro_det.IdEmpresa, cxc_cobro_det.IdSucursal, cxc_cobro_det.IdBodega_Cbte, cxc_cobro_det.IdCbte_vta_nota, cxc_cobro_det.dc_TipoDocumento, SUM(cxc_cobro_det.dc_ValorPago) AS dc_ValorPago
			FROM     cxc_cobro_det INNER JOIN
				cxc_cobro ON cxc_cobro_det.IdEmpresa = cxc_cobro.IdEmpresa AND cxc_cobro_det.IdSucursal = cxc_cobro.IdSucursal AND cxc_cobro_det.IdCobro = cxc_cobro.IdCobro INNER JOIN
				cxc_cobro_tipo ON cxc_cobro.IdCobro_tipo = cxc_cobro_tipo.IdCobro_tipo
			WHERE cxc_cobro_tipo.ESRetenFTE = 'S' OR cxc_cobro_tipo.ESRetenIVA = 'S' AND cxc_cobro.cr_fecha <= @Fecha_corte
			GROUP BY cxc_cobro_det.IdEmpresa, cxc_cobro_det.IdSucursal, cxc_cobro_det.IdBodega_Cbte, cxc_cobro_det.IdCbte_vta_nota, cxc_cobro_det.dc_TipoDocumento
			) A WHERE cxc_spCXC_Rpt018.IdEmpresa = A.IdEmpresa
			AND cxc_spCXC_Rpt018.IdSucursal = A.IdSucursal
			AND cxc_spCXC_Rpt018.IdBodega = A.IdBodega_Cbte
			AND cxc_spCXC_Rpt018.IdCbteVta = A.IdCbte_vta_nota
			AND cxc_spCXC_Rpt018.dc_tipo_documento = A.dc_TipoDocumento
	END

	BEGIN --ACTUALIZO VALOR COBRO

			UPDATE cxc_spCXC_Rpt018 SET valor_pagos = ROUND(A.dc_ValorPago,2)
			FROM(
			SELECT cxc_cobro_det.IdEmpresa, cxc_cobro_det.IdSucursal, cxc_cobro_det.IdBodega_Cbte, cxc_cobro_det.IdCbte_vta_nota, cxc_cobro_det.dc_TipoDocumento, SUM(cxc_cobro_det.dc_ValorPago) AS dc_ValorPago
			FROM     cxc_cobro_det INNER JOIN
				cxc_cobro ON cxc_cobro_det.IdEmpresa = cxc_cobro.IdEmpresa AND cxc_cobro_det.IdSucursal = cxc_cobro.IdSucursal AND cxc_cobro_det.IdCobro = cxc_cobro.IdCobro INNER JOIN
				cxc_cobro_tipo ON cxc_cobro.IdCobro_tipo = cxc_cobro_tipo.IdCobro_tipo
			WHERE cxc_cobro_tipo.ESRetenFTE = 'N' AND cxc_cobro_tipo.ESRetenIVA = 'N' AND cxc_cobro.cr_fecha <= @Fecha_corte
			and not exists(
			select nc.IdEmpresa_nt from fa_notaCreDeb_x_cxc_cobro nc
			where cxc_cobro.IdEmpresa = nc.IdEmpresa_cbr
			and cxc_cobro.IdSucursal = nc.IdSucursal_cbr
			and cxc_cobro.IdCobro = nc.IdCobro_cbr
			)
			GROUP BY cxc_cobro_det.IdEmpresa, cxc_cobro_det.IdSucursal, cxc_cobro_det.IdBodega_Cbte, cxc_cobro_det.IdCbte_vta_nota, cxc_cobro_det.dc_TipoDocumento
			) A WHERE cxc_spCXC_Rpt018.IdEmpresa = A.IdEmpresa
			AND cxc_spCXC_Rpt018.IdSucursal = A.IdSucursal
			AND cxc_spCXC_Rpt018.IdBodega = A.IdBodega_Cbte
			AND cxc_spCXC_Rpt018.IdCbteVta = A.IdCbte_vta_nota
			AND cxc_spCXC_Rpt018.dc_tipo_documento = A.dc_TipoDocumento			
	END

	BEGIN --ACTUALIZO VALOR COBRO X NC

			UPDATE cxc_spCXC_Rpt018 SET valor_nc = ROUND(A.dc_ValorPago,2)
			FROM(
			SELECT cxc_cobro_det.IdEmpresa, cxc_cobro_det.IdSucursal, cxc_cobro_det.IdBodega_Cbte, cxc_cobro_det.IdCbte_vta_nota, cxc_cobro_det.dc_TipoDocumento, SUM(cxc_cobro_det.dc_ValorPago) AS dc_ValorPago
			FROM     cxc_cobro_det INNER JOIN
				cxc_cobro ON cxc_cobro_det.IdEmpresa = cxc_cobro.IdEmpresa AND cxc_cobro_det.IdSucursal = cxc_cobro.IdSucursal AND cxc_cobro_det.IdCobro = cxc_cobro.IdCobro INNER JOIN
				cxc_cobro_tipo ON cxc_cobro.IdCobro_tipo = cxc_cobro_tipo.IdCobro_tipo
			WHERE cxc_cobro_tipo.ESRetenFTE = 'N' AND cxc_cobro_tipo.ESRetenIVA = 'N' AND cxc_cobro.cr_fecha <= @Fecha_corte
			and exists(
			select nc.IdEmpresa_nt from fa_notaCreDeb_x_cxc_cobro nc
			where cxc_cobro.IdEmpresa = nc.IdEmpresa_cbr
			and cxc_cobro.IdSucursal = nc.IdSucursal_cbr
			and cxc_cobro.IdCobro = nc.IdCobro_cbr
			)
			GROUP BY cxc_cobro_det.IdEmpresa, cxc_cobro_det.IdSucursal, cxc_cobro_det.IdBodega_Cbte, cxc_cobro_det.IdCbte_vta_nota, cxc_cobro_det.dc_TipoDocumento
			) A WHERE cxc_spCXC_Rpt018.IdEmpresa = A.IdEmpresa
			AND cxc_spCXC_Rpt018.IdSucursal = A.IdSucursal
			AND cxc_spCXC_Rpt018.IdBodega = A.IdBodega_Cbte
			AND cxc_spCXC_Rpt018.IdCbteVta = A.IdCbte_vta_nota
			AND cxc_spCXC_Rpt018.dc_tipo_documento = A.dc_TipoDocumento			
	END

	update cxc_spCXC_Rpt018 set saldo = round(valor_total - valor_retencion - valor_pagos - valor_nc,2)

	IF(@No_mostrar_saldo_0 = 1)
		delete cxc_spCXC_Rpt018 where saldo = 0

select * from cxc_spCXC_Rpt018

END