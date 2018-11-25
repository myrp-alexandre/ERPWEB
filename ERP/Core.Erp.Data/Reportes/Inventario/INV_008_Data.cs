using Core.Erp.Info.Inventario;
using Core.Erp.Info.Reportes.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.Inventario
{
    public class INV_008_Data
    {
        public List<INV_008_Info> get_list(int IdEmpresa, int IdSucursal, int IdBodega, bool mostrar_saldos_en_0, List<in_Producto_Info> lst_producto)
        {
            try
            {
                if (lst_producto == null)
                    lst_producto = new List<in_Producto_Info>();
                List<INV_008_Info> Lista = new List<INV_008_Info>();
                using (Entities_reportes Context = new Entities_reportes())
                {
                    foreach (var IdProducto in lst_producto)
                    {
                        if (mostrar_saldos_en_0)
                        {
                            Lista.AddRange((from q in Context.VWINV_008
                                            where q.IdEmpresa == IdEmpresa
                                            && q.IdSucursal == IdSucursal
                                            && q.IdBodega == IdBodega
                                            && q.IdProducto_padre == IdProducto.IdProducto
                                            select new INV_008_Info
                                            {
                                                IdEmpresa = q.IdEmpresa,
                                                IdSucursal = q.IdSucursal,
                                                IdBodega = q.IdBodega,
                                                IdProducto = q.IdProducto,
                                                pr_codigo = q.pr_codigo,
                                                pr_descripcion = q.pr_descripcion,
                                                IdProducto_padre = q.IdProducto_padre,
                                                lote_fecha_fab = q.lote_fecha_fab,
                                                lote_fecha_vcto = q.lote_fecha_vcto,
                                                lote_num_lote = q.lote_num_lote,
                                                stock = q.stock,
                                                IdLinea = q.IdLinea,
                                                IdGrupo = q.IdGrupo,
                                                IdSubGrupo = q.IdSubGrupo,
                                                IdCategoria = q.IdCategoria,
                                                ca_Categoria = q.ca_Categoria,
                                                bo_Descripcion = q.bo_Descripcion,
                                                IdPresentacion = q.IdPresentacion,
                                                nom_presentacion = q.nom_presentacion,
                                                Su_Descripcion = q.Su_Descripcion
                                            }).ToList());
                        }else
                            Lista.AddRange((from q in Context.VWINV_008
                                            where q.IdEmpresa == IdEmpresa
                                            && q.IdSucursal == IdSucursal
                                            && q.IdBodega == IdBodega
                                            && q.IdProducto_padre == IdProducto.IdProducto
                                            && q.stock > 0
                                            select new INV_008_Info
                                            {
                                                IdEmpresa = q.IdEmpresa,
                                                IdSucursal = q.IdSucursal,
                                                IdBodega = q.IdBodega,
                                                IdProducto = q.IdProducto,
                                                pr_codigo = q.pr_codigo,
                                                pr_descripcion = q.pr_descripcion,
                                                IdProducto_padre = q.IdProducto_padre,
                                                lote_fecha_fab = q.lote_fecha_fab,
                                                lote_fecha_vcto = q.lote_fecha_vcto,
                                                lote_num_lote = q.lote_num_lote,
                                                stock = q.stock,
                                                IdLinea = q.IdLinea,
                                                IdGrupo = q.IdGrupo,
                                                IdSubGrupo = q.IdSubGrupo,
                                                IdCategoria = q.IdCategoria,
                                                ca_Categoria = q.ca_Categoria,
                                                bo_Descripcion = q.bo_Descripcion,
                                                IdPresentacion = q.IdPresentacion,
                                                nom_presentacion = q.nom_presentacion,
                                                Su_Descripcion = q.Su_Descripcion
                                            }).ToList());
                    }                    
                }
                return Lista;
            }
            catch (Exception )
            {

                throw;
            }
        }
    }
}
