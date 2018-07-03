using Core.Erp.Data.Reportes.RRHH;
using Core.Erp.Info.Reportes.RRHH;
using System;
using System.Collections.Generic;

namespace Core.Erp.Bus.Reportes.RRHH
{
    public class ROL_002_Bus
    {
        ROL_002_Data odata = new ROL_002_Data();
        public List<ROL_002_Info> get_list(int IdEmpresa, int IdNomina, int IdNominaTipo, int IdPeriodo)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdNomina, IdNominaTipo, IdPeriodo);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
