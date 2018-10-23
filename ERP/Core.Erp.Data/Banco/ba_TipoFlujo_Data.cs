using Core.Erp.Info.Banco;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Banco
{
    public class ba_TipoFlujo_Data
    {
        public List<ba_TipoFlujo_Info> get_list(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                List<ba_TipoFlujo_Info> Lista;
                using (Entities_banco Context = new Entities_banco())
                {
                    if(mostrar_anulados)
                    Lista = (from q in Context.ba_TipoFlujo
                             where q.IdEmpresa == IdEmpresa
                             select new ba_TipoFlujo_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 cod_flujo = q.cod_flujo,
                                 Descricion = q.Descricion,
                                 Estado = q.Estado,
                                 IdTipoFlujo = q.IdTipoFlujo,
                                 IdTipoFlujoPadre = q.IdTipoFlujoPadre,
                                 Tipo = q.Tipo,

                                 EstadoBool = q.Estado == "A" ? true : false
                             }).ToList();
                    else
                        Lista = (from q in Context.ba_TipoFlujo
                                 where q.IdEmpresa == IdEmpresa
                                 && q.Estado == "A"
                                 select new ba_TipoFlujo_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     cod_flujo = q.cod_flujo,
                                     Descricion = q.Descricion,
                                     Estado = q.Estado,
                                     IdTipoFlujo = q.IdTipoFlujo,
                                     IdTipoFlujoPadre = q.IdTipoFlujoPadre,
                                     Tipo = q.Tipo,

                                     EstadoBool = q.Estado == "A" ? true : false
                                 }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public ba_TipoFlujo_Info get_info(int IdEmpresa, decimal IdTipoFlujo)
        {
            try
            {
                ba_TipoFlujo_Info info = new ba_TipoFlujo_Info();
                using (Entities_banco Context = new Entities_banco())
                {
                    ba_TipoFlujo Entity = Context.ba_TipoFlujo.Where(q => q.IdEmpresa == IdEmpresa && q.IdTipoFlujo == IdTipoFlujo).FirstOrDefault();
                    info = new ba_TipoFlujo_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        cod_flujo = Entity.cod_flujo,
                        Descricion = Entity.Descricion,
                        Estado = Entity.Estado,
                        IdTipoFlujo = Entity.IdTipoFlujo,
                        IdTipoFlujoPadre = Entity.IdTipoFlujoPadre,
                        Tipo = Entity.Tipo
                    };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        private decimal get_id(int IdEmpresa)
        {
            try
            {
                decimal ID = 1;
                using (Entities_banco Context = new Entities_banco())
                {
                    var lst = from q in Context.ba_TipoFlujo
                              where q.IdEmpresa == IdEmpresa
                              select q;
                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdTipoFlujo) + 1;
                }
                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
