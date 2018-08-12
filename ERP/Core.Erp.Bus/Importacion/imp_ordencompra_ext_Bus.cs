using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.Importacion;
using Core.Erp.Data.Importacion;
using Core.Erp.Data.Contabilidad;
using Core.Erp.Info.Inventario;
using Core.Erp.Bus.Inventario;
using Core.Erp.Bus.Contabilidad;

namespace Core.Erp.Bus.Importacion
{
  public  class imp_ordencompra_ext_Bus
    {
        #region variables
        imp_ordencompra_ext_Data odata = new imp_ordencompra_ext_Data();
        imp_ordencompra_ext_det_Data odata_det = new imp_ordencompra_ext_det_Data();
        imp_ordencompra_ext_Info info_oc = new imp_ordencompra_ext_Info();
        ct_cbtecble_det_Data comprobante_data = new ct_cbtecble_det_Data();
        List<imp_orden_compra_ext_ct_cbteble_det_gastos_Info> lst_gastos_nos_asignados = new List<imp_orden_compra_ext_ct_cbteble_det_gastos_Info>();
        List<imp_orden_compra_ext_ct_cbteble_det_gastos_Info> lst_gastos_asignados = new List<imp_orden_compra_ext_ct_cbteble_det_gastos_Info>();
        imp_orden_compra_ext_ct_cbteble_det_gastos_Data data_gastos = new imp_orden_compra_ext_ct_cbteble_det_gastos_Data();
        List<imp_ordencompra_ext_det_Info> lst_detalle = new List<imp_ordencompra_ext_det_Info>();
        in_Ing_Egr_Inven_Bus bus_ingreso = new in_Ing_Egr_Inven_Bus();
        ct_cbtecble_Bus bus_contabilidad = new ct_cbtecble_Bus();
        imp_parametro_Bus param_bus = new imp_parametro_Bus();
        imp_parametro_Info param = new imp_parametro_Info();

