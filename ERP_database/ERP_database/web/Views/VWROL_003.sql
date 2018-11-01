CREATE VIEW web.VWROL_003 as
SELECT        dbo.ro_empleado.IdEmpresa, dbo.ro_empleado.IdEmpleado, dbo.tb_persona.IdPersona, dbo.ro_empleado_Novedad.IdNovedad, dbo.ro_empleado_novedad_det.FechaPago, dbo.ro_empleado_novedad_det.Valor, 
                         dbo.ro_empleado_Novedad.Fecha_Transac, dbo.ro_cargo.ca_descripcion, dbo.tb_persona.pe_apellido, dbo.tb_persona.pe_nombre, dbo.tb_persona.pe_cedulaRuc, dbo.ro_Nomina_Tipoliqui.DescripcionProcesoNomina, 
                         dbo.ro_empleado_novedad_det.Observacion, dbo.ro_Nomina_Tipo.Descripcion, dbo.ro_rubro_tipo.rub_Acuerdo_Descuento, dbo.ro_rubro_tipo.ru_descripcion, dbo.ro_catalogo.ca_descripcion AS EstadoCobro,
						  dbo.ro_empleado_Novedad.TotalValor
FROM            dbo.ro_empleado INNER JOIN
                         dbo.ro_empleado_x_ro_tipoNomina ON dbo.ro_empleado.IdEmpresa = dbo.ro_empleado_x_ro_tipoNomina.IdEmpresa AND dbo.ro_empleado.IdEmpleado = dbo.ro_empleado_x_ro_tipoNomina.IdEmpleado INNER JOIN
                         dbo.ro_Nomina_Tipo ON dbo.ro_empleado_x_ro_tipoNomina.IdEmpresa = dbo.ro_Nomina_Tipo.IdEmpresa AND dbo.ro_empleado_x_ro_tipoNomina.IdTipoNomina = dbo.ro_Nomina_Tipo.IdNomina_Tipo INNER JOIN
                         dbo.ro_empleado_Novedad ON dbo.ro_empleado.IdEmpresa = dbo.ro_empleado_Novedad.IdEmpresa AND dbo.ro_empleado.IdEmpleado = dbo.ro_empleado_Novedad.IdEmpleado INNER JOIN
                         dbo.ro_empleado_novedad_det ON dbo.ro_empleado_Novedad.IdEmpresa = dbo.ro_empleado_novedad_det.IdEmpresa AND dbo.ro_empleado_Novedad.IdNovedad = dbo.ro_empleado_novedad_det.IdNovedad AND 
                         dbo.ro_empleado_Novedad.IdEmpleado = dbo.ro_empleado_novedad_det.IdEmpleado INNER JOIN
                         dbo.ro_cargo ON dbo.ro_empleado.IdEmpresa = dbo.ro_cargo.IdEmpresa AND dbo.ro_empleado.IdCargo = dbo.ro_cargo.IdCargo INNER JOIN
                         dbo.tb_persona ON dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.ro_Nomina_Tipoliqui ON dbo.ro_empleado_novedad_det.IdEmpresa = dbo.ro_Nomina_Tipoliqui.IdEmpresa AND dbo.ro_empleado_novedad_det.IdNomina_tipo = dbo.ro_Nomina_Tipoliqui.IdNomina_Tipo AND 
                         dbo.ro_empleado_novedad_det.IdNomina_Tipo_Liq = dbo.ro_Nomina_Tipoliqui.IdNomina_TipoLiqui INNER JOIN
                         dbo.ro_rubro_tipo ON dbo.ro_empleado_novedad_det.IdRubro = dbo.ro_rubro_tipo.IdRubro AND dbo.ro_empleado_novedad_det.IdEmpresa = dbo.ro_rubro_tipo.IdEmpresa INNER JOIN
                         dbo.ro_catalogo ON dbo.ro_empleado_novedad_det.EstadoCobro = dbo.ro_catalogo.CodCatalogo
