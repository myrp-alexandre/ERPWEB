using Core.Erp.Info.Reportes.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.Inventario
{
    public class INV_004_Data
    {
        public List<INV_004_Info> get_list(int IdEmpresa, int IdSucursal,int IdMovi_inven_tipo, decimal IdNumMovi, int IdBodega, string mv_tipo_movi, decimal IdProducto, string IdCategoria, int IdLinea, int IdGrupo, int IdSubgrupo, DateTime cm_fecha)
        {
            try
            {
                int IdSucursal_ini = IdSucursal;
                int IdSucursal_fin = IdSucursal == 0 ? 9999 : IdSucursal;
                int IdBodega_ini = IdBodega;
                int IdBodega_fin = IdBodega == 0 ? 9999 : IdBodega;
                decimal IdProducto_ini = IdProducto;
                decimal IdProducto_fin = IdProducto == 0 ? 9999 : IdProducto;
                DateTime cm_fecha_ini = cm_fecha;
                DateTime cm_fecha_fin = cm_fecha == DateTime.Now ? DateTime.Now.Date : cm_fecha;

                List<INV_004_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                    Lista = (from q in Context.VWINV_004
                             where q.IdEmpresa == IdEmpresa
                             && q.IdSucursal == IdSucursal
                             && q.IdBodega == IdBodega
                             && q.IdMovi_inven_tipo == IdMovi_inven_tipo
                             && q.IdNumMovi == IdNumMovi
                             && q.mv_tipo_movi == mv_tipo_movi
                             && q.IdProducto == IdProducto
                             && q.IdCategoria == IdCategoria
                             && q.IdLinea == IdLinea
                             && q.IdGrupo == IdGrupo
                             && q.IdSubGrupo == IdSubgrupo
                             && q.cm_fecha == cm_fecha
                             select new INV_004_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdSucursal = q.IdSucursal,
                                 IdBodega = q.IdBodega,
                                 IdMovi_inven_tipo = q.IdMovi_inven_tipo,
                                 IdNumMovi = q.IdNumMovi,
                                 mv_tipo_movi = q.mv_tipo_movi,
                                 Secuencia = q.Secuencia,
                                 tm_descripcion = q.tm_descripcion,
                                 IdProducto = q.IdProducto,
                                 pr_codigo = q.pr_codigo,
                                 pr_descripcion = q.pr_descripcion,
                                 nom_presentacion = q.nom_presentacion,
                                 lote_fecha_vcto = q.lote_fecha_vcto,
                                 lote_num_lote= q.lote_num_lote,
                                 cm_fecha = q.cm_fecha,
                                 cm_observacion = q.cm_observacion,
                                 Su_Descripcion = q.Su_Descripcion,
                                 bo_Descripcion = q.bo_Descripcion,
                                 dm_cantidad = q.dm_cantidad,
                                 mv_costo = q.mv_costo,
                                 IdUnidadMedida = q.IdUnidadMedida,
                                 Descripcion = q.Descripcion,
                                 IdCategoria = q.IdCategoria,
                                 IdLinea = q.IdLinea,
                                 IdGrupo = q.IdGrupo,
                                 IdSubGrupo = q.IdSubGrupo,
                                 anio = q.anio,
                                 mes = q.mes,
                                 IdProducto_padre = q.IdProducto_padre,
                                 pr_descripcion_padre = q.pr_descripcion_padre
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
