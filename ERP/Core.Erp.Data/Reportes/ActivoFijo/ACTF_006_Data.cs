using Core.Erp.Info.Reportes.ActivoFijo;
using Core.Erp.Info.Reportes.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Core.Erp.Data.Reportes.Inventario
{
    public class ACTF_006_Data
    {
        public List<ACTF_006_Info> get_list(int IdEmpresa, decimal IdProducto)
        {
            try
            {
                List<ACTF_006_Info> Lista=new List<ACTF_006_Info>();

               
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
