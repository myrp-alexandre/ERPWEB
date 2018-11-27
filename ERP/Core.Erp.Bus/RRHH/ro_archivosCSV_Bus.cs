using Core.Erp.Data.RRHH;
using Core.Erp.Info.RRHH.MTE;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.RRHH
{
   public class ro_archivosCSV_Bus
    {
        ro_archivosCSV_Data odata = new ro_archivosCSV_Data();
        public List<ro_archivosCSV_Info> get_lis(int idEmpresa, int IdRol, int IdRubro)
        {
            try
            {
                return odata.get_lis(idEmpresa, IdRol, IdRubro);
            }
            catch (Exception)
            {

                throw;
            }

        }
        }
    }
