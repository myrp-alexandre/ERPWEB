using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.Importacion;
using Core.Erp.Data.Importacion;
namespace Core.Erp.Bus.Importacion
{
  public  class imp_ordencompra_ext_Bus
    {
        imp_ordencompra_ext_Data odata = new imp_ordencompra_ext_Data();
        imp_ordencompra_ext_det_Data odata_det = new imp_ordencompra_ext_det_Data();

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

    }
}
