CREATE VIEW vwAf_Activo_fijo_cuentas_para_contabilizar_por_tipo
AS
SELECT  Af_Activo_fijo.IdEmpresa, Af_Activo_fijo.IdActivoFijo, Af_Parametros.IdCtaCble_Activo, Af_Parametros.IdCtaCble_Dep_Acum, Af_Parametros.IdCtaCble_Gastos_Depre, 'Por_CtaCble' as tipo
FROM            Af_Activo_fijo INNER JOIN
                         Af_Parametros ON Af_Activo_fijo.IdEmpresa = Af_Parametros.IdEmpresa
UNION ALL
SELECT   Af_Activo_fijo.IdEmpresa, Af_Activo_fijo.IdActivoFijo, Af_Activo_fijo_tipo.IdCtaCble_Activo, Af_Activo_fijo_tipo.IdCtaCble_Dep_Acum, Af_Activo_fijo_tipo.IdCtaCble_Gastos_Depre, 'Por_Tipo_CtaCble'
FROM            Af_Activo_fijo INNER JOIN
                         Af_Activo_fijo_tipo ON Af_Activo_fijo.IdEmpresa = Af_Activo_fijo_tipo.IdEmpresa AND Af_Activo_fijo.IdActivoFijoTipo = Af_Activo_fijo_tipo.IdActivoFijoTipo
UNION ALL

SELECT A.IdEmpresa, A.IdActivoFijo, MAX(A.IdCtaCble_Activo), MAX(A.IdCtaCble_depre_acum), MAX(A.IdCtaCble_gasto_depre), 'Por_Activo'
FROM (
SELECT        Af_Activo_fijo.IdEmpresa, Af_Activo_fijo.IdActivoFijo, Af_Activo_fijo_CtasCbles.IdTipoCuenta, Af_Activo_fijo_CtasCbles.IdCtaCble as IdCtaCble_Activo, null IdCtaCble_depre_acum, null IdCtaCble_gasto_depre
FROM            Af_Activo_fijo INNER JOIN
                         Af_Activo_fijo_CtasCbles ON Af_Activo_fijo.IdEmpresa = Af_Activo_fijo_CtasCbles.IdEmpresa AND Af_Activo_fijo.IdActivoFijo = Af_Activo_fijo_CtasCbles.IdActivoFijo
WHERE Af_Activo_fijo_CtasCbles.IdTipoCuenta = 'CTA_ACTIVO'
UNION ALL
SELECT        Af_Activo_fijo.IdEmpresa, Af_Activo_fijo.IdActivoFijo, Af_Activo_fijo_CtasCbles.IdTipoCuenta, null, Af_Activo_fijo_CtasCbles.IdCtaCble as IdCtaCble_depre_acum,null
FROM            Af_Activo_fijo INNER JOIN
                         Af_Activo_fijo_CtasCbles ON Af_Activo_fijo.IdEmpresa = Af_Activo_fijo_CtasCbles.IdEmpresa AND Af_Activo_fijo.IdActivoFijo = Af_Activo_fijo_CtasCbles.IdActivoFijo
WHERE Af_Activo_fijo_CtasCbles.IdTipoCuenta = 'CTA_DEPRE_ACUM'
UNION ALL
SELECT        Af_Activo_fijo.IdEmpresa, Af_Activo_fijo.IdActivoFijo, Af_Activo_fijo_CtasCbles.IdTipoCuenta, null, null, Af_Activo_fijo_CtasCbles.IdCtaCble as IdCtaCble_gasto_depre
FROM            Af_Activo_fijo INNER JOIN
                         Af_Activo_fijo_CtasCbles ON Af_Activo_fijo.IdEmpresa = Af_Activo_fijo_CtasCbles.IdEmpresa AND Af_Activo_fijo.IdActivoFijo = Af_Activo_fijo_CtasCbles.IdActivoFijo
WHERE Af_Activo_fijo_CtasCbles.IdTipoCuenta = 'CTA_GASTOS_DEPRE') A
GROUP BY A.IdEmpresa, A.IdActivoFijo
