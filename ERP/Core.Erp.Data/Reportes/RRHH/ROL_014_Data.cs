using Core.Erp.Info.Reportes.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.RRHH
{
    public class ROL_014_Data
    {
        public List<ROL_014_Info> get_list(int IdEmpresa, int IdTipoNomina)
        {
            try
            {
                List<ROL_014_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                    Lista = (from q in Context.VWROL_014
                             where q.IdEmpresa == IdEmpresa
                             && q.IdTipoNomina == IdTipoNomina
                             select new ROL_014_Info
                             {

                             }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
