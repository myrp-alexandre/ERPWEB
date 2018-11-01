--select * from tb_sis_reporte where Modulo like '%fac%'

CREATE view [dbo].[vwFAC_Rpt013]
as
SELECT        suc.IdEmpresa, tb_empresa.em_nombre AS nom_empresa, suc.IdSucursal, suc.Su_Descripcion AS nom_sucursal, fa.IdCliente, 
                         per.pe_apellido + per.pe_nombre AS nom_cliente, per.pe_cedulaRuc AS Cedula_Ruc, fa.vt_fecha AS fecha, 
                         fa.vt_tipoDoc + '-' + fa.vt_serie1 + '-' + fa.vt_serie2 + '-' + fa.vt_NumFactura AS Documento, SUM(fa_d.vt_total) AS Debito, 0 AS Credito, 0 AS Saldo, fa.vt_Observacion
FROM            fa_factura AS fa INNER JOIN
                         tb_sucursal AS suc ON fa.IdEmpresa = suc.IdEmpresa AND fa.IdSucursal = suc.IdSucursal INNER JOIN
                         fa_cliente AS cli ON fa.IdEmpresa = cli.IdEmpresa AND fa.IdCliente = cli.IdCliente INNER JOIN
                         tb_persona AS per ON cli.IdPersona = per.IdPersona INNER JOIN
                         fa_factura_det AS fa_d ON fa.IdEmpresa = fa_d.IdEmpresa AND fa.IdSucursal = fa_d.IdSucursal AND fa.IdBodega = fa_d.IdBodega AND 
                         fa.IdCbteVta = fa_d.IdCbteVta INNER JOIN
                         tb_empresa ON suc.IdEmpresa = tb_empresa.IdEmpresa
GROUP BY suc.IdEmpresa, suc.IdSucursal, suc.Su_Descripcion, per.pe_apellido, per.pe_nombre, per.pe_cedulaRuc, fa.vt_fecha, fa.vt_tipoDoc, fa.vt_serie1, fa.vt_serie2, 
                         fa.vt_NumFactura, fa.vt_Observacion, fa.IdCliente, tb_empresa.em_nombre
union

SELECT       nt.IdEmpresa, em.em_nombre AS nom_empresa, su.IdSucursal, su.Su_Descripcion AS nom_sucursal
,cli.IdCliente, per.pe_apellido +' '+ per.pe_nombre as nom_cliente, per.pe_cedulaRuc,nt.no_fecha
,'N/D:'+ cast(nt.IdNota as varchar(20))+'/'+isnull(nt.NumNota_Impresa,'') , SUM(nt_d.sc_total) AS Debito,0 Credito ,0 Saldo, nt.sc_observacion
FROM            fa_notaCreDeb AS nt INNER JOIN
                         tb_empresa AS em ON nt.IdEmpresa = em.IdEmpresa INNER JOIN
                         tb_sucursal AS su ON nt.IdEmpresa = su.IdEmpresa AND nt.IdSucursal = su.IdSucursal INNER JOIN
                         fa_notaCreDeb_det AS nt_d ON nt.IdEmpresa = nt_d.IdEmpresa AND nt.IdSucursal = nt_d.IdSucursal AND nt.IdBodega = nt_d.IdBodega AND 
                         nt.IdNota = nt_d.IdNota INNER JOIN
                         fa_cliente AS cli ON nt.IdEmpresa = cli.IdEmpresa AND nt.IdCliente = cli.IdCliente INNER JOIN
                         tb_persona AS per ON cli.IdPersona = per.IdPersona
GROUP BY nt.IdEmpresa, em.em_nombre, su.IdSucursal, su.Su_Descripcion, nt.CreDeb, nt.Serie1, nt.Serie2, nt.NumNota_Impresa, nt.IdNota, nt.no_fecha, nt.sc_observacion, 
                         cli.IdCliente, per.pe_apellido, per.pe_nombre, per.pe_cedulaRuc
having nt.CreDeb='D'

union

SELECT        cb.IdEmpresa, emp.em_nombre AS nom_empresa, suc.IdSucursal, suc.Su_Descripcion AS nom_sucursal, clie.IdCliente, per.pe_apellido +' ' + per.pe_nombre, 
                         per.pe_cedulaRuc, cb.cr_fecha, 'COBRO x ' + cb.IdCobro_tipo  + '#' + cast(cb.IdCobro as varchar(20)) +'/'+ cb.cr_NumDocumento,0 Debito, cb.cr_TotalCobro as Credito,0 Saldo
						 ,cb.cr_observacion
FROM            cxc_cobro AS cb INNER JOIN
                         tb_empresa AS emp ON cb.IdEmpresa = emp.IdEmpresa INNER JOIN
                         tb_sucursal AS suc ON cb.IdEmpresa = suc.IdEmpresa AND cb.IdSucursal = suc.IdSucursal INNER JOIN
                         fa_cliente AS clie ON cb.IdEmpresa = clie.IdEmpresa AND cb.IdCliente = clie.IdCliente INNER JOIN
                         tb_persona AS per ON clie.IdPersona = per.IdPersona