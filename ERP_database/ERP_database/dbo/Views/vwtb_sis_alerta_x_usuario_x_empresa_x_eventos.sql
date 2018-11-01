CREATE VIEW vwtb_sis_alerta_x_usuario_x_empresa_x_eventos
AS
SELECT        tb_sis_alerta_x_usuario_x_empresa_x_eventos.IdEmpresa, tb_sis_alerta_x_usuario_x_empresa_x_eventos.IdUsuario, tb_sis_alerta_x_usuario_x_empresa_x_eventos.CodAlerta, 
                         tb_sis_alerta_x_usuario_x_empresa_x_eventos.enum_evento, tb_sis_alerta_x_usuario_x_empresa.IdSucursal, tb_sis_alerta.Nombre, tb_sis_alerta.Formulario, tb_sis_alerta.nom_Asembly
FROM            tb_sis_alerta INNER JOIN
                         tb_sis_alerta_x_usuario_x_empresa ON tb_sis_alerta.CodAlerta = tb_sis_alerta_x_usuario_x_empresa.CodAlerta INNER JOIN
                         tb_sis_alerta_x_usuario_x_empresa_x_eventos ON tb_sis_alerta_x_usuario_x_empresa.IdEmpresa = tb_sis_alerta_x_usuario_x_empresa_x_eventos.IdEmpresa AND 
                         tb_sis_alerta_x_usuario_x_empresa.IdUsuario = tb_sis_alerta_x_usuario_x_empresa_x_eventos.IdUsuario AND tb_sis_alerta_x_usuario_x_empresa.CodAlerta = tb_sis_alerta_x_usuario_x_empresa_x_eventos.CodAlerta