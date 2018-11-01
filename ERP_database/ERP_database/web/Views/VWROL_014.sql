create view web.VWROL_014

 

as

 

SELECT        dbo.ro_empleado_x_ro_tipoNomina.IdEmpresa, dbo.ro_empleado_x_ro_tipoNomina.IdEmpleado, dbo.ro_empleado_x_ro_tipoNomina.IdTipoNomina, dbo.ro_Departamento.IdDepartamento, dbo.ro_Departamento.de_descripcion,

                          dbo.tb_persona.pe_cedulaRuc, dbo.tb_persona.pe_apellido, dbo.tb_persona.pe_nombre,

                             (SELECT        RUBRO

                               FROM            dbo.vwro_rubros_acumulados_x_empleados AS D

                               WHERE        (IdEmpleado = dbo.ro_empleado_x_ro_tipoNomina.IdEmpleado) AND (IdEmpresa = dbo.ro_empleado_x_ro_tipoNomina.IdEmpresa) AND (IdRubro = 289)) AS Decimo_Cuarto,

                             (SELECT        RUBRO

                               FROM            dbo.vwro_rubros_acumulados_x_empleados AS D

                               WHERE        (IdEmpleado = dbo.ro_empleado_x_ro_tipoNomina.IdEmpleado) AND (IdEmpresa = dbo.ro_empleado_x_ro_tipoNomina.IdEmpresa) AND (IdRubro = 290)) AS Decimo_Tercero,

                             (SELECT        RUBRO

                               FROM            dbo.vwro_rubros_acumulados_x_empleados AS D

                               WHERE        (IdEmpleado = dbo.ro_empleado_x_ro_tipoNomina.IdEmpleado) AND (IdEmpresa = dbo.ro_empleado_x_ro_tipoNomina.IdEmpresa) AND (IdRubro = 296)) AS Fondos_Reservas,

                                                  dbo.ro_empleado.IdDivision

FROM            dbo.ro_empleado INNER JOIN

                         dbo.tb_persona ON dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona INNER JOIN

                         dbo.ro_empleado_x_ro_tipoNomina ON dbo.ro_empleado.IdEmpresa = dbo.ro_empleado_x_ro_tipoNomina.IdEmpresa AND dbo.ro_empleado.IdEmpleado = dbo.ro_empleado_x_ro_tipoNomina.IdEmpleado INNER JOIN

                         dbo.ro_Departamento ON dbo.ro_empleado.IdEmpresa = dbo.ro_Departamento.IdEmpresa AND dbo.ro_empleado.IdDepartamento = dbo.ro_Departamento.IdDepartamento

WHERE        (dbo.ro_empleado.em_status <> 'EST_LIQ')

