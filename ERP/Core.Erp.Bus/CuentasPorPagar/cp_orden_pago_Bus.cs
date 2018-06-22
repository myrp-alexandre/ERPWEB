using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.CuentasPorPagar;
using Core.Erp.Data.CuentasPorPagar;
using Core.Erp.Bus.Contabilidad;
namespace Core.Erp.Bus.CuentasPorPagar
{
   public class cp_orden_pago_Bus
    {
        cp_orden_pago_Data oData = new cp_orden_pago_Data();
        cp_orden_pago_det_Data odata_detalle = new cp_orden_pago_det_Data();

        ct_cbtecble_Bus bus_contabilidad = new ct_cbtecble_Bus();
        cp_proveedor_Info info_proveedore = new cp_proveedor_Info();
        cp_proveedor_Bus bus_proveedor = new cp_proveedor_Bus();
        ct_cbtecble_det_Bus bus_contabilidad_det = new ct_cbtecble_det_Bus();

        public List<cp_orden_pago_Info> get_list(int IdEmpresa)
        {
            try
            {
                return oData.get_list(IdEmpresa);
            }
            catch (Exception)
            {
                throw;
            }
        }
        public List<cp_orden_pago_det_Info> Get_List_orden_pago_con_saldo(int IdEmpresa, string IdTipo_op, decimal IdProveedor, string IdEstado_Aprobacion, string IdUsuario)
        {
            try
            {
                return oData.Get_List_orden_pago_con_saldo(IdEmpresa,IdTipo_op, IdProveedor, IdEstado_Aprobacion, IdUsuario);
            }
            catch (Exception)
            {
                throw;
            }
        }


        public cp_orden_pago_Info get_info(int IdEmpresa, decimal IdOrdenPago)
        {
            try
            {
                cp_orden_pago_Info info_ = new cp_orden_pago_Info();
                info_= oData.get_info(IdEmpresa, IdOrdenPago);

                info_.detalle = odata_detalle.Get_list_cuotas_x_doc_det(IdEmpresa, IdOrdenPago);
                info_.info_comprobante = bus_contabilidad.get_info(info_.IdEmpresa, Convert.ToInt32(info_.detalle.FirstOrDefault().IdTipoCbte_cxp), Convert.ToInt32(info_.detalle.FirstOrDefault().IdCbteCble_cxp));
                info_.info_comprobante.lst_ct_cbtecble_det = bus_contabilidad_det.get_list(info_.IdEmpresa, info_.info_comprobante.IdTipoCbte,info_.info_comprobante.IdCbteCble);
                return info_;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public Boolean guardarDB(cp_orden_pago_Info info)
        {
            try
            {
                info_proveedore = bus_proveedor.get_info(info.IdEmpresa,Convert.ToInt32( info.IdEntidad));
                info.IdPersona = info_proveedore.IdPersona;

                info.info_comprobante.IdEmpresa = info.IdEmpresa;
                info.info_comprobante.cb_Fecha = (DateTime)info.Fecha_Pago;
                info.info_comprobante.cb_Anio = info.info_comprobante.cb_Fecha.Year;
                info.info_comprobante.cb_mes = info.info_comprobante.cb_Fecha.Month;
                info.info_comprobante.cb_Estado = "A";
                info.info_comprobante.IdPeriodo = Convert.ToInt32(info.info_comprobante.cb_Fecha.Year.ToString() + info.info_comprobante.cb_Fecha.Month.ToString().PadLeft(2, '0'));
                info.info_comprobante.IdEmpresa = info.IdEmpresa;
                info.info_comprobante.cb_Observacion = info.Observacion;

                if (bus_contabilidad.guardarDB(info.info_comprobante))
                {

                   
                    oData.guardarDB(info);
                }

                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public Boolean modificarDB(cp_orden_pago_Info info)
        {
            try
            {
                if (oData.modificarDB(info))
                {
                    bus_contabilidad.modificarDB(info.info_comprobante);

                    foreach (var item in info.detalle)
                    {
                        odata_detalle.modificarDB(item);

                    }
                }
                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public Boolean anularDB(cp_orden_pago_Info info)
        {
            try
            {
                if (oData.anularDB(info))
                {
                    bus_contabilidad.anularDB(info.info_comprobante);

                    foreach (var item in info.detalle)
                    {
                        odata_detalle.modificarDB(item);

                    }
                }
                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public string validar(cp_orden_pago_Info info)
        {
            try
            {
                string mensaje = "";

                if (info.detalle == null)
                    mensaje = "No existe detalle de pago";
                if (info.detalle.Count() == 0)
                    mensaje = "No existe detalle de pago";

                if (info.info_comprobante.lst_ct_cbtecble_det == null)
                    mensaje = "No existe diario contable";
                if (info.info_comprobante.lst_ct_cbtecble_det.Count() == 0)
                    mensaje = "No existe diario contable";

                if (info.info_comprobante.lst_ct_cbtecble_det.Sum(v=>v.dc_Valor)!=0)                    
                    mensaje = "El diario contable esta descudrado";
                if (info.IdEstadoAprobacion == null)
                    mensaje = "Falta esta aprovación en tipo OP";
                if (info.detalle == null)
                    mensaje = "Falta tipo comprobante contable en tipo OP";
                foreach (var item in info.info_comprobante.lst_ct_cbtecble_det)
                {
                    if (item.IdCtaCble==null | item.IdCtaCble == "")
                        mensaje = "Falta cuenta contable";
                }

                return mensaje;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public Boolean guardar_op_x_fpDB(cp_orden_pago_Info info)
        {
            try
            {
               
               

                    oData.guardarDB(info);
                

                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

    }
}
