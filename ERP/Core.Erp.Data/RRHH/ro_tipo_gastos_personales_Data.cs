using Core.Erp.Info.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.RRHH
{
   public class ro_tipo_gastos_personales_Data
    {
        public List<ro_tipo_gastos_personales_Info> get_list()
        {
            try
            {
                List<ro_tipo_gastos_personales_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    
                        Lista = (from q in Context.ro_tipo_gastos_personales
                                 select new ro_tipo_gastos_personales_Info
                                 {
                                     IdTipoGasto = q.IdTipoGasto,
                                     nom_tipo_gasto = q.nom_tipo_gasto,
                                     orden = q.orden,
                                     estado = q.estado
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
