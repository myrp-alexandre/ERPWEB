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
                    imp_parametro Entity = Context.imp_parametro.FirstOrDefault(q => q.IdEmpresa == IdEmpresa);
                    if (Entity == null) return null;
                    info = new imp_parametro_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdTipoCbte_liquidacion = Entity.IdTipoCbte_liquidacion,
                        IdTipoCbte_liquidacion_anu = Entity.IdTipoCbte_liquidacion_anu
                    };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(imp_parametro_Info info)
        {
            try
            {
                using (Entities_importacion Context = new Entities_importacion())
                {
                    imp_parametro Entity = new imp_parametro
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdTipoCbte_liquidacion = info.IdTipoCbte_liquidacion,
                        IdTipoCbte_liquidacion_anu = info.IdTipoCbte_liquidacion_anu
                    };
                    Context.imp_parametro.Add(Entity);
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
