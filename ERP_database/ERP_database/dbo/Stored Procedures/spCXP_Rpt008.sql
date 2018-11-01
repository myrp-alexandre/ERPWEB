--EXEC [dbo].[spCXP_Rpt008] 1,7,7,542,542,'31/01/2017'
CREATE PROCEDURE [dbo].[spCXP_Rpt008]
(
@IdEmpresa int,
@IdClase_ini int,
@IdClase_fin int,
@IdProveedor_ini numeric,
@IdProveedor_fin numeric,
@Fecha_corte datetime
)
AS
BEGIN

SELECT        A.IdEmpresa, A.IdTipoCbte_Ogiro, A.IdCbteCble_Ogiro, A.co_FechaFactura, 'FAC # ' + cast(cast(A.co_factura AS numeric) AS varchar(10)) co_factura, 
                         cp_proveedor.IdProveedor, cp_proveedor.pr_codigo, per.pe_nombreCompleto pr_nombre, cp_proveedor_clase.IdClaseProveedor, cp_proveedor_clase.cod_clase_proveedor, 
                         cp_proveedor_clase.descripcion_clas_prove, A.co_total AS valor_fa, ISNULL(vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.MontoAplicado, 0) AS valor_nc, 
                         ISNULL(vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.MontoAplicado, 0) AS valor_ba, ISNULL(vwCP_Retencion_Valor_total.Total_Retencion, 0) 
                         AS valor_ret, ROUND(A.co_total - ISNULL(vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.MontoAplicado, 0) 
                         - ISNULL(vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.MontoAplicado, 0) - ISNULL(vwCP_Retencion_Valor_total.Total_Retencion, 0), 2) AS Total, 
                         A.Estado, 'Factura' AS Documento
