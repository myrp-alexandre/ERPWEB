create view web.VWROL_010 as
						 SELECT        dbo.ro_empleado_x_ro_tipoNomina.IdEmpresa, dbo.ro_empleado_x_ro_tipoNomina.IdEmpleado, dbo.ro_empleado_x_ro_tipoNomina.IdTipoNomina, dbo.tb_persona.pe_cedulaRuc, 
                         dbo.tb_persona.pe_apellido + ' ' + dbo.tb_persona.pe_nombre AS Empleado, dbo.ro_empleado.em_fecha_ingreso, CAST(dbo.ro_empleado.em_fechaSalida AS date) em_fechaSalida, dbo.ro_cargo.ca_descripcion, 
                         dbo.ro_catalogo.ca_descripcion AS EstadoEmpleado, dbo.ro_empleado.IdDivision, dbo.ro_empleado.em_fechaIngaRol, cast(CASE WHEN IIF(em_fechaSalida = NULL, datediff(dayofyear, em_fechaSalida, em_fechaIngaRol), 
                         datediff(dayofyear, em_fechaIngaRol, getdate())) >= 360 THEN IIF(em_fechaSalida = NULL, datediff(dayofyear, em_fechaSalida, em_fechaIngaRol), datediff(dayofyear, em_fechaIngaRol, getdate())) 
                         / 360 ELSE 0 END AS varchar(20)) + ' año(s), ' + cast(CASE WHEN IIF(em_fechaSalida = NULL, datediff(dayofyear, em_fechaSalida, em_fechaIngaRol), datediff(dayofyear, em_fechaIngaRol, getdate())) 
                         >= 30 THEN (IIF(em_fechaSalida = NULL, datediff(dayofyear, em_fechaSalida, em_fechaIngaRol), datediff(dayofyear, em_fechaIngaRol, getdate())) / 30) - (CASE WHEN IIF(em_fechaSalida = NULL, datediff(dayofyear, 
                         em_fechaSalida, em_fechaIngaRol), datediff(dayofyear, em_fechaIngaRol, getdate())) >= 360 THEN IIF(em_fechaSalida = NULL, datediff(dayofyear, em_fechaSalida, em_fechaIngaRol), datediff(dayofyear, em_fechaIngaRol, 
                         getdate())) / 360 ELSE 0 END * 12) ELSE 0 END AS varchar(20)) + ' mes(es)' AS antiguedad_string
FROM            dbo.ro_catalogo INNER JOIN
                         dbo.tb_persona INNER JOIN
                         dbo.ro_empleado ON dbo.tb_persona.IdPersona = dbo.ro_empleado.IdPersona INNER JOIN
                         dbo.ro_empleado_x_ro_tipoNomina ON dbo.ro_empleado.IdEmpresa = dbo.ro_empleado_x_ro_tipoNomina.IdEmpresa AND dbo.ro_empleado.IdEmpleado = dbo.ro_empleado_x_ro_tipoNomina.IdEmpleado INNER JOIN
                         dbo.ro_cargo ON dbo.ro_empleado.IdEmpresa = dbo.ro_cargo.IdEmpresa AND dbo.ro_empleado.IdCargo = dbo.ro_cargo.IdCargo ON dbo.ro_catalogo.CodCatalogo = dbo.ro_empleado.em_status
WHERE        (dbo.ro_empleado.em_estado = 'A')
