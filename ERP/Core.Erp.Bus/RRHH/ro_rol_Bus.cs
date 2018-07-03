using Core.Erp.Data.Contabilidad;
using Core.Erp.Data.RRHH;
using Core.Erp.Info.Contabilidad;
using Core.Erp.Info.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
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

        ro_Comprobantes_Contables_Data ro_comprobante = new ro_Comprobantes_Contables_Data();
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
                        valorTotal = oListro_rol_detalle_Info.Where(v => v.IdDivision == Convert.ToInt32(item.IdDivision) 
                                                                    && v.IdArea == item.IdArea 
                                                                    && v.IdDepartamento == item.IdDepartamento 
                                                                    && v.IdRubro == item.IdRubro ).Sum(v =>v.Valor);
                    if (valorTotal > 0)
                    {
                        secuecia++;
                        ct_cbtecble_det_Info oct_cbtecble_det_Info = new ct_cbtecble_det_Info();
                        oct_cbtecble_det_Info.secuencia = secuecia;
                        oct_cbtecble_det_Info.IdEmpresa = idEmpresa;
                        oct_cbtecble_det_Info.IdTipoCbte = 1;
                        oct_cbtecble_det_Info.IdCtaCble = item.IdCtaCble.Trim();
                        oct_cbtecble_det_Info.IdCentroCosto = item.IdCentroCosto;
                        if (item.DebCre == "C")
                        {
                            egreso = egreso + valorTotal;
                            valorTotal = valorTotal * -1;
                            oct_cbtecble_det_Info.dc_Valor_debe = valorTotal;
                        }
                        else if (item.DebCre == "D")
                        {
                            ingreso = ingreso + valorTotal;
                            oct_cbtecble_det_Info.dc_Valor_haber = valorTotal;
                        }
                        oct_cbtecble_det_Info.dc_Valor = valorTotal;
                        oct_cbtecble_det_Info.dc_Observacion = item.ru_descripcion.Trim() + " " + item.DescripcionDiv.Trim() + " " + item.DescripcionArea.Trim() + " " + item.de_descripcion.Trim();
                        lst_detalle_diario.Add(oct_cbtecble_det_Info);
                    }
                                                    
                }

                double valorSueldoXPagar = 0;
                valorSueldoXPagar = ingreso - egreso;
                secuecia++;
                ct_cbtecble_det_Info oct_cbtecble_det_Info2 = new ct_cbtecble_det_Info();
                oct_cbtecble_det_Info2.secuencia = secuecia;
                oct_cbtecble_det_Info2.IdEmpresa = idEmpresa;
                oct_cbtecble_det_Info2.IdTipoCbte =1; //DIARIO CONTABLE                                
                oct_cbtecble_det_Info2.IdCtaCble = info_cta_sueldo_x_pagar.IdCtaCble;
                oct_cbtecble_det_Info2.dc_Valor = valorSueldoXPagar * -1;
                oct_cbtecble_det_Info2.dc_Valor_debe = valorSueldoXPagar * -1;
                oct_cbtecble_det_Info2.dc_Observacion = "Sueldo por Pagar Neto a Recibir al " + idPeriodo;
                lst_detalle_diario.Add(oct_cbtecble_det_Info2);

                return lst_detalle_diario;
            }
            catch (Exception )
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
                    valorTotal = oListro_rol_detalle_Info.Where(v => v.IdDivision == Convert.ToInt32(item.IdDivision)
                                                                && v.IdArea == item.IdArea
                                                                && v.IdDepartamento == item.IdDepartamento
                                                                && v.IdRubro == item.IdRubro).Sum(v => v.Valor);
                    if (valorTotal > 0)
                    {
                        secuencia++;
                        ct_cbtecble_det_Info oct_cbtecble_det_Info = new ct_cbtecble_det_Info();
                        oct_cbtecble_det_Info.secuencia = secuencia;
                        oct_cbtecble_det_Info.IdEmpresa = idEmpresa;
                        oct_cbtecble_det_Info.IdTipoCbte = 1;
                        oct_cbtecble_det_Info.IdCtaCble = item.IdCtaCble.Trim();
                        oct_cbtecble_det_Info.dc_Valor_debe = valorTotal;
                        oct_cbtecble_det_Info.dc_Observacion = item.ru_descripcion.Trim() + " " + item.DescripcionDiv.Trim() + " " + item.DescripcionArea.Trim() + " " + item.de_descripcion.Trim();
                        lst_detalle_diario.Add(oct_cbtecble_det_Info);

                        secuencia++;
                        ct_cbtecble_det_Info oct_cbtecble_det_Info2 = new ct_cbtecble_det_Info();
                        oct_cbtecble_det_Info2.secuencia = secuencia;
                        oct_cbtecble_det_Info2.IdEmpresa = idEmpresa;
                        oct_cbtecble_det_Info2.IdTipoCbte = 1;
                        oct_cbtecble_det_Info2.IdCtaCble = item.IdCtaCble_Haber.Trim(); 
                        oct_cbtecble_det_Info2.dc_Valor_haber = valorTotal * -1;
                        oct_cbtecble_det_Info2.dc_Observacion = item.ru_descripcion.Trim() + " " + item.DescripcionDiv.Trim() + " " + item.DescripcionArea.Trim() + " " + item.de_descripcion.Trim();
                        lst_detalle_diario.Add(oct_cbtecble_det_Info2);
                    }
                }

              
                return lst_detalle_diario;
            }
            catch (Exception )
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

    }
}
