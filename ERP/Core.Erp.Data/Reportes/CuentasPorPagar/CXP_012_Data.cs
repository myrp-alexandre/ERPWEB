using Core.Erp.Info.Reportes.CuentasPorPagar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.CuentasPorPagar
{
    public class CXP_012_Data
    {
        public List<CXP_012_Info> get_list(int IdEmpresa, decimal IdRetencion)
        {
            try
            {
                List<CXP_012_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                    Lista = (from q in Context.VWCXP_012
                             where q.IdEmpresa == IdEmpresa
                             && q.IdRetencion == IdRetencion
                             select new CXP_012_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdRetencion = q.IdRetencion,
                                 CodDocumentoTipo = q.CodDocumentoTipo,
                                 serie1 = q.serie1,
                                 serie2 = q.serie2,
                                 NumRetencion = q.NumRetencion,
                                 NAutorizacion = q.NAutorizacion,
                                 Fecha_Autorizacion = q.Fecha_Autorizacion,
                                 fecha = q.fecha,
                                 observacion = q.observacion,
                                 re_Tiene_RTiva = q.re_Tiene_RTiva,
                                 re_Tiene_RFuente = q.re_Tiene_RFuente,
                                 co_serie = q.co_serie,
                                 co_factura = q.co_factura,
                                 co_FechaFactura = q.co_FechaFactura,
                                 pe_razonSocial = q.pe_razonSocial,
                                 re_tipoRet = q.re_tipoRet,
                                 re_baseRetencion = q.re_baseRetencion,
                                 IdCodigo_SRI = q.IdCodigo_SRI,
                                 re_Codigo_impuesto = q.re_Codigo_impuesto,
                                 re_Porcen_retencion = q.re_Porcen_retencion,
                                 re_valor_retencion = q.re_valor_retencion,
                                 co_descripcion = q.co_descripcion                                 
                             }).ToList();
                }
                return Lista;
            }
            catch (Exception ex)
            {

                throw;
            }
        }
    }
}
