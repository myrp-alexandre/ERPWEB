using Core.Erp.Info.Reportes.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.Inventario
{
    public class INV_012_Data
    {
        public List<INV_012_Info> get_list(int IdEmpresa, int IdSucursal, int IdBodega, decimal IdProducto, int IdMarca, DateTime? fechaIni, int dIAS)
        {
            try
            {
                int IdSucursalIni = IdSucursal;
                int IdSucursalFin = IdSucursal == 0 ? 9999 : IdSucursal;

                int IdBodegaIni = IdBodega;
                int IdBodegaFin = IdBodega == 0 ? 9999 : IdBodega;

                decimal IdProductoIni = IdProducto;
                decimal IdProductoFin = IdProducto == 0 ? 9999 : IdProducto;

                int IdMarcaIni = IdMarca;
                int IdMarcaFin = IdMarca == 0 ? 9999 : IdMarca;
                List<INV_012_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                    Lista = (from q in Context.SPINV_012(IdEmpresa, IdSucursalIni, IdSucursalFin, IdBodegaIni, IdBodegaFin, IdProductoIni, IdProductoFin, IdMarcaIni, IdMarcaFin, fechaIni, dIAS)
                             select new INV_012_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdSucursal = q.IdSucursal,
                                 IdBodega = q.IdBodega,
                                 IdProducto = q.IdProducto,
                                 NomBodega = q.NomBodega,
                                 NomMarca = q.NomMarca,
                                 NomPresentacion = q.NomPresentacion,
                                 NomProducto = q.NomProducto,
                                 NomSucursal = q.NomSucursal,
                                 StockActual = q.StockActual,
                                 DiasAVencer = q.DiasAVencer, 
                                 IdProducto_padre = q.IdProducto_padre,
                                 lote_fecha_vcto = q.lote_fecha_vcto,
                                 lote_num_lote = q.lote_num_lote
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
