using Core.Erp.Data.ActivoFijo;
using Core.Erp.Info.ActivoFijo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.ActivoFijo
{
   public class Af_Activo_fijo_CtaCble_Bus
    {
        Af_Activo_fijo_CtaCble_Data odata = new Af_Activo_fijo_CtaCble_Data();
        public List<Af_Activo_fijo_CtaCble_Info> GetList(int IdEmpresa, int IdActivoFijo)
        {
            try
            {
                return odata.GetList(IdEmpresa, IdActivoFijo);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
