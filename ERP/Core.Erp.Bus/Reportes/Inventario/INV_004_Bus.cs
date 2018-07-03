using Core.Erp.Data.Reportes.Inventario;
using Core.Erp.Info.Reportes.Inventario;
using System;
using System.Collections.Generic;

namespace Core.Erp.Bus.Reportes.Inventario
{
    public class INV_004_Bus
    {
        INV_004_Data odata = new INV_004_Data();
    
        public List<INV_004_Info> get_list(int IdEmpresa, int IdSucursal, int IdMovi_inven_tipo, decimal IdNumMovi, int IdBodega, string mv_tipo_movi, decimal IdProducto, string IdCategoria, int IdLinea, int IdGrupo, int IdSubgrupo, DateTime cm_fecha)

        {
            try
            {
                return odata.get_list(IdEmpresa, IdSucursal, IdMovi_inven_tipo, IdNumMovi, IdBodega, mv_tipo_movi, IdProducto, IdCategoria, IdLinea, IdGrupo, IdSubgrupo, cm_fecha);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
