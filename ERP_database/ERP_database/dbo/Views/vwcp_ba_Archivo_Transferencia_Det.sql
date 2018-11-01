CREATE VIEW [dbo].[vwcp_ba_Archivo_Transferencia_Det]
AS
SELECT        dbo.cp_orden_pago_det.Valor_a_pagar, dbo.cp_orden_pago.Observacion, dbo.tb_persona.CodPersona, dbo.tb_persona.pe_Naturaleza, 
                         dbo.tb_persona.pe_nombreCompleto, dbo.tb_persona.pe_apellido, dbo.tb_persona.pe_razonSocial, dbo.tb_persona.pe_nombre, 0 IdTipoPersona, 
                         dbo.tb_persona.IdTipoDocumento, dbo.tb_persona.pe_cedulaRuc, dbo.tb_persona.IdPersona, dbo.cp_orden_pago.Fecha_Pago, 
                         dbo.ba_Archivo_Transferencia_Det.Estado, dbo.ba_Archivo_Transferencia_Det.IdEstadoRegistro_cat, dbo.cp_orden_pago_det.IdEstadoAprobacion, 
                         dbo.ba_Archivo_Transferencia_Det.IdEmpresa, dbo.ba_Archivo_Transferencia_Det.IdArchivo, dbo.ba_Archivo_Transferencia_Det.IdProceso_bancario, 
                         dbo.ba_Archivo_Transferencia_Det.Secuencia, dbo.ba_Archivo_Transferencia_Det.IdEmpresa_OP, dbo.ba_Archivo_Transferencia_Det.IdOrdenPago, 
                         dbo.ba_Archivo_Transferencia_Det.Secuencia_OP, dbo.cp_orden_pago.IdTipo_Persona, dbo.cp_orden_pago.IdEntidad
FROM            dbo.cp_orden_pago_det INNER JOIN
                         dbo.ba_Archivo_Transferencia_Det ON dbo.cp_orden_pago_det.Secuencia = dbo.ba_Archivo_Transferencia_Det.Secuencia_OP AND 
                         dbo.cp_orden_pago_det.IdEmpresa = dbo.ba_Archivo_Transferencia_Det.IdEmpresa_OP AND 
                         dbo.cp_orden_pago_det.IdOrdenPago = dbo.ba_Archivo_Transferencia_Det.IdOrdenPago INNER JOIN
                         dbo.cp_orden_pago ON dbo.cp_orden_pago_det.IdEmpresa = dbo.cp_orden_pago.IdEmpresa AND 
                         dbo.cp_orden_pago_det.IdOrdenPago = dbo.cp_orden_pago.IdOrdenPago INNER JOIN
                         dbo.tb_persona ON dbo.cp_orden_pago.IdPersona = dbo.tb_persona.IdPersona