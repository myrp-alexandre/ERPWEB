
CREATE VIEW [dbo].[vwcom_ordencompra_local_det_x_com_solicitud_compra_det]
AS
SELECT        OC.IdEmpresa, OC.IdSucursal, OC.IdOrdenCompra, OC.IdProveedor, OC.oc_NumDocumento, OC.IdTerminoPago, OC.oc_plazo, OC.oc_fecha,  
                         OC.oc_observacion, OC.Estado, OC.IdEstadoAprobacion_cat, OC.co_fecha_aprobacion, OC.IdUsuario_Aprueba, OC.IdUsuario_Reprue, OC.co_fechaReproba, 
                         OC.Fecha_Transac, OC.Fecha_UltMod, OC.IdUsuarioUltMod, OC.FechaHoraAnul, OC.IdUsuarioUltAnu,  
                         OC.MotivoReprobacion, SUM(OCDet.do_subtotal) AS subtotal, SUM(OCDet.do_iva) AS iva, SUM(OCDet.do_total) AS total,  
                         Apr.descripcion AS ap_descripcion, PAgo.descripcion AS tp_descripcion, REc.descripcion AS rec_descripcion, pe.pe_nombreCompleto pr_nombre, dbo.tb_sucursal.Su_Descripcion, 
                         OC.IdDepartamento,  OC.IdComprador, OC.MotivoAnulacion, Perso_Soli.pe_nombreCompleto AS Nom_Solicita, 
                         dbo.ro_Departamento.de_descripcion AS SDepartamento, OC.IdMotivo, OC.oc_fechaVencimiento, dbo.com_comprador.Descripcion AS Nom_Comprador, 
                         OC.IdEstado_cierre, dbo.com_Motivo_Orden_Compra.Descripcion AS nom_motivo_OC, com_x_sol.scd_IdEmpresa, com_x_sol.scd_IdSucursal, 
                         com_x_sol.scd_IdSolicitudCompra
FROM            dbo.com_ordencompra_local AS OC INNER JOIN
                         dbo.com_ordencompra_local_det AS OCDet ON OC.IdEmpresa = OCDet.IdEmpresa AND OC.IdSucursal = OCDet.IdSucursal AND 
                         OC.IdOrdenCompra = OCDet.IdOrdenCompra INNER JOIN
                         dbo.cp_proveedor AS Prov ON OC.IdEmpresa = Prov.IdEmpresa AND OC.IdProveedor = Prov.IdProveedor INNER JOIN
                         dbo.tb_sucursal ON OC.IdSucursal = dbo.tb_sucursal.IdSucursal AND OC.IdEmpresa = dbo.tb_sucursal.IdEmpresa INNER JOIN
                         dbo.vwcom_EstadoRecibido AS REc ON 1 = REc.Id INNER JOIN
                         dbo.vwcom_TerminoPago AS PAgo ON OC.IdTerminoPago = PAgo.IdTerminoPago INNER JOIN
                         dbo.vwcom_EstadoAprobacion AS Apr ON OC.IdEstadoAprobacion_cat = Apr.Id INNER JOIN
                         dbo.com_comprador ON OC.IdEmpresa = dbo.com_comprador.IdEmpresa AND OC.IdComprador = dbo.com_comprador.IdComprador INNER JOIN
                         dbo.com_Motivo_Orden_Compra ON OC.IdEmpresa = dbo.com_Motivo_Orden_Compra.IdEmpresa AND 
                         OC.IdMotivo = dbo.com_Motivo_Orden_Compra.IdMotivo INNER JOIN
                         dbo.com_ordencompra_local_det_x_com_solicitud_compra_det AS com_x_sol ON com_x_sol.ocd_IdEmpresa = OCDet.IdEmpresa AND 
                         com_x_sol.ocd_IdSucursal = OCDet.IdSucursal AND com_x_sol.ocd_IdOrdenCompra = OCDet.IdOrdenCompra AND 
                         com_x_sol.ocd_Secuencia = OCDet.Secuencia LEFT OUTER JOIN
                         dbo.ro_Departamento ON OC.IdDepartamento = dbo.ro_Departamento.IdDepartamento AND OC.IdEmpresa = dbo.ro_Departamento.IdEmpresa LEFT OUTER JOIN
                         dbo.tb_persona AS Perso_Soli ON 1 = Perso_Soli.IdPersona
						 inner join tb_persona as pe on prov.IdPersona = pe.IdPersona
GROUP BY OC.IdEmpresa, OC.IdSucursal, OC.IdOrdenCompra, OC.IdProveedor, OC.oc_NumDocumento,  OC.IdTerminoPago, OC.oc_plazo, OC.oc_fecha,  
                         OC.oc_observacion, OC.Estado, OC.IdEstadoAprobacion_cat, OC.co_fecha_aprobacion, OC.IdUsuario_Aprueba, OC.IdUsuario_Reprue, OC.co_fechaReproba, 
                         OC.Fecha_Transac, OC.Fecha_UltMod, OC.IdUsuarioUltMod, OC.FechaHoraAnul, OC.IdUsuarioUltAnu,   OC.MotivoReprobacion, 
                         Apr.descripcion, PAgo.descripcion, REc.descripcion, pe.pe_nombreCompleto, dbo.tb_sucursal.Su_Descripcion, OC.IdDepartamento,   
                         OC.IdComprador, OC.MotivoAnulacion, Perso_Soli.pe_nombreCompleto, dbo.ro_Departamento.de_descripcion, OC.IdMotivo, OC.oc_fechaVencimiento, 
                         dbo.com_comprador.Descripcion, OC.IdEstado_cierre, dbo.com_Motivo_Orden_Compra.Descripcion, com_x_sol.scd_IdEmpresa, com_x_sol.scd_IdSucursal, 
                         com_x_sol.scd_IdSolicitudCompra