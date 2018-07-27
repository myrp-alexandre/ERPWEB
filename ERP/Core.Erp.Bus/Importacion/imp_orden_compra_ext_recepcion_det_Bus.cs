using Core.Erp.Data.Importacion;
using Core.Erp.Info.Importacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Importacion
{
   public class imp_orden_compra_ext_recepcion_det_Bus
    {
        imp_orden_compra_ext_recepcion_det_Data odata = new imp_orden_compra_ext_recepcion_det_Data();

        public List<imp_orden_compra_ext_recepcion_det_Info> get_list(int IdEmpresa, decimal IdOrdencompraext)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdOrdencompraext);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
