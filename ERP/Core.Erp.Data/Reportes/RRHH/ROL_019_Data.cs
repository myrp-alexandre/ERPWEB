using Core.Erp.Info.Reportes.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.RRHH
{
    public class ROL_019_Data
    {
        public List<ROL_019_Info> get_list(int IdEmpresa, decimal IdEmpleado, DateTime fecha_ini, DateTime fecha_fin)
        {
            try
            {
                decimal IdEmpleadoIni = IdEmpleado;
                decimal IdEmpleadoFin = IdEmpleado == 0 ? 9999 : IdEmpleado;
                fecha_fin = Convert.ToDateTime(fecha_fin.ToShortDateString());
                fecha_ini = Convert.ToDateTime(fecha_ini.ToShortDateString());
                List<ROL_019_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                    Lista = (from q in Context.VWROL_019
                             where q.IdEmpresa == IdEmpresa
                             && q.IdEmpleado >= IdEmpleadoIni 
                             && q.IdEmpleado <= IdEmpleadoFin
                             && q.FechaIni >= fecha_ini 
                             && q.FechaIni <= fecha_fin
                             select new ROL_019_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdNominaTipo = q.IdNominaTipo,
                                 IdNominaTipoLiqui = q.IdNominaTipoLiqui,
                                 IdPeriodo = q.IdPeriodo,
                                 IdEmpleado = q.IdEmpleado,
                                 IdRubro = q.IdRubro,
                                 Orden = q.Orden,
                                 Valor = q.Valor,
                                 Observacion = q.Observacion,
                                 pe_anio = q.pe_anio,
                                 pe_mes = q.pe_mes,
                                 Division = q.Division,
                                 Departamento = q.Departamento,
                                 Cargo = q.Cargo,
                                 Rubro = q.Rubro,
                                 NominaTipo = q.NominaTipo,
                                 Nomina = q.Nomina,
                                 Empleado = q.Empleado,
                                 Cedula = q.Cedula,
                                 ru_tipo = q.ru_tipo,
                                 pe_FechaIni = q.FechaIni,
                                 pe_FechaFin = q.FechaFin,
                                 ru_codRolGen=q.ru_codRolGen
                             }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
