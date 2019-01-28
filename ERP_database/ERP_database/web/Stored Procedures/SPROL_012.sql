--estas publicando?
--SIMON, ya publique


--exec [web].[SPROL_012] 2,'2018/01/01','2019/12/31',null


CREATE procedure [web].[SPROL_012]
@IdEmpresa int,
@Fecha_desde date,
@Fecha_hasta date,
@IdRubro varchar(50)
as begin

SELECT        dbo.ro_empleado.IdEmpresa, dbo.ro_Departamento.IdDepartamento, dbo.ro_empleado.IdEmpleado, dbo.ro_prestamo_detalle.IdPrestamo, dbo.tb_persona.pe_cedulaRuc, 
                         dbo.tb_persona.pe_apellido, dbo.tb_persona.pe_nombre, dbo.ro_prestamo_detalle.EstadoPago, dbo.ro_Departamento.de_descripcion,SUM( dbo.ro_prestamo.MontoSol) AS Total_Prestamo, 
                        SUM( IIF(dbo.ro_prestamo_detalle.EstadoPago = 'CAN', dbo.ro_prestamo_detalle.TotalCuota, 0)) AS Total_Cancelado,SUM( IIF(dbo.ro_prestamo_detalle.EstadoPago = 'PEN', TotalCuota, 0)) AS Total_Pendiente_pago, 
                          dbo.ro_prestamo.Observacion,ro_prestamo.Fecha_PriPago, ro_prestamo.Fecha_Transac, ro_empleado.IdSucursal, ro_prestamo.IdRubro, ru.ru_descripcion

FROM            dbo.ro_prestamo_detalle INNER JOIN
                         dbo.ro_prestamo ON dbo.ro_prestamo_detalle.IdEmpresa = dbo.ro_prestamo.IdEmpresa AND dbo.ro_prestamo_detalle.IdPrestamo = dbo.ro_prestamo.IdPrestamo INNER JOIN
                         dbo.ro_empleado ON dbo.ro_prestamo.IdEmpresa = dbo.ro_empleado.IdEmpresa AND dbo.ro_prestamo.IdEmpresa = dbo.ro_empleado.IdEmpresa AND dbo.ro_prestamo.IdEmpleado = dbo.ro_empleado.IdEmpleado INNER JOIN
                         dbo.ro_Departamento ON dbo.ro_empleado.IdEmpresa = dbo.ro_Departamento.IdEmpresa AND dbo.ro_empleado.IdDepartamento = dbo.ro_Departamento.IdDepartamento INNER JOIN
                         dbo.tb_persona ON dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona
						 left join ro_rubro_tipo as ru on ru.IdEmpresa = ro_prestamo.IdEmpresa
						 AND RU.IdRubro = ro_prestamo.IdRubro
						 	  where CAST( dbo.ro_prestamo.Fecha_Transac as date) between @Fecha_desde and @Fecha_hasta
							  and   dbo.ro_prestamo.IdEmpresa=@IdEmpresa 
							  and ro_prestamo.IdRubro like case when len(ltrim(rtrim(@IdRubro))) = 0 or @IdRubro is null then '%%' else @IdRubro end 
						 group by
						 dbo.ro_empleado.IdEmpresa,  dbo.ro_Departamento.IdDepartamento, dbo.ro_empleado.IdEmpleado, dbo.ro_prestamo_detalle.IdPrestamo, dbo.tb_persona.pe_cedulaRuc, 
                         dbo.tb_persona.pe_apellido, dbo.tb_persona.pe_nombre, dbo.ro_prestamo_detalle.EstadoPago, dbo.ro_Departamento.de_descripcion,  
                          dbo.ro_prestamo.Observacion,ro_prestamo.Fecha_PriPago, ro_prestamo.Fecha_Transac, ro_empleado.IdSucursal,ro_prestamo.IdRubro, ru.ru_descripcion
						  end