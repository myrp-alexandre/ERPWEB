using Core.Erp.Info.Reportes.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.Inventario
{
   public  class INV_015_Data
    {
        public List<INV_015_Info> get_list(int IdEmpresa, int IdSucursal, int IdBodega, decimal IdProducto, int IdCategoria, int IdLinea, int IdGrupo, int IdSubgrupo)
        {
            try
            {
                List<INV_015_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                    Lista = Context.VWINV_015.Where(q => q.IdEmpresa_fa == IdEmpresa
                    && q.IdSucursal_fa == IdSucursal
                    && q.IdBodega_fa == IdBodega
                    && q.IdProducto == IdProducto
                    && q.IdCategoria == IdCategoria
                    && q.IdLinea == IdLinea
                    && q.IdGrupo == IdGrupo
                    && q.IdSubGrupo == IdSubgrupo

                    ).Select(q => new INV_015_Info
                    {
                        IdEmpresa_eg = q.IdEmpresa_eg,
                        IdEmpresa_fa = q.IdEmpresa_fa,
                        IdBodega_fa = q.IdBodega_fa,
                        IdCategoria= q.IdCategoria,
                        CantidadFac = q.CantidadFac,
                        CantidadInv = q.CantidadInv,
                        ca_Categoria = q.ca_Categoria,
                        CostoUni = q.CostoUni,
                        IdCbteVta_fa = q.IdCbteVta_fa,
                        IdGrupo =q.IdGrupo,
                        IdLinea = q.IdLinea,
                        IdMovi_inven_tipo_eg = q.IdMovi_inven_tipo_eg,
                        IdNumMovi_eg = q.IdNumMovi_eg,
                        IdSubGrupo = q.IdSubGrupo,
                        IdSucursal_eg = q.IdSucursal_eg,
                        IdSucursal_fa = q.IdSucursal_fa,
                        nom_grupo = q.nom_grupo,
                        nom_linea = q.nom_linea,
                        nom_subgrupo = q.nom_subgrupo,
                        pr_descripcion = q.pr_descripcion,
                        Secuencia_eg = q.Secuencia_eg,
                        Secuencia_fa = q.Secuencia_fa,
                        Su_Descripcion = q.Su_Descripcion,
                        TotalCosto = q.TotalCosto,
                        TotalFac = q.TotalFac,
                        Utilidad = q.Utilidad,
                        vt_fecha = q.vt_fecha,
                        vt_NumFactura = q.vt_NumFactura,
                        vt_PrecioFinal = q.vt_PrecioFinal,
                        IdProducto = q.IdProducto

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
