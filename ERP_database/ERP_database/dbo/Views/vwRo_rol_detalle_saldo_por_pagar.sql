/*where (rol.ValorGanado - pago.Valor) > 0
where rol.IdPeriodo=201804*/
CREATE VIEW dbo.vwRo_rol_detalle_saldo_por_pagar
AS
SELECT        rol_1.IdEmpresa, rol_1.IdRol, rol_1.IdNominaTipo, rol_1.IdNominaTipoLiqui, rol_1.IdPeriodo, rol_1.IdEmpleado, rol_1.IdRubro, rol_1.ValorGanado, rol_1.IdSucursal, rol_1.em_codigo, rol_1.pe_apellido, rol_1.pe_nombre, 
                         rol_1.pe_nombreCompleto, rol_1.pe_cedulaRuc, ISNULL(pago.Valor, 0) AS ValorCancelado, rol_1.ValorGanado - ISNULL(pago.Valor, 0) AS Saldo, rol_1.em_NumCta, rol_1.em_tipoCta, rol_1.IdPersona
FROM            (SELECT        rol.IdEmpresa, rol.IdRol, rol.IdNominaTipo, rol.IdNominaTipoLiqui, rol.IdPeriodo, rol_det.IdEmpleado, rol_det.IdRubro, rol_det.Valor AS ValorGanado, rol_det.IdSucursal, emp.em_codigo, persona.pe_apellido, 
                                                    persona.pe_nombre, persona.pe_nombreCompleto, persona.pe_cedulaRuc, emp.em_NumCta, emp.em_tipoCta, persona.IdPersona
                          FROM            dbo.ro_rol AS rol INNER JOIN
                                                    dbo.ro_rol_detalle AS rol_det ON rol.IdEmpresa = rol_det.IdEmpresa AND rol.IdRol = rol_det.IdRol INNER JOIN
                                                    dbo.ro_empleado AS emp ON rol_det.IdEmpresa = emp.IdEmpresa AND rol_det.IdEmpleado = emp.IdEmpleado INNER JOIN
                                                    dbo.tb_persona AS persona ON emp.IdPersona = persona.IdPersona AND rol_det.IdRubro = 24) AS rol_1 LEFT OUTER JOIN
                             (SELECT        archivo.IdEmpresa, archivo.IdNomina, archivo.IdNominaTipo, archivo.IdPeriodo, archivo_det.IdSucursal, archivo_det.IdEmpleado, SUM(archivo_det.Valor) AS Valor
                               FROM            dbo.ro_archivos_bancos_generacion AS archivo INNER JOIN
                                                         dbo.ro_archivos_bancos_generacion_x_empleado AS archivo_det ON archivo.IdEmpresa = archivo_det.IdEmpresa AND archivo.IdArchivo = archivo_det.IdArchivo AND archivo.estado = 'A'
                               GROUP BY archivo.IdEmpresa, archivo.IdNomina, archivo.IdNominaTipo, archivo.IdPeriodo, archivo_det.IdEmpleado, archivo_det.IdSucursal
                               UNION ALL
                               SELECT        nom_pa_cheq.IdEmpresa, nom_pa_cheq.IdNomina_Tipo, nom_pa_cheq.IdNomina_TipoLiqui, nom_pa_cheq.IdPeriodo, nom_pa_cheq_det.IdSucursal, nom_pa_cheq_det.IdEmpleado, SUM(nom_pa_cheq_det.Valor) 
                                                        AS Expr1
                               FROM            dbo.ro_NominasPagosCheques AS nom_pa_cheq INNER JOIN
                                                        dbo.ro_NominasPagosCheques_det AS nom_pa_cheq_det ON nom_pa_cheq.IdEmpresa = nom_pa_cheq_det.IdEmpresa AND nom_pa_cheq.IdTransaccion = nom_pa_cheq_det.IdTransaccion
                               GROUP BY nom_pa_cheq.IdEmpresa, nom_pa_cheq.IdNomina_Tipo, nom_pa_cheq.IdNomina_TipoLiqui, nom_pa_cheq.IdPeriodo, nom_pa_cheq_det.IdEmpleado, nom_pa_cheq_det.IdSucursal) AS pago ON 
                         pago.IdEmpresa = rol_1.IdEmpresa AND pago.IdNomina = rol_1.IdNominaTipo AND pago.IdNominaTipo = rol_1.IdNominaTipoLiqui AND pago.IdPeriodo = rol_1.IdPeriodo AND pago.IdEmpleado = rol_1.IdEmpleado AND 
                         pago.IdSucursal = rol_1.IdSucursal