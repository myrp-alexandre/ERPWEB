using Core.Erp.Info.Reportes.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.RRHH
{
    public class ROL_013_Data
    {
        public List<ROL_013_Info> get_list(int IdEmpresa, int IdNomina, decimal IdEmpleado, DateTime fecha_inicio, DateTime fecha_fin)
        {
            try
            {
                decimal IdEmpleadoIni = IdEmpleado;
                decimal IdEmpleadoFin = IdEmpleado == 0 ? 9999 : IdEmpleado;
                
                List<ROL_013_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                    Lista = (from q in Context.SPROL_013(IdEmpresa, IdNomina, fecha_inicio, fecha_fin)
                             where  q.IdEmpleado >= IdEmpleadoIni && q.IdEmpleado <= IdEmpleadoFin
                             select new ROL_013_Info
                             {
                                 IdDepartamento = q.IdDepartamento,
                                 pe_anio = q.pe_anio,
                                 pe_FechaIni = q.pe_FechaIni,
                                 pe_FechaFin = q.pe_FechaFin,
                                 pe_apellido = q.pe_apellido,
                                 pe_cedulaRuc = q.pe_cedulaRuc,
                                 pe_mes = q.pe_mes,
                                 pe_nombre = q.pe_nombre,
                                 ru_descripcion = q.ru_descripcion,
                                 de_descripcion = q.de_descripcion,
                                 Nomina = q.Nomina,
                                 ca_descripcion = q.ca_descripcion,
                                 em_fechaIngaRol = q.em_fechaIngaRol,
                                 em_fechaSalida = q.em_fechaSalida,
                                 Descripcion = q.de_descripcion,
                                 Valor = q.Valor,
                                 IdEmpleado = q.IdEmpleado


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
