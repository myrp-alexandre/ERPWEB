using Core.Erp.Data.Importacion;
using Core.Erp.Info.Importacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.Inventario;
using Core.Erp.Bus.Inventario;

namespace Core.Erp.Bus.Importacion
{
   public class imp_orden_compra_ext_recepcion_Bus
    {
        imp_orden_compra_ext_recepcion_Data odata = new imp_orden_compra_ext_recepcion_Data();
        imp_ordencompra_ext_Data odata_oc = new imp_ordencompra_ext_Data();
        imp_ordencompra_ext_det_Data odta_det_oc = new imp_ordencompra_ext_det_Data();
        imp_parametro_Data data_parametros = new imp_parametro_Data();
        in_Ing_Egr_Inven_Bus bus_ingreso = new in_Ing_Egr_Inven_Bus();
        imp_orden_compra_ext_recepcion_det_Data odata_det = new imp_orden_compra_ext_recepcion_det_Data();
        public List<imp_orden_compra_ext_recepcion_Info> get_list(int IdEmpresa, DateTime fecha_inicio, DateTime Fecha_fin)
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

        public imp_orden_compra_ext_recepcion_Info get_info(int IdEmpresa, decimal IdOrdenCompra_ext)
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
        public bool guardarDB(imp_orden_compra_ext_recepcion_Info info)
        {
            try
            {
                var info_movimiento_inventario = get_movimineto_inv(info);
                if (bus_ingreso.guardarDB(info_movimiento_inventario, "+"))
                {
                    info.IdNumMovi_inv = info_movimiento_inventario.IdNumMovi;
                    return odata.guardarDB(info);
                }
                else
                    return false;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool modificarDB(imp_orden_compra_ext_recepcion_Info info)
        {
            try
            {
                var info_movimiento_inventario = get_movimineto_inv(info);
                info_movimiento_inventario.signo = "+";
                if (bus_ingreso.modificarDB(info_movimiento_inventario))
                {
                    info.IdNumMovi_inv = info_movimiento_inventario.IdNumMovi;
                    odata_det.eliminar(info.IdEmpresa, info.IdRecepcion);
                    return odata.modificarDB(info);
                }
                else
                    return false;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool anularDB(imp_orden_compra_ext_recepcion_Info info)
        {
            try
            {
                var info_movimiento_inventario = get_movimineto_inv(info);
                info_movimiento_inventario.signo = "+";
                if (bus_ingreso.anularDB(info_movimiento_inventario))
                {
                    info.IdNumMovi_inv = info_movimiento_inventario.IdNumMovi;
                    return odata.anularDB(info);
                }
                else
                    return false;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public imp_orden_compra_ext_recepcion_Info get_rcepcion_mercancia(int IdEmpresa, decimal IdOrdenCompra_ext)
        {
            try
            {
                var parametros = data_parametros.get_info(IdEmpresa);
                imp_orden_compra_ext_recepcion_Info info = new imp_orden_compra_ext_recepcion_Info();
                var orden = odata_oc.get_info_recepcion_merca(IdEmpresa, IdOrdenCompra_ext);
                var detalle_oc = odta_det_oc.get_list(IdEmpresa, IdOrdenCompra_ext);
                if(orden!=null & detalle_oc!=null)
                {
                    info.lst_detalle = new List<imp_orden_compra_ext_recepcion_det_Info>();
                    info.pe_cedulaRuc = orden.pe_cedulaRuc;
                    info.pe_nombreCompleto = orden.pe_nombreCompleto;
                    info.or_observacion = orden.oe_observacion;
                    info.IdOrdenCompraExt = orden.IdOrdenCompra_ext;
                    info.oe_fecha = orden.oe_fecha;
                    info.oe_fecha_embarque = orden.oe_fecha_embarque;
                    info.oe_fecha_llegada = orden.oe_fecha_embarque;
                    info.IdCatalogo_via = orden.IdCatalogo_via;
                    info.IdSucursal_inv = parametros.IdSucursal;
                    info.IdBodega = parametros.IdBodega;
                    info.IdMovi_inven_tipo_inv = parametros.IdMovi_inven_tipo_ing;
                    info.IdMotivo_Inv = parametros.IdMotivo_Inv_ing;
                    info.or_fecha = DateTime.Now;
                   
                    
                    foreach (var item in detalle_oc)
                    {
                        imp_orden_compra_ext_recepcion_det_Info item_add = new imp_orden_compra_ext_recepcion_det_Info();
                        item_add.IdEmpresa = item.IdEmpresa;
                        item_add.IdEmpresa_oc = item.IdEmpresa;
                        item_add.Secuencia_oc = item.Secuencia;
                        item_add.IdOrdenCompra_ext = item.IdOrdenCompra_ext;
                        item_add.secuencia = item.Secuencia;
                        item_add.IdProducto = item.IdProducto;
                        item_add.Observacion = "";
                        item_add.cantidad = item.od_cantidad;
                        item_add.pr_descripcion = item.pr_descripcion;
                        item_add.cantidad = item.od_cantidad;
                        item_add.od_cantidad = item.od_cantidad;
                        item_add.IdUnidadMedida = item.IdUnidadMedida;
                        item_add.costo = item.od_costo;
                        info.lst_detalle.Add(item_add);
                    }
                }

                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

    
        private in_Ing_Egr_Inven_Info get_movimineto_inv(imp_orden_compra_ext_recepcion_Info info)
        {
            try
            {
                // armando ingreso
                in_Ing_Egr_Inven_Info ingreso = new in_Ing_Egr_Inven_Info();
                ingreso.IdEmpresa = info.IdEmpresa;
                ingreso.IdNumMovi = info.IdNumMovi_inv;
                ingreso.CodMoviInven = "0";
                ingreso.cm_fecha = info.or_fecha;
                ingreso.IdUsuario = info.IdUsuario_creacion;
                ingreso.nom_pc = " ";
                ingreso.ip = " ";
                ingreso.Fecha_Transac = DateTime.Now;
                ingreso.signo = "+";
                ingreso.IdSucursal = info.IdSucursal_inv;
                ingreso.IdBodega = info.IdBodega;
                ingreso.cm_observacion = "Ingreso por importacion " + info.or_observacion;
                ingreso.IdMovi_inven_tipo = info.IdMovi_inven_tipo_inv;
                ingreso.IdMotivo_Inv = info.IdMotivo_Inv;
                ingreso.lst_in_Ing_Egr_Inven_det = new List<in_Ing_Egr_Inven_det_Info>();

                // detalle ingreso
                foreach (var item in info.lst_detalle)
                {
                    ingreso.lst_in_Ing_Egr_Inven_det.Add(new in_Ing_Egr_Inven_det_Info

                    {
                    IdEmpresa = item.IdEmpresa,
                    IdSucursal = info.IdSucursal_inv,
                    IdMovi_inven_tipo=info.IdMovi_inven_tipo_inv,
                    IdNumMovi = info.IdNumMovi_inv,
                    Secuencia = item.secuencia,
                    IdBodega = info.IdBodega,
                    IdProducto = item.IdProducto,
                    dm_observacion = info.oe_observacion,
                    mv_costo = item.cantidad,
                    mv_costo_sinConversion = item.costo,
                    dm_cantidad_sinConversion = item.cantidad,
                    dm_cantidad = item.cantidad,
                    IdUnidadMedida = item.IdUnidadMedida,
                    IdUnidadMedida_sinConversion = item.IdUnidadMedida
                   }
                    );

                }

                return ingreso;
            }
            catch (Exception)
            {
                throw;

            }

        }

    }
}
