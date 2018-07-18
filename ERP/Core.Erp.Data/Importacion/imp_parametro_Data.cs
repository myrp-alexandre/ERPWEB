using Core.Erp.Info.Importacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Importacion
{
   public class imp_parametro_Data
    {
        public imp_parametro_Info get_info( int IdEmpresa)
        {
            try
            {
                imp_parametro_Info info = new imp_parametro_Info();
                using (Entities_importacion Context = new Entities_importacion())
                {
                   
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
