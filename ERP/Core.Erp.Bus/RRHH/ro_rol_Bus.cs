using Core.Erp.Data.Contabilidad;
using Core.Erp.Data.RRHH;
using Core.Erp.Info.Contabilidad;
using Core.Erp.Info.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using Core.Erp.Info.CuentasPorPagar;
using Core.Erp.Info.Helps;
using Core.Erp.Data.CuentasPorPagar;
using Core.Erp.Bus.CuentasPorPagar;
namespace Core.Erp.Bus.RRHH
{
    public class ro_rol_Bus
    {
        #region Variables
        ro_rol_Data odata = new ro_rol_Data();
        ro_rol_Info info = new ro_rol_Info();
        ro_Config_Param_contable_Bus bus_parametros_contables = new ro_Config_Param_contable_Bus();
        List<ro_Config_Param_contable_Info> lst_confn_param_contables = new List<ro_Config_Param_contable_Info>();
        ro_parametro_contable_x_Nomina_Tipoliqui_Sueldo_x_Pagar_Bus bus_cta_sueldo_x_pagar = new ro_parametro_contable_x_Nomina_Tipoliqui_Sueldo_x_Pagar_Bus();
        ro_parametro_contable_x_Nomina_Tipoliqui_Sueldo_x_Pagar_Info info_cta_sueldo_x_pagar = new ro_parametro_contable_x_Nomina_Tipoliqui_Sueldo_x_Pagar_Info();
        ro_rol_detalle_Bus bus_detalle = new ro_rol_detalle_Bus();
        ct_cbtecble_Data odata_comprobante = new ct_cbtecble_Data();
        ro_Parametros_Data ro_parametro = new ro_Parametros_Data();
        ro_Parametros_Info info_parametro = new ro_Parametros_Info();
        cp_orden_pago_tipo_x_empresa_Data data_tipo_op = new cp_orden_pago_tipo_x_empresa_Data();
        cp_orden_pago_tipo_x_empresa_Info info_tipo_op = new cp_orden_pago_tipo_x_empresa_Info();
        cp_orden_pago_Bus bus_op = new cp_orden_pago_Bus();
        ro_Comprobantes_Contables_Data ro_comprobante = new ro_Comprobantes_Contables_Data();
        cp_orden_pago_x_nomina_Data data_op_x_empleado = new cp_orden_pago_x_nomina_Data();
        List<cp_orden_pago_x_nomina_Info> lst_op_x_nomina = new List<cp_orden_pago_x_nomina_Info>();

