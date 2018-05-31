using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.Reportes.RRHH;
using Core.Erp.Data.Reportes.RRHH;

namespace Core.Erp.Bus.Reportes.RRHH
{
  public  class ROL_001_Bus
    {
        ROL_001_Data odata = new ROL_001_Data();
        public List<ROL_001_Info> get_list(int IdEmpresa, int IdNomina, int IdNominaTipo, int IdPeriodo)
        {
            try
            {
                return odata.get_list(IdEmpresa,IdNomina,IdNominaTipo,IdPeriodo);
            }
            catch (Exception)
            {

                throw;
            }
        }
   }
}
