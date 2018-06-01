using Core.Erp.Info.Reportes.ActivoFijo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.ActivoFijo
{
  public  class ACTF_004_Data
    {
        public List<ACTF_004_Info> get_list(int IdEmpresa, DateTime fecha_corte)
        {
            try
            {
                string IdUsuario = "";
                List<ACTF_004_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                    Lista = (from q in Context.SPACTF_004_detalle(IdEmpresa, fecha_corte, IdUsuario)
                             select new ACTF_004_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdActivoFijo = q.IdActivoFijo,
                                 IdUsuario = q.IdUsuario,
                                 IdSucursal = q.IdSucursal,
                                 Su_Descripcion = q.Su_Descripcion,
                                 CodActivoFijo = q.CodActivoFijo,
                                 Af_Nombre = q.Af_Nombre,
                                 IdActivoFijoTipo = q.IdActivoFijoTipo,
                                 tipo_AF = q.tipo_AF,
                                 IdCategoria_Af = q.IdCategoria_Af,
                                 Categoria_AF = q.Categoria_AF,
                                 Af_costo_compra = q.Af_costo_compra,
                                 Af_Depreciacion_acum = q.Af_Depreciacion_acum,
                                 Costo_actual = q.Costo_actual,
                                 valor_ult_depreciacion = q.valor_ult_depreciacion,
                                 Af_fecha_compra = q.Af_fecha_compra
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
