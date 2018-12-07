CREATE view vwro_nomina_sin_percebir_sueldo as
SELECT        dbo.ro_rol_detalle.IdEmpresa, dbo.ro_rol_detalle.IdRol, dbo.ro_rol_detalle.IdEmpleado, dbo.ro_rol_detalle.IdRubro,CAST( dbo.ro_rol_detalle.Valor as numeric(10,2))Valor, dbo.ro_rol_detalle.IdSucursal, dbo.ro_empleado.em_codigo, 
                         dbo.tb_persona.pe_cedulaRuc, dbo.tb_persona.pe_apellido, dbo.tb_persona.pe_nombre, dbo.tb_persona.pe_nombreCompleto
FROM            dbo.ro_rol_detalle INNER JOIN
                         dbo.ro_empleado ON dbo.ro_rol_detalle.IdEmpresa = dbo.ro_empleado.IdEmpresa AND dbo.ro_rol_detalle.IdEmpleado = dbo.ro_empleado.IdEmpleado INNER JOIN
                         dbo.tb_persona ON dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona
						 where ro_rol_detalle.IdRubro=950
						 and Valor<=0