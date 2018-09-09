using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH.RDEP;
namespace Core.Erp.Data.RRHH
{
   public class Rdep_Data
    {
        public List<Rdep_Info> gett_list(int IdEmpresa, int Anio)
        {
            List<Rdep_Info> Lista = new List<Rdep_Info>();

            try
            {
                using (Entities_rrhh context=new Entities_rrhh())
                {
                    string sql = "select * from EntidadRegulatoria.vwrdep_IngrEgr_x_Empleado where IdEmpresa='"+IdEmpresa+"' and pe_anio= '"+Anio+"'";
                    Lista = context.Database.SqlQuery<Rdep_Info>(sql).ToList();

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
