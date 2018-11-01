CREATE VIEW [dbo].[vwCXP_Rpt008]
AS
SELECT        A.IdEmpresa, A.IdTipoCbte_Ogiro, A.IdCbteCble_Ogiro, A.co_FechaFactura, 'FAC # ' + cast(cast(A.co_factura AS numeric) AS varchar(10)) co_factura, 
                         cp_proveedor.IdProveedor, cp_proveedor.pr_codigo, pe_nombreCompleto pr_nombre, cp_proveedor_clase.IdClaseProveedor, cp_proveedor_clase.cod_clase_proveedor, 
                         cp_proveedor_clase.descripcion_clas_prove, A.co_total AS valor_fa, ISNULL(vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.MontoAplicado, 0) AS valor_nc, 
                         ISNULL(vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.MontoAplicado, 0) AS valor_ba, ISNULL(vwCP_Retencion_Valor_total.Total_Retencion, 0) 
                         AS valor_ret, ROUND(A.co_total - ISNULL(vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.MontoAplicado, 0) 
                         - ISNULL(vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.MontoAplicado, 0) - ISNULL(vwCP_Retencion_Valor_total.Total_Retencion, 0), 2) AS Total, 
                         A.Estado, 'Factura' AS Documento
FROM            dbo.cp_orden_giro AS A INNER JOIN
                         dbo.cp_proveedor ON A.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND A.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
                         dbo.cp_proveedor_clase ON dbo.cp_proveedor.IdEmpresa = dbo.cp_proveedor_clase.IdEmpresa AND 
                         dbo.cp_proveedor.IdClaseProveedor = dbo.cp_proveedor_clase.IdClaseProveedor LEFT OUTER JOIN
                         dbo.vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan ON 
                         A.IdEmpresa = dbo.vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.IdEmpresa_cxp AND 
                         A.IdCbteCble_Ogiro = dbo.vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.IdCbteCble_cxp AND 
                         A.IdTipoCbte_Ogiro = dbo.vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.IdTipoCbte_cxp LEFT OUTER JOIN
                         dbo.vwcp_orden_pago_con_cancelacion_pagado_con_ncxp ON A.IdEmpresa = dbo.vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.IdEmpresa_cxp AND 
                         A.IdTipoCbte_Ogiro = dbo.vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.IdTipoCbte_cxp AND 
                         A.IdCbteCble_Ogiro = dbo.vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.IdCbteCble_cxp LEFT OUTER JOIN
                         dbo.vwCP_Retencion_Valor_total ON A.IdEmpresa = dbo.vwCP_Retencion_Valor_total.IdEmpresa_Ogiro AND 
                         A.IdCbteCble_Ogiro = dbo.vwCP_Retencion_Valor_total.IdCbteCble_Ogiro AND A.IdTipoCbte_Ogiro = dbo.vwCP_Retencion_Valor_total.IdTipoCbte_Ogiro
						 inner join tb_persona as per on cp_proveedor.IdPersona = per.IdPersona
UNION
SELECT        A.IdEmpresa, A.IdTipoCbte_Nota, A.IdCbteCble_Nota, A.cn_fecha, 'ND # ' + cast(cast(A.cod_nota AS numeric) AS varchar(10)), cp_proveedor.IdProveedor, 
                         cp_proveedor.pr_codigo, pe_nombreCompleto, cp_proveedor_clase.IdClaseProveedor, cp_proveedor_clase.cod_clase_proveedor, 
                         cp_proveedor_clase.descripcion_clas_prove, A.cn_total AS valor_fa, ISNULL(vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.MontoAplicado, 0) AS valor_nc, 
                         ISNULL(vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.MontoAplicado, 0) AS valor_ba, cast(0 AS float) AS valor_ret, 
                         ROUND(A.cn_total - ISNULL(vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.MontoAplicado, 0) 
                         - ISNULL(vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.MontoAplicado, 0),2) AS Total, A.Estado, 'Nota de débito' AS Documento
FROM            dbo.cp_nota_DebCre AS A INNER JOIN
                         dbo.cp_proveedor ON A.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND A.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
                         dbo.cp_proveedor_clase ON dbo.cp_proveedor.IdEmpresa = dbo.cp_proveedor_clase.IdEmpresa AND 
                         dbo.cp_proveedor.IdClaseProveedor = dbo.cp_proveedor_clase.IdClaseProveedor LEFT OUTER JOIN
                         dbo.vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan ON 
                         A.IdEmpresa = dbo.vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.IdEmpresa_cxp AND 
                         A.IdCbteCble_Nota = dbo.vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.IdCbteCble_cxp AND 
                         A.IdTipoCbte_Nota = dbo.vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.IdTipoCbte_cxp LEFT OUTER JOIN
                         dbo.vwcp_orden_pago_con_cancelacion_pagado_con_ncxp ON A.IdEmpresa = dbo.vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.IdEmpresa_cxp AND 
                         A.IdTipoCbte_Nota = dbo.vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.IdTipoCbte_cxp AND 
                         A.IdCbteCble_Nota = dbo.vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.IdCbteCble_cxp
						 inner join tb_persona as per on cp_proveedor.IdPersona = per.IdPersona