FROM            dbo.cp_orden_giro AS A INNER JOIN
                         dbo.cp_proveedor ON A.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND A.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
						 tb_persona as per on cp_proveedor.IdPersona = per.IdPersona INNER JOIN
                         dbo.cp_proveedor_clase ON dbo.cp_proveedor.IdEmpresa = dbo.cp_proveedor_clase.IdEmpresa AND 
                         dbo.cp_proveedor.IdClaseProveedor = dbo.cp_proveedor_clase.IdClaseProveedor LEFT OUTER JOIN
                         (
								SELECT        dbo.cp_orden_pago_cancelaciones.IdEmpresa_cxp, dbo.cp_orden_pago_cancelaciones.IdTipoCbte_cxp, dbo.cp_orden_pago_cancelaciones.IdCbteCble_cxp, 
								SUM(dbo.cp_orden_pago_cancelaciones.MontoAplicado) AS MontoAplicado
								FROM            dbo.cp_orden_pago_cancelaciones INNER JOIN
								dbo.ba_Cbte_Ban ON dbo.cp_orden_pago_cancelaciones.IdEmpresa_pago = dbo.ba_Cbte_Ban.IdEmpresa AND 
								dbo.cp_orden_pago_cancelaciones.IdTipoCbte_pago = dbo.ba_Cbte_Ban.IdTipocbte AND 
								dbo.cp_orden_pago_cancelaciones.IdCbteCble_pago = dbo.ba_Cbte_Ban.IdCbteCble
								WHERE dbo.ba_Cbte_Ban.IdEmpresa = @IdEmpresa and dbo.ba_Cbte_Ban.cb_Fecha <= @Fecha_corte
								GROUP BY dbo.cp_orden_pago_cancelaciones.IdEmpresa_cxp, dbo.cp_orden_pago_cancelaciones.IdTipoCbte_cxp, dbo.cp_orden_pago_cancelaciones.IdCbteCble_cxp								
						)
						  AS vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan ON 
                         A.IdEmpresa = vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.IdEmpresa_cxp AND 
                         A.IdCbteCble_Ogiro = vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.IdCbteCble_cxp AND 
                         A.IdTipoCbte_Ogiro = vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.IdTipoCbte_cxp LEFT OUTER JOIN
                         (
								SELECT        dbo.cp_orden_pago_cancelaciones.IdEmpresa_cxp, dbo.cp_orden_pago_cancelaciones.IdTipoCbte_cxp, dbo.cp_orden_pago_cancelaciones.IdCbteCble_cxp, 
								SUM(dbo.cp_orden_pago_cancelaciones.MontoAplicado) AS MontoAplicado
								FROM            cp_orden_pago_cancelaciones INNER JOIN
								ct_cbtecble ON cp_orden_pago_cancelaciones.IdEmpresa_pago = ct_cbtecble.IdEmpresa AND 
								cp_orden_pago_cancelaciones.IdTipoCbte_pago = ct_cbtecble.IdTipoCbte AND cp_orden_pago_cancelaciones.IdCbteCble_pago = ct_cbtecble.IdCbteCble
								WHERE dbo.ct_cbtecble.IdEmpresa = @IdEmpresa and dbo.ct_cbtecble.cb_Fecha <= @Fecha_corte 
								and not exists(
								select ban.IdEmpresa from ba_Cbte_Ban BAN
								where dbo.ct_cbtecble.IdEmpresa = ban.IdEmpresa
								and dbo.ct_cbtecble.IdTipoCbte = ban.IdTipocbte
								and dbo.ct_cbtecble.IdCbteCble = ban.IdCbteCble
								)
								GROUP BY dbo.cp_orden_pago_cancelaciones.IdEmpresa_cxp, dbo.cp_orden_pago_cancelaciones.IdTipoCbte_cxp, dbo.cp_orden_pago_cancelaciones.IdCbteCble_cxp
						 )
						 vwcp_orden_pago_con_cancelacion_pagado_con_ncxp ON A.IdEmpresa = vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.IdEmpresa_cxp AND 
                         A.IdTipoCbte_Ogiro = vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.IdTipoCbte_cxp AND 
                         A.IdCbteCble_Ogiro = vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.IdCbteCble_cxp LEFT OUTER JOIN
                         (
							SELECT        dbo.cp_retencion_det.IdEmpresa, dbo.cp_retencion_det.IdRetencion, SUM(dbo.cp_retencion_det.re_valor_retencion) AS Total_Retencion, 
							dbo.cp_retencion.IdEmpresa_Ogiro, dbo.cp_retencion.IdCbteCble_Ogiro, dbo.cp_retencion.IdTipoCbte_Ogiro
							FROM            dbo.cp_retencion_det INNER JOIN
							dbo.cp_retencion ON dbo.cp_retencion_det.IdEmpresa = dbo.cp_retencion.IdEmpresa AND dbo.cp_retencion_det.IdRetencion = dbo.cp_retencion.IdRetencion
							WHERE cp_retencion.IdEmpresa = @IdEmpresa and cp_retencion.fecha <= @Fecha_corte
							GROUP BY dbo.cp_retencion_det.IdEmpresa, dbo.cp_retencion_det.IdRetencion, dbo.cp_retencion.IdEmpresa_Ogiro, dbo.cp_retencion.IdCbteCble_Ogiro, 
							dbo.cp_retencion.IdTipoCbte_Ogiro
						 )
						 vwCP_Retencion_Valor_total ON A.IdEmpresa = vwCP_Retencion_Valor_total.IdEmpresa_Ogiro AND 
                         A.IdCbteCble_Ogiro = vwCP_Retencion_Valor_total.IdCbteCble_Ogiro AND A.IdTipoCbte_Ogiro = vwCP_Retencion_Valor_total.IdTipoCbte_Ogiro
WHERE a.IdEmpresa = @IdEmpresa and a.co_FechaFactura <= @Fecha_corte and cp_proveedor.IdProveedor between @IdProveedor_ini and @IdProveedor_fin and cp_proveedor_clase.IdClaseProveedor between @IdClase_ini and @IdClase_fin
UNION
SELECT        A.IdEmpresa, A.IdTipoCbte_Nota, A.IdCbteCble_Nota, A.cn_fecha, 'ND # ' + cast(cast(A.cod_nota AS numeric) AS varchar(10)), cp_proveedor.IdProveedor, 
                         cp_proveedor.pr_codigo, per.pe_nombreCompleto pr_nombre, cp_proveedor_clase.IdClaseProveedor, cp_proveedor_clase.cod_clase_proveedor, 
                         cp_proveedor_clase.descripcion_clas_prove, A.cn_total AS valor_fa, ISNULL(vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.MontoAplicado, 0) AS valor_nc, 
                         ISNULL(vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.MontoAplicado, 0) AS valor_ba, cast(0 AS float) AS valor_ret, 
                         ROUND(A.cn_total - ISNULL(vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.MontoAplicado, 0) 
                         - ISNULL(vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.MontoAplicado, 0), 2) AS Total, A.Estado, 'Nota de débito' AS Documento
