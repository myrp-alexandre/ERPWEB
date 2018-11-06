using Core.Erp.Bus.Contabilidad;
using Core.Erp.Data.CuentasPorPagar;
using Core.Erp.Data.General;
using Core.Erp.Info.CuentasPorPagar;
using Core.Erp.Info.General;
using Core.Erp.Info.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
namespace Core.Erp.Bus.CuentasPorPagar
{
    public class cp_retencion_Bus
    {

        #region Variables
        cp_retencion_Data odata = new cp_retencion_Data();
        cp_orden_giro_Data o_data_orden_giro = new cp_orden_giro_Data();
        cp_retencion_Info info_retencion = new cp_retencion_Info();
        cp_orden_giro_Info info_orden_giro = new cp_orden_giro_Info();
        tb_sis_Documento_Tipo_Talonario_Data data_talonario = new tb_sis_Documento_Tipo_Talonario_Data();
        tb_sis_Documento_Tipo_Talonario_Info info_talonario = new tb_sis_Documento_Tipo_Talonario_Info();
        ct_cbtecble_Bus bus_comprobante = new ct_cbtecble_Bus();
        cp_retencion_x_ct_cbtecble_Info info_comp_x_retencion = new cp_retencion_x_ct_cbtecble_Info();
        cp_retencion_x_ct_cbtecble_Data data_comp_x_retencion = new cp_retencion_x_ct_cbtecble_Data();
        ct_cbtecble_det_Bus bus_comprobante_det = new ct_cbtecble_det_Bus();
        ct_periodo_Bus bus_periodo = new ct_periodo_Bus();
        cp_retencion_det_Data data_retencion_der = new cp_retencion_det_Data();
        #endregion
        public List<cp_retencion_Info> get_list(int IdEmpresa, DateTime Fechaini, DateTime FechaFin)
        {
            try
            {
                return odata.get_list(IdEmpresa,Fechaini, FechaFin);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public cp_retencion_Info get_info(int IdEmpresa,decimal IdRetencion)
        {
            try
            {
                cp_retencion_Info info = new cp_retencion_Info();

                info= odata.get_info(IdEmpresa,IdRetencion);
                info.detalle = data_retencion_der.get_list(info.IdEmpresa, info.IdRetencion);
                if (info.ct_IdCbteCble != null)
                    info.info_comprobante = bus_comprobante.get_info(info.IdEmpresa, (int)info.ct_IdTipoCbte, (decimal)info.ct_IdCbteCble);
                else
                    info.info_comprobante = new Info.Contabilidad.ct_cbtecble_Info();

                if (info.ct_IdCbteCble != null)
                    info.info_comprobante.lst_ct_cbtecble_det = bus_comprobante_det.get_list(info.IdEmpresa, (int)info.ct_IdTipoCbte, (decimal)info.ct_IdCbteCble);
                else
                    info.info_comprobante.lst_ct_cbtecble_det = new List<Info.Contabilidad.ct_cbtecble_det_Info>();
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public cp_retencion_Info get_info_factura(int IdEmpresa, int IdTipoCbte_Ogiro, decimal IdCbteCble_Ogiro)
        {
            try
            {

                // ultima retencion no usada
                info_talonario = data_talonario.get_info_ultimo_no_usado(IdEmpresa, "RETEN");
                info_orden_giro = o_data_orden_giro.get_info_retencion(IdEmpresa, IdTipoCbte_Ogiro, IdCbteCble_Ogiro);

                info_retencion.IdEmpresa = info_orden_giro.IdEmpresa;
                info_retencion.IdProveedor = info_orden_giro.IdProveedor;
                info_retencion.serie1 = info_talonario.Establecimiento;
                info_retencion.serie2 = info_talonario.PuntoEmision;
                info_retencion.NumRetencion = info_talonario.NumDocumento;
                info_retencion.IdTipoCbte_Ogiro = info_orden_giro.IdTipoCbte_Ogiro;
                info_retencion.IdCbteCble_Ogiro = info_orden_giro.IdCbteCble_Ogiro;
                info_retencion.co_baseImponible = info_orden_giro.co_total;
                info_retencion.co_serie = info_orden_giro.co_serie;
                info_retencion.co_factura = info_orden_giro.co_factura;
                info_retencion.co_subtotal_iva = info_orden_giro.co_subtotal_iva;
                info_retencion.co_valoriva = info_orden_giro.co_valoriva;
                info_retencion.co_subtotal_siniva = info_orden_giro.co_subtotal_siniva;
                info_retencion.Descripcion = info_orden_giro.Descripcion;
                info_retencion.pe_razonSocial = info_orden_giro.info_proveedor.info_persona.pe_razonSocial;
                info_retencion.observacion = info_orden_giro.co_observacion;
                info_retencion.fecha = info_orden_giro.co_FechaFactura;
                return info_retencion;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(cp_retencion_Info info)
        {
            try
            {
                odata = new cp_retencion_Data();
                info.IdEmpresa_Ogiro = info.IdEmpresa;
                info.CodDocumentoTipo = "RETEN";
                if(info.re_Tiene_RFuente == null) 
                 info.re_Tiene_RFuente="N";
                if (info.re_Tiene_RTiva == null)
                    info.re_Tiene_RTiva = "N";
                info.re_EstaImpresa = "N";
                info.info_comprobante.IdEmpresa = info.IdEmpresa;
                info.info_comprobante.cb_Fecha = (DateTime)info.fecha;
                info.info_comprobante.cb_Anio = info.info_comprobante.cb_Fecha.Year;
                info.info_comprobante.cb_mes = info.info_comprobante.cb_Fecha.Month;
                info.info_comprobante.cb_Estado = "A";
                info.info_comprobante.IdPeriodo = Convert.ToInt32(info.info_comprobante.cb_Fecha.Year.ToString() + info.info_comprobante.cb_Fecha.Month.ToString().PadLeft(2, '0'));
                info.info_comprobante.IdEmpresa = info.IdEmpresa;
                info.info_comprobante.cb_Observacion = info.observacion;
                if (bus_comprobante.guardarDB(info.info_comprobante))
                {
                    if (odata.guardarDB(info))
                    {
                        info_comp_x_retencion.ct_IdEmpresa = info.IdEmpresa;
                        info_comp_x_retencion.rt_IdRetencion = info.IdRetencion;
                        info_comp_x_retencion.ct_IdTipoCbte = info.info_comprobante.IdTipoCbte;
                        info_comp_x_retencion.ct_IdCbteCble = info.info_comprobante.IdCbteCble;
                        info_comp_x_retencion.Observacion = info.observacion;
                        data_comp_x_retencion.guardarDB(info_comp_x_retencion);


                        info_talonario.IdEmpresa = info.IdEmpresa;
                        info_talonario.Establecimiento = info.serie1;
                        info_talonario.PuntoEmision = info.serie2;
                        info_talonario.NumDocumento = info.NumRetencion;
                        info_talonario.Usado = true;
                        info_talonario.CodDocumentoTipo = "RETEN";
                        data_talonario.modificar_estado_usadoDB(info_talonario);
                        return true;
                    }
                    else
                        return false;

                }
                else
                    return false;

            }
            catch (Exception )
            {

                throw;
            }
        }
        public bool modificarDB(cp_retencion_Info info)
        {
            try
            {
                odata = new cp_retencion_Data();
                info.IdEmpresa_Ogiro = info.IdEmpresa;
                info.CodDocumentoTipo = "RETEN";
                if (info.re_Tiene_RFuente == null)
                    info.re_Tiene_RFuente = "N";
                if (info.re_Tiene_RTiva == null)
                    info.re_Tiene_RTiva = "N";
                info.re_EstaImpresa = "N";
                info.info_comprobante.IdEmpresa = info.IdEmpresa;
                info.info_comprobante.cb_Fecha = (DateTime)info.fecha;
                info.info_comprobante.cb_Anio = info.info_comprobante.cb_Fecha.Year;
                info.info_comprobante.cb_mes = info.info_comprobante.cb_Fecha.Month;
                info.info_comprobante.cb_Estado = "A";
                info.info_comprobante.IdPeriodo = Convert.ToInt32(info.info_comprobante.cb_Fecha.Year.ToString() + info.info_comprobante.cb_Fecha.Month.ToString().PadLeft(2, '0'));
                info.info_comprobante.IdEmpresa = info.IdEmpresa;
                info.info_comprobante.cb_Observacion = info.observacion;
                if (info.info_comprobante.IdCbteCble != 0)
                {
                    if (bus_comprobante.modificarDB(info.info_comprobante))
                    {
                        if (odata.modificarDB(info))
                        {
                            data_retencion_der.eliminarDB(info.IdEmpresa, info.IdRetencion);
                            data_retencion_der.guardarDB(info);
                            return true;
                        }
                        else
                            return false;

                    }
                    else
                        return false;
                }
                else
                {
                    if (bus_comprobante.guardarDB(info.info_comprobante))
                    {
                            info_comp_x_retencion.ct_IdEmpresa = info.IdEmpresa;
                            info_comp_x_retencion.rt_IdRetencion = info.IdRetencion;
                            info_comp_x_retencion.ct_IdTipoCbte = info.info_comprobante.IdTipoCbte;
                            info_comp_x_retencion.ct_IdCbteCble = info.info_comprobante.IdCbteCble;
                            info_comp_x_retencion.Observacion = info.observacion;
                            data_comp_x_retencion.guardarDB(info_comp_x_retencion);


                            info_talonario.IdEmpresa = info.IdEmpresa;
                            info_talonario.Establecimiento = info.serie1;
                            info_talonario.PuntoEmision = info.serie2;
                            info_talonario.NumDocumento = info.NumRetencion;
                            info_talonario.Usado = true;
                            info_talonario.CodDocumentoTipo = "RETEN";
                            data_talonario.modificar_estado_usadoDB(info_talonario);
                            return true;
                    }
                    else
                        return false;
                }       

            }
            catch (Exception )
            {

                throw;
            }
        }
        public bool anularDB(cp_retencion_Info info)
        {

            try
            {
                odata = new cp_retencion_Data();
                info.IdEmpresa_Ogiro = info.IdEmpresa;
                info.CodDocumentoTipo = "RETEN";
                if (info.re_Tiene_RFuente == null)
                    info.re_Tiene_RFuente = "N";
                if (info.re_Tiene_RTiva == null)
                    info.re_Tiene_RTiva = "N";
                info.re_EstaImpresa = "N";
                info.info_comprobante.IdEmpresa = info.IdEmpresa;
                info.info_comprobante.cb_Fecha = (DateTime)info.fecha;
                info.info_comprobante.cb_Anio = info.info_comprobante.cb_Fecha.Year;
                info.info_comprobante.cb_mes = info.info_comprobante.cb_Fecha.Month;
                info.info_comprobante.cb_Estado = "A";
                info.info_comprobante.IdPeriodo = Convert.ToInt32(info.info_comprobante.cb_Fecha.Year.ToString() + info.info_comprobante.cb_Fecha.Month.ToString().PadLeft(2, '0'));
                info.info_comprobante.IdEmpresa = info.IdEmpresa;
                info.info_comprobante.cb_Observacion = info.observacion;
                if (bus_comprobante.anularDB(info.info_comprobante))
                {
                    if (odata.anularDB(info))
                    {

                        return true;
                    }
                    else
                        return false;

                }
                else
                    return false;

            }
            catch (Exception )
            {

                throw;
            }
        }
        public string validar(cp_retencion_Info info)
        {
            try
            {
                string mensaje = "";

                if (!bus_periodo.ValidarFechaTransaccion(info.IdEmpresa, info.fecha, cl_enumeradores.eModulo.CONTA, ref mensaje))
                {
                    return mensaje;
                }

                if (!bus_periodo.ValidarFechaTransaccion(info.IdEmpresa, info.fecha, cl_enumeradores.eModulo.CXP, ref mensaje))
                {
                    return mensaje;
                }

                if (info.co_serie == "" | info.co_serie == null)
                {
                    mensaje = "Ingrese la serie del documento";
                    return mensaje;
                }
                if (info.serie1 == "" | info.serie1 == null)
                {
                    mensaje = "Ingrese serie de la retención";
                    return mensaje;
                }
                if (info.serie2 == "" | info.serie2 == null)
                {
                    mensaje = "Ingrese serie de la retención";
                    return mensaje;
                }
                if (info.NumRetencion == "" | info.NumRetencion == null)
                {
                    mensaje = "No existe talonario de retención";
                    return mensaje;
                }
                if (info.co_factura == "" | info.co_factura == null)
                {
                    mensaje = "Ingrese el número del documento";
                    return mensaje;
                }
               
               if(info.info_comprobante.lst_ct_cbtecble_det == null)
                {
                    mensaje = "No existe detalle";
                }
                else
                info.info_comprobante.lst_ct_cbtecble_det.ForEach(item =>
                {
                    if (item.IdCtaCble == null | item.IdCtaCble == "")
                        mensaje = "Falta cuenta contable " + item.dc_Observacion;
                });

                double valor = Convert.ToInt32(info.info_comprobante.lst_ct_cbtecble_det.Sum(v => v.dc_Valor));
                if (valor != 0)
                    mensaje = "El diario contable esta descuadrado ";

               
                return mensaje;

            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
