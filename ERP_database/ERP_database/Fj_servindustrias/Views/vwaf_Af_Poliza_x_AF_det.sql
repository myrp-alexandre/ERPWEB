create view Fj_servindustrias.vwaf_Af_Poliza_x_AF_det as
SELECT        Fj_servindustrias.Af_Poliza_x_AF_det.IdEmpresa, Fj_servindustrias.Af_Poliza_x_AF_det.IdPoliza, Fj_servindustrias.Af_Poliza_x_AF_det.IdActivoFijo, 
                         Fj_servindustrias.Af_Poliza_x_AF_det.secuencia, Fj_servindustrias.Af_Poliza_x_AF_det.Subtotal_0, Fj_servindustrias.Af_Poliza_x_AF_det.Subtotal_12, 
                         Fj_servindustrias.Af_Poliza_x_AF_det.Iva, Fj_servindustrias.Af_Poliza_x_AF_det.Prima, Fj_servindustrias.Af_Poliza_x_AF_det.observacion_det, 
                         dbo.Af_Activo_fijo.Af_Nombre, Fj_servindustrias.Af_Poliza_x_AF_det.IdEstadoFacturacion_cat
FROM            dbo.Af_Activo_fijo INNER JOIN
                         Fj_servindustrias.Af_Poliza_x_AF_det ON dbo.Af_Activo_fijo.IdEmpresa = Fj_servindustrias.Af_Poliza_x_AF_det.IdEmpresa AND 
                         dbo.Af_Activo_fijo.IdActivoFijo = Fj_servindustrias.Af_Poliza_x_AF_det.IdActivoFijo