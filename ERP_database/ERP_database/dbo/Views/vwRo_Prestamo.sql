CREATE VIEW dbo.vwRo_Prestamo
AS
SELECT        pres.IdEmpresa, pres.IdPrestamo, pres.IdEmpleado, per_emp.pe_nombre, per_emp.pe_apellido, pres.IdRubro, rub.ru_descripcion, pres.Estado, pres.Fecha, pres.MontoSol, ISNULL(estado_can.TotalCobrado, 0) 
                         AS TotalCobrado, ISNULL(pres.MontoSol - estado_can.TotalCobrado, 0) AS Valor_pendiente, pres.NumCuotas, pres.Fecha_PriPago, pres.Observacion, pres.MotiAnula, per_emp.pe_cedulaRuc, 0 AS IdTipoPersona, 
                         per_emp.IdPersona, pres.IdTipoCbte, pres.IdCbteCble, pres.IdOrdenPago, pres.descuento_mensual, pres.descuento_quincena, pres.descuento_men_quin
FROM            dbo.ro_empleado AS emp_apru RIGHT OUTER JOIN
                         dbo.ro_prestamo AS pres INNER JOIN
                         dbo.ro_empleado AS emp ON pres.IdEmpresa = emp.IdEmpresa AND pres.IdEmpleado = emp.IdEmpleado INNER JOIN
                         dbo.tb_persona AS per_emp ON emp.IdPersona = per_emp.IdPersona INNER JOIN
                         dbo.ro_rubro_tipo AS rub ON pres.IdRubro = rub.IdRubro AND pres.IdEmpresa = rub.IdEmpresa ON emp_apru.IdEmpresa = pres.IdEmpresa LEFT OUTER JOIN
                         dbo.vwRo_Prestamo_TotalCobrado AS estado_can ON pres.IdEmpresa = estado_can.IdEmpresa AND pres.IdPrestamo = estado_can.IdPrestamo