        #endregion
        public List< ro_rol_Info> get_list_nominas(int IdEmpresa )
        {
            try
            {
                return odata.get_list_nominas(IdEmpresa);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public List<ro_rol_Info> get_list_decimos(int IdEmpresa)
        {
            try
            {
                return odata.get_list_decimos(IdEmpresa);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public ro_rol_Info get_info(int IdEmpresa, int IdNominaTipo, int IdNominaTipoLiqui, int IdPeriodo)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdNominaTipo, IdNominaTipoLiqui, IdPeriodo);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool procesar( ro_rol_Info info)
        {
            try
            {
                return odata.procesar(info);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool CerrarPeriodo(ro_rol_Info info)
        {
            try
            {
                var oarametro = ro_parametro.get_info(info.IdEmpresa);
                if(oarametro!=null)
                if (oarametro.genera_op_x_pago == true && oarametro.Genera_op_x_pago_x_empleao == true)
                {
                    info_tipo_op = data_tipo_op.get_info(info.IdEmpresa, cl_enumeradores.eTipoOrdenPago.ANTI_EMPLE.ToString());
                    var lst_rol_x_empleado = bus_detalle.Get_lst_detalle_genear_op(info.IdEmpresa, info.IdNomina_Tipo, info.IdNomina_TipoLiqui, info.IdPeriodo);
                    var lst_op = get_op_x_empleados(lst_rol_x_empleado, info_tipo_op);
                    foreach (var item in lst_op)
                    {
                        bus_op.guardarDB(item);
                        lst_op_x_nomina.Add(
                            new cp_orden_pago_x_nomina_Info
                            {
                                IdEmpresa = item.IdEmpresa,
                                IdEmpleado = item.IdEmpleado,
                                IdNominaTipo = info.IdNomina_Tipo,
                                IdNominaTipoLiqui = info.IdNomina_TipoLiqui,
                                IdPeriodo = info.IdPeriodo,
                                IdEmpresa_op = item.IdEmpresa,
                                IdOrdenPago = item.IdOrdenPago
                            }
                            );
                    }
                    data_op_x_empleado.guardarDB(lst_op_x_nomina, info);
                }
                return odata.CerrarPeriodo(info);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool AbrirPeriodo(ro_rol_Info info)
        {
            try
            {
                return odata.AbrirPeriodo(info);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool Reversar_contabilidad_Periodo(ro_rol_Info info)
        {
            try
            {
                return odata.Reversar_contabilidad_Periodo(info);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool ContabilizarPeriodo(ro_rol_Info info)
        {
            try
            {
                ro_Comprobantes_Contables_Info info_comprobanteID = new ro_Comprobantes_Contables_Info();
                ct_cbtecble_Info info_ctb =null;
                 info_parametro = ro_parametro.get_info(info.IdEmpresa);
                if(info.lst_sueldo_x_pagar.Count()>0)
                 info_ctb = get_armar_diario_sueldo(info,Convert.ToInt32( info_parametro.IdTipoCbte_AsientoSueldoXPagar));
                if (info_ctb != null)
                {
                    if (odata_comprobante.guardarDB(info_ctb))
                    {
                        // grabando los ID del asiento sueldo por pagar
                        info_comprobanteID.IdEmpresa = info.IdEmpresa;
                        info_comprobanteID.IdNomina = info.IdNomina_Tipo;
                        info_comprobanteID.IdNominaTipo = info.IdNomina_TipoLiqui;
                        info_comprobanteID.IdPeriodo = info.IdPeriodo;
                        info_comprobanteID.IdTipoCbte = info_ctb.IdTipoCbte;
                        info_comprobanteID.IdCbteCble = info_ctb.IdCbteCble;
                        info_comprobanteID.CodCtbteCble = info_ctb.IdCbteCble.ToString();
                        ro_comprobante.grabarDB(info_comprobanteID);
                        info_ctb = null;
                        if(info.lst_provisiones.Count() > 0)
                        info_ctb = get_armar_diario_provisiones(info, Convert.ToInt32(info_parametro.IdTipoCbte_AsientoSueldoXPagar));
                        if (info_ctb != null)
                        {
                            if(odata_comprobante.guardarDB(info_ctb))
                            {
                                // grabando los ID del asiento sueldo por pagar
                                info_comprobanteID = new ro_Comprobantes_Contables_Info();
                                info_comprobanteID.IdEmpresa = info.IdEmpresa;
                                info_comprobanteID.IdNomina = info.IdNomina_Tipo;
                                info_comprobanteID.IdNominaTipo = info.IdNomina_TipoLiqui;
                                info_comprobanteID.IdPeriodo = info.IdPeriodo;
                                info_comprobanteID.IdTipoCbte = info_ctb.IdTipoCbte;
                                info_comprobanteID.IdCbteCble = info_ctb.IdCbteCble;
                                info_comprobanteID.CodCtbteCble = info_ctb.IdCbteCble.ToString();
                                ro_comprobante.grabarDB(info_comprobanteID);
                            }
                        }

                    }
                }
                 odata.ContabilizarPeriodo(info);

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public ro_rol_Info get_info_contabilizar(int IdEmpresa, int IdNominaTipo, int IdNominaTipoLiqui, int IdPeriodo)
        {
            try
            {
                info= odata.get_info(IdEmpresa, IdNominaTipo, IdNominaTipoLiqui, IdPeriodo);
                info.lst_sueldo_x_pagar = get_diario_ctble_sueldo_x_pagar(IdEmpresa, IdNominaTipo, IdNominaTipoLiqui, IdPeriodo);
                info.lst_provisiones = get_diario_ctble_provisiones(IdEmpresa, IdNominaTipo, IdNominaTipoLiqui, IdPeriodo);
                
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }
        private List<ct_cbtecble_det_Info> get_diario_ctble_sueldo_x_pagar(int idEmpresa, int idNominaTipo, int idNominaTipoLiqui, int idPeriodo)
        {
            try
            {
                List<ct_cbtecble_det_Info> lst_detalle_diario = new List<ct_cbtecble_det_Info>();
                List<ro_rol_detalle_Info> oListro_rol_detalle_Info = new List<ro_rol_detalle_Info>();
                lst_confn_param_contables = bus_parametros_contables.get_list(idEmpresa,"0");
                double ingreso = 0;
                double egreso = 0;
                int secuecia = 0;
                info_cta_sueldo_x_pagar = bus_cta_sueldo_x_pagar.get_info(idEmpresa, idNominaTipo, idNominaTipoLiqui);
                oListro_rol_detalle_Info = bus_detalle.Get_lst_detalle_contabilizar(idEmpresa, idNominaTipo, idNominaTipoLiqui, idPeriodo, false);

                foreach (ro_Config_Param_contable_Info item in lst_confn_param_contables)
                {
                   
                    double valorTotal = 0;
                    valorTotal = oListro_rol_detalle_Info.Where(v => /*v.IdDivision == Convert.ToInt32(item.IdDivision)*/
                                                                //&& v.IdArea == item.IdArea
                                                                //&& v.IdDepartamento == item.IdDepartamento
                                                                 v.IdRubro == item.IdRubro).Sum(v => v.Valor);
                    if (valorTotal < 0)
                        valorTotal = valorTotal * -1;
                    if (valorTotal > 0)
                    {
                        valorTotal = Math.Round(valorTotal, 2);
                        secuecia++;
                        ct_cbtecble_det_Info oct_cbtecble_det_Info = new ct_cbtecble_det_Info();
                        oct_cbtecble_det_Info.secuencia = secuecia;
                        oct_cbtecble_det_Info.IdEmpresa = idEmpresa;
                        oct_cbtecble_det_Info.IdCtaCble = item.IdCtaCble;
                        oct_cbtecble_det_Info.IdCentroCosto = item.IdCentroCosto;
                        if (item.ru_tipo == "E")
                        {
                            egreso = egreso + valorTotal;
                            oct_cbtecble_det_Info.dc_Valor_haber = valorTotal;
                            valorTotal = valorTotal * -1;

                        }
                        else 
                        {
                            ingreso = ingreso + valorTotal;
                            oct_cbtecble_det_Info.dc_Valor_debe = valorTotal;
                        }
                        oct_cbtecble_det_Info.dc_Valor = valorTotal;
                        oct_cbtecble_det_Info.dc_Observacion = item.ru_descripcion;
                        lst_detalle_diario.Add(oct_cbtecble_det_Info);
                    }
                                                    
                }

                double valorSueldoXPagar = 0;
                valorSueldoXPagar = ingreso - egreso;
                secuecia++;
                ct_cbtecble_det_Info oct_cbtecble_det_Info2 = new ct_cbtecble_det_Info();
                oct_cbtecble_det_Info2.secuencia = secuecia;
                oct_cbtecble_det_Info2.IdEmpresa = idEmpresa;
                oct_cbtecble_det_Info2.IdCtaCble = info_cta_sueldo_x_pagar.IdCtaCble;
                oct_cbtecble_det_Info2.dc_Valor = valorSueldoXPagar * -1;
                oct_cbtecble_det_Info2.dc_Valor_haber = valorSueldoXPagar ;
                oct_cbtecble_det_Info2.dc_Observacion = "Sueldo por Pagar Neto a Recibir al " + idPeriodo;
                lst_detalle_diario.Add(oct_cbtecble_det_Info2);

                return lst_detalle_diario;
            }
            catch (Exception e)
            {
                throw;
            }
        }
        private List<ct_cbtecble_det_Info> get_diario_ctble_provisiones(int idEmpresa, int idNominaTipo, int idNominaTipoLiqui, int idPeriodo)
        {
            try
            {
                int secuencia = 0;
                List<ct_cbtecble_det_Info> lst_detalle_diario = new List<ct_cbtecble_det_Info>();
                List<ro_rol_detalle_Info> oListro_rol_detalle_Info = new List<ro_rol_detalle_Info>();
                lst_confn_param_contables = bus_parametros_contables.get_list(idEmpresa, "1");
                info_cta_sueldo_x_pagar = bus_cta_sueldo_x_pagar.get_info(idEmpresa, idNominaTipo, idNominaTipoLiqui);
                oListro_rol_detalle_Info = bus_detalle.Get_lst_detalle_contabilizar(idEmpresa, idNominaTipo, idNominaTipoLiqui, idPeriodo, true);

                foreach (ro_Config_Param_contable_Info item in lst_confn_param_contables)
                {
                    double valorTotal = 0;
                    valorTotal = oListro_rol_detalle_Info.Where(v => /*v.IdDivision == Convert.ToInt32(item.IdDivision)*/
                                                                     //&& v.IdArea == item.IdArea
                                                                     //&& v.IdDepartamento == item.IdDepartamento
                                                                  v.IdRubro == item.IdRubro).Sum(v => v.Valor);
                    if (valorTotal > 0)
                    {
                        valorTotal = Math.Round(valorTotal);
                        secuencia++;
                        ct_cbtecble_det_Info oct_cbtecble_det_Info = new ct_cbtecble_det_Info();
                        oct_cbtecble_det_Info.secuencia = secuencia;
                        oct_cbtecble_det_Info.IdEmpresa = idEmpresa;
                        oct_cbtecble_det_Info.IdTipoCbte = 1;
                        oct_cbtecble_det_Info.IdCtaCble = item.IdCtaCble;
                        oct_cbtecble_det_Info.dc_Valor_debe = valorTotal;
                        oct_cbtecble_det_Info.dc_Valor = valorTotal;
                        oct_cbtecble_det_Info.dc_Observacion = item.ru_descripcion;
                        lst_detalle_diario.Add(oct_cbtecble_det_Info);

                        secuencia++;
                        ct_cbtecble_det_Info oct_cbtecble_det_Info2 = new ct_cbtecble_det_Info();
                        oct_cbtecble_det_Info2.secuencia = secuencia;
                        oct_cbtecble_det_Info2.IdEmpresa = idEmpresa;
                        oct_cbtecble_det_Info2.IdTipoCbte = 1;
                        oct_cbtecble_det_Info2.IdCtaCble = item.IdCtaCble_Haber; 
                        oct_cbtecble_det_Info2.dc_Valor = valorTotal * -1;
                        oct_cbtecble_det_Info2.dc_Valor_haber = valorTotal ;

                        oct_cbtecble_det_Info2.dc_Observacion = item.ru_descripcion;
                        lst_detalle_diario.Add(oct_cbtecble_det_Info2);
                    }
                }

              
                return lst_detalle_diario;
            }
            catch (Exception e)
            {
                throw;
            }
        }
        private ct_cbtecble_Info get_armar_diario_sueldo(ro_rol_Info info, int TipoComprobante)
        {

            try
            {
                ct_cbtecble_Info info_diario=new ct_cbtecble_Info();
                info_diario.lst_ct_cbtecble_det = info.lst_sueldo_x_pagar;
                info_diario.IdEmpresa = info.IdEmpresa;
                info_diario.IdTipoCbte = TipoComprobante;
                info_diario.cb_Fecha = info.Fechacontabilizacion;
                info_diario.IdPeriodo = Convert.ToInt32(info.Fechacontabilizacion.Year.ToString() + info.Fechacontabilizacion.Month.ToString().PadLeft(2, '0'));
                info_diario.cb_Anio = info.Fechacontabilizacion.Year;
                info_diario.cb_mes = info.Fechacontabilizacion.Month;
                info_diario.cb_Observacion = "Contabilización rol general del periodo "+info.IdPeriodo.ToString();
                info_diario.cb_Valor = info.lst_sueldo_x_pagar.Sum(v=>v.dc_Valor);
                info_diario.IdUsuario = info.UsuarioIngresa;
                info_diario.cb_FechaTransac = DateTime.Now;
                info_diario.cb_Estado = "A";
                
                return info_diario;
            }
            catch (Exception)
            {

                throw;
            }
        }
        private ct_cbtecble_Info get_armar_diario_provisiones(ro_rol_Info info, int TipoComprobante)
        {

            try
            {
                ct_cbtecble_Info info_diario = new ct_cbtecble_Info();
                info_diario.lst_ct_cbtecble_det = info.lst_provisiones;
                info_diario.IdEmpresa = info.IdEmpresa;
                info_diario.IdTipoCbte = TipoComprobante;
                info_diario.cb_Fecha = info.Fechacontabilizacion;
                info_diario.IdPeriodo = Convert.ToInt32(info.Fechacontabilizacion.Year.ToString() + info.Fechacontabilizacion.Month.ToString().PadLeft(2, '0'));
                info_diario.cb_Anio = info.Fechacontabilizacion.Year;
                info_diario.cb_mes = info.Fechacontabilizacion.Month;
                info_diario.cb_Observacion = "Contabilización rol general del periodo " + info.IdPeriodo.ToString();
                info_diario.cb_Valor = info.lst_sueldo_x_pagar.Sum(v => v.dc_Valor);
                info_diario.IdUsuario = info.UsuarioIngresa;
                info_diario.cb_FechaTransac = DateTime.Now;
                info_diario.cb_Estado = "A";
                info_diario.IdUsuario = info.UsuarioIngresa;

                return info_diario;
            }
            catch (Exception)
            {

                throw;
            }
        }
        // funciones para decimos
        public bool Decimos(ro_rol_Info info)
        {
            try
            {
                info.region = "COSTA";
                if (info.decimoIII)
                    odata.procesarDIII(info);
                else
                    odata.procesarIV(info);
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        // generar ordenes de pagos
        public List<cp_orden_pago_Info> get_op_x_empleados(List<ro_rol_detalle_Info> lista_rol_detalle, cp_orden_pago_tipo_x_empresa_Info tipo_op)
        {
            try
            {
                List<cp_orden_pago_Info> lista_op = new List<cp_orden_pago_Info>();
                lista_rol_detalle.ForEach(item =>

                {

                    lista_op.Add(
                        new cp_orden_pago_Info
                        {

                            IdEmpresa = item.IdEmpresa,
                            Observacion = "Cancelacion sueldo y salarios de " + (item.pe_nombreCompleato)==null?" ":item.pe_nombreCompleato,
                            IdTipo_op = cl_enumeradores.eTipoOrdenPago.ANTI_EMPLE.ToString(),
                            IdTipo_Persona = cl_enumeradores.eTipoPersona.EMPLEA.ToString(),
                            IdPersona = item.IdPersona,
                            IdEntidad = item.IdEmpleado,
                            Fecha = item.pe_FechaFin,
                            Fecha_Pago = item.pe_FechaFin,
                            IdEstadoAprobacion = cl_enumeradores.eEstadoAprobacionOrdenPago.APRO.ToString(),
                            IdFormaPago = cl_enumeradores.eFormaPagoOrdenPago.CHEQUE.ToString(),
                            Estado = "A",
                            Fecha_Transac = DateTime.Now,
                            IdEmpleado=item.IdEmpleado,
                            
                            
                            detalle = new List<cp_orden_pago_det_Info>
                            {
                                new cp_orden_pago_det_Info
                                {
                                    IdEmpresa=item.IdEmpresa,
                                    Secuencia=1,
                                    Valor_a_pagar=item.Valor,
                                    Referencia="Periodo "+item.IdPeriodo,
                                    Fecha_Pago=item.pe_FechaFin,
                                    IdEstadoAprobacion = cl_enumeradores.eEstadoAprobacionOrdenPago.APRO.ToString(),
                                    IdFormaPago = cl_enumeradores.eFormaPagoOrdenPago.CHEQUE.ToString(),
                                }
                            },
                            info_comprobante=new ct_cbtecble_Info
                            {
                                IdEmpresa = info.IdEmpresa,
                                cb_Fecha = item.pe_FechaFin,
                                cb_Anio = item.pe_FechaFin.Year,
                                cb_mes = item.pe_FechaFin.Month,
                                IdTipoCbte=1,
                                cb_Estado = "A",
                                IdPeriodo = Convert.ToInt32(item.pe_FechaFin.Year.ToString() + item.pe_FechaFin.Month.ToString().PadLeft(2, '0')),
                                cb_Observacion = "Cancelación de sueldo del "+item.IdPeriodo+" ha "+item.pe_nombreCompleato,
                                lst_ct_cbtecble_det=new List<ct_cbtecble_det_Info>
                                {
                                    new ct_cbtecble_det_Info
                                    {
                                        IdEmpresa=item.IdEmpresa,
                                        IdTipoCbte=1,
                                        IdCtaCble=info_tipo_op.IdCtaCble,
                                        dc_Valor=item.Valor,
                                        dc_Observacion="Cancelación de sueldo del "+item.IdPeriodo+" ha "+item.pe_nombreCompleato,
                                        secuencia=1,
                                    },
                                    new ct_cbtecble_det_Info
                                    {
                                         IdEmpresa=item.IdEmpresa,
                                        IdTipoCbte=1,
                                        IdCtaCble=info_tipo_op.IdCtaCble,
                                        dc_Valor=item.Valor*-1,
                                        dc_Observacion="Cancelación de sueldo del "+item.IdPeriodo+" ha "+item.pe_nombreCompleato,
                                        secuencia=2,
                                    }
                                     
                                }
                                 
                             }
                           
                        });
                    
                });
                return lista_op;
            }
            catch (Exception)
            {

                
                throw;
            }
        }

    }
}
