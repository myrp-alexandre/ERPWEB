CREATE view web.VWROL_020 as
SELECT     ROW_NUMBER() OVER(ORDER BY archiv.IdEmpresa DESC) AS Secuancia,  

        archiv.IdEmpresa, archiv.IdArchivo, archiv.IdNomina, archiv.IdNominaTipo, archiv.IdPeriodo, archiv.IdCuentaBancaria, archiv.IdProceso, archv_det.Valor, 
                         CASE WHEN emp.em_tipoCta = 'AHO' THEN 'A' WHEN emp.em_tipoCta = 'COR' THEN 'C' ELSE 'E' END AS em_tipoCta, CASE WHEN emp.em_tipoCta = 'VRT' THEN emp.em_NumCta ELSE per.pe_cedulaRuc END AS em_NumCta, 
                         per.pe_apellido + ' ' + per.pe_nombre AS Nombres, per.pe_cedulaRuc, emp.em_codigo, nom_tip.DescripcionProcesoNomina, nom.Descripcion, periodo.pe_FechaIni, periodo.pe_FechaFin
FROM            dbo.ro_archivos_bancos_generacion AS archiv INNER JOIN
                         dbo.ro_archivos_bancos_generacion_x_empleado AS archv_det ON archiv.IdEmpresa = archv_det.IdEmpresa AND archiv.IdArchivo = archv_det.IdArchivo INNER JOIN
                         dbo.ro_empleado AS emp ON archv_det.IdEmpresa = emp.IdEmpresa AND archv_det.IdEmpleado = emp.IdEmpleado INNER JOIN
                         dbo.tb_persona AS per ON emp.IdPersona = per.IdPersona INNER JOIN
                         dbo.ro_periodo_x_ro_Nomina_TipoLiqui AS pe_x_nom ON archiv.IdEmpresa = pe_x_nom.IdEmpresa AND archiv.IdNomina = pe_x_nom.IdNomina_Tipo AND archiv.IdNominaTipo = pe_x_nom.IdNomina_TipoLiqui AND 
                         archiv.IdPeriodo = pe_x_nom.IdPeriodo INNER JOIN
                         dbo.ro_periodo AS periodo ON pe_x_nom.IdEmpresa = periodo.IdEmpresa AND pe_x_nom.IdPeriodo = periodo.IdPeriodo INNER JOIN
                         dbo.ro_Nomina_Tipo AS nom ON archiv.IdEmpresa = nom.IdEmpresa INNER JOIN
                         dbo.ro_Nomina_Tipoliqui AS nom_tip ON pe_x_nom.IdEmpresa = nom_tip.IdEmpresa AND pe_x_nom.IdNomina_Tipo = nom_tip.IdNomina_Tipo AND pe_x_nom.IdNomina_TipoLiqui = nom_tip.IdNomina_TipoLiqui AND 
                         nom.IdEmpresa = nom_tip.IdEmpresa AND nom.IdNomina_Tipo = nom_tip.IdNomina_Tipo