using Core.Erp.Data.General;
using Core.Erp.Info.General;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.General
{
    public class tb_parroquia_Bus
    {
        tb_parroquia_Data odata = new tb_parroquia_Data();
        public List<tb_parroquia_Info> get_list(bool mostrar_anulados, string IdCiudad)
        {
            try
            {
                return odata.get_list(mostrar_anulados, IdCiudad);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public List<tb_parroquia_Info> get_list(bool mostrar_anulados)
        {
            try
            {
                return odata.get_list(mostrar_anulados);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
