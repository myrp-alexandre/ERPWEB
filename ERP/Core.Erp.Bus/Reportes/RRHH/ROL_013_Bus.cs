using Core.Erp.Data.Reportes.RRHH;
using Core.Erp.Info.Reportes.RRHH;
using System;
using System.Collections.Generic;

namespace Core.Erp.Bus.Reportes.RRHH
{
    public class ROL_013_Bus
    {
        ROL_013_Data odata = new ROL_013_Data();
    
        public List<ROL_013_Info> get_list(int IdEmpresa, int IdNomina, decimal IdEmpleado,  DateTime fecha_inicio, DateTime fecha_fin)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdNomina, IdEmpleado, fecha_inicio, fecha_fin);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
