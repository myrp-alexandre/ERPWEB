using Core.Erp.Info.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Core.Erp.Data.Facturacion
{
    public class fa_factura_x_cxc_cobro_tipo_Data
    {
        public List<fa_factura_x_cxc_cobro_tipo_Info> GetList(int IdEmpresa, int IdSucursal, int IdBodega, decimal IdCbteVta)
        {
            try
            {
                List<fa_factura_x_cxc_cobro_tipo_Info> Lista;
                using (Entities_facturacion db = new Entities_facturacion())
                {
                    Lista = db.fa_factura_x_cxc_cobro_tipo.Where(q => q.IdEmpresa_fa == IdEmpresa
                    && q.IdSucursal_fa == IdSucursal && q.IdBodega_fa == IdBodega
                    && q.IdCbteVta_fa == IdCbteVta).Select(q => new fa_factura_x_cxc_cobro_tipo_Info
                    {
                        IdCobro_tipo = q.IdCobro_tipo,
                        Valor = q.Valor
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
