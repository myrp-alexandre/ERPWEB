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
                                 GeneraOP_PagoPrestamos = q.GeneraOP_PagoPrestamos,
                                 IdTipoOP_PagoPrestamos = q.IdTipoOP_PagoPrestamos,
                                 IdFormaOP_PagoPrestamos = q.IdFormaOP_PagoPrestamos,
                                 GeneraOP_LiquidacionVacaciones = q.GeneraOP_LiquidacionVacaciones,
                                 IdTipoOP_LiquidacionVacaciones = q.IdTipoOP_LiquidacionVacaciones,
                                 IdTipoFlujoOP_LiquidacionVacaciones = q.IdTipoFlujoOP_LiquidacionVacaciones,
                                 IdFormaOP_LiquidacionVacaciones = q.IdFormaOP_LiquidacionVacaciones,
                                 DescuentaIESS_LiquidacionVacaciones = q.DescuentaIESS_LiquidacionVacaciones,
                                 cta_contable_IESS_Vacaciones = q.cta_contable_IESS_Vacaciones,
                                 GeneraOP_ActaFiniquito = q.GeneraOP_ActaFiniquito,
                                 IdTipoOP_ActaFiniquito = q.IdTipoOP_ActaFiniquito,
                                 IdFormaPagoOP_ActaFiniquito = q.IdFormaPagoOP_ActaFiniquito,
                                 Sueldo_basico=q.Sueldo_basico,
                                 Porcentaje_aporte_patr=q.Porcentaje_aporte_patr,
                                 Porcentaje_aporte_pers=q.Porcentaje_aporte_pers,
                                 IdRubro_acta_finiquito=q.IdRubro_acta_finiquito,
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
                        GeneraOP_PagoPrestamos = q.GeneraOP_PagoPrestamos,
                        IdTipoOP_PagoPrestamos = q.IdTipoOP_PagoPrestamos,
                        IdFormaOP_PagoPrestamos = q.IdFormaOP_PagoPrestamos,
                        GeneraOP_LiquidacionVacaciones = q.GeneraOP_LiquidacionVacaciones,
                        IdTipoOP_LiquidacionVacaciones = q.IdTipoOP_LiquidacionVacaciones,
                        IdTipoFlujoOP_LiquidacionVacaciones = q.IdTipoFlujoOP_LiquidacionVacaciones,
                        IdFormaOP_LiquidacionVacaciones = q.IdFormaOP_LiquidacionVacaciones,
                        DescuentaIESS_LiquidacionVacaciones = q.DescuentaIESS_LiquidacionVacaciones,
                        cta_contable_IESS_Vacaciones = q.cta_contable_IESS_Vacaciones,
                        GeneraOP_ActaFiniquito = q.GeneraOP_ActaFiniquito,
                        IdTipoOP_ActaFiniquito = q.IdTipoOP_ActaFiniquito,
                        IdFormaPagoOP_ActaFiniquito = q.IdFormaPagoOP_ActaFiniquito,
                        Sueldo_basico = q.Sueldo_basico,
                        Porcentaje_aporte_patr = q.Porcentaje_aporte_patr,
                        Porcentaje_aporte_pers = q.Porcentaje_aporte_pers,
                        IdRubro_acta_finiquito = q.IdRubro_acta_finiquito,
                        Descripcion = "Parametrización contable"
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
                       
                        GeneraOP_PagoPrestamos = info.GeneraOP_PagoPrestamos,
                        IdTipoOP_PagoPrestamos = info.IdTipoOP_PagoPrestamos,
                        IdFormaOP_PagoPrestamos = info.IdFormaOP_PagoPrestamos,
                        GeneraOP_LiquidacionVacaciones = info.GeneraOP_LiquidacionVacaciones,
                        IdTipoOP_LiquidacionVacaciones = info.IdTipoOP_LiquidacionVacaciones,
                        IdTipoFlujoOP_LiquidacionVacaciones = info.IdTipoFlujoOP_LiquidacionVacaciones,
                        IdFormaOP_LiquidacionVacaciones = info.IdFormaOP_LiquidacionVacaciones,
                        DescuentaIESS_LiquidacionVacaciones = info.DescuentaIESS_LiquidacionVacaciones,
                        cta_contable_IESS_Vacaciones = info.cta_contable_IESS_Vacaciones,
                        GeneraOP_ActaFiniquito = info.GeneraOP_ActaFiniquito,
                        IdTipoOP_ActaFiniquito = info.IdTipoOP_ActaFiniquito,
                        IdFormaPagoOP_ActaFiniquito = info.IdFormaPagoOP_ActaFiniquito,
                        Sueldo_basico = info.Sueldo_basico,
                        Porcentaje_aporte_patr = info.Porcentaje_aporte_patr,
                        Porcentaje_aporte_pers = info.Porcentaje_aporte_pers,
                        IdRubro_acta_finiquito = info.IdRubro_acta_finiquito,
                        genera_op_x_pago = info.genera_op_x_pago,
                        Genera_op_x_pago_x_empleao = info.Genera_op_x_pago_x_empleao
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
                    Entity.GeneraOP_PagoPrestamos = info.GeneraOP_PagoPrestamos;
                    Entity.IdTipoOP_PagoPrestamos = info.IdTipoOP_PagoPrestamos;
                    Entity.IdFormaOP_PagoPrestamos = info.IdFormaOP_PagoPrestamos;
                    Entity.GeneraOP_LiquidacionVacaciones = info.GeneraOP_LiquidacionVacaciones;
                    Entity.IdTipoOP_LiquidacionVacaciones = info.IdTipoOP_LiquidacionVacaciones;
                    Entity.IdTipoFlujoOP_LiquidacionVacaciones = info.IdTipoFlujoOP_LiquidacionVacaciones;
                    Entity.IdFormaOP_LiquidacionVacaciones = info.IdFormaOP_LiquidacionVacaciones;
                    Entity.DescuentaIESS_LiquidacionVacaciones = info.DescuentaIESS_LiquidacionVacaciones;
                    Entity.cta_contable_IESS_Vacaciones = info.cta_contable_IESS_Vacaciones;
                    Entity.GeneraOP_ActaFiniquito = info.GeneraOP_ActaFiniquito;
                    Entity.IdTipoOP_ActaFiniquito = info.IdTipoOP_ActaFiniquito;
                    Entity.IdFormaPagoOP_ActaFiniquito = info.IdFormaPagoOP_ActaFiniquito;
                    Entity.Sueldo_basico = info.Sueldo_basico;
                    Entity.Porcentaje_aporte_pers = info.Porcentaje_aporte_pers;
                    Entity.Porcentaje_aporte_patr = info.Porcentaje_aporte_patr;
                    Entity.IdRubro_acta_finiquito = info.IdRubro_acta_finiquito;
                    Entity.genera_op_x_pago = info.genera_op_x_pago;
                    Entity.Genera_op_x_pago_x_empleao = info.Genera_op_x_pago_x_empleao;
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
