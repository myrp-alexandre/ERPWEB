using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
namespace Core.Erp.Data.RRHH
{
   public class ro_rol_detalle_x_rubro_acumulado_Data
    {

        public double get_valor_x_rubro_acumulado(int IdEmpresa, decimal IdEmpleado, string IdRubro)
        {
            try
            {
                double valor_cuotas = 0;
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                 var   datos = (from q in Context.ro_rol_detalle_x_rubro_acumulado
                                  
                                    where q.IdEmpresa == IdEmpresa
                                          & q.IdEmpleado == IdEmpleado
                                          && q.IdRubro==IdRubro
                                          && q.Estado=="PEN"
                                    select q.Valor);
                    if (datos.Count() > 0)
                        valor_cuotas = datos.Sum();
                }

                return valor_cuotas;
            }
            catch (Exception )
            {

                throw;
            }
        }


        public double get_vac_x_mes_x_anio(int IdEmpresa, decimal IdEmpleado,int Anio, int mes)
        {
            try
            {
                double valor_cuotas = 0;
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    var datos = (from q in Context.ro_rol_detalle_x_rubro_acumulado
                                 join p in Context.ro_periodo
                                 on new { q.IdEmpresa, q.IdPeriodo} equals new { p.IdEmpresa,p.IdPeriodo}
                                     where q.IdEmpresa == IdEmpresa
                                       & q.IdEmpleado == IdEmpleado
                                        &p.pe_anio==Anio
                                        && p.pe_mes==mes
                                       && q.IdRubro == "295"
                                       && q.Estado == "PEN"
                                 select q.Valor);
                    if (datos.Count() > 0)
                        valor_cuotas = datos.Sum();
                }

                return valor_cuotas;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
