using Core.Erp.Data.Reportes.Importacion;
using Core.Erp.Info.Reportes.Importacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Reportes.Importacion
{
   public class IMP_002_Bus
    {
        IMP_002_Data odata = new IMP_002_Data();
              
        public List<IMP_002_Info> get_list(int IdEmpresa, int IdOrdenCompra_ext)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdOrdenCompra_ext);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
