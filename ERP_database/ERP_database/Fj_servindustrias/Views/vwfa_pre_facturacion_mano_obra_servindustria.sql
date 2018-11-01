CREATE VIEW Fj_servindustrias.vwfa_pre_facturacion_mano_obra_servindustria
AS
SELECT        empleado.IdEmpresa, empleado.IdEmpleado, persona.pe_cedulaRuc, persona.pe_apellido, persona.pe_nombre, dbo.Af_Activo_fijo.Af_DescripcionCorta, cargo.ca_descripcion, 
                         Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.Salario, Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.HorasExtras, 
                         Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.Alimentacion, Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.TotalIngresos, 
                         Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.Total_mas_Beneficios, Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.TotalManoObra, dbo.ct_centro_costo_sub_centro_costo.Centro_costo, 
                         dbo.ct_centro_costo.Centro_costo AS SubcentroCosto, Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdPeriodo, Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdCentroCosto, 
                         Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdCentroCosto_sub_centro_costo, Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdCargo, 
                         Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdActivoFijo, Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdPrefacturacion
FROM            dbo.ct_centro_costo INNER JOIN
                         dbo.ct_centro_costo_sub_centro_costo ON dbo.ct_centro_costo.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                         dbo.ct_centro_costo.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto INNER JOIN
                         dbo.ro_empleado AS empleado INNER JOIN
                         dbo.ro_cargo AS cargo ON empleado.IdEmpresa = cargo.IdEmpresa AND empleado.IdCargo = cargo.IdCargo INNER JOIN
                         dbo.tb_persona AS persona ON empleado.IdPersona = persona.IdPersona INNER JOIN
                         Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria ON empleado.IdEmpresa = Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdEmpresa AND 
                         empleado.IdEmpleado = Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdEmpleado AND cargo.IdEmpresa = Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdEmpresa AND 
                         cargo.IdCargo = Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdCargo INNER JOIN
                         dbo.Af_Activo_fijo ON Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdEmpresa = dbo.Af_Activo_fijo.IdEmpresa AND 
                         Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdActivoFijo = dbo.Af_Activo_fijo.IdActivoFijo AND Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdEmpresa = dbo.Af_Activo_fijo.IdEmpresa AND 
                         Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdActivoFijo = dbo.Af_Activo_fijo.IdActivoFijo ON 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo = Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdCentroCosto_sub_centro_costo AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto = Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdCentroCosto AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdEmpresa = Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdEmpresa AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo = Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdCentroCosto_sub_centro_costo AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto = Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdCentroCosto AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdEmpresa = Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdEmpresa