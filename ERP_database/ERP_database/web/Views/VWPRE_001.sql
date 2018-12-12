
CREATE VIEW [web].[VWPRE_001]
AS
SELECT d.IdEmpresa, d.IdPresupuesto, d.Secuencia, c.IdSucursal, su.Su_Descripcion, c.IdPeriodo, pe.DescripciónPeriodo, c.IdGrupo, gr.Descripcion AS DescripcionGrupo, d.IdRubro, ru.Descripcion AS DescripcionRubro, d.IdCtaCble, 
                  pc.pc_Cuenta, d.Cantidad, d.ValorUnitario, d.Monto, c.Estado, c.MontoSolicitado, c.MontoAprobado, c.Observacion, c.MotivoAnulacion
FROM     pre_Presupuesto AS c INNER JOIN
                  pre_PresupuestoDet AS d ON c.IdEmpresa = d.IdEmpresa AND c.IdPresupuesto = d.IdPresupuesto INNER JOIN
                  pre_PresupuestoPeriodo AS pe ON c.IdEmpresa = pe.IdEmpresa AND c.IdPeriodo = pe.IdPeriodo INNER JOIN
                  pre_Grupo AS gr ON c.IdEmpresa = gr.IdEmpresa AND c.IdGrupo = gr.IdGrupo INNER JOIN
                  tb_sucursal AS su ON c.IdEmpresa = su.IdEmpresa AND c.IdSucursal = su.IdSucursal INNER JOIN
                  pre_Rubro AS ru ON d.IdEmpresa = ru.IdEmpresa AND d.IdRubro = ru.IdRubro LEFT OUTER JOIN
                  ct_plancta AS pc ON d.IdCtaCble = pc.IdCtaCble AND d.IdEmpresa = pc.IdEmpresa