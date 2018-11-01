--EXEC Naturisa.spCXP_NATU_Rpt013 1,1,9999,1,9999,'01/01/2017','31/01/2017'
CREATE PROCEDURE [Naturisa].[spCXP_NATU_Rpt013]
(
@IdEmpresa int,
@IdClaseProveedor_ini int,
@IdClaseProveedor_fin int,
@IdProveedor_ini numeric,
@IdProveedor_fin numeric,
@Fecha_ini datetime,
@Fecha_fin datetime
)
as
BEGIN
/*
SET @IdEmpresa = 1
SET @IdProveedor = 16
SET @Fecha_ini = '01/01/2017'
SET @Fecha_fin = '28/02/2017'
*/

--SALDO INICIAL
DECLARE @Saldo_inicial float

select @Saldo_inicial = SUM(dc_Valor) 
from Naturisa.vwCXP_NATU_Rpt013
WHERE IdEmpresa = @IdEmpresa
AND IdClaseProveedor BETWEEN @IdClaseProveedor_ini AND @IdClaseProveedor_fin
AND IdProveedor BETWEEN @IdProveedor_ini AND @IdProveedor_fin
AND cb_Fecha < @Fecha_ini 

set @Saldo_inicial = isnull(@Saldo_inicial,0)

--CONTEO
DECLARE @Movimientos_en_rango numeric

SELECT @Movimientos_en_rango  = COUNT(dc_Valor) 
from Naturisa.vwCXP_NATU_Rpt013
WHERE IdEmpresa = @IdEmpresa
AND IdClaseProveedor BETWEEN @IdClaseProveedor_ini AND @IdClaseProveedor_fin
AND IdProveedor BETWEEN @IdProveedor_ini AND @IdProveedor_fin
AND cb_Fecha BETWEEN @Fecha_ini AND @Fecha_fin

set @Movimientos_en_rango = isnull(@Movimientos_en_rango,0)

