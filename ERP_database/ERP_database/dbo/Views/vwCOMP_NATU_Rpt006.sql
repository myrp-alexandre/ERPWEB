

CREATE VIEW [dbo].[vwCOMP_NATU_Rpt006]
AS
SELECT        dbo.com_solicitud_compra.IdEmpresa, dbo.com_solicitud_compra.IdSucursal, dbo.com_solicitud_compra.IdSolicitudCompra, 
                         dbo.com_solicitud_compra.NumDocumento, dbo.com_solicitud_compra.IdDepartamento, dbo.com_solicitud_compra.fecha, dbo.com_solicitud_compra.observacion, 
                         dbo.com_solicitud_compra.Estado, dbo.com_solicitud_compra_det.Secuencia, dbo.com_solicitud_compra_det.IdProducto, 
                         dbo.in_Producto.pr_codigo AS cod_producto, CASE WHEN dbo.in_Producto.pr_codigo IS NULL 
                         THEN dbo.com_solicitud_compra_det.NomProducto WHEN dbo.in_Producto.pr_codigo IS NOT NULL THEN dbo.in_Producto.pr_descripcion END AS NomProducto, 
                         dbo.com_solicitud_compra_det.do_Cantidad, dbo.ro_Departamento.de_descripcion AS nom_departamento, dbo.com_solicitud_compra.IdSolicitante IdPersona_Solicita, 
                         dbo.com_solicitud_compra.IdComprador AS IdPersona_comprador, dbo.com_comprador.Descripcion AS nom_persona_compra, 
                         dbo.com_solicitante.nom_solicitante AS nom_persona_solicita
FROM            dbo.com_solicitud_compra INNER JOIN
                         dbo.com_solicitud_compra_det ON dbo.com_solicitud_compra.IdEmpresa = dbo.com_solicitud_compra_det.IdEmpresa AND 
                         dbo.com_solicitud_compra.IdSucursal = dbo.com_solicitud_compra_det.IdSucursal AND 
                         dbo.com_solicitud_compra.IdSolicitudCompra = dbo.com_solicitud_compra_det.IdSolicitudCompra INNER JOIN
                         dbo.tb_sucursal ON dbo.com_solicitud_compra.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND 
                         dbo.com_solicitud_compra.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.tb_empresa ON dbo.tb_sucursal.IdEmpresa = dbo.tb_empresa.IdEmpresa INNER JOIN
                         dbo.tb_persona ON dbo.com_solicitud_compra.IdSolicitante = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.ro_Departamento ON dbo.com_solicitud_compra.IdEmpresa = dbo.ro_Departamento.IdEmpresa AND 
                         dbo.com_solicitud_compra.IdDepartamento = dbo.ro_Departamento.IdDepartamento INNER JOIN
                         dbo.com_comprador ON dbo.com_solicitud_compra.IdEmpresa = dbo.com_comprador.IdEmpresa AND 
                         dbo.com_solicitud_compra.IdComprador = dbo.com_comprador.IdComprador INNER JOIN
                         dbo.com_solicitante ON dbo.com_solicitud_compra.IdEmpresa = dbo.com_solicitante.IdEmpresa AND 
                         dbo.com_solicitud_compra.IdSolicitante = dbo.com_solicitante.IdSolicitante LEFT OUTER JOIN
                         dbo.in_Producto ON dbo.com_solicitud_compra_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND 
                         dbo.com_solicitud_compra_det.IdProducto = dbo.in_Producto.IdProducto