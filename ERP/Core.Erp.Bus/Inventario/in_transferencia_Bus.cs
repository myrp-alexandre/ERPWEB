using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.Inventario;
using Core.Erp.Data.Inventario;
namespace Core.Erp.Bus.Inventario
{
   public class in_transferencia_Bus
    {
       in_transferencia_Data odata = new in_transferencia_Data();
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
                return odata.get_info(IdEmpresa, IdSucursa,IdBodega,IdTransferencia);
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
                return odata.guardarDB(info);
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
                return odata.modificarDB(info);
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
                return odata.guardarDB(info);
            }
            catch (Exception)
            {

                throw;
            }
        }
        private in_Ing_Egr_Inven_Info Get_Info_Ing_Egr_Inven(in_transferencia_Info info)
        {
            try
            {
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
               ingreso.cm_observacion = "Ingreso x Trans. #" + info.IdTransferencia + " Suc.Dest.# " + info.IdSucursalDest + "Bod.Dest.# " + info.IdBodegaDest + " Suc.Org.# " + info.IdSucursalOrigen + "Bod.Org.# " + info.IdBodegaOrigen + ". " + info.tr_Observacion;
               ingreso.IdMovi_inven_tipo = info.IdMovi_inven_tipo_SucuDest == null ? 0 : Convert.ToInt32(info.IdMovi_inven_tipo_SucuDest);
               ingreso.IdMotivo_Inv = info.IdMovi_inven_tipo_SucuDest;

                ingreso.lst_in_Ing_Egr_Inven_det = new List<in_Ing_Egr_Inven_det_Info>();
                ingreso.lst_in_Ing_Egr_Inven_det = get_detalle(info.list_detalle, info.IdSucursalDest, info.IdBodegaDest, "+", ingreso.cm_fecha);


                return ingreso;
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
            return mensaje;

        }
    }
}