WHERE        (A.DebCre = 'D')
UNION
SELECT        cp_orden_pago.IdEmpresa, isnull(cp_orden_pago_det.IdTipoCbte_cxp, 0), isnull(cp_orden_pago_det.IdCbteCble_cxp, 0), cp_orden_pago.Fecha_Pago, 
                         'OP # ' + cast(cp_orden_pago.IdOrdenPago AS varchar(10)), cp_proveedor.IdProveedor, cp_proveedor.pr_codigo, pe_nombreCompleto, 
                         cp_proveedor_clase.IdClaseProveedor, cp_proveedor_clase.cod_clase_proveedor, cp_proveedor_clase.descripcion_clas_prove, 
                         cp_orden_pago_det.Valor_a_pagar, isnull(vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.MontoAplicado, 0), 
                         isnull(vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.MontoAplicado, 0), cast(0 AS float), 
                         ROUND(cp_orden_pago_det.Valor_a_pagar - ISNULL(vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.MontoAplicado, 0) 
                         - ISNULL(vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.MontoAplicado, 0), 2), cp_orden_pago.Estado, 'Orden de pago' AS Documento
FROM            cp_proveedor INNER JOIN
                         cp_proveedor_clase ON cp_proveedor.IdEmpresa = cp_proveedor_clase.IdEmpresa AND 
                         cp_proveedor.IdClaseProveedor = cp_proveedor_clase.IdClaseProveedor INNER JOIN
                         cp_orden_pago INNER JOIN
                         cp_orden_pago_det ON cp_orden_pago.IdEmpresa = cp_orden_pago_det.IdEmpresa AND cp_orden_pago.IdOrdenPago = cp_orden_pago_det.IdOrdenPago ON 
                         cp_proveedor.IdEmpresa = cp_orden_pago.IdEmpresa AND cp_proveedor.IdProveedor = cp_orden_pago.IdEntidad AND 
                         cp_proveedor.IdPersona = cp_orden_pago.IdPersona LEFT OUTER JOIN
                         vwcp_orden_pago_con_cancelacion_pagado_con_ncxp ON 
                         cp_orden_pago_det.IdEmpresa_cxp = vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.IdEmpresa_cxp AND 
                         cp_orden_pago_det.IdTipoCbte_cxp = vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.IdTipoCbte_cxp AND 
                         cp_orden_pago_det.IdCbteCble_cxp = vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.IdCbteCble_cxp LEFT OUTER JOIN
                         vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan ON 
                         cp_orden_pago_det.IdEmpresa_cxp = vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.IdEmpresa_cxp AND 
                         cp_orden_pago_det.IdCbteCble_cxp = vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.IdCbteCble_cxp AND 
                         cp_orden_pago_det.IdTipoCbte_cxp = vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.IdTipoCbte_cxp
						 inner join tb_persona as per on cp_proveedor.IdPersona = per.IdPersona
WHERE        (cp_orden_pago.IdTipo_Persona = 'PROVEE') AND NOT EXISTS
                             (SELECT        cp_orden_giro.IdEmpresa
                               FROM            cp_orden_giro
                               WHERE        cp_orden_giro.IdEmpresa = cp_orden_pago_det.IdEmpresa_cxp AND cp_orden_giro.IdTipoCbte_Ogiro = cp_orden_pago_det.IdTipoCbte_cxp AND 
                                                         cp_orden_giro.IdCbteCble_Ogiro = cp_orden_pago_det.IdCbteCble_cxp) AND NOT EXISTS
                             (SELECT        cp_nota_DebCre.IdEmpresa
                               FROM            cp_nota_DebCre
                               WHERE        cp_nota_DebCre.IdEmpresa = cp_orden_pago_det.IdEmpresa_cxp AND cp_nota_DebCre.IdTipoCbte_Nota = cp_orden_pago_det.IdTipoCbte_cxp AND 
                                                         cp_nota_DebCre.IdCbteCble_Nota = cp_orden_pago_det.IdCbteCble_cxp)