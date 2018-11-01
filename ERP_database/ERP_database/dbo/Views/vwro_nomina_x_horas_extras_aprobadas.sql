CREATE view vwro_nomina_x_horas_extras_aprobadas as
SELECT        he.IdEmpresa, he.IdHorasExtras, he.IdNominaTipo, he.IdNominaTipoLiqui, he.IdPeriodo, he_det.IdEmpleado,ISNULL( SUM( he_det.Valor25),0)Valor25,ISNULL( sum(he_det.Valor50),0)Valor50,ISNULL( SUM( he_det.Valor100),0)Valor100
FROM            dbo.ro_nomina_x_horas_extras AS he INNER JOIN
                         dbo.ro_nomina_x_horas_extras_det AS he_det ON he.IdEmpresa = he_det.IdEmpresa AND he.IdHorasExtras = he_det.IdHorasExtras
						 where es_HorasExtrasAutorizadas=1
GROUP BY he.IdEmpresa, he.IdHorasExtras, he.IdNominaTipo, he.IdNominaTipoLiqui, he.IdPeriodo, he_det.IdEmpleado