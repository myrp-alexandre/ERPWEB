using Core.Erp.Info.Reportes.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.Inventario
{
    public class INV_014_Data
    {
        public List<INV_014_Info> get_list(int IdEmpresa, decimal IdConsignacion)
        {
            try
            {
                List<INV_014_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                    Lista = Context.VWINV_014.Where(q => q.IdEmpresa == IdEmpresa && q.IdConsignacion == IdConsignacion).Select(q => new INV_014_Info
                    {
                        IdEmpresa = q.IdEmpresa,
                        IdConsignacion = q.IdConsignacion,
                        IdSucursal = q.IdSucursal,
                        IdBodega = q.IdBodega,
                        Fecha = q.Fecha,
                        IdProveedor = Convert.ToInt32(q.IdProveedor),
                        Observacion = q.Observacion,
                        Estado = q.Estado,
                        Secuencia = q.Secuencia,
                        IdProducto = q.IdProducto,
                        IdUnidadMedida = q.IdUnidadMedida,
                        Cantidad = q.Cantidad,
                        Costo = q.Costo,
                        ObservacionDet = q.ObservacionDet,
                        pr_descripcion = q.pr_descripcion,
                        pr_codigo = q.pr_codigo,
                        pe_nombre_Completo = q.pe_nombreCompleto,
                        pe_apellido = q.pe_apellido,
                        IdPersona = Convert.ToInt32(q.IdPersona),
                        pe_nombre = q.pe_nombre
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
