using Core.Erp.Info.Reportes.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.Inventario
{
   public class INV_009_Data
    {
        public List<INV_009_Info> get_list(int IdEmpresa, int IdSucursal, int IdBodega, int IdMarca, decimal IdProductoPadre, DateTime fechaCorte)
        {
            try
            {
                int IdSucursalIni = IdSucursal;
                int IdSucursalFin = IdSucursal == 0 ? 9999 : IdSucursal;

                int IdBodegaIni = IdBodega;
                int IdBodegaFin = IdBodega == 0 ? 9999 : IdBodega;

                int IdMarcaIni = IdMarca;
                int IdMarcaFin = IdMarca == 0 ? 9999 : IdMarca;

                decimal IdProductoPadreIni = IdProductoPadre;
                decimal IdProductoPadreFin = IdProductoPadre == 0 ? 9999 : IdProductoPadre;

                fechaCorte = fechaCorte.Date;

                List<INV_009_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                    Lista = (from q in Context.SPINV_009(IdEmpresa, IdSucursalIni, IdSucursalFin, IdBodegaIni, IdBodegaFin, IdMarcaIni, IdMarcaFin, IdProductoPadreIni, IdProductoPadreFin, fechaCorte)
                             select new INV_009_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdSucursal = q.IdSucursal,
                                 IdBodega = q.IdBodega,
                                 IdProducto = q.IdProducto,
                                 IdPresentacion = q.IdPresentacion,
                                 IdMarca = q.IdMarca,
                                 IdProductoTipo = q.IdProductoTipo,
                                 IdProducto_padre = q.IdProducto_padre,
                                 CostoTotal = q.CostoTotal,
                                 dm_cantidad = q.dm_cantidad,
                                 lote_fecha_vcto = q.lote_fecha_vcto,
                                 lote_num_lote = q.lote_num_lote,
                                 NomMarca = q.NomMarca,
                                 nom_presentacion = q.nom_presentacion,
                                 precio_1 = q.precio_1,
                                 pr_descripcion = q.pr_descripcion,
                                 tp_descripcion = q.tp_descripcion,
                                 bo_Descripcion = q.bo_Descripcion,
                                 Su_Descripcion = q.Su_Descripcion,
                                 PrecioTotal = q.PrecioTotal
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
