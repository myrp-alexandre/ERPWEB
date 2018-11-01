-- VISTA PARA EL REPORTE PRESTAMOS
create view web.VWROL_008 AS

SELECT        dbo.tb_persona.pe_cedulaRuc AS CedulaRuc, dbo.ro_empleado.IdEmpleado, dbo.ro_prestamo.IdPrestamo, dbo.ro_prestamo.IdEmpresa, dbo.ro_prestamo.Fecha, dbo.ro_prestamo.MontoSol, dbo.ro_prestamo.TasaInteres, 
                         dbo.ro_prestamo.TotalPrestamo, dbo.ro_prestamo.NumCuotas, dbo.ro_prestamo.Observacion, dbo.ro_prestamo_detalle.NumCuota, dbo.ro_prestamo_detalle.SaldoInicial, dbo.ro_prestamo_detalle.Interes, 
                         dbo.ro_prestamo_detalle.AbonoCapital, dbo.ro_prestamo_detalle.TotalCuota, dbo.ro_prestamo_detalle.Saldo, dbo.ro_prestamo_detalle.FechaPago, dbo.ro_prestamo_detalle.EstadoPago, 
                         dbo.ro_prestamo_detalle.Observacion_det AS ObservacionCuota, dbo.ro_rubro_tipo.ru_descripcion AS RubroDescripcion, dbo.ro_empleado.em_codigo AS CodigoEmpleado, dbo.tb_persona.pe_apellido, 
                         dbo.tb_persona.pe_nombre, dbo.ro_prestamo.descuento_mensual, dbo.ro_prestamo.descuento_quincena, dbo.ro_prestamo.descuento_men_quin
FROM            dbo.ro_empleado INNER JOIN
                         dbo.tb_persona ON dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.ro_prestamo ON dbo.ro_empleado.IdEmpresa = dbo.ro_prestamo.IdEmpresa AND dbo.ro_empleado.IdEmpresa = dbo.ro_prestamo.IdEmpresa AND dbo.ro_empleado.IdEmpleado = dbo.ro_prestamo.IdEmpleado INNER JOIN
                         dbo.ro_prestamo_detalle ON dbo.ro_prestamo.IdEmpresa = dbo.ro_prestamo_detalle.IdEmpresa AND dbo.ro_prestamo.IdPrestamo = dbo.ro_prestamo_detalle.IdPrestamo INNER JOIN
                         dbo.ro_rubro_tipo ON dbo.ro_prestamo.IdRubro = dbo.ro_rubro_tipo.IdRubro AND dbo.ro_prestamo.IdEmpresa = dbo.ro_rubro_tipo.IdEmpresa
