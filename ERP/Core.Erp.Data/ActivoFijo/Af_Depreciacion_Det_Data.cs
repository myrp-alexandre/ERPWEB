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
        public List<Af_Depreciacion_Det_Info> get_list(int IdEmpresa, decimal IdDepreciacion)
        {
            try
            {
                List<Af_Depreciacion_Det_Info> lista;
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    lista = (from q in Context.Af_Depreciacion_Det
                             where q.IdEmpresa == IdEmpresa
                             && q.IdDepreciacion == IdDepreciacion
                             select new Af_Depreciacion_Det_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdActivoFijo = q.IdActivoFijo,
                                 IdDepreciacion = q.IdDepreciacion,
                                 Concepto = q.Concepto,
                                 Porc_Depreciacion = q.Porc_Depreciacion,
                                 Secuencia = q.Secuencia,
                                 Valor_Compra = q.Valor_Compra,
                                 Valor_Depreciacion = q.Valor_Depreciacion,
                                 Valor_Depre_Acum = q.Valor_Depre_Acum,
                                 Valor_Salvamento = q.Valor_Salvamento,
                                 Vida_Util = q.Vida_Util
                             }).ToList();
                }
                return lista; 
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
