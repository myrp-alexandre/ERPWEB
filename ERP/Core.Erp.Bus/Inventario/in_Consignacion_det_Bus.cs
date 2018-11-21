using Core.Erp.Data.Inventario;
using Core.Erp.Info.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Inventario
{
    public class in_Consignacion_det_Bus
    {
        in_Consignacion_det_Data odata_det = new in_Consignacion_det_Data();

        public List<in_Consignacion_det_Info> GetList(int IdEmpresa, int IdConsignacion)
        {
            try
            {
                return odata_det.GetList(IdEmpresa, IdConsignacion);
            }
            catch (Exception)
            {
                throw;
            }
        }

    }
}
