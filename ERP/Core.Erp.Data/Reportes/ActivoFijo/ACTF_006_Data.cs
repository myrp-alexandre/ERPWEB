using Core.Erp.Info.Reportes.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Core.Erp.Data.Reportes.Inventario
{
    public class ACTF_006_Data
    {
        public List<INV_013_Info> get_list(int IdEmpresa, decimal IdProducto)
        {
            try
            {
                List<INV_013_Info> Lista=new List<INV_013_Info>();

               
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
