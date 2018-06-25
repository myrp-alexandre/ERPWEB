using Core.Erp.Info.Caja;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Caja
{
    public class cp_conciliacion_Caja_Data
    {
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

        public bool guardarDB()
        {
            try
            {
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
