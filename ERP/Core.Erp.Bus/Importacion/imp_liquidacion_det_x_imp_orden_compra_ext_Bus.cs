using Core.Erp.Data.Importacion;
using Core.Erp.Info.Importacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Importacion
{
   public class imp_liquidacion_det_x_imp_orden_compra_ext_Bus
    {
        imp_liquidacion_det_x_imp_orden_compra_ext_Data odata = new imp_liquidacion_det_x_imp_orden_compra_ext_Data();
        imp_ordencompra_ext_Data odata_oc = new imp_ordencompra_ext_Data();
        imp_ordencompra_ext_det_Data odta_det_oc = new imp_ordencompra_ext_det_Data();
        public List<imp_liquidacion_det_x_imp_orden_compra_ext_Info> get_list(int IdEmpresa, DateTime fecha_inicio, DateTime Fecha_fin)
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

        public imp_liquidacion_det_x_imp_orden_compra_ext_Info get_info(int IdEmpresa, decimal IdOrdenCompra_ext)
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
        public bool guardarDB(imp_liquidacion_det_x_imp_orden_compra_ext_Info info)
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
        public bool modificarDB(imp_liquidacion_det_x_imp_orden_compra_ext_Info info)
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
        public bool anularDB(imp_liquidacion_det_x_imp_orden_compra_ext_Info info)
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

     }
}
