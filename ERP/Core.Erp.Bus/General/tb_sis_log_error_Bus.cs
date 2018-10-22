using Core.Erp.Data.General;
using Core.Erp.Info.General;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.General
{
   public class tb_sis_log_error_Bus
    {
        tb_sis_log_error_Data odata = new tb_sis_log_error_Data();

        public bool guardarDB(tb_sis_log_error_Info info)
        {
            try
            {
                return odata.guardarDB(info);
            }
            catch (Exception)
            {

                throw;
            }
        }

    }
}
