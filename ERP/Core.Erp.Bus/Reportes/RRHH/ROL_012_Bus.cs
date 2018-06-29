using Core.Erp.Data.Reportes.RRHH;
using Core.Erp.Info.Reportes.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Reportes.RRHH
{
    public class ROL_012_Bus
    {
        ROL_012_Data odata = new ROL_012_Data();
        public List<ROL_012_Info> get_list(int IdEmpresa, DateTime fecha_inicio, DateTime fecha_fin)
        {
            try
            {
                return odata.get_list(IdEmpresa, fecha_inicio, fecha_fin);
            }
            catch (Exception e)
            {

                throw;
            }
        }
    }
}
