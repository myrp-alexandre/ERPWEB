using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.CuentasPorPagar;
namespace Core.Erp.Data.CuentasPorPagar
{
   public class cp_orden_giro_Data
    {

        public bool guardarDB( cp_orden_giro_Info info)
        {
            try
            {
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    cp_orden_giro Entity = new cp_orden_giro
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdCbteCble_Ogiro = info.IdCbteCble_Ogiro,
                        IdTipoCbte_Ogiro = info.IdTipoCbte_Ogiro,
                        IdOrden_giro_Tipo = info.IdOrden_giro_Tipo,
                        IdProveedor = info.IdProveedor,
                        co_fechaOg = info.co_fechaOg,
                        co_serie = info.co_serie,
                        co_factura = info.co_factura,
                        co_FechaFactura = info.co_FechaFactura,
                        co_FechaContabilizacion = info.co_FechaContabilizacion,
                        co_FechaFactura_vct = info.co_FechaFactura_vct,
                        co_plazo = info.co_plazo,
                        co_observacion = info.co_observacion,
                        co_subtotal_iva = info.co_subtotal_iva,
                        co_subtotal_siniva = info.co_subtotal_siniva,
                        co_baseImponible = info.co_baseImponible,
                        co_Por_iva = info.co_Por_iva,
                        co_valoriva = info.co_valoriva,
                        IdCod_ICE = info.IdCod_ICE,
                        co_Ice_base = info.co_Ice_base,
                        co_Ice_por = info.co_Ice_por,
                        co_Ice_valor = info.co_Ice_valor,
                        co_Serv_por = info.co_Serv_por,
                        co_Serv_valor = info.co_Serv_valor,
                        co_OtroValor_a_descontar = info.co_OtroValor_a_descontar,
                        co_OtroValor_a_Sumar = info.co_OtroValor_a_Sumar,
                        co_BaseSeguro = info.co_BaseSeguro,
                        co_total = info.co_total,
                        co_valorpagar = info.co_valorpagar,
                        co_vaCoa = "S",
                        IdIden_credito = info.IdIden_credito,
                        IdCod_101 = info.IdCod_101,
                        IdTipoFlujo = info.IdTipoFlujo,
                        IdTipoServicio = info.IdTipoServicio,
                        IdCtaCble_Gasto = info.IdCtaCble_Gasto,
                        IdCtaCble_IVA = info.IdCtaCble_IVA,
                        co_retencionManual = info.co_retencionManual,
                        IdCbteCble_Anulacion = info.IdTipoCbte_Anulacion,
                        IdCentroCosto = info.IdCentroCosto,
                        IdSucursal = info.IdSucursal,
                        PagoLocExt = info.PagoLocExt,
                        PaisPago = info.PaisPago,
                        ConvenioTributacion = info.ConvenioTributacion_bool == true ? "SI" : "NO",
                        PagoSujetoRetencion = info.PagoSujetoRetencion_bool == true ? "SI" : "NO",
                        BseImpNoObjDeIva = info.BseImpNoObjDeIva,
                        fecha_autorizacion = info.fecha_autorizacion,
                        Num_Autorizacion = info.Num_Autorizacion,
                        Num_Autorizacion_Imprenta = info.Num_Autorizacion_Imprenta,
                        co_propina = info.co_propina,
                        co_IRBPNR = info.co_IRBPNR,
                        es_retencion_electronica = info.es_retencion_electronica,
                        cp_es_comprobante_electronico = info.cp_es_comprobante_electronico,
                        Tipodoc_a_Modificar = info.Tipodoc_a_Modificar,
                        estable_a_Modificar = info.estable_a_Modificar,
                        ptoEmi_a_Modificar = info.ptoEmi_a_Modificar,
                        num_docu_Modificar = info.num_docu_Modificar,
                        aut_doc_Modificar = info.aut_doc_Modificar,
                        IdTipoMovi = info.IdTipoMovi,
                        Estado = "A",
                        IdUsuario = info.IdUsuario,
                        Fecha_Transac = info.Fecha_Transac = DateTime.Now,



                    };
                    Context.cp_orden_giro.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool modificarDB(cp_orden_giro_Info info)
        {
            try
            {
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    cp_orden_giro Entity = Context.cp_orden_giro.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa
                    && q.IdTipoCbte_Ogiro==info.IdTipoCbte_Ogiro
                    && q.IdCbteCble_Ogiro==info.IdCbteCble_Ogiro);
                    if (Entity == null) return false;
                    {

                        Entity.co_fechaOg = info.co_fechaOg;
                        Entity.co_serie = info.co_serie;
                        Entity.co_factura = info.co_factura;
                        Entity.co_FechaFactura = info.co_FechaFactura;
                        Entity.co_FechaContabilizacion = info.co_FechaContabilizacion;
                        Entity.co_FechaFactura_vct = info.co_FechaFactura_vct;
                        Entity.co_plazo = info.co_plazo;
                        Entity.co_observacion = info.co_observacion;
                        Entity.co_subtotal_iva = info.co_subtotal_iva;
                        Entity.co_subtotal_siniva = info.co_subtotal_siniva;
                        Entity.co_baseImponible = info.co_baseImponible;
                        Entity.co_Por_iva = info.co_Por_iva;
                        Entity.co_valoriva = info.co_valoriva;
                        Entity.IdCod_ICE = info.IdCod_ICE;
                        Entity.co_Ice_base = info.co_Ice_base;
                        Entity.co_Ice_por = info.co_Ice_por;
                        Entity.co_Ice_valor = info.co_Ice_valor;
                        Entity.co_Serv_por = info.co_Serv_por;
                        Entity.co_Serv_valor = info.co_Serv_valor;
                        Entity.co_OtroValor_a_descontar = info.co_OtroValor_a_descontar;
                        Entity.co_OtroValor_a_Sumar = info.co_OtroValor_a_Sumar;
                        Entity.co_BaseSeguro = info.co_BaseSeguro;
                        Entity.co_total = info.co_total;
                        Entity.co_valorpagar = info.co_valorpagar;
                        Entity.co_vaCoa = "S";
                        Entity.IdIden_credito = info.IdIden_credito;
                        Entity.IdCod_101 = info.IdCod_101;
                        Entity.IdTipoFlujo = info.IdTipoFlujo;
                        Entity.IdOrden_giro_Tipo = info.IdOrden_giro_Tipo;
                        Entity.IdTipoServicio = info.IdTipoServicio;
                        Entity.IdCtaCble_Gasto = info.IdCtaCble_Gasto;
                        Entity.IdCtaCble_IVA = info.IdCtaCble_IVA;
                        Entity.co_retencionManual = info.co_retencionManual;
                        Entity.IdCbteCble_Anulacion = info.IdTipoCbte_Anulacion;
                        Entity.IdCentroCosto = info.IdCentroCosto;
                        Entity.IdSucursal = info.IdSucursal;
                        Entity.PagoLocExt = info.PagoLocExt;
                        Entity.PaisPago = info.PaisPago;
                        Entity.ConvenioTributacion = info.ConvenioTributacion_bool == true ? "SI" : "NO";
                        Entity.PagoSujetoRetencion = info.PagoSujetoRetencion_bool == true ? "SI" : "NO";
                        Entity.BseImpNoObjDeIva = info.BseImpNoObjDeIva;
                        Entity.fecha_autorizacion = info.fecha_autorizacion;
                        Entity.Num_Autorizacion = info.Num_Autorizacion;
                        Entity.Num_Autorizacion_Imprenta = info.Num_Autorizacion_Imprenta;
                        Entity.co_propina = info.co_propina;
                        Entity.co_IRBPNR = info.co_IRBPNR;
                        Entity.es_retencion_electronica = info.es_retencion_electronica;
                        Entity.cp_es_comprobante_electronico = info.cp_es_comprobante_electronico;
                        Entity.Tipodoc_a_Modificar = info.Tipodoc_a_Modificar;
                        Entity.estable_a_Modificar = info.estable_a_Modificar;
                        Entity.ptoEmi_a_Modificar = info.ptoEmi_a_Modificar;
                        Entity.num_docu_Modificar = info.num_docu_Modificar;
                        Entity.aut_doc_Modificar = info.aut_doc_Modificar;
                        Entity.IdTipoMovi = info.IdTipoMovi;


                    };
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception e)
            {

                throw;
            }
        }
        public bool anularDB(cp_orden_giro_Info info)
        {
            try
            {
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    cp_orden_giro Entity = Context.cp_orden_giro.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa
                    && q.IdTipoCbte_Ogiro == info.IdTipoCbte_Ogiro
                    && q.IdCbteCble_Ogiro == info.IdCbteCble_Ogiro);
                    if (Entity == null) return false;
                    {
                        Entity.IdTipoCbte_Anulacion = info.IdTipoCbte_Anulacion;
                        Entity.IdCbteCble_Anulacion = info.IdCbteCble_Anulacion;
                        Entity.IdUsuarioUltAnu = info.IdUsuarioUltAnu;
                        Entity.Fecha_UltAnu = info.Fecha_UltAnu;
                        Entity.Estado = "I";
                    };
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public List<cp_orden_giro_Info> get_lst(int IdEmpresa, int IdSucursal, DateTime FechaInicio, DateTime FechaFin)
        {
            try
            {
                List<cp_orden_giro_Info> Lista;
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                        Lista = (from q in Context.vwcp_orden_giro
                                 where q.IdEmpresa==IdEmpresa
                                 && q.IdSucursal==IdSucursal
                                 &&q.co_FechaFactura>=FechaInicio
                                  && q.co_FechaFactura <= FechaFin

                    select new cp_orden_giro_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdCbteCble_Ogiro = q.IdCbteCble_Ogiro,
                                     IdTipoCbte_Ogiro = q.IdTipoCbte_Ogiro,
                                     IdOrden_giro_Tipo = q.IdOrden_giro_Tipo,
                                     IdProveedor = q.IdProveedor,
                                     co_fechaOg = q.co_fechaOg,
                                     co_serie = q.co_serie,
                                     co_factura = q.co_factura,
                                     co_FechaFactura = q.co_FechaFactura,
                                     co_FechaContabilizacion = q.co_FechaContabilizacion,
                                     co_FechaFactura_vct = q.co_FechaFactura_vct,
                                     co_plazo = q.co_plazo,
                                     co_observacion = q.co_observacion,
                                     co_subtotal_iva = q.co_subtotal_iva,
                                     co_subtotal_siniva = q.co_subtotal_siniva,
                                     co_baseImponible = q.co_baseImponible,
                                     co_Por_iva = q.co_Por_iva,
                                     co_valoriva = q.co_valoriva,
                                     IdCod_ICE = q.IdCod_ICE,
                                     co_Ice_base = q.co_Ice_base,
                                     co_Ice_por = q.co_Ice_por,
                                     co_Ice_valor = q.co_Ice_valor,
                                     co_Serv_por = q.co_Serv_por,
                                     co_Serv_valor = q.co_Serv_valor,
                                     co_OtroValor_a_descontar = q.co_OtroValor_a_descontar,
                                     co_OtroValor_a_Sumar = q.co_OtroValor_a_Sumar,
                                     co_BaseSeguro = q.co_BaseSeguro,
                                     co_total = q.co_total,
                                     co_valorpagar = q.co_valorpagar,
                                     co_vaCoa = q.co_vaCoa,
                                     IdIden_credito = q.IdIden_credito,
                                     IdCod_101 = q.IdCod_101,
                                     IdTipoFlujo = q.IdTipoFlujo,
                                     IdTipoServicio = q.IdTipoServicio,
                                     IdCtaCble_Gasto = q.IdCtaCble_Gasto,
                                     IdCtaCble_IVA = q.IdCtaCble_IVA,
                                     co_retencionManual = q.co_retencionManual,
                                     IdCbteCble_Anulacion = q.IdTipoCbte_Anulacion,
                                     IdCentroCosto = q.IdCentroCosto,
                                     IdSucursal = q.IdSucursal,
                                     PagoLocExt = q.PagoLocExt,
                                     PaisPago = q.PaisPago,
                                     ConvenioTributacion = q.ConvenioTributacion,
                                     PagoSujetoRetencion = q.PagoSujetoRetencion,
                                     BseImpNoObjDeIva = q.BseImpNoObjDeIva,
                                     fecha_autorizacion = q.fecha_autorizacion,
                                     Num_Autorizacion = q.Num_Autorizacion,
                                     Num_Autorizacion_Imprenta = q.Num_Autorizacion_Imprenta,
                                     co_propina = q.co_propina,
                                     co_IRBPNR = q.co_IRBPNR,
                                     es_retencion_electronica = q.es_retencion_electronica,
                                     cp_es_comprobante_electronico = q.cp_es_comprobante_electronico,
                                     Tipodoc_a_Modificar = q.Tipodoc_a_Modificar,
                                     estable_a_Modificar = q.estable_a_Modificar,
                                     ptoEmi_a_Modificar = q.ptoEmi_a_Modificar,
                                     num_docu_Modificar = q.num_docu_Modificar,
                                     aut_doc_Modificar = q.aut_doc_Modificar,
                                     IdTipoMovi = q.IdTipoMovi,
                                     Estado=q.Estado,
                                     info_proveedor= new cp_proveedor_Info
                                     {
                                         info_persona=new Info.General.tb_persona_Info
                                         {
                                             pe_apellido=q.pe_apellido,
                                             pe_nombre=q.pe_nombre,
                                             pe_nombreCompleto=q.pe_nombreCompleto,
                                             pe_cedulaRuc=q.pe_cedulaRuc
                                         }
                                     }


                                     
                                     
                                 }).ToList();
                  
                }
                return Lista;

            }
            catch (Exception )
            {
               
                throw ;
            }
        }
        public List<cp_orden_giro_Info> get_lst_sin_ret(int IdEmpresa, DateTime FechaInicio, DateTime FechaFin)
        {
            try
            {
                List<cp_orden_giro_Info> Lista;
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    Lista = (from q in Context.vwcp_orden_giro
                             where !(from o in Context.cp_retencion
                                     select o.IdCbteCble_Ogiro)
                                    .Contains(q.IdCbteCble_Ogiro)
                                    && q.IdEmpresa == IdEmpresa
                                    && q.Estado=="A"
                             select new cp_orden_giro_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdCbteCble_Ogiro = q.IdCbteCble_Ogiro,
                                 IdTipoCbte_Ogiro = q.IdTipoCbte_Ogiro,
                                 IdOrden_giro_Tipo = q.IdOrden_giro_Tipo,
                                 IdProveedor = q.IdProveedor,
                                 co_fechaOg = q.co_fechaOg,
                                 co_serie = q.co_serie,
                                 co_factura = q.co_factura,
                                 co_FechaFactura = q.co_FechaFactura,
                                 co_FechaContabilizacion = q.co_FechaContabilizacion,
                                 co_FechaFactura_vct = q.co_FechaFactura_vct,
                                 co_plazo = q.co_plazo,
                                 co_observacion = q.co_observacion,
                                 co_subtotal_iva = q.co_subtotal_iva,
                                 co_subtotal_siniva = q.co_subtotal_siniva,
                                 co_baseImponible = q.co_baseImponible,
                                 co_Por_iva = q.co_Por_iva,
                                 co_valoriva = q.co_valoriva,
                                 IdCod_ICE = q.IdCod_ICE,
                                 co_Ice_base = q.co_Ice_base,
                                 co_Ice_por = q.co_Ice_por,
                                 co_Ice_valor = q.co_Ice_valor,
                                 co_Serv_por = q.co_Serv_por,
                                 co_Serv_valor = q.co_Serv_valor,
                                 co_OtroValor_a_descontar = q.co_OtroValor_a_descontar,
                                 co_OtroValor_a_Sumar = q.co_OtroValor_a_Sumar,
                                 co_BaseSeguro = q.co_BaseSeguro,
                                 co_total = q.co_total,
                                 co_valorpagar = q.co_valorpagar,
                                 co_vaCoa = q.co_vaCoa,
                                 IdIden_credito = q.IdIden_credito,
                                 IdCod_101 = q.IdCod_101,
                                 IdTipoFlujo = q.IdTipoFlujo,
                                 IdTipoServicio = q.IdTipoServicio,
                                 IdCtaCble_Gasto = q.IdCtaCble_Gasto,
                                 IdCtaCble_IVA = q.IdCtaCble_IVA,
                                 co_retencionManual = q.co_retencionManual,
                                 IdCbteCble_Anulacion = q.IdTipoCbte_Anulacion,
                                 IdCentroCosto = q.IdCentroCosto,
                                 IdSucursal = q.IdSucursal,
                                 PagoLocExt = q.PagoLocExt,
                                 PaisPago = q.PaisPago,
                                 ConvenioTributacion = q.ConvenioTributacion,
                                 PagoSujetoRetencion = q.PagoSujetoRetencion,
                                 BseImpNoObjDeIva = q.BseImpNoObjDeIva,
                                 fecha_autorizacion = q.fecha_autorizacion,
                                 Num_Autorizacion = q.Num_Autorizacion,
                                 Num_Autorizacion_Imprenta = q.Num_Autorizacion_Imprenta,
                                 co_propina = q.co_propina,
                                 co_IRBPNR = q.co_IRBPNR,
                                 es_retencion_electronica = q.es_retencion_electronica,
                                 cp_es_comprobante_electronico = q.cp_es_comprobante_electronico,
                                 Tipodoc_a_Modificar = q.Tipodoc_a_Modificar,
                                 estable_a_Modificar = q.estable_a_Modificar,
                                 ptoEmi_a_Modificar = q.ptoEmi_a_Modificar,
                                 num_docu_Modificar = q.num_docu_Modificar,
                                 aut_doc_Modificar = q.aut_doc_Modificar,
                                 IdTipoMovi = q.IdTipoMovi,
                                 Estado = q.Estado,
                                 info_proveedor = new cp_proveedor_Info
                                 {
                                     info_persona = new Info.General.tb_persona_Info
                                     {
                                         pe_apellido = q.pe_apellido,
                                         pe_nombre = q.pe_nombre,
                                         pe_nombreCompleto = q.pe_nombreCompleto,
                                         pe_cedulaRuc = q.pe_cedulaRuc
                                     }
                                 }




                             }).ToList();

                }
                return Lista;

            }
            catch (Exception)
            {

                throw;
            }
        }
        public List<cp_orden_giro_Info> get_lst_orden_giro_x_pagar(int IdEmpresa)
        {
            try
            {
                List<cp_orden_giro_Info> Lista=null;
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {

                    Lista = (from q in Context.vwcp_orden_giro_x_pagar
                             where q.IdEmpresa == IdEmpresa
                             & q.Saldo_OG > 0
                             select new cp_orden_giro_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdCbteCble_Ogiro = q.IdCbteCble_Ogiro,
                                 IdTipoCbte_Ogiro = q.IdTipoCbte_Ogiro,
                                 IdOrden_giro_Tipo = q.IdOrden_giro_Tipo,
                                 IdProveedor = q.IdProveedor,
                                 co_fechaOg = q.co_fechaOg,
                                 co_serie = q.co_serie,
                                 co_factura = q.cod_Documento + "-" + q.co_serie + "-" + q.co_factura,
                                 co_FechaFactura = q.co_FechaFactura,
                                 co_observacion = q.co_observacion,
                                 co_subtotal_iva = q.co_subtotal_iva,
                                 co_subtotal_siniva = q.co_subtotal_siniva,
                                 co_baseImponible = q.co_baseImponible,
                                 co_Por_iva = q.co_Por_iva,
                                 co_valoriva = q.co_valoriva,
                                 co_total = q.co_total,
                                 co_valorpagar = q.co_valorpagar,
                                 Total_Pagado = q.Total_Pagado,
                                 Saldo_OG = q.Saldo_OG,
                                 Fecha_Transac=q.co_FechaFactura_vct,
                                 info_proveedor = new cp_proveedor_Info
                                 {
                                     IdPersona=q.IdPersona,
                                     info_persona = new Info.General.tb_persona_Info
                                     {
                                         pe_razonSocial = q.nom_proveedor,
                                         IdPersona=q.IdPersona,
                                     }
                                 },

                             }).ToList();
                        }
                Lista.ForEach(item =>
                {

                    item.co_FechaFactura_vct = item.Fecha_Transac == null ? DateTime.Now.Date : Convert.ToDateTime(item.Fecha_Transac);
                    TimeSpan ts = Convert.ToDateTime(item.Fecha_Transac == null ? DateTime.Now.Date : Convert.ToDateTime(item.Fecha_Transac)) - Convert.ToDateTime(DateTime.Now);
                    int dias = ts.Days;
                    item.Dias_Vencidos = dias;
                    if (dias < 0) //Por vencer
                    {
                        item.Tipo_Vcto = "VENCIDO";
                    }
                    if (dias == 0) //normal
                    {
                        item.Tipo_Vcto = "VENCE_HOY";
                    }
                    if (dias > 0) // vencido
                    {
                        item.Tipo_Vcto = "X_VENCER";
                    }
                });
                return Lista;

            }
            catch (Exception)
            {

                throw;
            }
        }
        public cp_orden_giro_Info get_info(int IdEmpresa, int IdTipoCbte_Ogiro,decimal IdCbteCble_Ogiro)
        {
            try
            {
                cp_orden_giro_Info info = new cp_orden_giro_Info();
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    cp_orden_giro Entity = Context.cp_orden_giro.FirstOrDefault(q => q.IdEmpresa == IdEmpresa
                    && q.IdTipoCbte_Ogiro==IdTipoCbte_Ogiro
                    &&q.IdCbteCble_Ogiro==IdCbteCble_Ogiro);
                    if (Entity == null) return null;
                    info = new cp_orden_giro_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdCbteCble_Ogiro = Entity.IdCbteCble_Ogiro,
                        IdTipoCbte_Ogiro = Entity.IdTipoCbte_Ogiro,
                        IdOrden_giro_Tipo = Entity.IdOrden_giro_Tipo,
                        IdProveedor = Entity.IdProveedor,
                        co_fechaOg = Entity.co_fechaOg,
                        co_serie = Entity.co_serie,
                        co_factura = Entity.co_factura,
                        co_FechaFactura = Entity.co_FechaFactura,
                        co_FechaContabilizacion = Entity.co_FechaContabilizacion,
                        co_FechaFactura_vct = Entity.co_FechaFactura_vct,
                        co_plazo = Entity.co_plazo,
                        co_observacion = Entity.co_observacion,
                        co_subtotal_iva = Entity.co_subtotal_iva,
                        co_subtotal_siniva = Entity.co_subtotal_siniva,
                        co_baseImponible = Entity.co_baseImponible,
                        co_Por_iva = Entity.co_Por_iva,
                        co_valoriva = Entity.co_valoriva,
                        IdCod_ICE = Entity.IdCod_ICE,
                        co_Ice_base = Entity.co_Ice_base,
                        co_Ice_por = Entity.co_Ice_por,
                        co_Ice_valor = Entity.co_Ice_valor,
                        co_Serv_por = Entity.co_Serv_por,
                        co_Serv_valor = Entity.co_Serv_valor,
                        co_OtroValor_a_descontar = Entity.co_OtroValor_a_descontar,
                        co_OtroValor_a_Sumar = Entity.co_OtroValor_a_Sumar,
                        co_BaseSeguro = Entity.co_BaseSeguro,
                        co_total = Entity.co_total,
                        co_valorpagar = Entity.co_valorpagar,
                        co_vaCoa = Entity.co_vaCoa,
                        IdIden_credito = Entity.IdIden_credito,
                        IdCod_101 = Entity.IdCod_101,
                        IdTipoFlujo = Entity.IdTipoFlujo,
                        IdTipoServicio = Entity.IdTipoServicio,
                        IdCtaCble_Gasto = Entity.IdCtaCble_Gasto,
                        IdCtaCble_IVA = Entity.IdCtaCble_IVA,
                        co_retencionManual = Entity.co_retencionManual,
                        IdCbteCble_Anulacion = Entity.IdTipoCbte_Anulacion,
                        IdCentroCosto = Entity.IdCentroCosto,
                        IdSucursal = Entity.IdSucursal,
                        PagoLocExt = Entity.PagoLocExt,
                        PaisPago = Entity.PaisPago,
                        ConvenioTributacion_bool = Entity.ConvenioTributacion == "SI" ? true : false,
                        PagoSujetoRetencion_bool = Entity.PagoSujetoRetencion == "SI" ? true : false,
                        BseImpNoObjDeIva = Entity.BseImpNoObjDeIva,
                        fecha_autorizacion = Entity.fecha_autorizacion,
                        Num_Autorizacion = Entity.Num_Autorizacion,
                        Num_Autorizacion_Imprenta = Entity.Num_Autorizacion_Imprenta,
                        co_propina = Entity.co_propina,
                        co_IRBPNR = Entity.co_IRBPNR,
                        es_retencion_electronica = Entity.es_retencion_electronica,
                        cp_es_comprobante_electronico = Entity.cp_es_comprobante_electronico,
                        Tipodoc_a_Modificar = Entity.Tipodoc_a_Modificar,
                        estable_a_Modificar = Entity.estable_a_Modificar,
                        ptoEmi_a_Modificar = Entity.ptoEmi_a_Modificar,
                        num_docu_Modificar = Entity.num_docu_Modificar,
                        aut_doc_Modificar = Entity.aut_doc_Modificar,
                        IdTipoMovi = Entity.IdTipoMovi,
                        Estado = Entity.Estado,
                        

                       
                    };
                }
                return info;
            }
            catch (Exception)
            {
                throw;
            }
        }
        public cp_orden_giro_Info get_info_retencion(int IdEmpresa, int IdTipoCbte_Ogiro, decimal IdCbteCble_Ogiro)
        {
            try
            {
                cp_orden_giro_Info info = new cp_orden_giro_Info();
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    vwcp_orden_giro Entity = Context.vwcp_orden_giro.FirstOrDefault(q => q.IdEmpresa == IdEmpresa
                    && q.IdTipoCbte_Ogiro == IdTipoCbte_Ogiro
                    && q.IdCbteCble_Ogiro == IdCbteCble_Ogiro);
                    if (Entity == null) return null;
                    info = new cp_orden_giro_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdCbteCble_Ogiro = Entity.IdCbteCble_Ogiro,
                        IdTipoCbte_Ogiro = Entity.IdTipoCbte_Ogiro,
                        IdOrden_giro_Tipo = Entity.IdOrden_giro_Tipo,
                        IdProveedor = Entity.IdProveedor,
                        co_fechaOg = Entity.co_fechaOg,
                        co_serie = Entity.co_serie,
                        co_factura = Entity.co_factura,
                        co_FechaFactura = Entity.co_FechaFactura,
                        co_FechaContabilizacion = Entity.co_FechaContabilizacion,
                        co_FechaFactura_vct = Entity.co_FechaFactura_vct,
                        co_plazo = Entity.co_plazo,
                        co_observacion = Entity.co_observacion,
                        co_subtotal_iva = Entity.co_subtotal_iva,
                        co_subtotal_siniva = Entity.co_subtotal_siniva,
                        co_baseImponible = Entity.co_baseImponible,
                        co_Por_iva = Entity.co_Por_iva,
                        co_valoriva = Entity.co_valoriva,
                        IdCod_ICE = Entity.IdCod_ICE,
                        co_Ice_base = Entity.co_Ice_base,
                        co_Ice_por = Entity.co_Ice_por,
                        co_Ice_valor = Entity.co_Ice_valor,
                        co_Serv_por = Entity.co_Serv_por,
                        co_Serv_valor = Entity.co_Serv_valor,
                        co_OtroValor_a_descontar = Entity.co_OtroValor_a_descontar,
                        co_OtroValor_a_Sumar = Entity.co_OtroValor_a_Sumar,
                        co_BaseSeguro = Entity.co_BaseSeguro,
                        co_total = Entity.co_total,
                        co_valorpagar = Entity.co_valorpagar,
                        co_vaCoa = Entity.co_vaCoa,
                        IdIden_credito = Entity.IdIden_credito,
                        IdCod_101 = Entity.IdCod_101,
                        IdTipoFlujo = Entity.IdTipoFlujo,
                        IdTipoServicio = Entity.IdTipoServicio,
                        IdCtaCble_Gasto = Entity.IdCtaCble_Gasto,
                        IdCtaCble_IVA = Entity.IdCtaCble_IVA,
                        co_retencionManual = Entity.co_retencionManual,
                        IdCbteCble_Anulacion = Entity.IdTipoCbte_Anulacion,
                        IdCentroCosto = Entity.IdCentroCosto,
                        IdSucursal = Entity.IdSucursal,
                        PagoLocExt = Entity.PagoLocExt,
                        PaisPago = Entity.PaisPago,
                        ConvenioTributacion_bool = Entity.ConvenioTributacion == "SI" ? true : false,
                        PagoSujetoRetencion_bool = Entity.PagoSujetoRetencion == "SI" ? true : false,
                        BseImpNoObjDeIva = Entity.BseImpNoObjDeIva,
                        fecha_autorizacion = Entity.fecha_autorizacion,
                        Num_Autorizacion = Entity.Num_Autorizacion,
                        Num_Autorizacion_Imprenta = Entity.Num_Autorizacion_Imprenta,
                        co_propina = Entity.co_propina,
                        co_IRBPNR = Entity.co_IRBPNR,
                        es_retencion_electronica = Entity.es_retencion_electronica,
                        cp_es_comprobante_electronico = Entity.cp_es_comprobante_electronico,
                        Tipodoc_a_Modificar = Entity.Tipodoc_a_Modificar,
                        estable_a_Modificar = Entity.estable_a_Modificar,
                        ptoEmi_a_Modificar = Entity.ptoEmi_a_Modificar,
                        num_docu_Modificar = Entity.num_docu_Modificar,
                        aut_doc_Modificar = Entity.aut_doc_Modificar,
                        IdTipoMovi = Entity.IdTipoMovi,
                        Estado = Entity.Estado,
                        Descripcion=Entity.Descripcion,
                        info_proveedor = new cp_proveedor_Info
                        {
                            info_persona = new Info.General.tb_persona_Info
                            {
                                pe_apellido = Entity.pe_apellido,
                                pe_nombre = Entity.pe_nombre,
                                pe_nombreCompleto = Entity.pe_nombreCompleto,
                                pe_cedulaRuc = Entity.pe_cedulaRuc,
                                pe_razonSocial=Entity.pe_razonSocial
                            }
                        }
                    };
                }
                return info;
            }
            catch (Exception)
            {
                throw;
            }
        }
        public bool si_existe(cp_orden_giro_Info info)
        {
            try
            {                
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    var lst = from q in Context.cp_orden_giro
                              where 
                               q.IdEmpresa==info.IdEmpresa
                             && q.co_serie==info.co_serie
                              && q.co_factura==info.co_factura
                              && q.IdProveedor==info.IdProveedor
                              && q.Estado == "A"
                              select q;
                    if (lst.Count() > 0)
                        return true;
                    else
                        return false;

                    
                }
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
    }