FROM            dbo.cp_nota_DebCre AS A INNER JOIN
                         dbo.cp_proveedor ON A.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND A.IdProveedor = dbo.cp_proveedor.IdProveedor 
						 INNER JOIN tb_persona as per on per.IdPersona = cp_proveedor.IdPersona
						 INNER JOIN
                         dbo.cp_proveedor_clase ON dbo.cp_proveedor.IdEmpresa = dbo.cp_proveedor_clase.IdEmpresa AND 
                         dbo.cp_proveedor.IdClaseProveedor = dbo.cp_proveedor_clase.IdClaseProveedor LEFT OUTER JOIN
                         (
								SELECT        dbo.cp_orden_pago_cancelaciones.IdEmpresa_cxp, dbo.cp_orden_pago_cancelaciones.IdTipoCbte_cxp, dbo.cp_orden_pago_cancelaciones.IdCbteCble_cxp, 
								SUM(dbo.cp_orden_pago_cancelaciones.MontoAplicado) AS MontoAplicado
								FROM            dbo.cp_orden_pago_cancelaciones INNER JOIN
								dbo.ba_Cbte_Ban ON dbo.cp_orden_pago_cancelaciones.IdEmpresa_pago = dbo.ba_Cbte_Ban.IdEmpresa AND 
								dbo.cp_orden_pago_cancelaciones.IdTipoCbte_pago = dbo.ba_Cbte_Ban.IdTipocbte AND 
								dbo.cp_orden_pago_cancelaciones.IdCbteCble_pago = dbo.ba_Cbte_Ban.IdCbteCble
								WHERE dbo.ba_Cbte_Ban.IdEmpresa = @IdEmpresa and dbo.ba_Cbte_Ban.cb_Fecha <= @Fecha_corte
								GROUP BY dbo.cp_orden_pago_cancelaciones.IdEmpresa_cxp, dbo.cp_orden_pago_cancelaciones.IdTipoCbte_cxp, dbo.cp_orden_pago_cancelaciones.IdCbteCble_cxp								
						)
						  AS vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan ON 
                         A.IdEmpresa = vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.IdEmpresa_cxp AND 
                         A.IdCbteCble_Nota = vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.IdCbteCble_cxp AND 
                         A.IdTipoCbte_Nota = vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.IdTipoCbte_cxp LEFT OUTER JOIN
                         (
								SELECT        dbo.cp_orden_pago_cancelaciones.IdEmpresa_cxp, dbo.cp_orden_pago_cancelaciones.IdTipoCbte_cxp, dbo.cp_orden_pago_cancelaciones.IdCbteCble_cxp, 
								SUM(dbo.cp_orden_pago_cancelaciones.MontoAplicado) AS MontoAplicado
								FROM            dbo.cp_orden_pago_cancelaciones INNER JOIN
								dbo.cp_nota_DebCre ON dbo.cp_orden_pago_cancelaciones.IdEmpresa_pago = dbo.cp_nota_DebCre.IdEmpresa AND 
								dbo.cp_orden_pago_cancelaciones.IdCbteCble_pago = dbo.cp_nota_DebCre.IdCbteCble_Nota AND 
								dbo.cp_orden_pago_cancelaciones.IdTipoCbte_pago = dbo.cp_nota_DebCre.IdTipoCbte_Nota
								WHERE dbo.cp_nota_DebCre.IdEmpresa = @IdEmpresa and dbo.cp_nota_DebCre.cn_fecha <= @Fecha_corte and dbo.cp_nota_DebCre.DebCre = 'C'
								GROUP BY dbo.cp_orden_pago_cancelaciones.IdEmpresa_cxp, dbo.cp_orden_pago_cancelaciones.IdTipoCbte_cxp, dbo.cp_orden_pago_cancelaciones.IdCbteCble_cxp
						 )
						 vwcp_orden_pago_con_cancelacion_pagado_con_ncxp ON A.IdEmpresa = vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.IdEmpresa_cxp AND 
                         A.IdTipoCbte_Nota = vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.IdTipoCbte_cxp AND 
                         A.IdCbteCble_Nota = vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.IdCbteCble_cxp
