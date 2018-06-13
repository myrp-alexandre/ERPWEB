using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Data.CuentasPorPagar;
using Core.Erp.Info.CuentasPorPagar;
using Core.Erp.Bus.Contabilidad;
namespace Core.Erp.Bus.CuentasPorPagar
{
   public class cp_orden_giro_Bus
    {
        cp_orden_giro_Data data = new cp_orden_giro_Data();
        ct_cbtecble_Bus bus_contabilidad = new ct_cbtecble_Bus();
        cp_cuotas_x_doc_Bus bus_cuotas = new cp_cuotas_x_doc_Bus();
        ct_cbtecble_det_Bus bus_comrpbante_det = new ct_cbtecble_det_Bus();
        public List<cp_orden_giro_Info> get_lst(int IdEmpresa, DateTime fi, DateTime ff)
        {
            try
            {
                return data.get_lst(IdEmpresa, fi,ff);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(cp_orden_giro_Info info)
        {
            try
            {
                info.info_comrobante.IdEmpresa = info.IdEmpresa;
                info.info_comrobante.cb_Fecha =(DateTime) info.co_FechaContabilizacion;
                info.info_comrobante.cb_Anio = info.info_comrobante.cb_Fecha.Year;
                info.info_comrobante.cb_mes = info.info_comrobante.cb_Fecha.Month;
                info.info_comrobante.cb_Estado = "A";
                info.info_comrobante.IdPeriodo =Convert.ToInt32( info.info_comrobante.cb_Fecha.Year.ToString() + info.info_comrobante.cb_Fecha.Month.ToString().PadLeft(2,'0'));
                info.info_comrobante.IdEmpresa = info.IdEmpresa;
                info.info_comrobante.cb_Observacion = info.co_observacion;

                info.co_valorpagar = info.co_total;
                if (info.info_cuota.Total_a_pagar == 0)
                    info.co_FechaFactura_vct = info.co_FechaFactura;
                else
                    info.co_FechaFactura_vct = info.info_cuota.Fecha_inicio;
                info.co_fechaOg = info.co_FechaFactura;
                if (bus_contabilidad.guardarDB(info.info_comrobante))
                {
                    data = new cp_orden_giro_Data();
                    info.IdTipoCbte_Ogiro = info.info_comrobante.IdTipoCbte;
                    info.IdCbteCble_Ogiro = info.info_comrobante.IdCbteCble;
                    data.guardarDB(info);
                }

                if(info.info_cuota.Dias_plazo!=0
                    & info.info_cuota.Total_a_pagar!=0
                    & info.info_cuota.lst_cuotas_det.Count()>0
                  )
                {
                    info.info_cuota.IdEmpresa = info.IdEmpresa;
                    info.info_cuota.IdTipoCbte = info.info_comrobante.IdTipoCbte;
                    info.info_cuota.IdCbteCble = info.info_comrobante.IdCbteCble;
                    info.info_cuota.Observacion = info.co_observacion;
                    info.info_cuota.Estado = true;

                    bus_cuotas.GuardarDB(info.info_cuota);
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(cp_orden_giro_Info info)
        {
            try
            {
                info.info_comrobante.IdEmpresa = info.IdEmpresa;
                info.info_comrobante.IdTipoCbte = info.IdTipoCbte_Ogiro;
                info.info_comrobante.IdCbteCble = info.IdCbteCble_Ogiro;
                info.info_comrobante.cb_Fecha = (DateTime)info.co_FechaContabilizacion;
                info.info_comrobante.cb_Anio = info.info_comrobante.cb_Fecha.Year;
                info.info_comrobante.cb_mes = info.info_comrobante.cb_Fecha.Month;
                info.info_comrobante.cb_Estado = "A";
                info.info_comrobante.IdPeriodo = Convert.ToInt32(info.info_comrobante.cb_Fecha.Year.ToString() + info.info_comrobante.cb_Fecha.Month.ToString().PadLeft(2, '0'));
                info.info_comrobante.IdEmpresa = info.IdEmpresa;
                info.info_comrobante.cb_Observacion = info.co_observacion;

                info.co_valorpagar = info.co_total;
                if (info.info_cuota.Total_a_pagar == 0)
                    info.co_FechaFactura_vct = info.co_FechaFactura;
                else
                {
                    info.co_FechaFactura_vct = info.info_cuota.Fecha_inicio;
                }
                info.co_fechaOg = info.co_FechaFactura;
                if (bus_contabilidad.modificarDB(info.info_comrobante))
                {
                    data = new cp_orden_giro_Data();
                    info.IdTipoCbte_Ogiro = info.IdTipoCbte_Ogiro;
                    info.IdCbteCble_Ogiro = info.IdCbteCble_Ogiro;
                    data.modificarDB(info);
                }

                if (info.info_cuota.Dias_plazo != 0
                    & info.info_cuota.Total_a_pagar != 0
                    & info.info_cuota.lst_cuotas_det.Count() > 0
                  )
                {
                    info.info_cuota.IdEmpresa = info.IdEmpresa;
                    info.info_cuota.IdTipoCbte = info.IdTipoCbte_Ogiro;
                    info.info_cuota.IdCbteCble = info.IdCbteCble_Ogiro;
                    info.info_cuota.Observacion = info.co_observacion;
                    info.info_cuota.Estado = true;
                    bus_cuotas.ModificarDB(info.info_cuota);
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool anularDB(cp_orden_giro_Info info)
        {
            try
            {
                info.info_comrobante.IdEmpresa = info.IdEmpresa;
                info.info_comrobante.cb_Fecha = (DateTime)info.co_FechaContabilizacion;
                info.info_comrobante.cb_Anio = info.info_comrobante.cb_Fecha.Year;
                info.info_comrobante.cb_mes = info.info_comrobante.cb_Fecha.Month;
                info.info_comrobante.cb_Estado = "A";
                info.info_comrobante.IdPeriodo = Convert.ToInt32(info.info_comrobante.cb_Fecha.Year.ToString() + info.info_comrobante.cb_Fecha.Month.ToString().PadLeft(2, '0'));
                info.info_comrobante.IdEmpresa = info.IdEmpresa;
                info.info_comrobante.cb_Observacion = info.co_observacion+" ANULADO";

                info.co_valorpagar = info.co_total;
                if (info.info_cuota.Total_a_pagar == 0)
                    info.co_FechaFactura_vct = info.co_FechaFactura;
                else
                    info.co_FechaFactura_vct = info.info_cuota.Fecha_inicio;
                info.co_fechaOg = info.co_FechaFactura;
              
                if (bus_contabilidad.anularDB(info.info_comrobante))
                {
                    data = new cp_orden_giro_Data();
                    info.IdTipoCbte_Anulacion = info.info_comrobante.IdTipoCbte;
                    info.IdCbteCble_Anulacion = info.info_comrobante.IdCbteCble;
                    data.anularDB(info);
                }

                if (info.info_cuota.Dias_plazo != 0
                    & info.info_cuota.Total_a_pagar != 0
                    & info.info_cuota.lst_cuotas_det.Count() > 0
                  )
                {
                    info.info_cuota.IdEmpresa = info.IdEmpresa;
                    info.info_cuota.IdTipoCbte = info.IdTipoCbte_Ogiro;
                    info.info_cuota.IdCbteCble = info.IdCbteCble_Ogiro;
                    info.info_cuota.Observacion = info.co_observacion+"ANULADO";
                    bus_cuotas.AnularDB(info.info_cuota);
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }


        public cp_orden_giro_Info get_info(int IdEmpresa, int IdTipoCbte_Ogiro, decimal IdCbteCble_Ogiro)
        {
            try
            {
                cp_orden_giro_Info info = new cp_orden_giro_Info();
                info= data.get_info(IdEmpresa,IdTipoCbte_Ogiro, IdCbteCble_Ogiro);
                info.info_comrobante = bus_contabilidad.get_info(IdEmpresa, IdTipoCbte_Ogiro, IdCbteCble_Ogiro);
                info.info_comrobante.lst_ct_cbtecble_det = bus_comrpbante_det.get_list(IdEmpresa, IdTipoCbte_Ogiro, IdCbteCble_Ogiro);
                info.info_cuota = bus_cuotas.get_info(IdEmpresa, IdTipoCbte_Ogiro, IdCbteCble_Ogiro);
                if (info.info_cuota == null)
                    info.info_cuota = new cp_cuotas_x_doc_Info();
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public string validar(cp_orden_giro_Info info)
        {
            try
            {


                string mensaje = "";
                if (info.IdSucursal == 0 | info.IdSucursal == null)
                {
                    mensaje = "Selecciona la sucursal";
                    return mensaje;
                }
                if (info.IdProveedor == 0)
                {
                    mensaje = "Selecciona el proveedor";
                    return mensaje;
                }
                if (info.IdTipoServicio == "")
                {
                    mensaje = "Selecciona el tipo de servicio";
                    return mensaje;
                }
                if (info.IdIden_credito == 0)
                {
                    mensaje = "Selecciona el tipo de sustento tributario";
                    return mensaje;
                }
            
                if (info.IdOrden_giro_Tipo == ""| info.IdOrden_giro_Tipo==null)
                { 
                    mensaje = "Selecciona el tipo de documento";
                    return mensaje;
                }
                if (info.co_serie == "" | info.co_serie == null)
                { 
                    mensaje = "Ingrese seri del documento";
                    return mensaje;
                }
                if (info.co_factura == "" | info.co_factura == null)
                {
                    mensaje = "Ingrese el número del documento";
                    return mensaje;
                }
                if (info.Num_Autorizacion == "" | info.Num_Autorizacion == null)
                { 
                    mensaje = "Ingrese el número de autorización";
                    return mensaje;
                }
                if (info.co_observacion == "" | info.co_observacion == null)
                { 
                    mensaje = "Ingrese la observación";
                    return mensaje;
                }
                if (info.PagoLocExt == "EXT")
                {
                    if(info.PaisPago=="" | info.PaisPago==null)
                    { 
                    mensaje = "Seleccion el país donde se realiza el pago";
                        return mensaje;
                    }
                }
                if (info.co_total == 0 )
                {
                    mensaje = "El monto de la factura no puede ser cero";
                    return mensaje;
                }
                info.info_comrobante.lst_ct_cbtecble_det.ForEach(item =>
                {
                    if (item.IdCtaCble == null | item.IdCtaCble == "")
                        mensaje = "Falta cuenta contable " + item.dc_Observacion;
                });

                if(Convert.ToDouble( info.info_comrobante.lst_ct_cbtecble_det.Sum(v => v.dc_Valor))!=0)
                    mensaje = "El diario contable esta descuadrado ";

                if(info.info_cuota.Total_a_pagar!=0)
                {
                    if(info.info_cuota.lst_cuotas_det.Count()==0)
                        mensaje = "No existe detalle de pago";

                }
                return mensaje;

            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
