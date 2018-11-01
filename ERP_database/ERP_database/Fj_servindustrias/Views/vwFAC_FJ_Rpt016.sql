CREATE VIEW Fj_servindustrias.vwFAC_FJ_Rpt016
AS
SELECT        empleado.IdEmpresa, empleado.IdEmpleado, persona.pe_cedulaRuc, persona.pe_apellido, persona.pe_nombre, dbo.Af_Activo_fijo.Af_DescripcionCorta, cargo.ca_descripcion, 
                         Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.Salario, Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.HorasExtras, 
                         Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.Alimentacion, Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.TotalIngresos, 
                         Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.Total_mas_Beneficios, Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.TotalManoObra, dbo.ct_centro_costo_sub_centro_costo.Centro_costo as SubcentroCosto, 
                         dbo.ct_centro_costo.Centro_costo, Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdPeriodo, Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdCentroCosto, 
                         Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdCentroCosto_sub_centro_costo, Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdCargo, 
                         Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdActivoFijo, Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdPrefacturacion, Fj_servindustrias.fa_tarifario_facturacion_x_cliente.nom_tarifario, 
                         Fj_servindustrias.fa_tarifario_facturacion_x_cliente.codTarifario, fa_tarifario_facturacion_x_cliente_Por_comision_1.IdAnio, fa_tarifario_facturacion_x_cliente_Por_comision_1.Fecha_inicio, 
                         fa_tarifario_facturacion_x_cliente_Por_comision_1.Fecha_Fin, fa_tarifario_facturacion_x_cliente_Por_comision_1.porcentaje
FROM            dbo.ct_centro_costo INNER JOIN
                         dbo.ct_centro_costo_sub_centro_costo ON dbo.ct_centro_costo.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                         dbo.ct_centro_costo.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto INNER JOIN
                         Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria ON 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo = Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdCentroCosto_sub_centro_costo AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto = Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdCentroCosto AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdEmpresa = Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdEmpresa AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo = Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdCentroCosto_sub_centro_costo AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto = Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdCentroCosto AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdEmpresa = Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdEmpresa LEFT OUTER JOIN
                         Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision AS fa_tarifario_facturacion_x_cliente_Por_comision_1 INNER JOIN
                         Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo INNER JOIN
                         Fj_servindustrias.fa_tarifario_facturacion_x_cliente ON Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdEmpresa = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdEmpresa AND 
                         Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdTarifario = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdTarifario AND 
                         Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdEmpresa = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdEmpresa AND 
                         Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdTarifario = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdTarifario AND 
                         Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdEmpresa = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdEmpresa AND 
                         Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdTarifario = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdTarifario AND 
                         Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdEmpresa = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdEmpresa AND 
                         Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdTarifario = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdTarifario AND 
                         Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdEmpresa = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdEmpresa AND 
                         Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdTarifario = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdTarifario INNER JOIN
                         dbo.Af_Activo_fijo ON Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdEmpresa = dbo.Af_Activo_fijo.IdEmpresa AND 
                         Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdActivoFijo = dbo.Af_Activo_fijo.IdActivoFijo ON 
                         fa_tarifario_facturacion_x_cliente_Por_comision_1.IdEmpresa = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdEmpresa AND 
                         fa_tarifario_facturacion_x_cliente_Por_comision_1.IdTarifario = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdTarifario AND 
                         fa_tarifario_facturacion_x_cliente_Por_comision_1.IdEmpresa = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdEmpresa AND 
                         fa_tarifario_facturacion_x_cliente_Por_comision_1.IdTarifario = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdTarifario AND 
                         fa_tarifario_facturacion_x_cliente_Por_comision_1.IdEmpresa = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdEmpresa AND 
                         fa_tarifario_facturacion_x_cliente_Por_comision_1.IdTarifario = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdTarifario AND 
                         fa_tarifario_facturacion_x_cliente_Por_comision_1.IdEmpresa = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdEmpresa AND 
                         fa_tarifario_facturacion_x_cliente_Por_comision_1.IdTarifario = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdTarifario AND 
                         fa_tarifario_facturacion_x_cliente_Por_comision_1.IdEmpresa = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdEmpresa AND 
                         fa_tarifario_facturacion_x_cliente_Por_comision_1.IdTarifario = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdTarifario AND 
                         fa_tarifario_facturacion_x_cliente_Por_comision_1.IdEmpresa = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdEmpresa AND 
                         fa_tarifario_facturacion_x_cliente_Por_comision_1.IdTarifario = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdTarifario ON 
                         Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdEmpresa = dbo.Af_Activo_fijo.IdEmpresa AND Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdActivoFijo = dbo.Af_Activo_fijo.IdActivoFijo AND 
                         Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdEmpresa = dbo.Af_Activo_fijo.IdEmpresa AND 
                         Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdActivoFijo = dbo.Af_Activo_fijo.IdActivoFijo LEFT OUTER JOIN
                         dbo.ro_empleado AS empleado INNER JOIN
                         dbo.ro_cargo AS cargo ON empleado.IdEmpresa = cargo.IdEmpresa AND empleado.IdCargo = cargo.IdCargo INNER JOIN
                         dbo.tb_persona AS persona ON empleado.IdPersona = persona.IdPersona ON Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdEmpresa = empleado.IdEmpresa AND 
                         Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdEmpleado = empleado.IdEmpleado AND Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdEmpresa = cargo.IdEmpresa AND 
                         Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria.IdCargo = cargo.IdCargo