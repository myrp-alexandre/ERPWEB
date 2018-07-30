using Core.Erp.Info.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Inventario
{
    public class in_devolucion_inven_Data
    {
        public List<in_devolucion_inven_Info> get_list(int IdEmpresa, DateTime Fecha_ini, DateTime Fecha_fin)
        {
            try
            {
                Fecha_ini = Fecha_ini.Date;
                Fecha_fin = Fecha_fin.Date;
                List<in_devolucion_inven_Info> Lista;
                using (Entities_inventario Context = new Entities_inventario())
                {
                    Lista = (from q in Context.in_devolucion_inven
                             where q.IdEmpresa == IdEmpresa
                             && Fecha_ini <= q.Fecha && q.Fecha <= Fecha_fin
                             select new in_devolucion_inven_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdDev_Inven = q.IdDev_Inven,
                                 cod_Dev_Inven = q.cod_Dev_Inven,
                                 Fecha = q.Fecha,
                                 observacion = q.observacion,
                                 Estado = q.Estado,
                                 dev_IdEmpresa = q.dev_IdEmpresa,
                                 dev_IdSucursal = q.dev_IdSucursal,
                                 dev_IdMovi_inven_tipo = q.dev_IdMovi_inven_tipo,
                                 dev_IdNumMovi = q.dev_IdNumMovi,
                                 dev_signo = q.dev_signo
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
