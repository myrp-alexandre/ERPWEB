using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
namespace Core.Erp.Data.RRHH
{
   public class ro_ArchivosIess_Data
    {

        public List<ro_ArchivosIess_Info> get_list(int IdEmpresa, int Anio, int Mes)
        {
            try
            {
                List<ro_ArchivosIess_Info> lista;

                using (Entities_rrhh Contex=new Entities_rrhh())
                {

                   

                }

                return new List<ro_ArchivosIess_Info>();
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
