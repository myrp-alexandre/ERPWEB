using Core.Erp.Info.Reportes.CuentasPorCobrar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.CuentasPorCobrar
{
    public class CXC_006_sin_comision_Data
    {
        public List<CXC_006_sin_comision_Info> get_list(int IdEmpresa, decimal IdLiquidacion)
        {
            try
            {
                List<CXC_006_sin_comision_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                    Lista = (from q in Context.VWCXC_006_sin_comision
                             where q.IdEmpresa == IdEmpresa
                             && q.IdLiquidacion == IdLiquidacion
                             select new CXC_006_sin_comision_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdLiquidacion = q.IdLiquidacion,
                                 IdVendedor = q.IdVendedor,
                                 BaseComision = q.BaseComision,
                                 Estado = q.Estado,
                                 Fecha = q.Fecha,
                                 IvaFactura = q.IvaFactura,
                                 NoComisiona = q.NoComisiona,
                                 Observacion = q.Observacion,
                                 pe_nombreCompleto = q.pe_nombreCompleto,
                                 PorcentajeComision = q.PorcentajeComision,
                                 Saldo = q.Saldo,
                                 SubtotalFactura = q.SubtotalFactura,
                                 TotalAComisionar = q.TotalAComisionar,
                                 TotalCobrado = q.TotalCobrado,
                                 TotalComisionado = q.TotalComisionado,
                                 TotalFactura = q.TotalFactura,
                                 TotalLiquidacion = q.TotalLiquidacion,
                                 Ve_Vendedor = q.Ve_Vendedor,
                                 vt_NumFactura = q.vt_NumFactura,
                                 vt_tipoDoc = q.vt_tipoDoc
                                 
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