--select @Movimientos_en_rango

				SELECT isnull(ROW_NUMBER() over(order by A.IdEmpresa),0) AS IdRow, A.IdEmpresa,A.IdTipoCbte,A.IdCbteCble,A.secuencia, A.IdCtaCble, A.pc_Cuenta, A.cb_Fecha, A.co_observacion,
				A.IdClaseProveedor, a.descripcion_clas_prove, a.IdProveedor,a.pr_codigo, a.pr_nombre, a.IdCtaCble_CXP_clase, a.IdCtaCble_CXP_provee, A.CodTipoCbte, A.tc_TipoCbte, 
				abs(ISNULL(@Saldo_inicial,0)) as Saldo_inicial, A.Debe, A.Haber, A.dc_Valor, 
				ABS(ISNULL(@Saldo_inicial,0)  + sum(A.dc_Valor) over(Partition by A.IdEmpresa ORDER BY A.IdEmpresa,a.IdClaseProveedor, a.IdProveedor, A.cb_Fecha,  a.IdTipoCbte, a.IdCbteCble, a.secuencia, A.Secuencia_rpt)) as Saldo,
				A.referencia, A.Secuencia_rpt
				FROM (
				--OG
						SELECT        det.IdEmpresa, det.IdTipoCbte, det.IdCbteCble, det.secuencia, ct_plancta_1.IdCtaCble, ct_plancta_1.pc_Cuenta, cxp.co_FechaFactura as cb_Fecha, cxp.co_observacion, 
										cp_proveedor_clase.IdClaseProveedor, cp_proveedor_clase.descripcion_clas_prove, cp_proveedor.IdProveedor,cp_proveedor.pr_codigo , pe_nombreCompleto pr_nombre, 
										cp_proveedor_clase.IdCtaCble_CXP AS IdCtaCble_CXP_clase, cp_proveedor.IdCtaCble_CXP AS IdCtaCble_CXP_provee, ct_cbtecble_tipo.CodTipoCbte, 
										ct_cbtecble_tipo.tc_TipoCbte, CASE WHEN DET.dc_Valor > 0 THEN ABS(DET.dc_Valor) ELSE 0 END AS Debe, CASE WHEN DET.dc_Valor < 0 THEN ABS(DET.dc_Valor)
										ELSE 0 END AS Haber, det.dc_Valor, LTRIM(RTRIM(ct_cbtecble_tipo.CodTipoCbte)) + '-' + cxp.co_factura AS referencia, 1 AS Secuencia_rpt
						FROM            ct_plancta AS ct_plancta_1 INNER JOIN
										cp_proveedor_clase INNER JOIN
										cp_proveedor ON cp_proveedor_clase.IdEmpresa = cp_proveedor.IdEmpresa AND 
										cp_proveedor_clase.IdClaseProveedor = cp_proveedor.IdClaseProveedor INNER JOIN
										cp_orden_giro AS cxp INNER JOIN
										ct_cbtecble AS cab ON cxp.IdEmpresa = cab.IdEmpresa AND cxp.IdTipoCbte_Ogiro = cab.IdTipoCbte AND cxp.IdCbteCble_Ogiro = cab.IdCbteCble INNER JOIN
										ct_cbtecble_det AS det ON cab.IdEmpresa = det.IdEmpresa AND cab.IdTipoCbte = det.IdTipoCbte AND cab.IdCbteCble = det.IdCbteCble ON 
										cp_proveedor.IdEmpresa = cxp.IdEmpresa AND cp_proveedor.IdProveedor = cxp.IdProveedor ON ct_plancta_1.IdEmpresa = det.IdEmpresa AND 
										ct_plancta_1.IdCtaCble = det.IdCtaCble INNER JOIN
										ct_cbtecble_tipo ON cab.IdEmpresa = ct_cbtecble_tipo.IdEmpresa AND cab.IdTipoCbte = ct_cbtecble_tipo.IdTipoCbte
										inner join tb_persona as per on cp_proveedor.IdPersona = per.IdPersona
						where cxp.IdEmpresa = @IdEmpresa and cxp.IdProveedor between @IdProveedor_ini and @IdProveedor_fin and cp_proveedor.IdClaseProveedor between @IdClaseProveedor_ini and @IdClaseProveedor_fin 
									and exists(
									select clase.IdEmpresa from cp_proveedor_clase clase
									where clase.IdEmpresa = det.IdEmpresa
									and clase.IdCtaCble_CXP = det.IdCtaCble
									)
									and cxp.co_FechaFactura between @Fecha_ini and @Fecha_fin AND CXP.Estado = 'A'
				UNION
				--ND
						SELECT        det.IdEmpresa, det.IdTipoCbte, det.IdCbteCble, det.secuencia, ct_plancta_1.IdCtaCble, ct_plancta_1.pc_Cuenta, cxp.cn_fecha, cxp.cn_observacion, 
										cp_proveedor_clase.IdClaseProveedor, cp_proveedor_clase.descripcion_clas_prove, cp_proveedor.IdProveedor,cp_proveedor.pr_codigo, pe_nombreCompleto pr_nombre, 
										cp_proveedor_clase.IdCtaCble_CXP AS IdCtaCble_CXP_clase, cp_proveedor.IdCtaCble_CXP AS IdCtaCble_CXP_provee, ct_cbtecble_tipo.CodTipoCbte, 
										ct_cbtecble_tipo.tc_TipoCbte, CASE WHEN DET.dc_Valor > 0 THEN ABS(DET.dc_Valor) ELSE 0 END AS Debe, CASE WHEN DET.dc_Valor < 0 THEN ABS(DET.dc_Valor)
										ELSE 0 END AS Haber, det.dc_Valor, LTRIM(RTRIM(ct_cbtecble_tipo.CodTipoCbte)) + '-' + cxp.cod_nota AS referencia, 1 AS Secuencia_rpt
						FROM            ct_plancta AS ct_plancta_1 INNER JOIN
										cp_proveedor_clase INNER JOIN
										cp_proveedor ON cp_proveedor_clase.IdEmpresa = cp_proveedor.IdEmpresa AND 
										cp_proveedor_clase.IdClaseProveedor = cp_proveedor.IdClaseProveedor INNER JOIN
										cp_nota_DebCre AS cxp INNER JOIN
										ct_cbtecble AS cab ON cxp.IdEmpresa = cab.IdEmpresa AND cxp.IdTipoCbte_Nota = cab.IdTipoCbte AND cxp.IdCbteCble_Nota = cab.IdCbteCble INNER JOIN
										ct_cbtecble_det AS det ON cab.IdEmpresa = det.IdEmpresa AND cab.IdTipoCbte = det.IdTipoCbte AND cab.IdCbteCble = det.IdCbteCble ON 
										cp_proveedor.IdEmpresa = cxp.IdEmpresa AND cp_proveedor.IdProveedor = cxp.IdProveedor ON ct_plancta_1.IdEmpresa = det.IdEmpresa AND 
										ct_plancta_1.IdCtaCble = det.IdCtaCble INNER JOIN
										ct_cbtecble_tipo ON cab.IdEmpresa = ct_cbtecble_tipo.IdEmpresa AND cab.IdTipoCbte = ct_cbtecble_tipo.IdTipoCbte
										inner join tb_persona as per on cp_proveedor.IdPersona = per.IdPersona
						WHERE        (cxp.DebCre = 'D') AND (det.dc_Valor < 0) and exists(
									select clase.IdEmpresa from cp_proveedor_clase clase
									where clase.IdEmpresa = det.IdEmpresa
									and clase.IdCtaCble_CXP = det.IdCtaCble
									) 
									and cxp.IdEmpresa = @IdEmpresa and cxp.IdProveedor between @IdProveedor_ini and @IdProveedor_fin and cp_proveedor.IdClaseProveedor between @IdClaseProveedor_ini and @IdClaseProveedor_fin
									and cxp.cn_fecha between @Fecha_ini and @Fecha_fin AND CXP.Estado = 'A'
				UNION
				--OP
						SELECT        det.IdEmpresa, det.IdTipoCbte, det.IdCbteCble, det.secuencia, ct_plancta_1.IdCtaCble, ct_plancta_1.pc_Cuenta,  cp_orden_pago.Fecha, cp_orden_pago.Observacion, 
									cp_proveedor_clase.IdClaseProveedor, cp_proveedor_clase.descripcion_clas_prove, cp_proveedor.IdProveedor,cp_proveedor.pr_codigo, pe_nombreCompleto pr_nombre, 
									cp_proveedor_clase.IdCtaCble_CXP AS IdCtaCble_CXP_clase, cp_proveedor.IdCtaCble_CXP AS IdCtaCble_CXP_provee, ct_cbtecble_tipo.CodTipoCbte, 
									ct_cbtecble_tipo.tc_TipoCbte, CASE WHEN DET.dc_Valor > 0 THEN ABS(DET.dc_Valor) ELSE 0 END AS Debe, CASE WHEN DET.dc_Valor < 0 THEN ABS(DET.dc_Valor)
									ELSE 0 END AS Haber, det.dc_Valor, 'OP-' + CAST(cp_orden_pago.IdOrdenPago AS varchar(20)) +' / '+ LTRIM(RTRIM(ct_cbtecble_tipo.CodTipoCbte))+'-' +CAST( DET.IdCbteCble AS VARCHAR(20)) AS referencia, 
									1 AS Secuencia_rpt
						FROM            ct_cbtecble_tipo INNER JOIN
									ct_plancta AS ct_plancta_1 INNER JOIN
									ct_cbtecble AS cab INNER JOIN
									ct_cbtecble_det AS det ON cab.IdEmpresa = det.IdEmpresa AND cab.IdTipoCbte = det.IdTipoCbte AND cab.IdCbteCble = det.IdCbteCble ON 
									ct_plancta_1.IdEmpresa = det.IdEmpresa AND ct_plancta_1.IdCtaCble = det.IdCtaCble ON ct_cbtecble_tipo.IdEmpresa = cab.IdEmpresa AND 
									ct_cbtecble_tipo.IdTipoCbte = cab.IdTipoCbte INNER JOIN
									cp_orden_pago_det ON cab.IdEmpresa = cp_orden_pago_det.IdEmpresa_cxp AND cab.IdTipoCbte = cp_orden_pago_det.IdTipoCbte_cxp AND 
									cab.IdCbteCble = cp_orden_pago_det.IdCbteCble_cxp INNER JOIN
									cp_orden_pago ON cp_orden_pago_det.IdEmpresa = cp_orden_pago.IdEmpresa AND cp_orden_pago_det.IdOrdenPago = cp_orden_pago.IdOrdenPago INNER JOIN
									cp_proveedor_clase INNER JOIN
									cp_proveedor ON cp_proveedor_clase.IdEmpresa = cp_proveedor.IdEmpresa AND cp_proveedor_clase.IdClaseProveedor = cp_proveedor.IdClaseProveedor ON 
									cp_orden_pago.IdEmpresa = cp_proveedor.IdEmpresa AND cp_orden_pago.IdEntidad = cp_proveedor.IdProveedor AND 
									cp_orden_pago.IdPersona = cp_proveedor.IdPersona
									inner join tb_persona as per on cp_proveedor.IdPersona = per.IdPersona
						WHERE        (cp_orden_pago.IdTipo_Persona = 'PROVEE') AND (NOT EXISTS
										(SELECT        IdEmpresa
										FROM            cp_orden_giro AS og
										WHERE        (IdEmpresa = cab.IdEmpresa) AND (IdTipoCbte_Ogiro = cab.IdTipoCbte) AND (IdCbteCble_Ogiro = cab.IdCbteCble))) AND (NOT EXISTS
										(SELECT        IdEmpresa
										FROM            cp_nota_DebCre AS nd
										WHERE        (IdEmpresa = cab.IdEmpresa) AND (IdTipoCbte_Nota = cab.IdTipoCbte) AND (IdCbteCble_Nota = cab.IdCbteCble)))
										and cp_orden_pago.IdEmpresa = @IdEmpresa and cp_orden_pago.IdEntidad between @IdProveedor_ini and @IdProveedor_fin and cp_proveedor.IdClaseProveedor between @IdClaseProveedor_ini and @IdClaseProveedor_fin
										 and exists(
								select clase.IdEmpresa from cp_proveedor_clase clase
								where clase.IdEmpresa = det.IdEmpresa
								and clase.IdCtaCble_CXP = det.IdCtaCble
								)and cp_orden_pago.Fecha between @Fecha_ini and @Fecha_fin AND cp_orden_pago.Estado = 'A'
				union
				--RETENCION
						SELECT        det.IdEmpresa, det.IdTipoCbte, det.IdCbteCble, det.secuencia, ct_plancta_det.IdCtaCble, ct_plancta_det.pc_Cuenta, cp_retencion.fecha, cab.cb_Observacion, 
										cp_proveedor_clase.IdClaseProveedor, cp_proveedor_clase.descripcion_clas_prove, cp_proveedor.IdProveedor,cp_proveedor.pr_codigo, pe_nombreCompleto pr_nombre, 
										cp_proveedor_clase.IdCtaCble_CXP AS IdCtaCble_CXP_clase, cp_proveedor.IdCtaCble_CXP AS IdCtaCble_CXP_provee,
										ct_cbtecble_tipo.CodTipoCbte, ct_cbtecble_tipo.tc_TipoCbte, 
										CASE WHEN DET.dc_Valor > 0 THEN ABS(DET.dc_Valor) ELSE 0 END AS Debe,
										CASE WHEN DET.dc_Valor < 0 THEN ABS(DET.dc_Valor) ELSE 0 END AS Haber,
										DET.dc_Valor,
										ltrim(rtrim(ct_cbtecble_tipo.CodTipoCbte)) +'-'+ cp_retencion.NumRetencion as referencia,
										2 AS Secuencia_rpt       
						FROM            ct_plancta AS ct_plancta_det INNER JOIN
										cp_retencion INNER JOIN
										cp_retencion_x_ct_cbtecble ON cp_retencion.IdEmpresa = cp_retencion_x_ct_cbtecble.rt_IdEmpresa AND 
										cp_retencion.IdRetencion = cp_retencion_x_ct_cbtecble.rt_IdRetencion INNER JOIN
										ct_cbtecble AS cab ON cp_retencion_x_ct_cbtecble.ct_IdEmpresa = cab.IdEmpresa AND cp_retencion_x_ct_cbtecble.ct_IdTipoCbte = cab.IdTipoCbte AND 
										cp_retencion_x_ct_cbtecble.ct_IdCbteCble = cab.IdCbteCble INNER JOIN
										ct_cbtecble_det AS det ON cab.IdEmpresa = det.IdEmpresa AND cab.IdTipoCbte = det.IdTipoCbte AND cab.IdCbteCble = det.IdCbteCble INNER JOIN
										ct_cbtecble_tipo ON cab.IdEmpresa = ct_cbtecble_tipo.IdEmpresa AND cab.IdTipoCbte = ct_cbtecble_tipo.IdTipoCbte ON 
										ct_plancta_det.IdEmpresa = det.IdEmpresa AND ct_plancta_det.IdCtaCble = det.IdCtaCble INNER JOIN
										cp_proveedor INNER JOIN
										cp_proveedor_clase ON cp_proveedor.IdEmpresa = cp_proveedor_clase.IdEmpresa AND 
										cp_proveedor.IdClaseProveedor = cp_proveedor_clase.IdClaseProveedor ON det.IdEmpresa = cp_proveedor_clase.IdEmpresa INNER JOIN
										cp_orden_giro ON cp_proveedor.IdEmpresa = cp_orden_giro.IdEmpresa AND cp_proveedor.IdProveedor = cp_orden_giro.IdProveedor AND 
										cp_retencion.IdEmpresa_Ogiro = cp_orden_giro.IdEmpresa AND cp_retencion.IdCbteCble_Ogiro = cp_orden_giro.IdCbteCble_Ogiro AND 
										cp_retencion.IdTipoCbte_Ogiro = cp_orden_giro.IdTipoCbte_Ogiro
										inner join tb_persona as per on cp_proveedor.IdPersona = per.IdPersona
									where cp_orden_giro.IdEmpresa = @IdEmpresa and cp_orden_giro.IdProveedor between @IdProveedor_ini and @IdProveedor_fin and cp_proveedor.IdClaseProveedor between @IdClaseProveedor_ini and @IdClaseProveedor_fin
									 and exists(
									select clase.IdEmpresa from cp_proveedor_clase clase
									where clase.IdEmpresa = det.IdEmpresa
									and clase.IdCtaCble_CXP = det.IdCtaCble
									)and cp_retencion.fecha between @Fecha_ini and @Fecha_fin AND cp_retencion.Estado = 'A'
				UNION
				--NC
							SELECT			det.IdEmpresa, det.IdTipoCbte, det.IdCbteCble, det.secuencia, ct_plancta.IdCtaCble, ct_plancta.pc_Cuenta,  cp_nota_DebCre.cn_fecha, cp_nota_DebCre.cn_observacion, 
											cp_proveedor_clase.IdClaseProveedor, cp_proveedor_clase.descripcion_clas_prove, cp_proveedor.IdProveedor,cp_proveedor.pr_codigo, pe_nombreCompleto pr_nombre, 
											cp_proveedor_clase.IdCtaCble_CXP AS IdCtaCble_CXP_clase, cp_proveedor.IdCtaCble_CXP AS IdCtaCble_CXP_provee, ct_cbtecble_tipo.CodTipoCbte, 
											ct_cbtecble_tipo.tc_TipoCbte, 

											CASE WHEN DET.dc_Valor > 0  THEN abs(DET.dc_Valor)						 
											ELSE 0 END AS Debe, 

											CASE WHEN DET.dc_Valor < 0  THEN abs(DET.dc_Valor)	
											ELSE 0 END AS Haber, 
						  						  
											DET.dc_Valor,

											LTRIM(RTRIM(ct_cbtecble_tipo.CodTipoCbte)) + '-' + cp_nota_DebCre.cod_nota AS referencia						  
											,3 AS Secuencia_rpt
							FROM            ct_cbtecble_det AS det INNER JOIN
											ct_cbtecble AS cab ON det.IdEmpresa = cab.IdEmpresa AND det.IdTipoCbte = cab.IdTipoCbte AND det.IdCbteCble = cab.IdCbteCble INNER JOIN
											cp_nota_DebCre ON cab.IdEmpresa = cp_nota_DebCre.IdEmpresa AND cab.IdTipoCbte = cp_nota_DebCre.IdTipoCbte_Nota AND 
											cab.IdCbteCble = cp_nota_DebCre.IdCbteCble_Nota INNER JOIN
											ct_plancta ON det.IdEmpresa = ct_plancta.IdEmpresa AND det.IdCtaCble = ct_plancta.IdCtaCble INNER JOIN
											cp_proveedor ON cp_nota_DebCre.IdProveedor = cp_proveedor.IdProveedor AND cp_nota_DebCre.IdEmpresa = cp_proveedor.IdEmpresa INNER JOIN
											cp_proveedor_clase ON cp_proveedor.IdEmpresa = cp_proveedor_clase.IdEmpresa AND 
											cp_proveedor.IdClaseProveedor = cp_proveedor_clase.IdClaseProveedor INNER JOIN
											ct_cbtecble_tipo ON cab.IdEmpresa = ct_cbtecble_tipo.IdEmpresa AND cab.IdTipoCbte = ct_cbtecble_tipo.IdTipoCbte
											inner join tb_persona as per on per.IdPersona = cp_proveedor.IdPersona
							where cp_nota_DebCre.IdEmpresa = @IdEmpresa and cp_nota_DebCre.IdProveedor between @IdProveedor_ini and @IdProveedor_fin and cp_proveedor.IdClaseProveedor between @IdClaseProveedor_ini and @IdClaseProveedor_fin
							 and cp_nota_DebCre.DebCre = 'C' AND cp_nota_DebCre.Estado ='A' and exists(
										select clase.IdEmpresa from cp_proveedor_clase clase
										where clase.IdEmpresa = det.IdEmpresa
										and clase.IdCtaCble_CXP = det.IdCtaCble
										) and cp_nota_DebCre.cn_fecha between @Fecha_ini and @Fecha_fin and cp_nota_DebCre.Estado = 'A' and det.dc_Valor > 0
				UNION
				--CONCILIACION OG
							SELECT        ct_cbtecble_det.IdEmpresa, ct_cbtecble_det.IdTipoCbte, ct_cbtecble_det.IdCbteCble, ct_cbtecble_det.secuencia, ct_plancta.IdCtaCble, ct_plancta.pc_Cuenta, ct_cbtecble.cb_Fecha as cb_Fecha, ct_cbtecble.cb_Observacion, 
							cp_proveedor_clase.IdClaseProveedor, cp_proveedor_clase.descripcion_clas_prove, cp_proveedor.IdProveedor,cp_proveedor.pr_codigo , pe_nombreCompleto pr_nombre, 
							cp_proveedor_clase.IdCtaCble_CXP AS IdCtaCble_CXP_clase, cp_proveedor.IdCtaCble_CXP AS IdCtaCble_CXP_provee, ct_cbtecble_tipo.CodTipoCbte, 
							ct_cbtecble_tipo.tc_TipoCbte, CASE WHEN ct_cbtecble_det.dc_Valor > 0 THEN ABS(ct_cbtecble_det.dc_Valor) ELSE 0 END AS Debe, CASE WHEN ct_cbtecble_det.dc_Valor < 0 THEN ABS(ct_cbtecble_det.dc_Valor)
							ELSE 0 END AS Haber, ct_cbtecble_det.dc_Valor, 'CONCI-'+ cast(cp_conciliacion.IdConciliacion as varchar(20)) +' / '+LTRIM(RTRIM(ct_cbtecble_tipo.CodTipoCbte)) + '-' + cast(ct_cbtecble.IdCbteCble as varchar(20)) AS referencia, 3 AS Secuencia_rpt
							FROM            cp_conciliacion INNER JOIN
							cp_orden_pago_cancelaciones ON cp_conciliacion.IdEmpresa = cp_orden_pago_cancelaciones.IdEmpresa AND 
							cp_conciliacion.IdCancelacion = cp_orden_pago_cancelaciones.Idcancelacion INNER JOIN
							ct_cbtecble_tipo ON cp_orden_pago_cancelaciones.IdEmpresa_pago = ct_cbtecble_tipo.IdEmpresa AND 
							cp_orden_pago_cancelaciones.IdTipoCbte_pago = ct_cbtecble_tipo.IdTipoCbte INNER JOIN
							cp_orden_giro ON cp_orden_pago_cancelaciones.IdEmpresa_cxp = cp_orden_giro.IdEmpresa AND 
							cp_orden_pago_cancelaciones.IdTipoCbte_cxp = cp_orden_giro.IdTipoCbte_Ogiro AND 
							cp_orden_pago_cancelaciones.IdCbteCble_cxp = cp_orden_giro.IdCbteCble_Ogiro INNER JOIN
							ct_cbtecble_det ON cp_orden_pago_cancelaciones.IdEmpresa_pago = ct_cbtecble_det.IdEmpresa AND 
							cp_orden_pago_cancelaciones.IdTipoCbte_pago = ct_cbtecble_det.IdTipoCbte AND 
							cp_orden_pago_cancelaciones.IdCbteCble_pago = ct_cbtecble_det.IdCbteCble INNER JOIN
							cp_proveedor ON cp_orden_giro.IdEmpresa = cp_proveedor.IdEmpresa AND cp_orden_giro.IdProveedor = cp_proveedor.IdProveedor INNER JOIN
							cp_proveedor_clase ON cp_proveedor.IdEmpresa = cp_proveedor_clase.IdEmpresa AND 
							cp_proveedor.IdClaseProveedor = cp_proveedor_clase.IdClaseProveedor INNER JOIN
							ct_cbtecble ON ct_cbtecble_det.IdEmpresa = ct_cbtecble.IdEmpresa AND ct_cbtecble_det.IdTipoCbte = ct_cbtecble.IdTipoCbte AND 
							ct_cbtecble_det.IdCbteCble = ct_cbtecble.IdCbteCble
							inner join ct_plancta on ct_plancta.IdEmpresa = ct_cbtecble_det.IdEmpresa
							and ct_plancta.IdCtaCble = ct_cbtecble_det.IdCtaCble
							inner join tb_persona as per on per.IdPersona = cp_proveedor.IdPersona
							WHERE       cp_orden_giro.IdEmpresa = @IdEmpresa and cp_orden_giro.IdProveedor between @IdProveedor_ini and @IdProveedor_fin and cp_proveedor.IdClaseProveedor between @IdClaseProveedor_ini and @IdClaseProveedor_fin
							and	ct_cbtecble.cb_Fecha between @Fecha_ini and @Fecha_fin and		
							(NOT EXISTS
								(SELECT        IdEmpresa
								FROM            cp_nota_DebCre AS cre
								WHERE        (IdEmpresa = cp_orden_pago_cancelaciones.IdEmpresa_pago) AND (IdTipoCbte_Nota = cp_orden_pago_cancelaciones.IdTipoCbte_pago) AND 
															(IdCbteCble_Nota = cp_orden_pago_cancelaciones.IdCbteCble_pago))) 
															AND EXISTS
								(SELECT        IdEmpresa
								FROM            cp_proveedor_clase AS clase
								WHERE        (IdEmpresa = ct_cbtecble_det.IdEmpresa) AND (IdCtaCble_CXP = ct_cbtecble_det.IdCtaCble)) 
						
				UNION
				--CONCILIACION OG
							SELECT        ct_cbtecble_det.IdEmpresa, ct_cbtecble_det.IdTipoCbte, ct_cbtecble_det.IdCbteCble, ct_cbtecble_det.secuencia, ct_plancta.IdCtaCble, ct_plancta.pc_Cuenta, ct_cbtecble.cb_Fecha as cb_Fecha, ct_cbtecble.cb_Observacion, 
							cp_proveedor_clase.IdClaseProveedor, cp_proveedor_clase.descripcion_clas_prove, cp_proveedor.IdProveedor,cp_proveedor.pr_codigo , pe_nombreCompleto pr_nombre, 
							cp_proveedor_clase.IdCtaCble_CXP AS IdCtaCble_CXP_clase, cp_proveedor.IdCtaCble_CXP AS IdCtaCble_CXP_provee, ct_cbtecble_tipo.CodTipoCbte, 
							ct_cbtecble_tipo.tc_TipoCbte, CASE WHEN ct_cbtecble_det.dc_Valor > 0 THEN ABS(ct_cbtecble_det.dc_Valor) ELSE 0 END AS Debe, CASE WHEN ct_cbtecble_det.dc_Valor < 0 THEN ABS(ct_cbtecble_det.dc_Valor)
							ELSE 0 END AS Haber, ct_cbtecble_det.dc_Valor, 'CONCI-'+ cast(cp_conciliacion.IdConciliacion as varchar(20)) +' / '+LTRIM(RTRIM(ct_cbtecble_tipo.CodTipoCbte)) + '-' + cast(ct_cbtecble.IdCbteCble as varchar(20)) AS referencia, 3 AS Secuencia_rpt
							FROM            cp_conciliacion INNER JOIN
							cp_orden_pago_cancelaciones ON cp_conciliacion.IdEmpresa = cp_orden_pago_cancelaciones.IdEmpresa AND 
							cp_conciliacion.IdCancelacion = cp_orden_pago_cancelaciones.Idcancelacion INNER JOIN
							ct_cbtecble_tipo ON cp_orden_pago_cancelaciones.IdEmpresa_pago = ct_cbtecble_tipo.IdEmpresa AND 
							cp_orden_pago_cancelaciones.IdTipoCbte_pago = ct_cbtecble_tipo.IdTipoCbte INNER JOIN
							cp_nota_DebCre ON cp_orden_pago_cancelaciones.IdEmpresa_cxp = cp_nota_DebCre.IdEmpresa AND 
							cp_orden_pago_cancelaciones.IdTipoCbte_cxp = cp_nota_DebCre.IdTipoCbte_Nota AND 
							cp_orden_pago_cancelaciones.IdCbteCble_cxp = cp_nota_DebCre.IdCbteCble_Nota INNER JOIN
							ct_cbtecble_det ON cp_orden_pago_cancelaciones.IdEmpresa_pago = ct_cbtecble_det.IdEmpresa AND 
							cp_orden_pago_cancelaciones.IdTipoCbte_pago = ct_cbtecble_det.IdTipoCbte AND 
							cp_orden_pago_cancelaciones.IdCbteCble_pago = ct_cbtecble_det.IdCbteCble INNER JOIN
							cp_proveedor ON cp_nota_DebCre.IdEmpresa = cp_proveedor.IdEmpresa AND cp_nota_DebCre.IdProveedor = cp_proveedor.IdProveedor INNER JOIN
							cp_proveedor_clase ON cp_proveedor.IdEmpresa = cp_proveedor_clase.IdEmpresa AND 
							cp_proveedor.IdClaseProveedor = cp_proveedor_clase.IdClaseProveedor INNER JOIN
							ct_cbtecble ON ct_cbtecble_det.IdEmpresa = ct_cbtecble.IdEmpresa AND ct_cbtecble_det.IdTipoCbte = ct_cbtecble.IdTipoCbte AND 
							ct_cbtecble_det.IdCbteCble = ct_cbtecble.IdCbteCble
							inner join ct_plancta on ct_plancta.IdEmpresa = ct_cbtecble_det.IdEmpresa
							and ct_plancta.IdCtaCble = ct_cbtecble_det.IdCtaCble
							inner join tb_persona as per on cp_proveedor.IdPersona = per.IdPersona
							WHERE       cp_nota_DebCre.IdEmpresa = @IdEmpresa and cp_nota_DebCre.IdProveedor between @IdProveedor_ini and @IdProveedor_fin and cp_proveedor.IdClaseProveedor between @IdClaseProveedor_ini and @IdClaseProveedor_fin
							and	ct_cbtecble.cb_Fecha between @Fecha_ini and @Fecha_fin and		
							(NOT EXISTS
								(SELECT        IdEmpresa
								FROM            cp_nota_DebCre AS cre
								WHERE        (IdEmpresa = cp_orden_pago_cancelaciones.IdEmpresa_pago) AND (IdTipoCbte_Nota = cp_orden_pago_cancelaciones.IdTipoCbte_pago) AND 
															(IdCbteCble_Nota = cp_orden_pago_cancelaciones.IdCbteCble_pago))) 
															AND EXISTS
								(SELECT        IdEmpresa
								FROM            cp_proveedor_clase AS clase
								WHERE        (IdEmpresa = ct_cbtecble_det.IdEmpresa) AND (IdCtaCble_CXP = ct_cbtecble_det.IdCtaCble)) 
						
				UNION
				--PAGOS BANCARIOS
				SELECT        det.IdEmpresa, det.IdTipoCbte, det.IdCbteCble, det.secuencia, ct_plancta_1.IdCtaCble, ct_plancta_1.pc_Cuenta, cab.cb_Fecha, cab.cb_Observacion, 
								cp_proveedor_clase.IdClaseProveedor, cp_proveedor_clase.descripcion_clas_prove, cp_proveedor.IdProveedor, cp_proveedor.pr_codigo, pe_nombreCompleto pr_nombre, 
								cp_proveedor_clase.IdCtaCble_CXP AS IdCtaCble_CXP_clase, cp_proveedor.IdCtaCble_CXP AS IdCtaCble_CXP_provee, ct_cbtecble_tipo.CodTipoCbte, 
								ct_cbtecble_tipo.tc_TipoCbte, CASE WHEN DET.dc_Valor > 0 THEN ABS(DET.dc_Valor) ELSE 0 END AS Debe, CASE WHEN DET.dc_Valor < 0 THEN ABS(DET.dc_Valor)
								ELSE 0 END AS Haber, det.dc_Valor, CASE WHEN ba_Cbte_Ban.cb_Cheque is null THEN LTRIM(RTRIM(ct_cbtecble_tipo.CodTipoCbte)) + '-' + CAST(ba_Cbte_Ban.IdCbteCble AS VARCHAR)
								ELSE LTRIM(RTRIM(ct_cbtecble_tipo.CodTipoCbte)) + '-' + ba_Cbte_Ban.cb_Cheque END AS referencia , 
								3 AS Secuencia_rpt
				FROM            cp_orden_pago INNER JOIN
								cp_orden_pago_det ON cp_orden_pago.IdEmpresa = cp_orden_pago_det.IdEmpresa AND 
								cp_orden_pago.IdOrdenPago = cp_orden_pago_det.IdOrdenPago INNER JOIN
								cp_proveedor_clase INNER JOIN
								cp_proveedor ON cp_proveedor_clase.IdEmpresa = cp_proveedor.IdEmpresa AND cp_proveedor_clase.IdClaseProveedor = cp_proveedor.IdClaseProveedor ON 
								cp_orden_pago.IdEmpresa = cp_proveedor.IdEmpresa AND cp_orden_pago.IdEntidad = cp_proveedor.IdProveedor AND 
								cp_orden_pago.IdPersona = cp_proveedor.IdPersona INNER JOIN
								cp_orden_pago_cancelaciones ON cp_orden_pago_det.IdEmpresa_cxp = cp_orden_pago_cancelaciones.IdEmpresa_cxp AND 
								cp_orden_pago_det.IdCbteCble_cxp = cp_orden_pago_cancelaciones.IdCbteCble_cxp AND 
								cp_orden_pago_det.IdTipoCbte_cxp = cp_orden_pago_cancelaciones.IdTipoCbte_cxp AND 
								cp_orden_pago_det.IdEmpresa = cp_orden_pago_cancelaciones.IdEmpresa_op AND 
								cp_orden_pago_det.IdOrdenPago = cp_orden_pago_cancelaciones.IdOrdenPago_op AND 
								cp_orden_pago_det.Secuencia = cp_orden_pago_cancelaciones.Secuencia_op INNER JOIN
								ct_cbtecble_tipo INNER JOIN
								ct_plancta AS ct_plancta_1 INNER JOIN
								ct_cbtecble AS cab INNER JOIN
								ct_cbtecble_det AS det ON cab.IdEmpresa = det.IdEmpresa AND cab.IdTipoCbte = det.IdTipoCbte AND cab.IdCbteCble = det.IdCbteCble ON 
								ct_plancta_1.IdEmpresa = det.IdEmpresa AND ct_plancta_1.IdCtaCble = det.IdCtaCble ON ct_cbtecble_tipo.IdEmpresa = cab.IdEmpresa AND 
								ct_cbtecble_tipo.IdTipoCbte = cab.IdTipoCbte ON cp_orden_pago_cancelaciones.IdEmpresa_pago = cab.IdEmpresa AND 
								cp_orden_pago_cancelaciones.IdTipoCbte_pago = cab.IdTipoCbte AND cp_orden_pago_cancelaciones.IdCbteCble_pago = cab.IdCbteCble INNER JOIN
								ba_Cbte_Ban ON cab.IdEmpresa = ba_Cbte_Ban.IdEmpresa AND cab.IdTipoCbte = ba_Cbte_Ban.IdTipocbte AND cab.IdCbteCble = ba_Cbte_Ban.IdCbteCble
								inner join tb_persona as per on cp_proveedor.IdPersona = per.IdPersona
				WHERE        (cp_orden_pago.IdTipo_Persona = 'PROVEE') AND (cp_orden_pago.IdEmpresa = @IdEmpresa) AND (cp_orden_pago.IdEntidad between @IdProveedor_ini and @IdProveedor_fin) and cp_proveedor.IdClaseProveedor between @IdClaseProveedor_ini and @IdClaseProveedor_fin
							 AND (ba_Cbte_Ban.cb_Fecha BETWEEN 
								@Fecha_ini AND @Fecha_fin) AND (cp_orden_pago.Estado = 'A') AND EXISTS
									(SELECT        IdEmpresa
									FROM            cp_proveedor_clase AS clase
									WHERE        (IdEmpresa = det.IdEmpresa) AND (IdCtaCble_CXP = det.IdCtaCble))
				UNION
				SELECT        cp_proveedor.IdEmpresa, 0 IdTipoCbte, 0 IdCbteCble, 0 secuencia, NULL IdCtaCble, NULL pc_Cuenta, @Fecha_fin, 'No existen movimientos'cb_Observacion, 
								cp_proveedor_clase.IdClaseProveedor, cp_proveedor_clase.descripcion_clas_prove, cp_proveedor.IdProveedor, cp_proveedor.pr_codigo, pe_nombreCompleto pr_nombre, 
								cp_proveedor_clase.IdCtaCble_CXP AS IdCtaCble_CXP_clase, cp_proveedor.IdCtaCble_CXP AS IdCtaCble_CXP_provee, 'NADA' CodTipoCbte, 
								'NADA' tc_TipoCbte, 0 AS Debe, 0 AS Haber, 0 dc_Valor, 'Sin movimientos' AS referencia , 
								0 AS Secuencia_rpt
				FROM     cp_proveedor INNER JOIN
                         cp_proveedor_clase ON cp_proveedor.IdEmpresa = cp_proveedor_clase.IdEmpresa AND cp_proveedor.IdClaseProveedor = cp_proveedor_clase.IdClaseProveedor
						 inner join tb_persona as per on cp_proveedor.IdPersona = per.IdPersona
				where cp_proveedor.IdProveedor between @IdProveedor_ini and @IdProveedor_fin and cp_proveedor.IdClaseProveedor between @IdClaseProveedor_ini and @IdClaseProveedor_fin
				 AND cp_proveedor.IdEmpresa = @IdEmpresa and @Movimientos_en_rango = 0 
						
						
				) A
ORDER BY A.IdEmpresa,a.IdClaseProveedor, A.IdProveedor, A.cb_Fecha,  a.IdTipoCbte, a.IdCbteCble, a.secuencia, A.Secuencia_rpt

END