        #endregion
        public List<imp_ordencompra_ext_Info> get_list(int IdEmpresa)
        {
            try
            {
                return odata.get_list(IdEmpresa);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public List<imp_ordencompra_ext_Info> get_list(int IdEmpresa, DateTime fecha_inicio, DateTime Fecha_fin)
        {
            try
            {
                return odata.get_list(IdEmpresa, fecha_inicio, Fecha_fin);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public List<imp_ordencompra_ext_Info> get_list_oc_con_recepcion_mercaderia(int IdEmpresa, DateTime fecha_inicio, DateTime Fecha_fin)
        {
            try
            {
                return odata.get_list_oc_con_recepcion_mercaderia(IdEmpresa, fecha_inicio, Fecha_fin);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public imp_ordencompra_ext_Info get_liquidar_oc(int IdEmpresa, decimal IdOrdenCompra_ext)
        {
            try
            {
                info_oc = odata.get_info_recepcion_merca(IdEmpresa, IdOrdenCompra_ext);
                return info_oc;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public imp_ordencompra_ext_Info get_asignar_gastos(int IdEmpresa, decimal IdOrdenCompra_ext)
        {
            try
            {
                info_oc = odata.get_info_recepcion_merca(IdEmpresa, IdOrdenCompra_ext);
                info_oc.lst_gastos_por_asignar = new List<imp_orden_compra_ext_ct_cbteble_det_gastos_Info>();
                info_oc.lst_gastos_asignados = new List<imp_orden_compra_ext_ct_cbteble_det_gastos_Info>();
                info_oc.lst_detalle = new List<imp_ordencompra_ext_det_Info>();
                info_oc.lst_detalle = odata_det.get_list(IdEmpresa, IdOrdenCompra_ext);
                info_oc.lst_gastos_asignados = data_gastos.get_list_gastos_asignados(IdEmpresa, IdOrdenCompra_ext);
                info_oc.lst_gastos_por_asignar = data_gastos.get_list_gastos_no_asignados(IdEmpresa,  info_oc.IdCtaCble_importacion);
                return info_oc;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public imp_ordencompra_ext_Info get_info(int IdEmpresa, decimal IdOrdenCompra_ext)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdOrdenCompra_ext);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(imp_ordencompra_ext_Info info)
        {
            try
            {
                return odata.guardarDB(info);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool modificarDB(imp_ordencompra_ext_Info info)
        {
            try
            {
                odata_det.eliminar(info.IdEmpresa, info.IdOrdenCompra_ext);
                return odata.modificarDB(info);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool anularDB(imp_ordencompra_ext_Info info)
        {
            try
            {
                return odata.anularDB(info);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public string validar(imp_ordencompra_ext_Info info)
        {
            try
            {
                string mensaje = "";
                if (info.IdProveedor == 0)
                    mensaje = "Seleccione proveedor";
                if (info.IdCtaCble_importacion == ""|info.IdCtaCble_importacion==null)
                    mensaje = "Seleccione cuenta contable";
                if (info.lst_detalle == null)
                    mensaje = "No existe detalle para la orden de compra";
                if(info.lst_detalle!=null)
                if (info.lst_detalle.Count() == 0)
                        mensaje = "No existe detalle para la orden de compra";
                if (info.IdPais_embarque == "" | info.IdPais_embarque==null)
                    mensaje = "Seleccione país embarque";
                return mensaje;

            }
            catch (Exception)
            {
                throw;
            }
        }

        public string validar_liquidacion(imp_ordencompra_ext_Info model)
        {
            try
            {
                string mensaje = "";
                if (model.lst_comprobante == null)

                    mensaje = "No existe diario contable";
                else
                {
                    if (model.lst_comprobante.Count() == 0)
                    {
                        mensaje = "No existe diario contable";

                    }
                    else
                    {
                        foreach (var item in model.lst_comprobante)
                        {
                            if (item.IdCtaCble == "" | item.IdCtaCble == null)
                                mensaje = "Faltan cuentas contables";
                        }
                    }

                    double sum = model.lst_comprobante.Sum(v => v.dc_Valor);
                    if (sum>1| sum <0)
                        mensaje = "El diario esta descuadrado";

                }

                if (model.lst_detalle == null)
                    mensaje = "No existe detalle";
                else
                {
                    if (model.lst_comprobante.Count() == 0)
                    {
                        mensaje = "No existe detalle";
                    }
                    else
                    {
                        foreach (var item in model.lst_detalle)
                        {
                            if (item.od_costo_total == 0 | item.od_costo_total == null)
                                mensaje = "Faltan costo en uno de los registros";
                        }
                    }

                  

                }
                return mensaje;
            }
            catch (Exception)
            {

                throw;
            }
        }

        #region funciones de liquidacion de oc
        public bool guardarLiquidacionDB(imp_ordencompra_ext_Info info)
        {
            try
            {
                odata = new imp_ordencompra_ext_Data();
                info.info_comrobante = new Info.Contabilidad.ct_cbtecble_Info();
                info.info_comrobante.IdEmpresa = info.IdEmpresa;
                info.info_comrobante.cb_Fecha = (DateTime)info.oe_fecha_desaduanizacion;
                info.info_comrobante.cb_Anio = info.info_comrobante.cb_Fecha.Year;
                info.info_comrobante.cb_mes = info.info_comrobante.cb_Fecha.Month;
                info.info_comrobante.cb_Estado = "A";
                info.info_comrobante.IdPeriodo = Convert.ToInt32(info.info_comrobante.cb_Fecha.Year.ToString() + info.info_comrobante.cb_Fecha.Month.ToString().PadLeft(2, '0'));
                info.info_comrobante.IdEmpresa = info.IdEmpresa;
                info.info_comrobante.cb_Observacion = info.oe_observacion;
                info.info_comrobante.lst_ct_cbtecble_det = info.lst_comprobante;

                var info_inventario = get_ingreso(info);
                info_inventario.cm_fecha =Convert.ToDateTime( info.oe_fecha_desaduanizacion);
                info.info_comrobante.IdTipoCbte = param.IdTipoCbte_liquidacion;
                bus_ingreso.guardarDB(info_inventario,"+");
                bus_contabilidad.guardarDB(info.info_comrobante);

                info.IdEmpresa_ct =Convert.ToInt32( info.info_comrobante.IdEmpresa);
                info.IdTipoCbte_ct =Convert.ToInt32( info.info_comrobante.IdTipoCbte);
                info.IdCbteCble_ct =Convert.ToInt32( info.info_comrobante.IdCbteCble);

                info.IdEmpresa_inv =Convert.ToInt32( info_inventario.IdEmpresa);
                info.IdSucursal_inv =Convert.ToInt32( info_inventario.IdSucursal);
                info.IdMovi_inven_tipo_inv =Convert.ToInt32( info_inventario.IdMovi_inven_tipo);
                info.IdNumMovi_inv =Convert.ToInt32( info_inventario.IdNumMovi);

                odata.guardarLiquidacionDB(info);
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public List<imp_ordencompra_ext_det_Info> calcular_costos(int IdEmpresa, decimal IdOrdenCompraExter)
        {
            try
            {
                double costo_incurridos = 0;
                double valor_compra = 0;
                lst_detalle = odata_det.get_list(IdEmpresa, IdOrdenCompraExter);
                lst_gastos_asignados = data_gastos.get_list_gastos_asignados(IdEmpresa, IdOrdenCompraExter);
                if (lst_gastos_asignados != null)
                    costo_incurridos = lst_gastos_asignados.Sum(v => v.dc_Valor);
                if (lst_gastos_asignados != null)
                    valor_compra = Convert.ToDouble(lst_detalle.Sum(v => v.od_total_fob));
                foreach (var item in lst_detalle)
                {
                    item.od_factor_costo = (costo_incurridos + valor_compra) / valor_compra;
                    item.od_costo_bodega = item.od_costo * item.od_factor_costo;
                    item.od_costo_total = item.od_costo_bodega * item.od_cantidad_recepcion;
                }
                return lst_detalle;
            }
            catch (Exception)
            {

                throw;
            }
        }
        private in_Ing_Egr_Inven_Info get_ingreso(imp_ordencompra_ext_Info info)
        {
            try
            {
                param = param_bus.get_info(info.IdEmpresa);
                in_Ing_Egr_Inven_Info ingreso = new in_Ing_Egr_Inven_Info();
                ingreso.IdEmpresa = info.IdEmpresa;
                ingreso.IdNumMovi = 0;
                ingreso.CodMoviInven = "0";
                ingreso.cm_fecha = info.oe_fecha;
                ingreso.IdUsuario = info.IdUsuario_creacion;
                ingreso.nom_pc = "";
                ingreso.ip = "";
                ingreso.Fecha_Transac = DateTime.Now;
                ingreso.signo = "+";
                ingreso.IdSucursal = param.IdSucursal;
                ingreso.IdBodega = param.IdBodega;
                ingreso.cm_observacion = "Ingreso por importacion. " + info.oe_observacion;
                ingreso.IdMovi_inven_tipo = param.IdMovi_inven_tipo_ing;
                ingreso.IdMotivo_Inv = param.IdMotivo_Inv_ing;
                foreach (var item in info.lst_detalle)
                {
                    in_Ing_Egr_Inven_det_Info info_det = new in_Ing_Egr_Inven_det_Info();
                    info_det.IdEmpresa = item.IdEmpresa;
                    info_det.IdSucursal = param.IdSucursal;
                    info_det.IdNumMovi = 0;
                    info_det.Secuencia = item.Secuencia;
                    info_det.IdBodega = param.IdBodega;
                    info_det.IdProducto = item.IdProducto;
                    info_det.dm_cantidad = item.od_cantidad_recepcion;
                    info_det.dm_observacion = "Ingreso por orden de compra del exterior";
                    info_det.mv_costo = item.od_costo_total / item.od_cantidad_recepcion;
                    info_det.mv_costo_sinConversion = item.od_costo_total/item.od_cantidad_recepcion;
                    info_det.dm_cantidad_sinConversion = item.od_cantidad_recepcion;
                    info_det.dm_cantidad = item.od_cantidad_recepcion;
                    info_det.IdUnidadMedida = item.IdUnidadMedida;
                    info_det.IdUnidadMedida_sinConversion = item.IdUnidadMedida;
                    ingreso.lst_in_Ing_Egr_Inven_det.Add(info_det);
                }
                return ingreso;
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        #endregion

    }
}
