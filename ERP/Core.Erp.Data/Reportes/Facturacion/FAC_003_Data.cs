using Core.Erp.Info.Reportes.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Core.Erp.Data.Reportes.Facturacion
{
    public class FAC_003_Data
    {
        public List<FAC_003_Info> get_list(int IdEmpresa, int IdSucursal, int IdBodega, decimal IdCbteVta, bool mostrar_cuotas)
        {
            try
            {
                List<FAC_003_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                        Lista = (from q in Context.VWFAC_003
                                 where q.IdEmpresa == IdEmpresa
                                 && q.IdSucursal == IdSucursal
                                 && q.IdBodega == IdBodega
                                 && q.IdCbteVta == IdCbteVta
                                 select new FAC_003_Info
                                 {

                                 }).ToList();
                    
                    
                }
                return Lista.OrderBy(q => q.Secuencia).ThenBy(q => q.orden).ToList();
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
