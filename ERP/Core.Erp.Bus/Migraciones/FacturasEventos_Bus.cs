using Core.Erp.Info.Migraciones;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Migraciones
{
   public class FacturasEventos_Bus
    {

        public List<FacturasEventos_Info> get_list()
        {
            try
            {
                return new List<FacturasEventos_Info>();
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
