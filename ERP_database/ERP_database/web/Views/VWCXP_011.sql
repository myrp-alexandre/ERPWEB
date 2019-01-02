CREATE VIEW web.VWCXP_011
AS
SELECT cp_SolicitudPago.IdEmpresa, cp_SolicitudPago.IdSolicitud, cp_SolicitudPago.IdSucursal, cp_SolicitudPago.Fecha, cp_SolicitudPago.IdProveedor, cp_SolicitudPago.Concepto, cp_SolicitudPago.Estado, cp_SolicitudPago.Valor, 
                  cp_SolicitudPago.Solicitante, tb_persona.pe_nombreCompleto, tb_persona.pe_cedulaRuc, tb_sucursal.Su_Descripcion
FROM     cp_SolicitudPago INNER JOIN
                  cp_proveedor ON cp_SolicitudPago.IdEmpresa = cp_proveedor.IdEmpresa AND cp_SolicitudPago.IdProveedor = cp_proveedor.IdProveedor INNER JOIN
                  tb_persona ON cp_proveedor.IdPersona = tb_persona.IdPersona INNER JOIN
                  tb_sucursal ON cp_SolicitudPago.IdEmpresa = tb_sucursal.IdEmpresa AND cp_SolicitudPago.IdSucursal = tb_sucursal.IdSucursal