
CREATE view [dbo].[vwCONTA_Rpt004]
as
SELECT        IdEmpresa, IdCtaCble, pc_Cuenta, IdCtaCblePadre, pc_Naturaleza, IdNivelCta, IdGrupoCble, null IdTipoCtaCble, pc_Estado, pc_EsMovimiento, null pc_es_flujo_efectivo, 
                         pc_clave_corta
FROM            dbo.ct_plancta