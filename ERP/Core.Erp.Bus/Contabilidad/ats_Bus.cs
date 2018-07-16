using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.Contabilidad.ATS.ATS_Info;
using Core.Erp.Data.Contabilidad;
using Core.Erp.Info.Contabilidad.ATS;
using Core.Erp.Info.Contabilidad;
using Core.Erp.Data.General;
using Core.Erp.Info.General;
namespace Core.Erp.Bus.Contabilidad
{
  public  class ats_Bus
    {
        #region variables
        ats_Data odata = new ats_Data();
        tb_empresa_Data data_empresa = new tb_empresa_Data();
        tb_empresa_Info info_empresa = new tb_empresa_Info();
        ct_periodo_Info info_periodo = new ct_periodo_Info();
        ct_periodo_Data data_periodo = new ct_periodo_Data();
        tb_sucursal_Data data_sucursal = new tb_sucursal_Data();
        tb_sucursal_Info info_sucursal = new tb_sucursal_Info();
        #endregion
        public ats_Info get_info(int IdEmpresa, int IdPeriodo)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdPeriodo); 
            }
            catch (Exception)
            {

                throw;
            }
        }


        public iva get_ats(int IdEmpresa, int IdPeriodo, int IdSucursal)
        {
            try
            {
                string registro = "";
                iva ats = new iva();
                info_periodo = data_periodo.get_info(IdEmpresa, IdPeriodo);
                info_empresa = data_empresa.get_info(IdEmpresa);
                ats_Info info_ats = get_info(IdEmpresa, IdPeriodo);

                #region cabecera del xml
                ats.IdInformante = info_empresa.em_ruc;
                ats.razonSocial = info_empresa.RazonSocial.Replace(".", " ").Replace("ñ", "n").Replace("Ñ", "N");
                ats.Anio = info_periodo.IdanioFiscal.ToString();
                ats.Mes = info_periodo.pe_mes.ToString().PadLeft(2, '0');
                info_sucursal = data_sucursal.get_info(IdEmpresa, IdSucursal);
                ats.numEstabRuc = info_sucursal.Su_CodigoEstablecimiento.ToString().PadLeft(3, '0');
                ats.TipoIDInformante = ivaTypeTipoIDInformante.R;
                ats.codigoOperativo = codigoOperativoType.IVA;
                ats.totalVentas = info_ats.lst_ventas.Sum(v=>v.baseImpGrav+v.baseImpGrav);
                #endregion

                #region listado de compras
                if (info_ats.lst_compras != null)
                {
                    if(info_ats.lst_compras.Count() >0)
                    {
                        ats.compras = new List<detalleCompras>();
                    }
                    info_ats.lst_compras.ForEach(
                    comp =>
                       {
                           detalleCompras comp_det = new detalleCompras();

                           registro = comp.denopr + " " + comp.secuencial;
                         if(comp.secuencial== "000000301")
                           {
                               int s = 0;
                           }
                               comp_det.codSustento = comp.codSustento;
                               comp_det.tpIdProv = comp.tpIdProv;
                               comp_det.idProv = comp.idProv;
                               comp_det.tipoComprobante = comp.tipoComprobante;
                               comp_det.parteRel = parteRelType.NO;
                               comp_det.fechaRegistro = comp.fechaRegistro.ToString().Substring(0, 10);
                               comp_det.establecimiento = comp.establecimiento;
                               comp_det.puntoEmision = comp.puntoEmision;
                               comp_det.secuencial = comp.secuencial;
                               comp_det.fechaEmision = comp.fechaEmision.ToString().Substring(0, 10);
                               comp_det.autorizacion = comp.autorizacion;
                               comp_det.baseNoGraIva = comp.baseNoGraIva.ToString("n2");
                               comp_det.baseImponible = comp.baseImponible.ToString("n2");
                               comp_det.baseImpGrav = comp.baseImpGrav.ToString("n2");
                               comp_det.baseImpExe = comp.baseImpExe.ToString("n2");
                               comp_det.montoIce = comp.montoIce.ToString("n2");
                               comp_det.montoIva = comp.montoIva.ToString("n2");
                               comp_det.valRetBien10 = "0.00";
                               comp_det.valRetServ20 = "0.00";
                               comp_det.valorRetBienes = "0.00";
                               comp_det.valRetServ50 = "0.00";
                               comp_det.valorRetServicios = "0.00";
                               comp_det.valRetServ100 = "0.00";
                               comp_det.totbasesImpReemb = "0.00";
                               pagoExterior item_pago = new pagoExterior();
                               item_pago.pagoLocExt = (comp.pagoLocExt == "LOC") ? pagoLocExtType.Item01 : pagoLocExtType.Item02;
                               item_pago.paisEfecPago = (item_pago.pagoLocExt == pagoLocExtType.Item01) ? "NA" : (comp.pagoLocExt != null || comp.pagoLocExt != "") ? comp.pagoLocExt : "NA";
                               item_pago.aplicConvDobTrib = (comp.aplicConvDobTrib == "S") ? aplicConvDobTribType.SI : (comp.aplicConvDobTrib == "N") ? aplicConvDobTribType.NO : aplicConvDobTribType.NA;
                               item_pago.pagExtSujRetNorLeg = (comp.pagExtSujRetNorLeg == "S") ? aplicConvDobTribType.SI : (comp.pagExtSujRetNorLeg == "N") ? aplicConvDobTribType.NO : aplicConvDobTribType.NA;
                               comp_det.pagoExterior = item_pago;
                           

                           #region retencion por facturas
                           if (info_ats.lst_retenciones != null)
                           {
                               if(info_ats.lst_retenciones.Count() > 0)
                               {
                                   var lstret_x_fac = info_ats.lst_retenciones.Where(r =>r.Cedula_ruc==comp.idProv & r.co_serie==comp.establecimiento+"-"+comp.puntoEmision & comp.secuencial==r.co_factura);
                                   if(lstret_x_fac!=null)
                                   {
                                       if(lstret_x_fac.Count() > 0)
                                       {
                                           comp_det.air = new List<detalleAir>();
                                           foreach (var item in lstret_x_fac)
                                           {
                                               detalleAir detalle_ret = new detalleAir();
                                               detalle_ret.codRetAir = item.codRetAir.ToString();
                                               detalle_ret.baseImpAir = item.baseImpAir.ToString();
                                               detalle_ret.porcentajeAir = item.porcentajeAir.ToString();
                                               detalle_ret.valRetAir = item.valRetAir.ToString();
                                               comp_det.air.Add(detalle_ret);
                                           }
                                       }
                                   }
                               }
                           }
                           #endregion
                           ats.compras.Add(comp_det);
                          
                       });
                }
                #endregion

                #region Ventas
                if (info_ats.lst_ventas != null)
                {
                    if (info_ats.lst_ventas.Count() > 0)
                    {
                        ats.ventas = new List<detalleVentas>();
                        info_ats.lst_ventas.ForEach(
                             vent =>
                             {
                                 detalleVentas det_ventas = new detalleVentas();
                                 det_ventas.tpIdCliente = vent.tpIdCliente;
                                 det_ventas.idCliente = vent.idCliente;
                                 det_ventas.parteRelVtas = parteRelType.NO;
                                 det_ventas.tipoComprobante = vent.tipoComprobante;
                                 det_ventas.tipoEmision = tipoEmisionType.F;
                                 det_ventas.numeroComprobantes = vent.numeroComprobantes.ToString();
                                 det_ventas.baseImponible = vent.baseImponible;
                                 det_ventas.montoIva = vent.montoIva;
                                 det_ventas.montoIce = vent.montoIce;
                                 det_ventas.valorRetIva = vent.valorRetIva.ToString("n2");
                                 det_ventas.valorRetRenta = vent.valorRetRenta.ToString("n2");
                                 det_ventas.tpIdCliente = vent.tpIdCliente;
                                 det_ventas.tpIdCliente = vent.tpIdCliente;
                                 string[] forma_pago = new string[] { vent.formaPago };
                                 ats.ventas.Add(det_ventas);
                             }
                            );
                    }
                }
                #endregion

                #region MyRegion
                if (info_ats.lst_ventas != null)
                {
                    if (info_ats.lst_ventas.Count() > 0)
                    {

                      

                        var vtas = info_ats.lst_ventas.GroupBy(x => x.codEstab)
                        .Select(x => new
                        {
                            codEstab = x.Key,
                            ventasEstab = x.Sum(y => y.ventasEstab)
                        }).ToList();

                        foreach (var item in vtas)
                        {
                            ventaEst vtas_esta = new ventaEst();
                            vtas_esta.codEstab = item.codEstab;
                            vtas_esta.ventasEstab = item.ventasEstab;
                            vtas_esta.ivaComp = Convert.ToDecimal("0.00");

                        }


                    }
                }
                        #endregion


                        return ats;

                
            }
            catch (Exception e)
            {

                throw;
            }
        }
    }
}
