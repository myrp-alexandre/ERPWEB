using Core.Erp.Data.Contabilidad;
using Core.Erp.Info.Banco;
using Core.Erp.Info.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Banco
{
    public class ba_Cbte_Ban_Data
    {
        ct_cbtecble_Data odata_ct = new ct_cbtecble_Data();
        public List<ba_Cbte_Ban_Info> get_list(int IdEmpresa, DateTime Fecha_ini, DateTime Fecha_fin, string CodCbte)
        {
            try
            {
                List<ba_Cbte_Ban_Info> Lista;

                using (Entities_banco Context = new Entities_banco())
                {
                    Lista = (from q in Context.ba_Cbte_Ban
                             where q.IdEmpresa == IdEmpresa
                             && Fecha_ini <= q.cb_Fecha
                             && q.cb_Fecha <= Fecha_fin
                             select new ba_Cbte_Ban_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdTipocbte = q.IdTipocbte,
                                 IdCbteCble = q.IdCbteCble,
                                 cb_Fecha = q.cb_Fecha,
                                 cb_Observacion = q.cb_Observacion,
                                 Estado = q.Estado
                             }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public ba_Cbte_Ban_Info get_info(int IdEmpresa, int IdTipoCbte, decimal IdCbteCble)
        {
            try
            {
                ba_Cbte_Ban_Info info;

                using (Entities_banco Context = new Entities_banco())
                {
                    ba_Cbte_Ban Entity = Context.ba_Cbte_Ban.Where(q => q.IdEmpresa == IdEmpresa && q.IdTipocbte == IdTipoCbte && q.IdCbteCble == IdCbteCble).FirstOrDefault();
                    if (Entity == null) return null;
                    info = new ba_Cbte_Ban_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdCbteCble = Entity.IdCbteCble,
                        IdTipocbte = Entity.IdTipocbte,
                        Cod_Cbtecble = Entity.Cod_Cbtecble,
                        IdPeriodo = Entity.IdPeriodo,
                        IdBanco = Entity.IdBanco,
                        cb_Fecha = Entity.cb_Fecha,
                        cb_Observacion = Entity.cb_Observacion,
                        cb_Valor = Entity.cb_Valor,
                        cb_Cheque = Entity.cb_Cheque,
                        Estado = Entity.Estado,
                        IdPersona_Girado_a = Entity.IdPersona_Girado_a,
                        cb_giradoA = Entity.cb_giradoA,
                        cb_ciudadChq = Entity.cb_ciudadChq,
                        IdTipoFlujo = Entity.IdTipoFlujo,
                        IdTipoNota = Entity.IdTipoNota,
                        ValorEnLetras = Entity.ValorEnLetras,
                        IdSucursal = Entity.IdSucursal,
                        IdEstado_Cbte_Ban_cat = Entity.IdEstado_Cbte_Ban_cat,
                        IdEstado_Preaviso_ch_cat = Entity.IdEstado_Preaviso_ch_cat,
                        IdEstado_cheque_cat = Entity.IdEstado_cheque_cat,
                        IdPersona = Entity.IdPersona,
                        IdEntidad = Entity.IdEntidad,
                        IdTipo_Persona = Entity.IdTipo_Persona,
                    };
                }

                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(ba_Cbte_Ban_Info info, cl_enumeradores.eTipoCbteBancario TipoCbteBanco)
        {
            Entities_banco Context_b = new Entities_banco();
            Entities_contabilidad Context_ct = new Entities_contabilidad();
            Entities_cuentas_por_pagar Context_cxp = new Entities_cuentas_por_pagar();
            try
            {
                #region Variables
                string TipoCbteBancoS = TipoCbteBanco.ToString();
                int secuencia = 1;
                #endregion

                #region Obtengo datos para el diario
                var e_TipoCbteBan = Context_b.ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo.Where(q => q.CodTipoCbteBan == TipoCbteBancoS && q.IdEmpresa == info.IdEmpresa).FirstOrDefault();
                if (e_TipoCbteBan == null)
                    return false;
                info.IdTipocbte = e_TipoCbteBan.IdTipoCbteCble;
                info.IdCbteCble = odata_ct.get_id(info.IdEmpresa, info.IdTipocbte);
                #endregion

                #region Diario
                Context_ct.ct_cbtecble.Add(new ct_cbtecble
                {
                    IdEmpresa = info.IdEmpresa,
                    IdTipoCbte = info.IdTipocbte,
                    IdCbteCble = info.IdCbteCble,
                    cb_Fecha = info.cb_Fecha,
                    cb_Observacion = info.cb_Observacion,
                    IdPeriodo = info.IdPeriodo,
                    cb_Anio = info.cb_Fecha.Year,
                    cb_mes = info.cb_Fecha.Month,
                    cb_FechaTransac = DateTime.Now,
                    cb_Estado = "A",
                    cb_Valor = info.cb_Valor,
                    IdUsuario = info.IdUsuario
                });

                foreach (var item in info.lst_det_ct)
                {
                    Context_ct.ct_cbtecble_det.Add(new ct_cbtecble_det
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdTipoCbte = info.IdTipocbte,
                        IdCbteCble = info.IdCbteCble,
                        secuencia = secuencia++,
                        IdCtaCble = item.IdCtaCble,
                        dc_Valor = Math.Round(item.dc_Valor, 2, MidpointRounding.AwayFromZero),
                    });
                }
                #endregion

                #region Cbte bancario
                Context_b.ba_Cbte_Ban.Add(new ba_Cbte_Ban
                {
                    IdEmpresa = info.IdEmpresa,
                    IdCbteCble = info.IdCbteCble,
                    IdTipocbte = info.IdTipocbte,
                    Cod_Cbtecble = info.Cod_Cbtecble,
                    IdPeriodo = info.IdPeriodo,
                    IdBanco = info.IdBanco,
                    cb_Fecha = info.cb_Fecha,
                    cb_Observacion = info.cb_Observacion,
                    cb_Valor = info.cb_Valor,
                    cb_Cheque = info.cb_Cheque,
                    Estado = "A",
                    IdPersona_Girado_a = info.IdPersona_Girado_a,
                    cb_giradoA = info.cb_giradoA,
                    cb_ciudadChq = info.cb_ciudadChq,
                    IdTipoFlujo = info.IdTipoFlujo,
                    IdTipoNota = info.IdTipoNota,
                    ValorEnLetras = info.ValorEnLetras,
                    IdSucursal = info.IdSucursal,
                    IdEstado_Cbte_Ban_cat = info.IdEstado_Cbte_Ban_cat,
                    IdEstado_Preaviso_ch_cat = info.IdEstado_Preaviso_ch_cat,
                    IdEstado_cheque_cat = info.IdEstado_cheque_cat,
                    IdPersona = info.IdPersona,
                    IdEntidad = info.IdEntidad,
                    IdTipo_Persona = info.IdTipo_Persona,
                });
                #endregion

                switch (TipoCbteBanco)
                {
                    case cl_enumeradores.eTipoCbteBancario.CHEQ:
                        foreach (var item in info.lst_det_canc_op)
                        {
                            
                        }
                        break;
                    case cl_enumeradores.eTipoCbteBancario.DEPO:
                        break;
                    case cl_enumeradores.eTipoCbteBancario.NCBA:
                        break;
                    case cl_enumeradores.eTipoCbteBancario.NDBA:
                        break;
                }

                Context_ct.SaveChanges();
                Context_b.SaveChanges();
                Context_cxp.SaveChanges();

                Context_ct.Dispose();
                Context_b.Dispose();
                Context_cxp.Dispose();
                return true;
            }
            catch (Exception)
            {
                Context_ct.Dispose();
                Context_b.Dispose();
                Context_cxp.Dispose();
                throw;
            }
        }
    }
}
