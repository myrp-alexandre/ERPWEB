
CREATE view EntidadRegulatoria.vwrdep_IngrEgr_x_Empleado as
SELECT        Ingresos_fijos.IdEmpresa, Ingresos_fijos.IdEmpleado, Ingresos_fijos.pe_anio, Ingresos_fijos.Su_CodigoEstablecimiento, Ingresos_fijos.pe_cedulaRuc, Ingresos_fijos.pe_nombre, Ingresos_fijos.pe_apellido, 
                         SUM(Ingresos_fijos.Sueldo) Sueldo, SUM(Ingresos_fijos.FondosReserva) FondosReserva, SUM(Ingresos_fijos.DecimoTercerSueldo) DecimoTercerSueldo, SUM(Ingresos_fijos.DecimoCuartoSueldo) DecimoCuartoSueldo, 
                         SUM(Ingresos_fijos.Vacaciones) Vacaciones, SUM(Ingresos_fijos.AportePErsonal) AportePErsonal, Ingresos_fijos.GastoAlimentacion, Ingresos_fijos.GastoEucacion, Ingresos_fijos.GastoSalud, Ingresos_fijos.GastoVestimenta, 
                         Ingresos_fijos.GastoVivienda, Ingresos_fijos.Utilidades, Ingresos_varios.IngresoVarios
