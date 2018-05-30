using Core.Erp.Data.General;
using Core.Erp.Info.General;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.General
{
    public class tb_sis_Impuesto_Tipo_Bus
    {
        tb_sis_Impuesto_Tipo_Data odata = new tb_sis_Impuesto_Tipo_Data();

        public List<tb_sis_Impuesto_Tipo_Info> get_list()
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
