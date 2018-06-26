using Core.Erp.Data.Contabilidad;
using Core.Erp.Data.CuentasPorPagar;
using Core.Erp.Info.Caja;
using Core.Erp.Info.Helps;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Core.Erp.Data.Caja
{
    public class cp_conciliacion_Caja_Data
    {
        cp_orden_pago_Data data_op = new cp_orden_pago_Data();
        ct_cbtecble_Data data_ct = new ct_cbtecble_Data();
        cp_orden_pago_cancelaciones_Data data_can = new cp_orden_pago_cancelaciones_Data();
        public string IdCtaCble_cxp { get; private set; }
        public string Observacion { get; private set; }

        public List<cp_conciliacion_Caja_Info> get_list(int IdEmpresa, DateTime Fecha_ini, DateTime Fecha_fin)
        {
            try
            {
                List<cp_conciliacion_Caja_Info> Lista;

                using (Entities_caja Context = new Entities_caja())
                {
                    Lista = (from q in Context.cp_conciliacion_Caja
                             where q.IdEmpresa == IdEmpresa
                             && Fecha_fin <= q.Fecha && q.Fecha <= Fecha_fin
                             select new cp_conciliacion_Caja_Info
                             {
                                 IdConciliacion_Caja = q.IdConciliacion_Caja,
                                 Observacion = q.Observacion,
                                 Fecha = q.Fecha,
                                 IdPeriodo = q.IdPeriodo,
                                 Ingresos = q.Ingresos,
                                 Dif_x_pagar_o_cobrar = q.Dif_x_pagar_o_cobrar,
                                 Total_fact_vale = q.Total_fact_vale
                             }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public cp_conciliacion_Caja_Info get_info(int IdEmpresa, decimal IdConciliacion_caja)
        {
            try
            {
                cp_conciliacion_Caja_Info info;
                using (Entities_caja Context = new Entities_caja())
                {
                    cp_conciliacion_Caja Entity = Context.cp_conciliacion_Caja.Where(q => q.IdEmpresa == IdEmpresa && q.IdConciliacion_Caja == IdConciliacion_caja).FirstOrDefault();
                    if (Entity == null) return null;
                    info = new cp_conciliacion_Caja_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdConciliacion_Caja = Entity.IdConciliacion_Caja,
                        IdPeriodo = Entity.IdPeriodo,
                        Fecha_ini = Entity.Fecha_ini,
                        Fecha_fin = Entity.Fecha_fin,
                        Fecha = Entity.Fecha,
                        IdCaja = Entity.IdCaja,
                        IdEstadoCierre = Entity.IdEstadoCierre,
                        Observacion = Entity.Observacion,
                        IdEmpresa_op = Entity.IdEmpresa_op,
                        IdOrdenPago_op = Entity.IdOrdenPago_op,
                        Saldo_cont_al_periodo = Entity.Saldo_cont_al_periodo,
                        Ingresos = Entity.Ingresos,
                        Total_Ing = Entity.Total_Ing,
                        Total_fact_vale = Entity.Total_fact_vale,
                        Total_fondo = Entity.Total_fondo,
                        Dif_x_pagar_o_cobrar = Entity.Dif_x_pagar_o_cobrar,
                        IdTipoFlujo = Entity.IdTipoFlujo,
                        IdEmpresa_mov_caj = Entity.IdEmpresa_mov_caj,
                        IdTipoCbte_mov_caj = Entity.IdTipoCbte_mov_caj,
                        IdCbteCble_mov_caj = Entity.IdCbteCble_mov_caj
                    };
                }
                return info;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public decimal get_id(int IdEmpresa)
        {
            try
            {
                decimal ID = 1;

                using (Entities_caja Context = new Entities_caja())
                {
                    var lst = from q in Context.cp_conciliacion_Caja
                              where q.IdEmpresa == IdEmpresa
                              select q;

                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdConciliacion_Caja) + 1;
                }

                return ID;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool guardarDB(cp_conciliacion_Caja_Info info)
        {
            Entities_caja Context = new Entities_caja();
            Entities_cuentas_por_pagar Context_cxp = new Entities_cuentas_por_pagar();
            Entities_contabilidad Context_ct = new Entities_contabilidad();
            try
            {
                #region Cabecera
                cp_conciliacion_Caja Entity_c = new cp_conciliacion_Caja
                {
                    IdEmpresa = info.IdEmpresa,
                    IdConciliacion_Caja = info.IdConciliacion_Caja = get_id(info.IdEmpresa),
                    IdCaja = info.IdCaja,
                    IdCtaCble = info.IdCtaCble,
                    Observacion = info.Observacion,
                    Fecha = info.Fecha.Date,
                    Fecha_ini = info.Fecha_ini,
                    Fecha_fin = info.Fecha_fin,
                    IdEstadoCierre = info.IdEstadoCierre,
                    IdPeriodo = info.IdPeriodo,

                    Ingresos = info.Ingresos,
                    Total_fondo = info.Total_fondo,
                    Saldo_cont_al_periodo = info.Saldo_cont_al_periodo,
                    Total_fact_vale = info.Total_fact_vale,
                    Dif_x_pagar_o_cobrar = info.Dif_x_pagar_o_cobrar,
                    Total_Ing = info.Total_Ing,

                    IdEmpresa_op = info.IdEmpresa_op,
                    IdOrdenPago_op = info.IdOrdenPago_op,
                };
                Context.cp_conciliacion_Caja.Add(Entity_c);
                #endregion

                #region Facturas
                int Secuencia = 1;
                decimal IdOrdenPago = 1;
                decimal IdCbteCble_NC = 1;
                decimal IdCbteCble_EG = 1;
                decimal IdCancelacion = 1;
                cp_parametros Entity_p = Context_cxp.cp_parametros.Where(q => q.IdEmpresa == info.IdEmpresa).FirstOrDefault();
                caj_parametro Entity_pc = Context.caj_parametro.Where(q => q.IdEmpresa == info.IdEmpresa).FirstOrDefault();
                if (Entity_p == null || Entity_pc == null)
                    return false;
                int IdTipoCbte_NC = Convert.ToInt32(Entity_p.pa_TipoCbte_NC);
                int IdTipoCbte_EG = Entity_pc.IdTipoCbteCble_MoviCaja_Egr;

                if (info.IdEstadoCierre == cl_enumeradores.eEstadoCierreCaja.EST_CIE_CER.ToString())
                {
                    IdOrdenPago = data_op.get_id(Entity_c.IdEmpresa);
                    IdCbteCble_NC = data_ct.get_id(Entity_c.IdEmpresa, IdTipoCbte_NC);
                    IdCancelacion = data_can.get_id(Entity_c.IdEmpresa);
                    IdCbteCble_EG = data_ct.get_id(Entity_c.IdEmpresa, IdTipoCbte_EG);
                }
                foreach (var item in info.lst_det_fact)
                {
                    if (info.IdEstadoCierre == cl_enumeradores.eEstadoCierreCaja.EST_CIE_CER.ToString())
                    {
                        if (item.IdOrdenPago_OP == null)
                        {
                            #region Orden de pago
                            cp_orden_pago op = new cp_orden_pago
                            {
                                IdEmpresa  = Entity_c.IdEmpresa,
                                IdOrdenPago = IdOrdenPago++,
                                Observacion = "Caja #" + Entity_c.IdConciliacion_Caja,
                                IdTipo_op = cl_enumeradores.eTipoOrdenPago.FACT_PROVEE.ToString(),
                                IdTipo_Persona = cl_enumeradores.eTipoPersona.PROVEE.ToString(),
                                IdPersona = item.IdPersona,
                                IdEntidad = item.idEntidad,
                                Fecha = Convert.ToDateTime(Entity_c.Fecha_fin).Date,
                                Fecha_Pago = Convert.ToDateTime(Entity_c.Fecha_fin).Date,
                                IdEstadoAprobacion = cl_enumeradores.eEstadoAprobacionOrdenPago.APRO.ToString(),
                                IdFormaPago = cl_enumeradores.eFormaPagoOrdenPago.EFEC.ToString(),
                                Estado = "A"
                            };
                            item.IdEmpresa_OP = op.IdEmpresa;
                            item.IdOrdenPago_OP = op.IdOrdenPago;
                            Context_cxp.cp_orden_pago.Add(op);

                            cp_orden_pago_det op_det = new cp_orden_pago_det
                            {
                                IdEmpresa = op.IdEmpresa,
                                IdOrdenPago = op.IdOrdenPago,
                                Secuencia = 1,

                                IdEmpresa_cxp = item.IdEmpresa_OGiro,
                                IdTipoCbte_cxp = item.IdTipoCbte_Ogiro,
                                IdCbteCble_cxp = item.IdCbteCble_Ogiro,

                                Valor_a_pagar = Convert.ToDouble(item.Valor_a_aplicar),
                                IdEstadoAprobacion = cl_enumeradores.eEstadoAprobacionOrdenPago.APRO.ToString(),
                                IdFormaPago = cl_enumeradores.eFormaPagoOrdenPago.EFEC.ToString(),
                                Fecha_Pago = op.Fecha_Pago
                            };
                            Context_cxp.cp_orden_pago_det.Add(op_det);
                            #endregion

                            #region Nota de crédito
                            ct_cbtecble diario = new ct_cbtecble
                            {
                                IdEmpresa = info.IdEmpresa,
                                IdTipoCbte = IdTipoCbte_NC,
                                IdCbteCble = IdCbteCble_NC,
                                cb_Fecha = op.Fecha_Pago,
                                cb_Observacion = op.Observacion,
                                IdPeriodo = Convert.ToInt32(op.Fecha_Pago.ToString("yyyyMM")),
                                cb_Anio = op.Fecha_Pago.Year,
                                cb_mes = op.Fecha_Pago.Month,
                                cb_FechaTransac = DateTime.Now,
                                cb_Estado = "A"
                            };
                            Context_ct.ct_cbtecble.Add(diario);

                            ct_cbtecble_det Debe = new ct_cbtecble_det
                            {
                                IdEmpresa = diario.IdEmpresa,
                                IdTipoCbte = diario.IdTipoCbte,
                                IdCbteCble = diario.IdCbteCble,
                                secuencia = 1,
                                IdCtaCble = IdCtaCble_cxp,
                                dc_Valor = Math.Round(Convert.ToDouble(item.Valor_a_aplicar),2,MidpointRounding.AwayFromZero),
                            };

                            ct_cbtecble_det Haber = new ct_cbtecble_det
                            {
                                IdEmpresa = diario.IdEmpresa,
                                IdTipoCbte = diario.IdTipoCbte,
                                IdCbteCble = diario.IdCbteCble,
                                secuencia = 1,
                                IdCtaCble = info.IdCtaCble,
                                dc_Valor = Math.Round(Convert.ToDouble(item.Valor_a_aplicar), 2, MidpointRounding.AwayFromZero)*-1,
                            };
                            Context_ct.ct_cbtecble_det.Add(Debe);
                            Context_ct.ct_cbtecble_det.Add(Haber);

                            cp_nota_DebCre Entity_nc = new cp_nota_DebCre
                            {
                                IdEmpresa = Entity_c.IdEmpresa,
                                IdTipoCbte_Nota = IdTipoCbte_NC,
                                IdCbteCble_Nota = IdCbteCble_NC++,
                                DebCre = "C",
                                IdTipoNota = cl_enumeradores.eTipoNotaCXP.T_TIP_NOTA_INT.ToString(),
                                IdProveedor = item.idEntidad,
                                IdSucursal = item.idSucursal,
                                cn_fecha = op.Fecha_Pago,
                                Fecha_contable = op.Fecha_Pago,
                                cn_Fecha_vcto = op.Fecha_Pago,
                                cn_observacion = op.Observacion,
                                cn_subtotal_iva = 0,
                                cn_subtotal_siniva = Convert.ToDouble(item.Valor_a_aplicar),
                                cn_Por_iva = item.por_iva,
                                cn_valoriva = 0,
                                cn_baseImponible = 0,
                                cn_Ice_valor = 0,
                                cn_Ice_base = 0,
                                cn_Ice_por = 0,
                                cn_Serv_por = 0,
                                cn_Serv_valor = 0,
                                cn_vaCoa = "N",
                                cn_BaseSeguro = 0,
                                cn_total = item.Valor_a_aplicar,
                                Estado = "A",
                                PagoLocExt = "LOC",
                                PagoSujetoRetencion = "NA"
                            };
                            Context_cxp.cp_nota_DebCre.Add(Entity_nc);
                            #endregion

                            #region Cancelación
                            cp_orden_pago_cancelaciones cancelacion = new cp_orden_pago_cancelaciones
                            {
                                IdEmpresa = op.IdEmpresa,
                                Idcancelacion = IdCancelacion++,
                                Secuencia = 1,
                                IdOrdenPago_op = op.IdOrdenPago,
                                Secuencia_op = 1,
                                IdEmpresa_cxp = item.IdEmpresa_OGiro,
                                IdTipoCbte_cxp = item.IdTipoCbte_Ogiro,
                                IdCbteCble_cxp = item.IdCbteCble_Ogiro,
                                IdEmpresa_pago = diario.IdEmpresa,
                                IdTipoCbte_pago = diario.IdTipoCbte,
                                IdCbteCble_pago = diario.IdCbteCble,
                                MontoAplicado = Debe.dc_Valor,
                                SaldoActual = 0,
                                SaldoAnterior = 0,
                                fechaTransaccion = DateTime.Now,
                                Observacion = op.Observacion
                            };
                            Context_cxp.cp_orden_pago_cancelaciones.Add(cancelacion);
                            #endregion
                        }
                    }

                    cp_conciliacion_Caja_det Entity_d = new cp_conciliacion_Caja_det
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdConciliacion_Caja = Entity_c.IdConciliacion_Caja,
                        Secuencia = Secuencia++,

                        IdEmpresa_OGiro = item.IdEmpresa_OGiro,
                        IdTipoCbte_Ogiro = item.IdTipoCbte_Ogiro,
                        IdCbteCble_Ogiro = item.IdCbteCble_Ogiro,
                        Tipo_documento = item.Tipo_documento,
                        Valor_a_aplicar = item.Valor_a_aplicar,

                        IdEmpresa_OP = item.IdEmpresa_OP,
                        IdOrdenPago_OP = item.IdOrdenPago_OP,
                    };
                    Context.cp_conciliacion_Caja_det.Add(Entity_d);
                }
                #endregion

                #region Vales
                Secuencia = 1;
                foreach (var item in info.lst_det_vale)
                {

                    if (item.IdCbteCble_movcaja == 0)
                    {
                        ct_cbtecble diario = new ct_cbtecble
                        {
                            IdEmpresa = item.IdEmpresa_movcaja = info.IdEmpresa,
                            IdTipoCbte = item.IdTipocbte_movcaja = IdTipoCbte_EG,
                            IdCbteCble = item.IdCbteCble_movcaja = IdCbteCble_EG,
                            cb_Fecha = item.fecha,
                            cb_Observacion = "Caja # "+info.IdConciliacion_Caja + Observacion,
                            IdPeriodo = Convert.ToInt32(item.fecha.ToString("yyyyMM")),
                            cb_Anio = item.fecha.Year,
                            cb_mes = item.fecha.Month,
                            cb_FechaTransac = DateTime.Now,
                            cb_Estado = "A"
                        };
                        Context_ct.ct_cbtecble.Add(diario);

                        ct_cbtecble_det Debe = new ct_cbtecble_det
                        {
                            IdEmpresa = diario.IdEmpresa,
                            IdTipoCbte = diario.IdTipoCbte,
                            IdCbteCble = diario.IdCbteCble,
                            secuencia = 1,
                            IdCtaCble = IdCtaCble_cxp,
                            dc_Valor = Math.Round(Convert.ToDouble(item.valor), 2, MidpointRounding.AwayFromZero),
                        };

                        ct_cbtecble_det Haber = new ct_cbtecble_det
                        {
                            IdEmpresa = diario.IdEmpresa,
                            IdTipoCbte = diario.IdTipoCbte,
                            IdCbteCble = diario.IdCbteCble,
                            secuencia = 1,
                            IdCtaCble = info.IdCtaCble,
                            dc_Valor = Math.Round(Convert.ToDouble(item.valor), 2, MidpointRounding.AwayFromZero) * -1,
                        };
                        Context_ct.ct_cbtecble_det.Add(Debe);
                        Context_ct.ct_cbtecble_det.Add(Haber);

                        caj_Caja_Movimiento Entity_caj = new caj_Caja_Movimiento
                        {
                            IdEmpresa = diario.IdEmpresa,
                            IdTipocbte = diario.IdTipoCbte,
                            IdCbteCble = diario.IdCbteCble,
                            CodMoviCaja = "Caja # "+info.IdConciliacion_Caja,
                            cm_Signo = "-",
                            cm_valor = item.valor,
                            IdTipoMovi = item.idTipoMovi,
                            cm_observacion = "Caja # "+info.IdConciliacion_Caja,
                            IdCaja = info.IdCaja,
                            IdPeriodo = Convert.ToInt32(item.fecha.ToString("yyyyMM")),
                            cm_fecha = item.fecha,
                            IdTipo_Persona = cl_enumeradores.eTipoPersona.PERSONA.ToString(),
                            IdEntidad = item.IdPersona,
                            IdPersona = item.IdPersona,
                            Estado = "A"
                        };
                        Context.caj_Caja_Movimiento.Add(Entity_caj);
                    }

                    cp_conciliacion_Caja_det_x_ValeCaja Entity_d = new cp_conciliacion_Caja_det_x_ValeCaja
                    {
                        IdEmpresa = item.IdEmpresa,
                        IdConciliacion_Caja = Entity_c.IdConciliacion_Caja,
                        Secuencia = item.Secuencia++,
                        IdEmpresa_movcaja = item.IdEmpresa_movcaja,
                        IdTipocbte_movcaja = item.IdTipocbte_movcaja,
                        IdCbteCble_movcaja = item.IdCbteCble_movcaja,
                        IdCtaCble = item.IdCtaCble
                    };
                    Context.cp_conciliacion_Caja_det_x_ValeCaja.Add(Entity_d);
                }
                #endregion

                #region Ingresos
                Secuencia = 1;
                foreach (var item in info.lst_det_ing)
                {
                    cp_conciliacion_Caja_det_Ing_Caja Entity_d = new cp_conciliacion_Caja_det_Ing_Caja
                    {
                        IdEmpresa = Entity_c.IdEmpresa,
                        IdConciliacion_Caja = Entity_c.IdConciliacion_Caja,
                        secuencia = Secuencia++,
                        IdEmpresa_movcaj = item.IdEmpresa_movcaj,
                        IdTipocbte_movcaj = item.IdTipocbte_movcaj,
                        IdCbteCble_movcaj = item.IdCbteCble_movcaj,
                        valor_aplicado = item.valor_aplicado,
                        valor_disponible = item.valor_disponible
                    };
                    Context.cp_conciliacion_Caja_det_Ing_Caja.Add(Entity_d);
                }
                #endregion

                Context_ct.Dispose();
                Context.Dispose();
                Context_cxp.Dispose();
                return true;                
            }
            catch (Exception)
            {
                Context_ct.Dispose();
                Context_cxp.Dispose();
                Context.Dispose();
                throw;
            }
        }

        public bool modificarDB(cp_conciliacion_Caja_Info info)
        {
            Entities_caja Context = new Entities_caja();
            try
            {
                cp_conciliacion_Caja Entity = Context.cp_conciliacion_Caja.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdConciliacion_Caja == info.IdConciliacion_Caja).FirstOrDefault();
                if (Entity == null) return false;


                Context.Dispose();
                return true;
            }
            catch (Exception)
            {
                Context.Dispose();
                throw;
            }
        }
    }
}
