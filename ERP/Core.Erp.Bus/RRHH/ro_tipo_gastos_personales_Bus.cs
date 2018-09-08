using Core.Erp.Data.RRHH;
using Core.Erp.Info.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.RRHH
{
  public  class ro_tipo_gastos_personales_Bus
    {
        ro_tipo_gastos_personales_Data odata = new ro_tipo_gastos_personales_Data();

        public List<ro_tipo_gastos_personales_Info> get_list()
        {

            try
            {
                return odata.get_list();
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
    }
