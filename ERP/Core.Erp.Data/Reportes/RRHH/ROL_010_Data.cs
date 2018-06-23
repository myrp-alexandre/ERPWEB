using Core.Erp.Info.Reportes.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.RRHH
{
    public class ROL_010_Data
    {
        public List<ROL_010_Info> get_list(int IdEmpresa)
        {
            try
            {
                List<ROL_010_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                    Lista = (from q in Context.VWROL_010
                             where q.IdEmpresa == IdEmpresa
                             select new ROL_010_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdEmpleado = q.IdEmpleado,
                                 IdDivision = q.IdDivision,
                                 ca_descripcion = q.ca_descripcion,
                                 antiguedad_string = q.antiguedad_string,
                                 Empleado = q.Empleado,
                                 em_fechaIngaRol = q.em_fechaIngaRol,
                                 em_fechaSalida = q.em_fechaSalida,
                                 em_fecha_ingreso = q.em_fecha_ingreso,
                                 EstadoEmpleado = q.EstadoEmpleado,
                                 pe_cedulaRuc = q.pe_cedulaRuc,
                                 IdTipoNomina = q.IdTipoNomina
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
