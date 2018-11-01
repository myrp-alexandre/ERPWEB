
CREATE VIEW [dbo].[vwcom_solicitud_compra]
AS
SELECT        SC.IdEmpresa, SC.IdSucursal, SC.IdSolicitudCompra, SC.NumDocumento, SC.IdSolicitante AS IdPersona_Solicita, SC.IdDepartamento, SC.fecha, SC.plazo, 
                         SC.fecha_vtc, SC.observacion, SC.Estado, sucu.Su_Descripcion AS Sucursal, SC.IdEstadoAprobacion, 
                         dbo.vwcom_EstadoAprobacion_sol_compra.descripcion AS nom_EstadoAprobacion, SC.IdUsuarioAprobo, SC.MotivoAprobacion, SC.FechaHoraAprobacion, 
                         SC.IdComprador, dbo.com_comprador.Descripcion AS Comprador, dbo.com_solicitante.nom_solicitante AS Solicitante, 
                         dbo.com_departamento.nom_departamento AS departamento
FROM            dbo.com_solicitud_compra AS SC INNER JOIN
                         dbo.tb_sucursal AS sucu ON SC.IdEmpresa = sucu.IdEmpresa AND SC.IdSucursal = sucu.IdSucursal INNER JOIN
                         dbo.com_comprador ON SC.IdEmpresa = dbo.com_comprador.IdEmpresa AND SC.IdComprador = dbo.com_comprador.IdComprador INNER JOIN
                         dbo.com_solicitante ON SC.IdEmpresa = dbo.com_solicitante.IdEmpresa AND SC.IdSolicitante = dbo.com_solicitante.IdSolicitante INNER JOIN
                         dbo.vwcom_EstadoAprobacion_sol_compra ON SC.IdEstadoAprobacion = dbo.vwcom_EstadoAprobacion_sol_compra.Codigo INNER JOIN
                         dbo.com_departamento ON SC.IdEmpresa = dbo.com_departamento.IdEmpresa AND SC.IdDepartamento = dbo.com_departamento.IdDepartamento