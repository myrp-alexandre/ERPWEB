using Core.Erp.Info.Reportes.RRHH;
using Core.Erp.Data.Reportes.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Reportes.RRHH
{
   public class ROL_010_Bus
    {
        ROL_010_Data odata = new ROL_010_Data();

        public List<ROL_010_Info> get_list(int IdEmpresa)
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
    }
}
