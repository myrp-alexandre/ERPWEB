CREATE VIEW vwman_tecnico
AS
SELECT man_tecnico.IdEmpresa, man_tecnico.IdTecnico, man_tecnico.IdEmpleado, man_tecnico.te_codigo, man_tecnico.te_observacion, man_tecnico.estado, tb_persona.pe_nombreCompleto, tb_persona.pe_cedulaRuc
FROM     man_tecnico INNER JOIN
                  ro_empleado ON man_tecnico.IdEmpresa = ro_empleado.IdEmpresa AND man_tecnico.IdEmpleado = ro_empleado.IdEmpleado INNER JOIN
                  tb_persona ON ro_empleado.IdPersona = tb_persona.IdPersona