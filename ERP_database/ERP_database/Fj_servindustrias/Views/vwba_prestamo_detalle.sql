CREATE VIEW [Fj_servindustrias].[vwba_prestamo_detalle]
	AS 
	SELECT        dbo.ba_prestamo_detalle.IdEmpresa, dbo.ba_prestamo_detalle.IdPrestamo, dbo.ba_prestamo_detalle.NumCuota, dbo.ba_prestamo_detalle.SaldoInicial, 
                         dbo.ba_prestamo_detalle.Interes, dbo.ba_prestamo_detalle.AbonoCapital, dbo.ba_prestamo_detalle.TotalCuota, dbo.ba_prestamo_detalle.Saldo, 
                         dbo.ba_prestamo_detalle.FechaPago, dbo.ba_prestamo_detalle.EstadoPago, dbo.ba_prestamo_detalle.Estado, dbo.ba_prestamo_detalle.Observacion_det, 
                         dbo.ba_prestamo.IdCliente
FROM            dbo.ba_prestamo_detalle INNER JOIN
                         dbo.ba_prestamo ON dbo.ba_prestamo_detalle.IdEmpresa = dbo.ba_prestamo.IdEmpresa AND dbo.ba_prestamo_detalle.IdPrestamo = dbo.ba_prestamo.IdPrestamo