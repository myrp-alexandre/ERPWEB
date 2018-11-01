CREATE view [dbo].[vwCXC_Rpt011]
as
SELECT        IdEmpresa, IdSucursal, IdCliente, Su_Descripcion, pe_nombreCompleto, pe_cedulaRuc, vt_fecha, Idtipo_cliente, Descripcion_tip_cliente, SUM(valor_Debe) 
                         AS Total_Debe, SUM(valor_Haber) AS Total_Haber
FROM            (SELECT        IdEmpresa, IdSucursal, IdCliente, Su_Descripcion, pe_nombreCompleto, pe_cedulaRuc, vt_fecha, Idtipo_cliente, Descripcion_tip_cliente, 
                                                    (CASE WHEN vwCli.IdCobro_tipo = 'FACT' THEN vwCli.vt_total 
													ELSE (CASE WHEN vwCli.IdCobro_tipo = 'NTDB' THEN abs(vwCli.vt_total) ELSE 0 END) END) AS valor_Debe, 
													(CASE WHEN vwCli.IdCobro_tipo = 'FACT' THEN 0 
													ELSE (CASE WHEN vwCli.IdCobro_tipo = 'NTDB' THEN 0 ELSE abs(vwCli.vt_total) END) 
                                                    END) AS valor_Haber
                          FROM            dbo.vwCXC_Rpt007 AS vwCli) AS q
GROUP BY IdEmpresa, IdSucursal, IdCliente, Su_Descripcion, pe_nombreCompleto, pe_cedulaRuc, vt_fecha, Idtipo_cliente, Descripcion_tip_cliente