using Core.Erp.Info.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Inventario
{
    public class in_devolucion_inven_det_Data
    {
        public List<in_devolucion_inven_det_Info> get_list_x_movimiento(int IdEmpresa, int IdSucursal, int IdMoviInven_tipo, decimal IdNumMovi)
        {
            try
            {
                List<in_devolucion_inven_det_Info> Lista;

                using (Entities_inventario Context = new Entities_inventario())
                {
                    Lista = (from q in Context.vwin_Ing_Egr_Inven_det_x_devolver
                             where q.IdEmpresa == IdEmpresa
                             && q.IdSucursal == IdSucursal
                             && q.IdMovi_inven_tipo == IdMoviInven_tipo
                             && q.IdNumMovi == IdNumMovi
                             select new in_devolucion_inven_det_Info
                             {
                                 inv_IdEmpresa = q.IdEmpresa,
                                 inv_IdSucursal = q.IdSucursal,
                                 inv_IdMovi_inven_tipo = q.IdMovi_inven_tipo,
                                 inv_IdNumMovi = q.IdNumMovi,
                                 inv_Secuencia = q.IdEmpresa,
                                 cant_devuelta = 0,
                                 IdUnidadMedida = q.IdUnidadMedida_sinConversion,
                                 dm_cantidad = q.dm_cantidad_sinConversion,
                                 mv_costo = q.mv_costo_sinConversion,
                                 IdBodega = q.IdBodega,                                 
                                 lote_num_lote = q.lote_num_lote,
                                 NomUnidad = q.NomUnidad,
                                 lote_fecha_vcto = q.lote_fecha_vcto,
                                 pr_descripcion = q.pr_descripcion,
                                 IdProducto = q.IdProducto,
                                 nom_presentacion = q.nom_presentacion,
                             }).ToList();
                }
                int secuencia = 1;
                Lista.ForEach(V => {
                    V.secuencia = secuencia++;
                    V.pr_descripcion = V.pr_descripcion + " " + V.nom_presentacion + " - " + V.lote_num_lote + " - " + (V.lote_fecha_vcto != null ? Convert.ToDateTime(V.lote_fecha_vcto).ToString("dd/MM/yyyy") : "");
                    V.dm_cantidad = Math.Abs(V.dm_cantidad);
                });
                Lista.ForEach(q => q.secuencia = secuencia++);   
                return Lista;
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