FROM            (SELECT        IdEmpresa, IdEmpleado, pe_anio, Su_CodigoEstablecimiento, pe_cedulaRuc, pe_nombre, pe_apellido, [24] AS Sueldo, CAST(isnull([198], 0) AS numeric(10, 2)) AS FondosReserva, CAST([199] AS numeric(10, 2)) 
                                                    AS DecimoTercerSueldo, [200] AS DecimoCuartoSueldo, CAST(ISNULL([295], 0) AS numeric(10, 2)) AS Vacaciones, [6] AportePErsonal, ISNULL(GastoAlimentacion, 0) GastoAlimentacion, ISNULL(GastoEucacion, 0) 
                                                    GastoEucacion, ISNULL(GastoSalud, 0) GastoSalud, ISNULL(GastoVestimenta, 0) GastoVestimenta, ISNULL(GastoVivienda, 0) GastoVivienda, ISNULL(Utilidades, 0) Utilidades
                          FROM            (
						  
						  SELECT        rol_det.IdEmpresa, rol_det.IdPeriodo, rol_det.IdEmpleado, rol_det.IdRubro, rol_det.Valor, per.pe_cedulaRuc, per.pe_apellido, per.pe_nombre, per.pe_sexo, per.pe_direccion, per.pe_telfono_Contacto, 
                                                                              per.pe_celular, per.pe_correo, per.IdEstadoCivil, per.pe_fechaNacimiento, pe.pe_anio, sucr.Su_CodigoEstablecimiento, EntidadRegulatoria.vwrdep_gastos_x_rubros_deducibles.GastoAlimentacion, 
                                                                              EntidadRegulatoria.vwrdep_gastos_x_rubros_deducibles.GastoEucacion, EntidadRegulatoria.vwrdep_gastos_x_rubros_deducibles.GastoSalud, 
                                                                              EntidadRegulatoria.vwrdep_gastos_x_rubros_deducibles.GastoVestimenta, EntidadRegulatoria.vwrdep_gastos_x_rubros_deducibles.GastoVivienda, SUM(utilidad_det.ValorTotal) Utilidades
                                                    FROM            dbo.ro_rol AS rol INNER JOIN
                                                                              dbo.ro_rol_detalle AS rol_det ON rol.IdEmpresa = rol_det.IdEmpresa AND rol.IdNominaTipo = rol_det.IdNominaTipo AND rol.IdNominaTipoLiqui = rol_det.IdNominaTipoLiqui AND 
                                                                              rol.IdPeriodo = rol_det.IdPeriodo INNER JOIN
                                                                              dbo.ro_periodo_x_ro_Nomina_TipoLiqui AS pe_x_nom ON rol.IdEmpresa = pe_x_nom.IdEmpresa AND rol.IdNominaTipo = pe_x_nom.IdNomina_Tipo AND 
                                                                              rol.IdNominaTipoLiqui = pe_x_nom.IdNomina_TipoLiqui AND rol.IdPeriodo = pe_x_nom.IdPeriodo INNER JOIN
                                                                              dbo.ro_periodo AS pe ON pe_x_nom.IdEmpresa = pe.IdEmpresa AND pe_x_nom.IdPeriodo = pe.IdPeriodo INNER JOIN
                                                                              dbo.ro_empleado AS emp ON rol_det.IdEmpresa = emp.IdEmpresa AND rol_det.IdEmpleado = emp.IdEmpleado INNER JOIN
                                                                              dbo.tb_persona AS per ON emp.IdPersona = per.IdPersona INNER JOIN
                                                                              dbo.tb_sucursal AS sucr ON emp.IdEmpresa = sucr.IdEmpresa AND emp.IdSucursal = sucr.IdSucursal LEFT OUTER JOIN
                                                                              dbo.ro_participacion_utilidad_empleado AS utilidad_det ON emp.IdEmpresa = utilidad_det.IdEmpresa AND emp.IdEmpleado = utilidad_det.IdEmpleado LEFT OUTER JOIN
                                                                              dbo.ro_participacion_utilidad AS utilidad ON utilidad_det.IdEmpresa = utilidad.IdEmpresa AND utilidad_det.IdUtilidad = utilidad.IdUtilidad AND pe_x_nom.IdEmpresa = utilidad.IdEmpresa AND 
                                                                              pe_x_nom.IdNomina_Tipo = utilidad.IdNomina AND pe_x_nom.IdNomina_TipoLiqui = utilidad.IdNominaTipo_liq AND pe_x_nom.IdPeriodo = utilidad.IdPeriodo LEFT OUTER JOIN
                                                                              EntidadRegulatoria.vwrdep_gastos_x_rubros_deducibles ON emp.IdEmpresa = EntidadRegulatoria.vwrdep_gastos_x_rubros_deducibles.IdEmpresa AND 
                                                                              emp.IdEmpleado = EntidadRegulatoria.vwrdep_gastos_x_rubros_deducibles.IdEmpleado AND pe.IdEmpresa = EntidadRegulatoria.vwrdep_gastos_x_rubros_deducibles.IdEmpresa AND 
                                                                              pe.pe_anio = EntidadRegulatoria.vwrdep_gastos_x_rubros_deducibles.AnioFiscal
                                                    GROUP BY rol_det.IdEmpresa, rol_det.IdPeriodo, rol_det.IdEmpleado, rol_det.IdRubro, rol_det.Valor, per.pe_cedulaRuc, per.pe_apellido, per.pe_nombre, per.pe_sexo, per.pe_direccion, per.pe_telfono_Contacto, 
                                                                              per.pe_celular, per.pe_correo, per.IdEstadoCivil, per.pe_fechaNacimiento, pe.pe_anio, sucr.Su_CodigoEstablecimiento, EntidadRegulatoria.vwrdep_gastos_x_rubros_deducibles.GastoAlimentacion, 
                                                                              EntidadRegulatoria.vwrdep_gastos_x_rubros_deducibles.GastoEucacion, EntidadRegulatoria.vwrdep_gastos_x_rubros_deducibles.GastoSalud, 
                                                                              EntidadRegulatoria.vwrdep_gastos_x_rubros_deducibles.GastoVestimenta, EntidadRegulatoria.vwrdep_gastos_x_rubros_deducibles.GastoVivienda) AS s PIVOT (sum([Valor]) FOR [IdRubro] IN ([24], 
                                                    [199], [200], [198], [295], [6])) AS pvt) AS Ingresos_fijos left JOIN
                             (SELECT        rol_det.IdEmpresa, rol_det.IdEmpleado, ro_pe.pe_anio, SUM(rol_det.Valor) AS IngresoVarios
                               FROM            dbo.ro_rubro_tipo AS rub INNER JOIN
                                                         dbo.ro_rol_detalle AS rol_det ON rub.IdEmpresa = rol_det.IdEmpresa AND rub.IdRubro = rol_det.IdRubro INNER JOIN
                                                         dbo.ro_periodo_x_ro_Nomina_TipoLiqui AS pe_nom ON rol_det.IdEmpresa = pe_nom.IdEmpresa AND rol_det.IdNominaTipo = pe_nom.IdNomina_Tipo AND 
                                                         rol_det.IdNominaTipoLiqui = pe_nom.IdNomina_TipoLiqui AND rol_det.IdPeriodo = pe_nom.IdPeriodo INNER JOIN
                                                         dbo.ro_periodo AS ro_pe ON pe_nom.IdEmpresa = ro_pe.IdEmpresa AND pe_nom.IdPeriodo = ro_pe.IdPeriodo AND rub.ru_tipo = 'I' AND rub.IdRubro <> 24
                               GROUP BY rol_det.IdEmpresa, rol_det.IdEmpleado, ro_pe.pe_anio) Ingresos_varios ON Ingresos_fijos.IdEmpresa = Ingresos_varios.IdEmpresa AND Ingresos_fijos.IdEmpleado = Ingresos_varios.IdEmpleado AND 
                         Ingresos_fijos.pe_anio = Ingresos_varios.pe_anio
GROUP BY Ingresos_fijos.IdEmpresa, Ingresos_fijos.IdEmpleado, Ingresos_fijos.pe_anio, Ingresos_fijos.Su_CodigoEstablecimiento, Ingresos_fijos.pe_cedulaRuc, Ingresos_fijos.pe_nombre, Ingresos_fijos.pe_apellido, 
                         Ingresos_fijos.GastoAlimentacion, Ingresos_fijos.GastoSalud, Ingresos_fijos.GastoVivienda, Ingresos_fijos.GastoVestimenta, Ingresos_fijos.GastoEucacion, Ingresos_fijos.Utilidades, Ingresos_varios.IngresoVarios