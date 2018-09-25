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
                    Lista = (from q in Context.vwcxc_liquidacion_comisiones_det
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
                                 fa_IdBodega = q.IdBodega,
                                 fa_IdCbteVta = q.IdCbteVta,
                                fa_IdEmpresa = q.IdEmpresa,
                                fa_IdSucursal = q.IdSucursal,

                                 vt_NumFactura = q.vt_NumFactura,
                                 Nombres = q.Nombres,
                                 vt_fecha = q.vt_fecha,
                                 vt_fecha_venc = q.vt_fech_venc

                             }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public List<cxc_liquidacion_comisiones_det_Info> get_list_x_liquidar(int IdEmpresa, int IdVendedor)
        {
            try
            {
                List<cxc_liquidacion_comisiones_det_Info> Lista;
                using (Entities_cuentas_por_cobrar Context = new Entities_cuentas_por_cobrar())
                {
                    Lista = (from q in Context.vwcxc_liquidacion_comisiones_det_x_comisionar
                             where q.IdEmpresa == IdEmpresa
                             && q.IdVendedor == IdVendedor
                             select new cxc_liquidacion_comisiones_det_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdVendedor = q.IdVendedor,
                                 PorcentajeComision = q.PorComision,
                                 SubtotalFactura = q.vt_Subtotal,
                                 IvaFactura = q.vt_iva,
                                 TotalFactura = q.vt_total,
                                 TotalCobrado = q.valor_cobro,
                                 BaseComision = q.vt_Subtotal,
                                 TotalAComisionar = q.TotalAComisionar,
                                 TotalComisionado = q.TotalComisionado,
                                 TotalLiquidacion = 0,
                                 NoComisiona = false,
                                 fa_IdBodega = q.IdBodega,
                                 fa_IdCbteVta = q.IdCbteVta,
                                 fa_IdEmpresa = q.IdEmpresa,
                                 fa_IdSucursal = q.IdSucursal,

                                 vt_NumFactura = q.vt_NumFactura,
                                 Nombres = q.Nombres,
                                 vt_fecha = q.vt_fecha,
                                 vt_fecha_venc = q.vt_fech_venc
                             }).ToList();
                    int Secuencia = 1;
                    Lista.ForEach(q => q.Secuencia = Secuencia++);
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
