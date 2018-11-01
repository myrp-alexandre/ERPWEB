CREATE VIEW [dbo].[vwCOMP_Rpt005]
AS
SELECT        pre.IdEmpresa, suc.IdSucursal, pre.IdSolicitudCompra, pre.Secuencia_SC, apro.IdProducto_SC, suc.Su_Descripcion, apro.NomProducto_SC, 
                         apro.Cantidad_aprobada, pre.IdUsuarioAprueba, pre.FechaHoraAprobacion, apro.observacion, uniMed.IdUnidadMedida, uniMed.Descripcion, apro.do_precioCompra, 
                         apro.do_porc_des, apro.do_subtotal, apro.do_iva, apro.do_total, apro.do_ManejaIva, apro.IdPunto_cargo, dbo.ro_Departamento.IdDepartamento, 
                         dbo.ro_Departamento.de_descripcion, dbo.cp_proveedor.IdProveedor, pe_nombreCompleto, pre.IdEstadoAprobacion, 
                         dbo.vwcom_EstadoAprobacion_sol_compra.descripcion AS DescrpcionEstado, dbo.com_solicitante.nom_solicitante AS nomSolicitante, 
                         sol.IdSolicitante  AS IdPersona
FROM            dbo.com_solicitud_compra_det_pre_aprobacion AS pre INNER JOIN
                         dbo.com_solicitud_compra_det AS solDet ON pre.IdEmpresa = solDet.IdEmpresa AND pre.IdSucursal_SC = solDet.IdSucursal AND 
                         pre.IdSolicitudCompra = solDet.IdSolicitudCompra AND pre.Secuencia_SC = solDet.Secuencia INNER JOIN
                         dbo.com_solicitud_compra_det_aprobacion AS apro ON solDet.IdEmpresa = apro.IdEmpresa AND solDet.IdSucursal = apro.IdSucursal_SC AND 
                         solDet.IdSolicitudCompra = apro.IdSolicitudCompra AND solDet.Secuencia = apro.Secuencia_SC INNER JOIN
                         dbo.com_solicitud_compra AS sol ON sol.IdEmpresa = solDet.IdEmpresa AND sol.IdSucursal = solDet.IdSucursal AND 
                         sol.IdSolicitudCompra = solDet.IdSolicitudCompra INNER JOIN
                         dbo.vwcom_EstadoAprobacion_sol_compra ON dbo.vwcom_EstadoAprobacion_sol_compra.Id = pre.IdEstadoAprobacion INNER JOIN
                         dbo.com_solicitante ON sol.IdEmpresa = dbo.com_solicitante.IdEmpresa AND sol.IdSolicitante = dbo.com_solicitante.IdSolicitante INNER JOIN
                         dbo.tb_sucursal AS suc ON sol.IdEmpresa = suc.IdEmpresa AND sol.IdSucursal = suc.IdSucursal INNER JOIN
                         dbo.tb_empresa ON sol.IdEmpresa = dbo.tb_empresa.IdEmpresa LEFT OUTER JOIN
                         dbo.cp_proveedor ON apro.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND apro.IdProveedor_SC = dbo.cp_proveedor.IdProveedor LEFT OUTER JOIN
                         dbo.in_UnidadMedida AS uniMed ON apro.IdUnidadMedida = uniMed.IdUnidadMedida LEFT OUTER JOIN
                         dbo.ro_Departamento ON sol.IdEmpresa = dbo.ro_Departamento.IdEmpresa AND sol.IdDepartamento = dbo.ro_Departamento.IdDepartamento
						 inner join tb_persona as per on per.IdPersona = cp_proveedor.IdPersona