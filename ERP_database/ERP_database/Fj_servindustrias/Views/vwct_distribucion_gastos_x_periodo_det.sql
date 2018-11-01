CREATE VIEW Fj_servindustrias.vwct_distribucion_gastos_x_periodo_det
AS
SELECT Fj_servindustrias.ct_distribucion_gastos_x_periodo_det.IdEmpresa, Fj_servindustrias.ct_distribucion_gastos_x_periodo_det.IdDistribucion, Fj_servindustrias.ct_distribucion_gastos_x_periodo_det.Secuencia, 
                  Fj_servindustrias.ct_distribucion_gastos_x_periodo_det.IdCtaCble, Fj_servindustrias.ct_distribucion_gastos_x_periodo_det.IdPunto_cargo, Fj_servindustrias.ct_distribucion_gastos_x_periodo_det.valor, 
                  ct_punto_cargo.nom_punto_cargo, ct_plancta.pc_Cuenta
FROM     Fj_servindustrias.ct_distribucion_gastos_x_periodo_det INNER JOIN
                  ct_plancta ON Fj_servindustrias.ct_distribucion_gastos_x_periodo_det.IdEmpresa = ct_plancta.IdEmpresa AND Fj_servindustrias.ct_distribucion_gastos_x_periodo_det.IdCtaCble = ct_plancta.IdCtaCble INNER JOIN
                  ct_punto_cargo ON Fj_servindustrias.ct_distribucion_gastos_x_periodo_det.IdEmpresa = ct_punto_cargo.IdEmpresa AND Fj_servindustrias.ct_distribucion_gastos_x_periodo_det.IdPunto_cargo = ct_punto_cargo.IdPunto_cargo