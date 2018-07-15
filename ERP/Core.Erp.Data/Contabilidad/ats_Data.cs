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

                    Context.generarATS(IdEmpresa, IdPeriodo);

                    info.lst_compras = (from q in Context.ATS_compras
                                        where q.IdEmpresa==IdEmpresa
                                        && q.IdPeriodo==IdPeriodo
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




                    info.lst_ventas = (from v in Context.ATS_ventas
                                        where v.IdEmpresa == IdEmpresa
                                        && v.IdPeriodo == IdPeriodo
                                        select new ventas_Info
                                        {
                                            IdEmpresa = v.IdEmpresa,
                                            IdPeriodo = v.IdPeriodo,
                                            Secuencia = v.Secuencia,
                                            tpIdCliente = v.tpIdCliente,
                                            idCliente = v.idCliente,
                                            parteRel = v.parteRel,
                                           tipoCliente=v.tipoCliente,
                                           DenoCli=v.DenoCli,
                                           tipoEm=v.tipoEm,
                                           numeroComprobantes=v.numeroComprobantes,
                                           baseNoGraIva=v.baseNoGraIva,
                                           baseImponible=v.baseImponible,
                                           baseImpGrav=v.baseImpGrav,
                                           montoIva=v.montoIva,
                                           montoIce=v.montoIce,
                                           valorRetIva=v.valorRetIva,
                                           valorRetRenta=v.valorRetRenta,
                                           formaPago=v.formaPago,
                                           codEstab=v.codEstab,
                                           ventasEstab=v.ventasEstab,
                                           ivaComp=v.ivaComp
                                        }).ToList();


                    info.lst_retenciones = (from r in Context.ATS_retenciones
                                       where r.IdEmpresa == IdEmpresa
                                       && r.IdPeriodo == IdPeriodo
                                       select new retenciones_Info
                                       {
                                           IdEmpresa = r.IdEmpresa,
                                           IdPeriodo = r.IdPeriodo,
                                           Secuencia = r.Secuencia,
                                           co_serie=r.co_serie ,
                                           co_factura=r.co_factura,
                                           Cedula_ruc=r.Cedula_ruc,
                                           valRetBien10=r.valRetBien10,
                                           valRetServ20=r.valRetServ20,
                                           valorRetBienes=r.valorRetBienes,
                                           valRetServ50=r.valRetServ50,
                                           valorRetServicios=r.valorRetServicios,
                                           valRetServ100=r.valRetServ100,
                                           codRetAir=r.codRetAir,
                                           estabRetencion1=r.estabRetencion1,
                                           ptoEmiRetencion1=r.ptoEmiRetencion1,
                                           secRetencion1=r.secRetencion1,
                                           autRetencion1=r.autRetencion1,
                                          fechaEmiRet1=r.fechaEmiRet1,
                                          docModificado=r.docModificado,
                                          estabModificado=r.autModificado,
                                          ptoEmiModificado=r.ptoEmiModificado,
                                          secModificado=r.secModificado,
                                          autModificado=r.autModificado
                                       }).ToList();


                }

                return info;
            }
            catch (Exception ex)
            {
                
                throw;
            }
        }
    }
}
