CREATE VIEW [dbo].[vwro_empleado_novedad_det]
	AS SELECT        dbo.ro_empleado_novedad_det.IdEmpresa, dbo.ro_empleado_novedad_det.IdNovedad, dbo.ro_empleado_novedad_det.Secuencia, dbo.ro_empleado_novedad_det.Observacion, dbo.ro_empleado_novedad_det.IdRubro, 
                         dbo.ro_empleado_novedad_det.FechaPago, dbo.ro_empleado_novedad_det.Valor, dbo.ro_empleado_novedad_det.EstadoCobro, dbo.ro_rubro_tipo.ru_descripcion
FROM            dbo.ro_empleado_novedad_det LEFT OUTER JOIN
                         dbo.ro_rubro_tipo ON dbo.ro_empleado_novedad_det.IdEmpresa = dbo.ro_rubro_tipo.IdEmpresa AND dbo.ro_empleado_novedad_det.IdRubro = dbo.ro_rubro_tipo.IdRubro
