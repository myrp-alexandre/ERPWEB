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
                        IdTipoCbteBaja_Anulacion = Entity.IdTipoCbteBaja_Anulacion,
                        IdTipoCbteDep_Acum_Anulacion = Entity.IdTipoCbteDep_Acum_Anulacion,
                        IdTipoCbteMejora_Anulacion = Entity.IdTipoCbteMejora_Anulacion,
                        IdTipoCbteMejora = Entity.IdTipoCbteMejora,
                        IdTipoCbteRetiro = Entity.IdTipoCbteRetiro,
                        IdTipoCbteRetiro_Anulacion = Entity.IdTipoCbteRetiro_Anulacion,
                        IdTipoCbteVenta =Entity.IdTipoCbteVenta,
                        IdTipoCbteVenta_Anulacion = Entity.IdTipoCbteVenta_Anulacion
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
                            IdTipoCbteBaja_Anulacion = info.IdTipoCbteBaja_Anulacion,
                            IdTipoCbteDep_Acum_Anulacion = info.IdTipoCbteDep_Acum_Anulacion,
                            IdTipoCbteMejora_Anulacion = info.IdTipoCbteMejora_Anulacion,
                            IdTipoCbteMejora = info.IdTipoCbteMejora,
                            IdTipoCbteRetiro = info.IdTipoCbteRetiro,
                            IdTipoCbteRetiro_Anulacion = info.IdTipoCbteRetiro_Anulacion,
                            IdTipoCbteVenta = info.IdTipoCbteVenta,
                            IdTipoCbteVenta_Anulacion = info.IdTipoCbteVenta_Anulacion
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
                        Entity.IdTipoCbteBaja_Anulacion = info.IdTipoCbteBaja_Anulacion;
                        Entity.IdTipoCbteDep_Acum_Anulacion = info.IdTipoCbteDep_Acum_Anulacion;
                        Entity.IdTipoCbteMejora_Anulacion = info.IdTipoCbteMejora_Anulacion;
                        Entity.IdTipoCbteMejora = info.IdTipoCbteMejora;
                        Entity.IdTipoCbteRetiro = info.IdTipoCbteRetiro;
                        Entity.IdTipoCbteRetiro_Anulacion = info.IdTipoCbteRetiro_Anulacion;
                        Entity.IdTipoCbteVenta = info.IdTipoCbteVenta;
                        Entity.IdTipoCbteVenta_Anulacion = info.IdTipoCbteVenta_Anulacion;
                    };
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
