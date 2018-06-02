using Core.Erp.Info.ActivoFijo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.ActivoFijo
{
    public class Af_Depreciacion_Det_Data
    {
        public Af_Depreciacion_Det_Info get_info(int IdEmpresa, decimal IdDepreciacion)
        {
            try
            {
                Af_Depreciacion_Det_Info info = new Af_Depreciacion_Det_Info();
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    Af_Depreciacion_Det Entity = Context.Af_Depreciacion_Det.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdDepreciacion == IdDepreciacion);
                    if (Entity == null) return null;
                    info = new Af_Depreciacion_Det_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdActivoFijo = Entity.IdActivoFijo,
                        IdDepreciacion = Entity.IdDepreciacion,
                        Concepto = Entity.Concepto,
                        Porc_Depreciacion = Entity.Porc_Depreciacion,
                        Secuencia = Entity.Secuencia,
                        Valor_Compra = Entity.Valor_Compra,
                        Valor_Depreciacion = Entity.Valor_Depreciacion,
                        Valor_Depre_Acum = Entity.Valor_Depre_Acum,
                        Valor_Salvamento = Entity.Valor_Salvamento,
                        Vida_Util = Entity.Vida_Util
                    };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(Af_Depreciacion_Det_Info info)
        {
            try
            {
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    Af_Depreciacion_Det Entity = new Af_Depreciacion_Det
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdActivoFijo = info.IdActivoFijo,
                        IdDepreciacion = info.IdDepreciacion,
                        Concepto = info.Concepto,
                        Porc_Depreciacion = info.Porc_Depreciacion,
                        Secuencia = info.Secuencia,
                        Valor_Compra = info.Valor_Compra,
                        Valor_Depreciacion = info.Valor_Depreciacion,
                        Valor_Depre_Acum = info.Valor_Depre_Acum,
                        Valor_Salvamento = info.Valor_Salvamento,
                        Vida_Util = info.Vida_Util

                    };
                    Context.Af_Depreciacion_Det.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool eliminarDB(int IdEmpresa, decimal IdDepreciacion)
        {
            try
            {
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    Context.Database.ExecuteSqlCommand("delete Af_Depreciacion_Det where IdEmpresa = '" + IdEmpresa + "'and IdDepreciacion = '" + IdDepreciacion);
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
