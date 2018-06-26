using Core.Erp.Info.Caja;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Caja
{
    public class cp_conciliacion_Caja_det_Data
    {
        public List<cp_conciliacion_Caja_det_Info> get_list(int IdEmpresa, decimal IdConciliacion_caja)
        {
            try
            {
                List<cp_conciliacion_Caja_det_Info> Lista;

                using (Entities_caja Context = new Entities_caja())
                {
                    Lista = (from q in Context.cp_conciliacion_Caja_det
                             where q.IdEmpresa == IdEmpresa
                             && q.IdConciliacion_Caja == IdConciliacion_caja
                             select new cp_conciliacion_Caja_det_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdConciliacion_Caja = q.IdConciliacion_Caja,
                                 Secuencia = q.Secuencia,
                                 IdEmpresa_OGiro = q.IdEmpresa_OGiro,
                                 IdTipoCbte_Ogiro = q.IdTipoCbte_Ogiro,
                                 IdCbteCble_Ogiro = q.IdCbteCble_Ogiro,
                                 IdTipoMovi = q.IdTipoMovi,
                                 Valor_a_aplicar = q.Valor_a_aplicar,
                                 Tipo_documento = q.Tipo_documento,
                                 IdEmpresa_OP = q.IdEmpresa_OP,
                                 IdOrdenPago_OP = q.IdOrdenPago_OP
                                 
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
