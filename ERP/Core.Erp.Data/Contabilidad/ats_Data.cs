using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.Contabilidad.ATS;
using Core.Erp.Info.Contabilidad.ATS.ATS_Info;
namespace Core.Erp.Data.Contabilidad
{
   public class ats_Data
    {
        public ats_Info get_info(int IdEmpresa, int IdPeriodo)
        {
            try
            {
                ats_Info info = new ats_Info();
                using (Entities_contabilidad Context = new Entities_contabilidad())
                {
                    info.lst_compras = (from q in Context.ATS_compras
                             select new compras_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdPeriodo = q.IdPeriodo,
                                 Secuencia = q.Secuencia,
                                 codSustento = q.codSustento,
                                 tpIdProv=q.tpIdProv,
                                 idProv=q.idProv,
                                 tipoComprobante=q.tipoComprobante,
                                 parteRel=q.parteRel,
                                 tipoProv=q.tipoProv,
                                 denopr=q.denopr,
                                 fechaRegistro=q.fechaRegistro,
                                 establecimiento=q.establecimiento,
                                 puntoEmision=q.puntoEmision,
                                 secuencial=q.secuencial,
                                 fechaEmision=q.fechaEmision,
                                 autorizacion=q.autorizacion,
                                 baseNoGraIva = q.baseNoGraIva,
                                 baseImponible = q.baseImponible,
                                 baseImpGrav=q.baseImpGrav,
                                 baseImpExe=q.baseImpExe,
                                 montoIce=q.montoIce,
                                 montoIva=q.montoIva,
                                 pagoLocExt=q.pagoLocExt,
                                 denopago=q.denopago,
                                 paisEfecPago=q.paisEfecPago,
                                 formaPago=q.formaPago,
                                 docModificado=q.docModificado,
                                 estabModificado=q.estabModificado,
                                 ptoEmiModificado=q.ptoEmiModificado,
                                 secModificado=q.secModificado,
                                 autModificado=q.autModificado
                             }).ToList();
                }

                return info;
            }
            catch (Exception)
            {
                
                throw;
            }
        }
    }
}
