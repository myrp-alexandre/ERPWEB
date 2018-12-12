using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.ActivoFijo;

namespace Core.Erp.Data.ActivoFijo
{
  public  class Af_Activo_fijo_CtaCble_Data
    {
        public List<Af_Activo_fijo_CtaCble_Info> GetList(int IdEmpresa, int IdActivoFijo)
        {
            try
            {
                List<Af_Activo_fijo_CtaCble_Info> Lista;
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    Lista = Context.vwAf_Activo_fijo_CtaCble.Where(
                        q => q.IdEmpresa == IdEmpresa
                        && q.IdActivoFijo == IdActivoFijo).Select(
                        q => new Af_Activo_fijo_CtaCble_Info
                    {
                            IdActivoFijo = q.IdActivoFijo,
                            IdEmpresa = q.IdEmpresa,
                            IdCtaCble = q.IdCtaCble,
                           Porcentaje = q.Porcentaje,
                           Secuencia = q.Secuencia,
                           pc_Cuenta = q.pc_Cuenta,
                           IdDepartamento = q.IdDepartamento
                             
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
