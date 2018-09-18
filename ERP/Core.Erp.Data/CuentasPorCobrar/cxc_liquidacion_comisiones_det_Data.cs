using Core.Erp.Info.CuentasPorCobrar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.CuentasPorCobrar
{
  public  class cxc_liquidacion_comisiones_det_Data
    {
        public List<cxc_liquidacion_comisiones_det_Info> get_list(int IdEmpresa, decimal IdLiquidacion)
        {
            try
            {
                List<cxc_liquidacion_comisiones_det_Info> Lista;
                using (Entities_cuentas_por_cobrar Context = new Entities_cuentas_por_cobrar())
                {
                    Lista = (from q in Context.cxc_liquidacion_comisiones_det
                             where q.IdEmpresa == IdEmpresa
                             && q.IdLiquidacion == IdLiquidacion
                             select new cxc_liquidacion_comisiones_det_Info
                             {
                                 IdEmpresa =q.IdEmpresa,
                                 IdLiquidacion = q.IdLiquidacion,
                                 Secuencia = q.Secuencia,
                                 IdVendedor = q.IdVendedor,
                                 PorcentajeComision = q.PorcentajeComision,
                                 SubtotalFactura = q.SubtotalFactura,
                                 IvaFactura = q.IvaFactura,
                                 TotalFactura = q.TotalFactura,
                                 TotalCobrado = q.TotalCobrado,
                                 BaseComision = q.BaseComision,
                                 TotalAComisionar = q.TotalAComisionar,
                                 TotalComisionado = q.TotalComisionado,
                                 TotalLiquidacion = q.TotalLiquidacion,
                                 NoComisiona = q.NoComisiona,
                                 fa_IdBodega = q.fa_IdBodega,
                                 fa_IdCbteVta = q.fa_IdCbteVta,
                                fa_IdEmpresa = q.fa_IdEmpresa,
                                fa_IdSucursal = q.fa_IdSucursal
                                 
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
