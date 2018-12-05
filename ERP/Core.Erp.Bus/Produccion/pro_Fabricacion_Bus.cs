using Core.Erp.Data.Produccion;
using Core.Erp.Info.Produccion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Produccion
{
   public class pro_Fabricacion_Bus
    {
        pro_Fabricacion_Data odata = new pro_Fabricacion_Data();
       public List<pro_Fabricacion_Info> GetList(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                return odata.GetList(IdEmpresa, mostrar_anulados);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
