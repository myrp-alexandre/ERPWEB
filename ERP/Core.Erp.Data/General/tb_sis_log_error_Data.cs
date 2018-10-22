using Core.Erp.Info.General;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.General
{
   public class tb_sis_log_error_Data
    {
        public decimal get_id(int IdEmpresa)
        {
            try
            {
                decimal ID =0;
                using (Entities_general Context = new Entities_general())
                {
                    var lst = from q in Context.tb_sis_log_error
                              where q.IdEmpresa==IdEmpresa
                              select q;

                    if (lst.Count() > 0)
                    {
                        ID = (Convert.ToInt32(lst.Max(q => q.IdError))) ;
                    }
                }
                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(tb_sis_log_error_Info info)
        {
            try
            {
                using (Entities_general Context = new Entities_general())
                {
                    tb_sis_log_error Entity = new tb_sis_log_error
                    {
                        IdEmpresa=info.IdEmpresa,
                        IdError = info.IdError = get_id(info.IdEmpresa),
                        DescripcionError = info.DescripcionError,
                        Modulo = info.Modulo,
                        Accion=info.Accion
                    };
                    Context.tb_sis_log_error.Add(Entity);
                    Context.SaveChanges();

                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

    }
}
