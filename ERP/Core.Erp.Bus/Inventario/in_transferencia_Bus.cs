using Core.Erp.Data.Inventario;
using Core.Erp.Info.Inventario;
using System;
using System.Collections.Generic;
using Core.Erp.Info.Helps;
namespace Core.Erp.Bus.Inventario
{
    public class in_transferencia_Bus
    {
        in_transferencia_Data odata = new in_transferencia_Data();
        in_transferencia_det_Data odata_det = new in_transferencia_det_Data();
        in_Ing_Egr_Inven_Bus bus_ingreso = new in_Ing_Egr_Inven_Bus();
        in_producto_x_tb_bodega_Costo_Historico_Bus bus_costo = new in_producto_x_tb_bodega_Costo_Historico_Bus();
        public List<in_transferencia_Info> get_list(int IdEmpresa)
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
        public in_transferencia_Info get_info(int IdEmpresa, int IdSucursa, int IdBodega, decimal IdTransferencia)
        {
            try
            {
                in_transferencia_Info info = new in_transferencia_Info();
                info= odata.get_info(IdEmpresa, IdSucursa,IdBodega,IdTransferencia);
                info.list_detalle = odata_det.get_list(IdEmpresa, IdSucursa, IdBodega, IdTransferencia);
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(in_transferencia_Info info)
        {
            try
            {
                info.IdEstadoAprobacion_cat = "XAPRO";
                if (odata.guardarDB(info))
                {
                    get_info_ing_egr(info);
                    bus_ingreso.guardarDB(info.info_ingreso,"+");
                    bus_ingreso.guardarDB(info.info_egreso,"-");

                    info.IdEmpresa_Ing_Egr_Inven_Origen = info.IdEmpresa;
                    info.IdSucursal_Ing_Egr_Inven_Origen = info.IdSucursalOrigen;
                    info.IdMovi_inven_tipo_SucuOrig = info.IdMovi_inven_tipo_SucuOrig;
                    info.IdNumMovi_Ing_Egr_Inven_Origen = info.info_ingreso.IdNumMovi;

                    info.IdEmpresa_Ing_Egr_Inven_Destino = info.IdEmpresa;
                    info.IdSucursal_Ing_Egr_Inven_Destino = info.IdSucursalDest;
                    info.IdMovi_inven_tipo_SucuDest = info.IdMovi_inven_tipo_SucuDest;
                    info.IdNumMovi_Ing_Egr_Inven_Destino = info.info_egreso.IdNumMovi;
                    odata.modificar_id_ing_egrDB(info);
                }


                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool modificarDB(in_transferencia_Info info)
        {
            try
            {
                odata = new in_transferencia_Data();
                odata_det = new in_transferencia_det_Data();
                odata_det.anularDB(info);
                if (odata.modificarDB(info))
                {
                    get_info_ing_egr(info);
                    bus_ingreso.modificarDB(info.info_ingreso);
                    bus_ingreso.modificarDB(info.info_egreso);
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool anularDB(in_transferencia_Info info)
        {
            try
            {
                if (odata.anularDB(info))
                {
                    get_info_ing_egr(info);
                    bus_ingreso.anularDB(info.info_ingreso);
                    bus_ingreso.anularDB(info.info_egreso);
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        private void get_info_ing_egr(in_transferencia_Info info)
        {
            try
            {
                // armando ingreso
                in_Ing_Egr_Inven_Info ingreso = new in_Ing_Egr_Inven_Info();
                ingreso.IdEmpresa = info.IdEmpresa;
                ingreso.IdNumMovi = 0;
                ingreso.CodMoviInven = "0";
                ingreso.cm_fecha = info.tr_fecha;
                ingreso.IdUsuario = info.IdUsuario;
                ingreso.nom_pc = info.nom_pc;
                ingreso.ip = info.ip;
                ingreso.Fecha_Transac = info.tr_fecha;
                ingreso.signo = "+";
                ingreso.IdSucursal = info.IdSucursalDest;
                ingreso.IdBodega = info.IdBodegaDest;
                ingreso.cm_observacion = "Egreso x Trans." + info.tr_Observacion;
                ingreso.IdMovi_inven_tipo = info.IdMovi_inven_tipo_SucuDest == null ? 0 : Convert.ToInt32(info.IdMovi_inven_tipo_SucuDest);
                ingreso.IdMotivo_Inv = info.IdMovi_inven_tipo_SucuDest;

                ingreso.lst_in_Ing_Egr_Inven_det = new List<in_Ing_Egr_Inven_det_Info>();
                ingreso.lst_in_Ing_Egr_Inven_det = get_detalle(info.list_detalle, info.IdSucursalDest, info.IdBodegaDest, "+", ingreso.cm_fecha);
                info.info_ingreso=ingreso;

                // armando egreso
                in_Ing_Egr_Inven_Info egreso = new in_Ing_Egr_Inven_Info();
                egreso.IdEmpresa = info.IdEmpresa;
                egreso.IdNumMovi = 0;
                egreso.CodMoviInven = "0";
                egreso.cm_fecha = info.tr_fecha;
                egreso.IdUsuario = info.IdUsuario;
                egreso.nom_pc = info.nom_pc;
                egreso.ip = info.ip;
                egreso.Fecha_Transac = info.tr_fecha;
                egreso.signo = "-";
                egreso.IdSucursal = info.IdSucursalDest;
                egreso.IdBodega = info.IdBodegaDest;
                egreso.cm_observacion = "Egreso x Trans."  + info.tr_Observacion;
                egreso.IdMovi_inven_tipo = info.IdMovi_inven_tipo_SucuDest == null ? 0 : Convert.ToInt32(info.IdMovi_inven_tipo_SucuDest);
                egreso.IdMotivo_Inv = info.IdMovi_inven_tipo_SucuDest;

                egreso.lst_in_Ing_Egr_Inven_det = new List<in_Ing_Egr_Inven_det_Info>();
                egreso.lst_in_Ing_Egr_Inven_det = get_detalle(info.list_detalle, info.IdSucursalDest, info.IdBodegaDest, "+", ingreso.cm_fecha);
                info.info_egreso = egreso;

            }
            catch (Exception )
            {
                throw;

            }

        }
        private List<in_Ing_Egr_Inven_det_Info> get_detalle(List<in_transferencia_det_Info> listDetalle, int IdSucursal, int IdBodega, string Signo, DateTime fecha)
        {
            try
            {
                List<in_Ing_Egr_Inven_det_Info> list_IngEgrDet = new List<in_Ing_Egr_Inven_det_Info>();
                foreach (var item in listDetalle)
                {

                    double costo = bus_costo.get_ultimo_costo(item.IdEmpresa, item.IdSucursalOrigen, item.IdBodegaOrigen,item.IdProducto, fecha);

                    in_Ing_Egr_Inven_det_Info info = new in_Ing_Egr_Inven_det_Info();
                    info.IdEmpresa = item.IdEmpresa;
                    info.IdSucursal = IdSucursal;
                    info.IdNumMovi = 0;
                    info.Secuencia = item.dt_secuencia;
                    info.IdBodega = IdBodega;
                    info.IdProducto = item.IdProducto;
                    info.dm_cantidad = item.dt_cantidad;
                    info.dm_observacion = item.tr_Observacion;
                    info.mv_costo = costo;
                    info.mv_costo_sinConversion = costo;
                    info.dm_cantidad_sinConversion = item.dt_cantidad;
                    info.dm_cantidad = item.dt_cantidad;
                    info.IdUnidadMedida = item.IdUnidadMedida;
                    info.IdUnidadMedida_sinConversion = item.IdUnidadMedida;
                    info.IdCentroCosto = item.IdCentroCosto;
                    info.IdCentroCosto_sub_centro_costo = item.IdCentroCosto_sub_centro_costo;
                    info.IdPunto_cargo = item.IdPunto_cargo;
                    info.IdPunto_cargo_grupo = item.IdPunto_cargo_grupo;
                    list_IngEgrDet.Add(info);
                }
                return list_IngEgrDet;
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public string validar(in_transferencia_Info info)
        {
            string mensaje = "";
            if (info.list_detalle.Count == 0)
            {
                mensaje = "Debe ingresar al menos un producto";
            }

            foreach (var item in info.list_detalle)
            {
                if(item.dt_cantidad==0)
                {
                    mensaje = "No existe cantidad";

                }

                if (item.IdProducto == 0)
                {
                    mensaje = "No existe producto en el detalle";

                }
            }
            return mensaje;

        }
    }
}
