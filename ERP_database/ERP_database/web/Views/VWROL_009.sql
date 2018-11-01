create view  web.VWROL_009 as


SELECT        dbo.tb_persona.pe_cedulaRuc AS CedulaRuc, dbo.tb_persona.pe_nombreCompleto AS NombreCompleto, dbo.ro_empleado_novedad_det.IdRubro, dbo.ro_empleado_novedad_det.FechaPago, 
                         dbo.ro_empleado_novedad_det.Valor, dbo.ro_empleado_novedad_det.EstadoCobro, dbo.ro_rubro_tipo.ru_descripcion AS RubroDescripcion, dbo.ro_Division.Descripcion AS Division, 
                         dbo.ro_Departamento.de_descripcion AS Departamento, dbo.ro_empleado_Novedad.IdEmpresa, dbo.ro_empleado_Novedad.IdEmpleado, dbo.ro_empleado.IdDivision, dbo.ro_empleado.em_codigo AS CodigoEmpleado, 
                         dbo.ro_Departamento.IdDepartamento, dbo.tb_persona.pe_apellido, dbo.tb_persona.pe_nombre, dbo.ro_empleado_novedad_det.Num_Horas, dbo.ro_cargo.ca_descripcion
FROM            dbo.ro_empleado_novedad_det INNER JOIN
                         dbo.ro_rubro_tipo ON dbo.ro_empleado_novedad_det.IdRubro = dbo.ro_rubro_tipo.IdRubro AND dbo.ro_empleado_novedad_det.IdEmpresa = dbo.ro_rubro_tipo.IdEmpresa INNER JOIN
                         dbo.ro_empleado ON dbo.ro_empleado_novedad_det.IdEmpresa = dbo.ro_empleado.IdEmpresa INNER JOIN
                         dbo.tb_persona ON dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.ro_empleado_Novedad ON dbo.ro_empleado_novedad_det.IdEmpresa = dbo.ro_empleado_Novedad.IdEmpresa AND dbo.ro_empleado_novedad_det.IdNovedad = dbo.ro_empleado_Novedad.IdNovedad AND 
                         dbo.ro_empleado_novedad_det.IdEmpleado = dbo.ro_empleado_Novedad.IdEmpleado AND dbo.ro_empleado.IdEmpresa = dbo.ro_empleado_Novedad.IdEmpresa AND 
                         dbo.ro_empleado.IdEmpleado = dbo.ro_empleado_Novedad.IdEmpleado INNER JOIN
                         dbo.ro_Division ON dbo.ro_empleado.IdDivision = dbo.ro_Division.IdDivision AND dbo.ro_empleado.IdEmpresa = dbo.ro_Division.IdEmpresa INNER JOIN
                         dbo.ro_Departamento ON dbo.ro_empleado.IdEmpresa = dbo.ro_Departamento.IdEmpresa AND dbo.ro_empleado.IdDepartamento = dbo.ro_Departamento.IdDepartamento INNER JOIN
                         dbo.ro_cargo ON dbo.ro_empleado.IdEmpresa = dbo.ro_cargo.IdEmpresa AND dbo.ro_empleado.IdCargo = dbo.ro_cargo.IdCargo
