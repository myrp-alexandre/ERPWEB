using Core.Erp.Data.Reportes.RRHH;
using Core.Erp.Info.Reportes.RRHH;
using System;
using System.Collections.Generic;

namespace Core.Erp.Bus.Reportes.RRHH
{
    public class ROL_009_Bus
    {
        ROL_009_Data odata = new ROL_009_Data();
    
        public List<ROL_009_Info> get_list(DateTime fehca_inicio, DateTime fecha_fin, int idEmpresa)
        {
            try
            {
                return odata.get_list(idEmpresa, fehca_inicio, fecha_fin);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
