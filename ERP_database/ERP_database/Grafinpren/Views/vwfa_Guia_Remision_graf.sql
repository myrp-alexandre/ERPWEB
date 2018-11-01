
CREATE VIEW [Grafinpren].[vwfa_Guia_Remision_graf]
AS
SELECT        dbo.fa_guia_remision.IdEmpresa, dbo.fa_guia_remision.IdSucursal, dbo.fa_guia_remision.IdBodega, dbo.fa_guia_remision.IdGuiaRemision, 
                         dbo.fa_Vendedor.Ve_Vendedor, dbo.fa_guia_remision.CodGuiaRemision, dbo.fa_guia_remision.Serie1, dbo.fa_guia_remision.Serie2, 
                         dbo.fa_guia_remision.NumGuia_Preimpresa, dbo.fa_guia_remision.gi_fecha, dbo.fa_guia_remision.gi_fech_venc, dbo.fa_guia_remision.gi_Observacion, 
                           dbo.fa_guia_remision.Estado,  
                         dbo.fa_guia_remision.gi_FechaFinTraslado, Grafinpren.fa_guia_remision_graf.Num_OP, 
                         Grafinpren.fa_guia_remision_graf.Num_Cotizacion, Grafinpren.fa_guia_remision_graf.fecha_Cotizacion, dbo.fa_guia_remision.IdCliente, 
                          dbo.fa_guia_remision.IdTransportista, dbo.tb_persona.pe_razonSocial, Grafinpren.fa_guia_remision_graf.IdEquipo, 
                         Grafinpren.fa_Equipo_graf.nom_Equipo, dbo.fa_guia_remision.CodDocumentoTipo, dbo.fa_guia_remision.placa, dbo.fa_guia_remision.ruta, 
                         dbo.fa_guia_remision.Direccion_Origen,  dbo.tb_empresa.em_nombre, dbo.tb_empresa.RazonSocial, 
                         dbo.tb_empresa.NombreComercial, dbo.tb_empresa.ContribuyenteEspecial, dbo.tb_empresa.ObligadoAllevarConta, dbo.tb_empresa.em_ruc, 
                         dbo.tb_transportista.Cedula, dbo.tb_transportista.Nombre AS nom_Transportista, dbo.tb_persona.IdTipoDocumento, dbo.tb_persona.pe_cedulaRuc, 
                         dbo.tb_persona.pe_direccion, null pe_telefonoCasa, null pe_telefonoOfic, dbo.tb_persona.pe_celular, dbo.tb_persona.pe_correo, 
                         dbo.tb_persona.pe_Naturaleza, dbo.tb_persona.pe_nombreCompleto, dbo.tb_persona.pe_apellido, dbo.tb_persona.pe_nombre, 0 IdTipoPersona
FROM            Grafinpren.fa_guia_remision_graf INNER JOIN
                         dbo.fa_guia_remision ON Grafinpren.fa_guia_remision_graf.IdEmpresa = dbo.fa_guia_remision.IdEmpresa AND 
                         Grafinpren.fa_guia_remision_graf.IdSucursal = dbo.fa_guia_remision.IdSucursal AND 
                         Grafinpren.fa_guia_remision_graf.IdBodega = dbo.fa_guia_remision.IdBodega AND 
                         Grafinpren.fa_guia_remision_graf.IdGuiaRemision = dbo.fa_guia_remision.IdGuiaRemision INNER JOIN
                         dbo.fa_Vendedor ON dbo.fa_guia_remision.IdEmpresa = dbo.fa_Vendedor.IdEmpresa  INNER JOIN
                         dbo.fa_cliente ON dbo.fa_guia_remision.IdCliente = dbo.fa_cliente.IdCliente AND dbo.fa_guia_remision.IdEmpresa = dbo.fa_cliente.IdEmpresa INNER JOIN
                         dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         Grafinpren.fa_Equipo_graf ON Grafinpren.fa_guia_remision_graf.IdEmpresa = Grafinpren.fa_Equipo_graf.IdEmpresa AND 
                         Grafinpren.fa_guia_remision_graf.IdEquipo = Grafinpren.fa_Equipo_graf.IdEquipo INNER JOIN
                         dbo.tb_transportista ON dbo.fa_guia_remision.IdEmpresa = dbo.tb_transportista.IdEmpresa AND 
                         dbo.fa_guia_remision.IdTransportista = dbo.tb_transportista.IdTransportista INNER JOIN
                         dbo.tb_empresa ON dbo.fa_guia_remision.IdEmpresa = dbo.tb_empresa.IdEmpresa