WHERE        (A.DebCre = 'D') and a.IdEmpresa = @IdEmpresa and a.cn_fecha <= @Fecha_corte and cp_proveedor.IdProveedor between @IdProveedor_ini and @IdProveedor_fin and cp_proveedor_clase.IdClaseProveedor between @IdClase_ini and @IdClase_fin
UNIOn
SELECT        cp_orden_pago.IdEmpresa, isnull(cp_orden_pago_det.IdTipoCbte_cxp, 0), isnull(cp_orden_pago_det.IdCbteCble_cxp, 0), cp_orden_pago.Fecha_Pago, 
                         'OP # ' + cast(cp_orden_pago.IdOrdenPago AS varchar(10)), cp_proveedor.IdProveedor, cp_proveedor.pr_codigo, per.pe_nombreCompleto pr_nombre, 
                         cp_proveedor_clase.IdClaseProveedor, cp_proveedor_clase.cod_clase_proveedor, cp_proveedor_clase.descripcion_clas_prove, 
                         cp_orden_pago_det.Valor_a_pagar, isnull(vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.MontoAplicado, 0), 
                         isnull(vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.MontoAplicado, 0), cast(0 AS float), 
                         ROUND(cp_orden_pago_det.Valor_a_pagar - ISNULL(vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.MontoAplicado, 0) 
                         - ISNULL(vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.MontoAplicado, 0), 2), cp_orden_pago.Estado, 'Orden de pago' AS Documento
