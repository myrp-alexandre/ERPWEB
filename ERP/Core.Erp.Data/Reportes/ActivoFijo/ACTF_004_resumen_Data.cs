using Core.Erp.Info.Reportes.ActivoFijo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.ActivoFijo
{
    public class ACTF_004_resumen_Data
    {
        public List<ACTF_004_resumen_Info> get_list(int IdEmpresa, DateTime fecha_corte)
        {
            try
            {
                string IdUsuario = "";
                List<ACTF_004_resumen_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                    Lista = (from q in Context.SPACTF_004_resumen(IdEmpresa, fecha_corte, IdUsuario)
                             select new ACTF_004_resumen_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdActivoFijoTipo = q.IdActivoFijoTipo,
                                 IdUsuario = q.IdUsuario,
                                 Af_Descripcion = q.Af_Descripcion,
                                 Af_costo_compra = q.Af_costo_compra,
                                 Valor_Depreciacion = q.Valor_Depreciacion,
                                 Valor_ult_depreciacion = q.Valor_ult_depreciacion,
                                 Costo_neto = q.Costo_neto
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
