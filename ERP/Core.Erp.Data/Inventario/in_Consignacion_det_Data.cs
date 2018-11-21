using Core.Erp.Info.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Inventario
{
    public class in_Consignacion_det_Data
    {
        public List<in_Consignacion_det_Info> GetList(int IdEmpresa, int IdConsignacion)
        {
            try
            {
                List<in_Consignacion_det_Info> Lista = new List<in_Consignacion_det_Info>();

                using (Entities_inventario db = new Entities_inventario())
                {
                    Lista = db.in_consignacion_det.Where(q => q.IdEmpresa == IdEmpresa && q.IdConsignacion == IdConsignacion).Select(q => new in_Consignacion_det_Info
                    {
                        IdEmpresa = q.IdEmpresa,
                        IdConsignacion = q.IdConsignacion,
                        Secuencial = q.Secuencial,
                        IdProducto = q.IdProducto,
                        IdUnidadMedida = q.IdUnidadMedida,
                        Cantidad = q.Cantidad,
                        Precio = q.Precio,
                        Observacion = q.Observacion
                    }).ToList();

                    return Lista;
                }
            }
            catch (Exception)
            {
                throw;
            }
        }

        public in_Consignacion_det_Info GetInfo(int IdEmpresa, int IdConsignacion)
        {
            try
            {
                in_Consignacion_det_Info info = new in_Consignacion_det_Info();

                using (Entities_inventario Context = new Entities_inventario())
                {
                    in_consignacion_det Entity = Context.in_consignacion_det.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdConsignacion == IdConsignacion);

                    if (Entity == null)
                    {
                        return null;
                    }

                    info = new in_Consignacion_det_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdConsignacion = Entity.IdConsignacion,
                        Secuencial = Entity.Secuencial,
                        IdProducto = Entity.IdProducto,
                        IdUnidadMedida = Entity.IdUnidadMedida,
                        Cantidad = Entity.Cantidad,
                        Observacion = Entity.Observacion
                    };
                }
                return info;
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
