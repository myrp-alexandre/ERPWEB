using Core.Erp.Data.Reportes.RRHH;
using Core.Erp.Info.Reportes.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Reportes.RRHH
{
    public class ROL_005_Bus
    {
        ROL_005_Data odata = new ROL_005_Data();
    
        public List<ROL_005_Info> get_list(int IdEmpresa, decimal IdActaFiniquito)
        {
            return odata.get_list(IdEmpresa, IdActaFiniquito);
        }
    }
}
