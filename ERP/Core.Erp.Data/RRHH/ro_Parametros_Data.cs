using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
namespace Core.Erp.Data.RRHH
{
    public class ro_Parametros_Data
    {
        public List<ro_Parametros_Info> get_list(int IdEmpresa)
        {
            try
            {
                List<ro_Parametros_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    Lista = (from q in Context.ro_Parametros
                             where q.IdEmpresa == IdEmpresa
                             select new ro_Parametros_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdTipoCbte_AsientoSueldoXPagar = q.IdTipoCbte_AsientoSueldoXPagar,
                                 IdTipoCbte_AsientoProvision = q.IdTipoCbte_AsientoProvision,
                                 IdTipo_mov_Ingreso = q.IdTipo_mov_Ingreso,
                                 IdTipo_mov_Egreso = q.IdTipo_mov_Egreso,
                                 Dias_considerado_ultimo_pago_quincela_Liq = q.Dias_considerado_ultimo_pago_quincela_Liq,
                                 IdNomina_Tipo_Para_Desc_Automat = q.IdNomina_Tipo_Para_Desc_Automat,
                                 IdNominatipoLiq_Para_Desc_Automat = q.IdNominatipoLiq_Para_Desc_Automat,
                                 GeneraraOP_PagoTerceros = q.GeneraraOP_PagoTerceros,
                                 IdTipoOP_PagoTerceros = q.IdTipoOP_PagoTerceros,
                                 IdTipoFlujoOP_PagoTerceros = q.IdTipoFlujoOP_PagoTerceros,
                                 IdFormaOP_PagoTerceros = q.IdFormaOP_PagoTerceros,
                                 IdBancoOP_PagoTerceros = q.IdBancoOP_PagoTerceros,
                                 GeneraOP_PagoPrestamos = q.GeneraOP_PagoPrestamos,
                                 IdTipoOP_PagoPrestamos = q.IdTipoOP_PagoPrestamos,
                                 IdTipoFlujoOP_PagoPrestamos = q.IdTipoFlujoOP_PagoPrestamos,
                                 IdFormaOP_PagoPrestamos = q.IdFormaOP_PagoPrestamos,
                                 IdBancoOP_PagoPrestamos = q.IdBancoOP_PagoPrestamos,
                                 GeneraOP_LiquidacionVacaciones = q.GeneraOP_LiquidacionVacaciones,
                                 IdTipoOP_LiquidacionVacaciones = q.IdTipoOP_LiquidacionVacaciones,
                                 IdTipoFlujoOP_LiquidacionVacaciones = q.IdTipoFlujoOP_LiquidacionVacaciones,
                                 IdFormaOP_LiquidacionVacaciones = q.IdFormaOP_LiquidacionVacaciones,
                                 IdBancoOP_LiquidacionVacaciones = q.IdBancoOP_LiquidacionVacaciones,
                                 DescuentaIESS_LiquidacionVacaciones = q.DescuentaIESS_LiquidacionVacaciones,
                                 cta_contable_IESS_Vacaciones = q.cta_contable_IESS_Vacaciones,
                                 GeneraOP_ActaFiniquito = q.GeneraOP_ActaFiniquito,
                                 IdTipoOP_ActaFiniquito = q.IdTipoOP_ActaFiniquito,
                                 IdTipoFlujoOP_ActaFiniquito = q.IdTipoFlujoOP_ActaFiniquito,
                                 IdFormaPagoOP_ActaFiniquito = q.IdFormaPagoOP_ActaFiniquito,
                                 Descripcion="Parametrización contable"

                             }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public ro_Parametros_Info get_info(int IdEmpresa)
        {
            try
            {
                ro_Parametros_Info info = new ro_Parametros_Info();

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_Parametros q = Context.ro_Parametros.FirstOrDefault(v => v.IdEmpresa == IdEmpresa);
                    if (q == null) return null;

                    info = new ro_Parametros_Info
                    {
                        IdEmpresa = q.IdEmpresa,
                        IdTipoCbte_AsientoSueldoXPagar = q.IdTipoCbte_AsientoSueldoXPagar,
                        IdTipoCbte_AsientoProvision = q.IdTipoCbte_AsientoProvision,
                        IdTipo_mov_Ingreso = q.IdTipo_mov_Ingreso,
                        IdTipo_mov_Egreso = q.IdTipo_mov_Egreso,
                        Dias_considerado_ultimo_pago_quincela_Liq = q.Dias_considerado_ultimo_pago_quincela_Liq,
                        IdNomina_Tipo_Para_Desc_Automat = q.IdNomina_Tipo_Para_Desc_Automat,
                        IdNominatipoLiq_Para_Desc_Automat = q.IdNominatipoLiq_Para_Desc_Automat,
                        GeneraraOP_PagoTerceros = q.GeneraraOP_PagoTerceros,
                        IdTipoOP_PagoTerceros = q.IdTipoOP_PagoTerceros,
                        IdTipoFlujoOP_PagoTerceros = q.IdTipoFlujoOP_PagoTerceros,
                        IdFormaOP_PagoTerceros = q.IdFormaOP_PagoTerceros,
                        IdBancoOP_PagoTerceros = q.IdBancoOP_PagoTerceros,
                        GeneraOP_PagoPrestamos = q.GeneraOP_PagoPrestamos,
                        IdTipoOP_PagoPrestamos = q.IdTipoOP_PagoPrestamos,
                        IdTipoFlujoOP_PagoPrestamos = q.IdTipoFlujoOP_PagoPrestamos,
                        IdFormaOP_PagoPrestamos = q.IdFormaOP_PagoPrestamos,
                        IdBancoOP_PagoPrestamos = q.IdBancoOP_PagoPrestamos,
                        GeneraOP_LiquidacionVacaciones = q.GeneraOP_LiquidacionVacaciones,
                        IdTipoOP_LiquidacionVacaciones = q.IdTipoOP_LiquidacionVacaciones,
                        IdTipoFlujoOP_LiquidacionVacaciones = q.IdTipoFlujoOP_LiquidacionVacaciones,
                        IdFormaOP_LiquidacionVacaciones = q.IdFormaOP_LiquidacionVacaciones,
                        IdBancoOP_LiquidacionVacaciones = q.IdBancoOP_LiquidacionVacaciones,
                        DescuentaIESS_LiquidacionVacaciones = q.DescuentaIESS_LiquidacionVacaciones,
                        cta_contable_IESS_Vacaciones = q.cta_contable_IESS_Vacaciones,
                        GeneraOP_ActaFiniquito = q.GeneraOP_ActaFiniquito,
                        IdTipoOP_ActaFiniquito = q.IdTipoOP_ActaFiniquito,
                        IdTipoFlujoOP_ActaFiniquito = q.IdTipoFlujoOP_ActaFiniquito,
                        IdFormaPagoOP_ActaFiniquito = q.IdFormaPagoOP_ActaFiniquito

                    };
                }

                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool si_existe(int IdEmpresa)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    var lst = from q in Context.ro_Parametros
                              where q.IdEmpresa == IdEmpresa
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
        public bool guardarDB(ro_Parametros_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_Parametros Entity = new ro_Parametros
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdTipoCbte_AsientoSueldoXPagar = info.IdTipoCbte_AsientoSueldoXPagar,
                        IdTipoCbte_AsientoProvision = info.IdTipoCbte_AsientoProvision,
                        IdTipo_mov_Ingreso = info.IdTipo_mov_Ingreso,
                        IdTipo_mov_Egreso = info.IdTipo_mov_Egreso,
                        Dias_considerado_ultimo_pago_quincela_Liq = info.Dias_considerado_ultimo_pago_quincela_Liq,
                        IdNomina_Tipo_Para_Desc_Automat = info.IdNomina_Tipo_Para_Desc_Automat,
                        IdNominatipoLiq_Para_Desc_Automat = info.IdNominatipoLiq_Para_Desc_Automat,
                        GeneraraOP_PagoTerceros = info.GeneraraOP_PagoTerceros,
                        IdTipoOP_PagoTerceros = info.IdTipoOP_PagoTerceros,
                        IdTipoFlujoOP_PagoTerceros = info.IdTipoFlujoOP_PagoTerceros,
                        IdFormaOP_PagoTerceros = info.IdFormaOP_PagoTerceros,
                        IdBancoOP_PagoTerceros = info.IdBancoOP_PagoTerceros,
                        GeneraOP_PagoPrestamos = info.GeneraOP_PagoPrestamos,
                        IdTipoOP_PagoPrestamos = info.IdTipoOP_PagoPrestamos,
                        IdTipoFlujoOP_PagoPrestamos = info.IdTipoFlujoOP_PagoPrestamos,
                        IdFormaOP_PagoPrestamos = info.IdFormaOP_PagoPrestamos,
                        IdBancoOP_PagoPrestamos = info.IdBancoOP_PagoPrestamos,
                        GeneraOP_LiquidacionVacaciones = info.GeneraOP_LiquidacionVacaciones,
                        IdTipoOP_LiquidacionVacaciones = info.IdTipoOP_LiquidacionVacaciones,
                        IdTipoFlujoOP_LiquidacionVacaciones = info.IdTipoFlujoOP_LiquidacionVacaciones,
                        IdFormaOP_LiquidacionVacaciones = info.IdFormaOP_LiquidacionVacaciones,
                        IdBancoOP_LiquidacionVacaciones = info.IdBancoOP_LiquidacionVacaciones,
                        DescuentaIESS_LiquidacionVacaciones = info.DescuentaIESS_LiquidacionVacaciones,
                        cta_contable_IESS_Vacaciones = info.cta_contable_IESS_Vacaciones,
                        GeneraOP_ActaFiniquito = info.GeneraOP_ActaFiniquito,
                        IdTipoOP_ActaFiniquito = info.IdTipoOP_ActaFiniquito,
                        IdTipoFlujoOP_ActaFiniquito = info.IdTipoFlujoOP_ActaFiniquito,
                        IdFormaPagoOP_ActaFiniquito = info.IdFormaPagoOP_ActaFiniquito

                    };
                    Context.ro_Parametros.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool modificarDB(ro_Parametros_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_Parametros Entity = Context.ro_Parametros.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa);
                    if (Entity == null)
                        return false;
                    Entity.IdTipoCbte_AsientoSueldoXPagar = info.IdTipoCbte_AsientoSueldoXPagar;
                    Entity.IdTipoCbte_AsientoProvision = info.IdTipoCbte_AsientoProvision;
                    Entity.IdTipo_mov_Ingreso = info.IdTipo_mov_Ingreso;
                    Entity.IdTipo_mov_Egreso = info.IdTipo_mov_Egreso;
                    Entity.Dias_considerado_ultimo_pago_quincela_Liq = info.Dias_considerado_ultimo_pago_quincela_Liq;
                    Entity.IdNomina_Tipo_Para_Desc_Automat = info.IdNomina_Tipo_Para_Desc_Automat;
                    Entity.IdNominatipoLiq_Para_Desc_Automat = info.IdNominatipoLiq_Para_Desc_Automat;
                    Entity.GeneraraOP_PagoTerceros = info.GeneraraOP_PagoTerceros;
                    Entity.GeneraraOP_PagoTerceros = info.GeneraraOP_PagoTerceros;
                    Entity.IdTipoOP_PagoTerceros = info.IdTipoOP_PagoTerceros;
                    Entity.IdTipoFlujoOP_PagoTerceros = info.IdTipoFlujoOP_PagoTerceros;
                    Entity.IdFormaOP_PagoTerceros = info.IdFormaOP_PagoTerceros;
                    Entity.IdBancoOP_PagoTerceros = info.IdBancoOP_PagoTerceros;
                    Entity.GeneraOP_PagoPrestamos = info.GeneraOP_PagoPrestamos;
                    Entity.IdTipoOP_PagoPrestamos = info.IdTipoOP_PagoPrestamos;
                    Entity.IdTipoFlujoOP_PagoPrestamos = info.IdTipoFlujoOP_PagoPrestamos;
                    Entity.IdFormaOP_PagoPrestamos = info.IdFormaOP_PagoPrestamos;
                    Entity.IdBancoOP_PagoPrestamos = info.IdBancoOP_PagoPrestamos;
                    Entity.GeneraOP_LiquidacionVacaciones = info.GeneraOP_LiquidacionVacaciones;
                    Entity.IdTipoOP_LiquidacionVacaciones = info.IdTipoOP_LiquidacionVacaciones;
                    Entity.IdTipoFlujoOP_LiquidacionVacaciones = info.IdTipoFlujoOP_LiquidacionVacaciones;
                    Entity.IdFormaOP_LiquidacionVacaciones = info.IdFormaOP_LiquidacionVacaciones;
                    Entity.IdBancoOP_LiquidacionVacaciones = info.IdBancoOP_LiquidacionVacaciones;
                    Entity.DescuentaIESS_LiquidacionVacaciones = info.DescuentaIESS_LiquidacionVacaciones;
                    Entity.cta_contable_IESS_Vacaciones = info.cta_contable_IESS_Vacaciones;
                    Entity.GeneraOP_ActaFiniquito = info.GeneraOP_ActaFiniquito;
                    Entity.IdTipoOP_ActaFiniquito = info.IdTipoOP_ActaFiniquito;
                    Entity.IdTipoFlujoOP_ActaFiniquito = info.IdTipoFlujoOP_ActaFiniquito;
                    Entity.IdFormaPagoOP_ActaFiniquito = info.IdFormaPagoOP_ActaFiniquito;
                    Context.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