FROM            cp_proveedor INNER JOIN
						tb_persona as per on cp_proveedor.IdPersona = per.IdPersona INNER JOIN
                         cp_proveedor_clase ON cp_proveedor.IdEmpresa = cp_proveedor_clase.IdEmpresa AND 
                         cp_proveedor.IdClaseProveedor = cp_proveedor_clase.IdClaseProveedor INNER JOIN
                         cp_orden_pago INNER JOIN
                         cp_orden_pago_det ON cp_orden_pago.IdEmpresa = cp_orden_pago_det.IdEmpresa AND cp_orden_pago.IdOrdenPago = cp_orden_pago_det.IdOrdenPago ON 
                         cp_proveedor.IdEmpresa = cp_orden_pago.IdEmpresa AND cp_proveedor.IdProveedor = cp_orden_pago.IdEntidad AND 
                         cp_proveedor.IdPersona = cp_orden_pago.IdPersona LEFT OUTER JOIN
                         (
								SELECT        dbo.cp_orden_pago_cancelaciones.IdEmpresa_cxp, dbo.cp_orden_pago_cancelaciones.IdTipoCbte_cxp, dbo.cp_orden_pago_cancelaciones.IdCbteCble_cxp, 
								SUM(dbo.cp_orden_pago_cancelaciones.MontoAplicado) AS MontoAplicado
								FROM            dbo.cp_orden_pago_cancelaciones INNER JOIN
								dbo.cp_nota_DebCre ON dbo.cp_orden_pago_cancelaciones.IdEmpresa_pago = dbo.cp_nota_DebCre.IdEmpresa AND 
								dbo.cp_orden_pago_cancelaciones.IdCbteCble_pago = dbo.cp_nota_DebCre.IdCbteCble_Nota AND 
								dbo.cp_orden_pago_cancelaciones.IdTipoCbte_pago = dbo.cp_nota_DebCre.IdTipoCbte_Nota
								WHERE dbo.cp_nota_DebCre.IdEmpresa = @IdEmpresa and dbo.cp_nota_DebCre.cn_fecha <= @Fecha_corte and dbo.cp_nota_DebCre.DebCre = 'C'
								GROUP BY dbo.cp_orden_pago_cancelaciones.IdEmpresa_cxp, dbo.cp_orden_pago_cancelaciones.IdTipoCbte_cxp, dbo.cp_orden_pago_cancelaciones.IdCbteCble_cxp
						 )
						 vwcp_orden_pago_con_cancelacion_pagado_con_ncxp ON 
                         cp_orden_pago_det.IdEmpresa_cxp = vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.IdEmpresa_cxp AND 
                         cp_orden_pago_det.IdTipoCbte_cxp = vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.IdTipoCbte_cxp AND 
                         cp_orden_pago_det.IdCbteCble_cxp = vwcp_orden_pago_con_cancelacion_pagado_con_ncxp.IdCbteCble_cxp LEFT OUTER JOIN
                         (
								SELECT        dbo.cp_orden_pago_cancelaciones.IdEmpresa_cxp, dbo.cp_orden_pago_cancelaciones.IdTipoCbte_cxp, dbo.cp_orden_pago_cancelaciones.IdCbteCble_cxp, 
								SUM(dbo.cp_orden_pago_cancelaciones.MontoAplicado) AS MontoAplicado
								FROM            dbo.cp_orden_pago_cancelaciones INNER JOIN
								dbo.ba_Cbte_Ban ON dbo.cp_orden_pago_cancelaciones.IdEmpresa_pago = dbo.ba_Cbte_Ban.IdEmpresa AND 
								dbo.cp_orden_pago_cancelaciones.IdTipoCbte_pago = dbo.ba_Cbte_Ban.IdTipocbte AND 
								dbo.cp_orden_pago_cancelaciones.IdCbteCble_pago = dbo.ba_Cbte_Ban.IdCbteCble
								WHERE dbo.ba_Cbte_Ban.IdEmpresa = @IdEmpresa and dbo.ba_Cbte_Ban.cb_Fecha <= @Fecha_corte
								GROUP BY dbo.cp_orden_pago_cancelaciones.IdEmpresa_cxp, dbo.cp_orden_pago_cancelaciones.IdTipoCbte_cxp, dbo.cp_orden_pago_cancelaciones.IdCbteCble_cxp								
						)
						  AS vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan ON 
                         cp_orden_pago_det.IdEmpresa_cxp = vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.IdEmpresa_cxp AND 
                         cp_orden_pago_det.IdCbteCble_cxp = vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.IdCbteCble_cxp AND 
                         cp_orden_pago_det.IdTipoCbte_cxp = vwcp_orden_pago_con_cancelacion_pagado_con_CbteBan.IdTipoCbte_cxp
WHERE        (cp_orden_pago.IdTipo_Persona = 'PROVEE') AND NOT EXISTS
                             (SELECT        cp_orden_giro.IdEmpresa
                               FROM            cp_orden_giro
                               WHERE        cp_orden_giro.IdEmpresa = cp_orden_pago_det.IdEmpresa_cxp AND cp_orden_giro.IdTipoCbte_Ogiro = cp_orden_pago_det.IdTipoCbte_cxp AND 
                                                         cp_orden_giro.IdCbteCble_Ogiro = cp_orden_pago_det.IdCbteCble_cxp) AND NOT EXISTS
                             (SELECT        cp_nota_DebCre.IdEmpresa
                               FROM            cp_nota_DebCre
                               WHERE        cp_nota_DebCre.IdEmpresa = cp_orden_pago_det.IdEmpresa_cxp AND cp_nota_DebCre.IdTipoCbte_Nota = cp_orden_pago_det.IdTipoCbte_cxp AND 
                                                         cp_nota_DebCre.IdCbteCble_Nota = cp_orden_pago_det.IdCbteCble_cxp)
							and cp_orden_pago.IdEmpresa = @IdEmpresa and cp_orden_pago.Fecha <= @Fecha_corte and cp_proveedor.IdProveedor between @IdProveedor_ini and @IdProveedor_fin and cp_proveedor_clase.IdClaseProveedor between @IdClase_ini and @IdClase_fin
						
END