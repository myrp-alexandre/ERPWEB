using Core.Erp.Bus.Contabilidad;
using Core.Erp.Bus.General;
using Core.Erp.Data.CuentasPorPagar;
using Core.Erp.Info.CuentasPorPagar;
using Core.Erp.Info.General;
using Core.Erp.Info.Helps;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Core.Erp.Bus.CuentasPorPagar
{
    public class cp_nota_DebCre_Bus
    {
        cp_nota_DebCre_Data data = new cp_nota_DebCre_Data();
        ct_cbtecble_Bus bus_contabilidad = new ct_cbtecble_Bus();
        cp_cuotas_x_doc_Bus bus_cuotas = new cp_cuotas_x_doc_Bus();
        ct_cbtecble_det_Bus bus_comrpbante_det = new ct_cbtecble_det_Bus();
        tb_sis_Documento_Tipo_Talonario_Bus bus_talonario = new tb_sis_Documento_Tipo_Talonario_Bus();
        tb_sis_Documento_Tipo_Talonario_Info info_talonario=new tb_sis_Documento_Tipo_Talonario_Info();
        cp_orden_pago_cancelaciones_Data data_cancelacion = new cp_orden_pago_cancelaciones_Data();
        cp_orden_pago_cancelaciones_Info info_cancelacion = new cp_orden_pago_cancelaciones_Info();
        ct_periodo_Bus bus_periodo = new ct_periodo_Bus();
        public List<cp_nota_DebCre_Info> get_lst(int IdEmpresa, DateTime fi, DateTime ff)
        {
            try
            {
                return data.get_lst(IdEmpresa, fi, ff);
            }
            catch (Exception)
            {

                throw;
            }
        }
      

        public bool guardarDB(cp_nota_DebCre_Info info)
        {
            try
            {
                cp_proveedor_Bus bus_proveedor = new cp_proveedor_Bus();
                var prov = bus_proveedor.get_info(info.IdEmpresa, info.IdProveedor);

                info.info_comrobante.IdEmpresa = info.IdEmpresa;
                info.info_comrobante.cb_Fecha = (DateTime)info.Fecha_contable;
                info.info_comrobante.cb_Anio = info.info_comrobante.cb_Fecha.Year;
                info.info_comrobante.cb_mes = info.info_comrobante.cb_Fecha.Month;
                info.info_comrobante.cb_Estado = "A";
                info.info_comrobante.IdPeriodo = Convert.ToInt32(info.info_comrobante.cb_Fecha.Year.ToString() + info.info_comrobante.cb_Fecha.Month.ToString().PadLeft(2, '0'));
                info.info_comrobante.IdEmpresa = info.IdEmpresa;
                if (prov != null)
                {
                    if (info.cn_observacion == null)
                        info.cn_observacion = "";
                    info.info_comrobante.cb_Observacion = "Prov: " + prov.info_persona.pe_nombreCompleto + " "+ info.cn_observacion;

                }
                else
                    info.info_comrobante.cb_Observacion = info.cn_observacion;
                if (bus_contabilidad.guardarDB(info.info_comrobante))
                {
                    data = new cp_nota_DebCre_Data();
                    info.IdTipoCbte_Nota = info.info_comrobante.IdTipoCbte;
                    info.IdCbteCble_Nota = info.info_comrobante.IdCbteCble;
                    info.DebCre = "C";
                    info.Estado = "A";
                    info.cn_vaCoa = "N";
                    info.IdTipoNota = info.IdTipoNota;
                    info.nom_pc = " ";
                    info.ip = " ";
                   if( data.guardarDB(info))
                    {
                        data_cancelacion = new cp_orden_pago_cancelaciones_Data();
                        foreach (var item in info.lst_detalle_op)
                        {
                            info_cancelacion.IdEmpresa = info.IdEmpresa;
                            info_cancelacion.Idcancelacion = 0;
                            info_cancelacion.Secuencia = 1;

                            info_cancelacion.IdEmpresa_op = info.IdEmpresa;
                            info_cancelacion.IdOrdenPago_op = item.IdOrdenPago;
                            info_cancelacion.Secuencia_op = item.Secuencia;
                            info_cancelacion.IdEmpresa_op_padre = info.IdEmpresa;
                            info_cancelacion.IdOrdenPago_op_padre = item.IdOrdenPago;
                            info_cancelacion.Secuencia_op_padre = item.Secuencia;

                            info_cancelacion.IdEmpresa_cxp = info.IdEmpresa;
                            info_cancelacion.IdTipoCbte_cxp = info.IdTipoCbte_Nota ;
                            info_cancelacion.IdCbteCble_cxp = info.IdCbteCble_Nota;
                            info_cancelacion.IdEmpresa_pago = info.IdEmpresa;
                            info_cancelacion.IdTipoCbte_pago = info.IdTipoCbte_Nota;
                            info_cancelacion.IdCbteCble_pago = info.IdCbteCble_Nota;
                            info_cancelacion.Observacion = info.cn_observacion;
                            info_cancelacion.MontoAplicado = item.Valor_a_pagar;
                            data_cancelacion.guardarDB(info_cancelacion);
                        }
                    }
                }

              
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(cp_nota_DebCre_Info info)
        {
            try
            {
                info.info_comrobante.IdEmpresa = info.IdEmpresa;
                info.info_comrobante.IdTipoCbte = info.IdTipoCbte_Nota;
                info.info_comrobante.IdCbteCble = info.IdCbteCble_Nota;
                info.info_comrobante.cb_Fecha = (DateTime)info.Fecha_contable;
                info.info_comrobante.cb_Anio = info.info_comrobante.cb_Fecha.Year;
                info.info_comrobante.cb_mes = info.info_comrobante.cb_Fecha.Month;
                info.info_comrobante.cb_Estado = "A";
                info.info_comrobante.IdPeriodo = Convert.ToInt32(info.info_comrobante.cb_Fecha.Year.ToString() + info.info_comrobante.cb_Fecha.Month.ToString().PadLeft(2, '0'));
                info.info_comrobante.IdEmpresa = info.IdEmpresa;
                info.info_comrobante.cb_Observacion = info.cn_observacion;

                info.cn_baseImponible = info.cn_subtotal_iva + info.cn_subtotal_siniva;
                if (bus_contabilidad.modificarDB(info.info_comrobante))
                {
                    data = new cp_nota_DebCre_Data();
                    if (data.modificarDB(info))
                    {
                        data_cancelacion = new cp_orden_pago_cancelaciones_Data();
                        data_cancelacion.ElimarDB(info.IdEmpresa, info.IdTipoCbte_Nota, info.IdCbteCble_Nota);
                        foreach (var item in info.lst_detalle_op)
                        {
                            info_cancelacion.IdEmpresa = info.IdEmpresa;
                            info_cancelacion.Idcancelacion = 0;
                            info_cancelacion.Secuencia = 1;

                            info_cancelacion.IdEmpresa_op = info.IdEmpresa;
                            info_cancelacion.IdOrdenPago_op = item.IdOrdenPago;
                            info_cancelacion.Secuencia_op = item.Secuencia;
                            info_cancelacion.IdEmpresa_op_padre = info.IdEmpresa;
                            info_cancelacion.IdOrdenPago_op_padre = item.IdOrdenPago;
                            info_cancelacion.Secuencia_op_padre = item.Secuencia;

                            info_cancelacion.IdEmpresa_cxp = info.IdEmpresa;
                            info_cancelacion.IdTipoCbte_cxp = info.IdTipoCbte_Nota;
                            info_cancelacion.IdCbteCble_cxp = info.IdCbteCble_Nota;
                            info_cancelacion.IdEmpresa_pago = info.IdEmpresa;
                            info_cancelacion.IdTipoCbte_pago = info.IdTipoCbte_Nota;
                            info_cancelacion.IdCbteCble_pago = info.IdCbteCble_Nota;
                            info_cancelacion.Observacion = info.cn_observacion;
                            info_cancelacion.MontoAplicado = item.Valor_a_pagar;
                            data_cancelacion.guardarDB(info_cancelacion);
                        }
                    }
                    }


                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool anularDB(cp_nota_DebCre_Info info)
        {
            try
            {
                info.info_comrobante.IdEmpresa = info.IdEmpresa;
                info.info_comrobante.IdTipoCbte = info.IdTipoCbte_Nota;
                info.info_comrobante.IdCbteCble = info.IdCbteCble_Nota;
                info.info_comrobante.cb_Fecha = (DateTime)info.Fecha_contable;
                info.info_comrobante.cb_Anio = info.info_comrobante.cb_Fecha.Year;
                info.info_comrobante.cb_mes = info.info_comrobante.cb_Fecha.Month;
                info.info_comrobante.cb_Estado = "A";
                info.info_comrobante.IdPeriodo = Convert.ToInt32(info.info_comrobante.cb_Fecha.Year.ToString() + info.info_comrobante.cb_Fecha.Month.ToString().PadLeft(2, '0'));
                info.info_comrobante.IdEmpresa = info.IdEmpresa;
                info.info_comrobante.cb_Observacion = info.cn_observacion;


                if (bus_contabilidad.anularDB(info.info_comrobante))
                {
                    data = new cp_nota_DebCre_Data();
                    info.IdTipoCbte_Nota = info.IdTipoCbte_Nota;
                    info.IdTipoCbte_Nota = info.IdTipoCbte_Nota;
                    data.anularDB(info);
                    data_cancelacion.ElimarDB(info.IdEmpresa, info.IdTipoCbte_Nota, info.IdCbteCble_Nota);
                }


                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }


        public cp_nota_DebCre_Info get_info(int IdEmpresa, int IdTipoCbte_Nota, decimal IdCbteCble_Nota)
        {
            try
            {
                cp_nota_DebCre_Info info = new cp_nota_DebCre_Info();
                info = data.get_info(IdEmpresa, IdTipoCbte_Nota, IdCbteCble_Nota);
                info.info_comrobante = bus_contabilidad.get_info(IdEmpresa, IdTipoCbte_Nota, IdCbteCble_Nota);
                info.info_comrobante.lst_ct_cbtecble_det = bus_comrpbante_det.get_list(IdEmpresa, IdTipoCbte_Nota, IdCbteCble_Nota);
             
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public string validar(cp_nota_DebCre_Info info)
        {
            try
            {
                string mensaje = "";
                if (!bus_periodo.ValidarFechaTransaccion(info.IdEmpresa, info.cn_fecha, cl_enumeradores.eModulo.CONTA, ref mensaje))
                {
                    return mensaje;
                }

                if (!bus_periodo.ValidarFechaTransaccion(info.IdEmpresa, info.cn_fecha, cl_enumeradores.eModulo.CXP, ref mensaje))
                {
                    return mensaje;
                }

                
                if (info.IdSucursal == 0 )
                {
                    mensaje = "Selecciona la sucursal";
                    return mensaje;
                }
                if (info.IdProveedor == 0)
                {
                    mensaje = "Selecciona el proveedor";
                    return mensaje;
                }
                if (info.IdTipoServicio == "")
                {
                    mensaje = "Selecciona el tipo de servicio";
                    return mensaje;
                }
                if (info.IdIden_credito == 0)
                {
                    mensaje = "Selecciona el tipo de sustento tributario";
                    return mensaje;
                }

                if ( info.IdTipoNota == "")
                {
                    mensaje = "Selecciona el tipo de documento";
                    return mensaje;
                }
                if (info.IdTipoNota == cl_enumeradores.eTipoNotaCXP.T_TIP_NOTA_SRI.ToString())
                {
                    if (info.cn_serie1 == "" | info.cn_Nota == null)
                    {
                        mensaje = "Ingrese seri del documento";
                        return mensaje;
                    }
                    if (info.cn_Nota == "" | info.cn_Nota == null)
                    {
                        mensaje = "Ingrese el número del documento";
                        return mensaje;
                    }
                    if (info.cn_Autorizacion == "" | info.cn_Autorizacion == null)
                    {
                        mensaje = "Ingrese el número de autorización";
                        return mensaje;
                    }
                }
                
                if (info.cn_observacion == "" | info.cn_observacion == null)
                {
                    mensaje = "Ingrese la observación";
                    return mensaje;
                }
                if (info.PagoLocExt == "EXT")
                {
                    if (info.PaisPago == "" | info.PaisPago == null)
                    {
                        mensaje = "Seleccion el país donde se realiza el pago";
                        return mensaje;
                    }
                }
                if (info.cn_total == 0)
                {
                    mensaje = "El monto de la factura no puede ser cero";
                    return mensaje;
                }
                info.info_comrobante.lst_ct_cbtecble_det.ForEach(item =>
                {
                    if (item.IdCtaCble == null | item.IdCtaCble == "")
                        mensaje = "Falta cuenta contable " + item.dc_Observacion;
                });

                if (Convert.ToDouble(info.info_comrobante.lst_ct_cbtecble_det.Sum(v => v.dc_Valor)) != 0)
                    mensaje = "El diario contable esta descuadrado ";

               
                return mensaje;

            }
            catch (Exception)
            {

                throw;
            }
        }

        public cp_nota_DebCre_Info get_info_nuevo(int IdEmpresa)
        {
            try
            {
                cp_nota_DebCre_Info info = new cp_nota_DebCre_Info();
                   tb_sis_Documento_Tipo_Talonario_Info info_ = new tb_sis_Documento_Tipo_Talonario_Info();
                info_= bus_talonario.get_info_ultimo_no_usado(IdEmpresa, "NTCR");
                info.IdEmpresa = IdEmpresa;
                info.cn_serie1 = info_.Establecimiento;
                info.cn_serie2 = info_.PuntoEmision;
                info.cn_Nota = info_.NumDocumento;
                info.cn_Autorizacion = info_.NumAutorizacion;
                info.Fecha_contable = DateTime.Now;
                info.cn_fecha = DateTime.Now;
                return info;

            }
            catch (Exception)
            {

                throw;
            }
        
}

    

    }
}
