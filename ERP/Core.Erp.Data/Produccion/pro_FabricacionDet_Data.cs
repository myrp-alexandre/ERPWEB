using Core.Erp.Info.Produccion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Produccion
{
    public class pro_FabricacionDet_Data
    {
        public List<pro_FabricacionDet_Info> GetList(int IdEmpresa, decimal IdFabricacion)
        {
            try
            {
                List<pro_FabricacionDet_Info> Lista;
                using (Entities_produccion Context = new Entities_produccion())
                {
                    Lista = Context.pro_FabricacionDet.Where(q => q.IdEmpresa == IdEmpresa && q.IdFabricacion == IdFabricacion).Select(q => new pro_FabricacionDet_Info
                    {
                        IdEmpresa = q.IdEmpresa,
                        IdFabricacion = q.IdProducto,
                        IdProducto = q.IdProducto,
                        Cantidad = q.Cantidad,
                        Costo = q.Costo,
                        IdUnidadMedida = q.IdUnidadMedida,
                        RealizaMovimiento = q.RealizaMovimiento,
                        Secuencia = q.Secuencia,
                        Signo = q.Signo

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
