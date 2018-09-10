using Core.Erp.Info.ActivoFijo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.ActivoFijo
{
    public class Af_Parametros_Data
    {
        public Af_Parametros_Info get_info(int IdEmpresa)
        {
            try
            {
                Af_Parametros_Info info = new Af_Parametros_Info();
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    Af_Parametros Entity = Context.Af_Parametros.FirstOrDefault(q => q.IdEmpresa == IdEmpresa);
                    if (Entity == null) return null;
                    info = new Af_Parametros_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdCtaCble_Activo = Entity.IdCtaCble_Activo,
                        FormaContabiliza = Entity.FormaContabiliza,
                        IdCtaCble_Dep_Acum = Entity.IdCtaCble_Dep_Acum,
                        IdCtaCble_Gastos_Depre = Entity.IdCtaCble_Gastos_Depre,
                        IdTipoCbte = Entity.IdTipoCbte,
                        IdTipoCbteBaja =Entity.IdTipoCbteBaja,
                        IdTipoCbteMejora = Entity.IdTipoCbteMejora,
                        IdTipoCbteRetiro = Entity.IdTipoCbteRetiro,
                        IdTipoCbteVenta =Entity.IdTipoCbteVenta,
                        DiasTransaccionesAFuturo = Entity.DiasTransaccionesAFuturo
                    };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(Af_Parametros_Info info)
        {
            try
            {
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    Af_Parametros Entity = Context.Af_Parametros.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa);
                    if (Entity == null)
                    {
                        Entity = new Af_Parametros
                        {

                            IdEmpresa = info.IdEmpresa,
                            IdCtaCble_Activo = info.IdCtaCble_Activo,
                            FormaContabiliza = info.FormaContabiliza,
                            IdCtaCble_Dep_Acum = info.IdCtaCble_Dep_Acum,
                            IdCtaCble_Gastos_Depre = info.IdCtaCble_Gastos_Depre,
                            IdTipoCbte = info.IdTipoCbte,
                            IdTipoCbteBaja = info.IdTipoCbteBaja,
                            IdTipoCbteMejora = info.IdTipoCbteMejora,
                            IdTipoCbteRetiro = info.IdTipoCbteRetiro,
                            IdTipoCbteVenta = info.IdTipoCbteVenta,
                            DiasTransaccionesAFuturo = info.DiasTransaccionesAFuturo
                        };
                        Context.Af_Parametros.Add(Entity);
                    }
                    else
                    {
                        Entity.IdCtaCble_Activo = info.IdCtaCble_Activo;
                        Entity.FormaContabiliza = info.FormaContabiliza;
                        Entity.IdCtaCble_Dep_Acum = info.IdCtaCble_Dep_Acum;
                        Entity.IdCtaCble_Gastos_Depre = info.IdCtaCble_Gastos_Depre;
                        Entity.IdTipoCbte = info.IdTipoCbte;
                        Entity.IdTipoCbteBaja = info.IdTipoCbteBaja;
                        Entity.IdTipoCbteMejora = info.IdTipoCbteMejora;
                        Entity.IdTipoCbteRetiro = info.IdTipoCbteRetiro;
                        Entity.IdTipoCbteVenta = info.IdTipoCbteVenta;
                        Entity.DiasTransaccionesAFuturo = info.DiasTransaccionesAFuturo;
                    }
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
